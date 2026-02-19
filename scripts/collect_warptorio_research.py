#!/usr/bin/env python3
"""Collect Warptorio-family mod research data from the Factorio mod portal."""

from __future__ import annotations

import argparse
import concurrent.futures
import html
import json
import sys
import re
import time
import unicodedata
from dataclasses import dataclass
from pathlib import Path
from typing import Any
from urllib.parse import parse_qs, urljoin, urlparse

import requests
from bs4 import BeautifulSoup, Tag
from markdownify import markdownify as md

BASE_URL = "https://mods.factorio.com"
USER_AGENT = "warpage-research-scraper/1.0 (+https://mods.factorio.com)"
SEARCH_QUERIES = ["warptorio", "warp drive machine"]
BUG_KEYWORDS = [
    "bug",
    "crash",
    "error",
    "broken",
    "issue",
    "fix",
    "incompatible",
    "missing",
    "fail",
    "not working",
    "doesn't work",
    "cant",
    "can't",
    "exception",
    "stacktrace",
    "stack trace",
]
POSITIVE_TERMS = [
    "love",
    "like",
    "great",
    "awesome",
    "fun",
    "enjoy",
    "good",
    "excellent",
    "cool",
    "nice",
    "amazing",
    "thanks",
]
NEGATIVE_TERMS = [
    "hate",
    "bad",
    "boring",
    "tedious",
    "frustrating",
    "annoying",
    "underwhelming",
    "grind",
    "jank",
    "painful",
    "not fun",
    "too hard",
    "too easy",
    "unfair",
    "awful",
]
GRIEVANCE_TERMS = [
    "frustrating",
    "annoying",
    "tedious",
    "boring",
    "underwhelming",
    "jank",
    "painful",
    "grind",
    "unfair",
]
THEMES = {
    "Warp timing and pacing": [
        "timer",
        "autowarp",
        "warp time",
        "warp out",
        "stay longer",
        "grace period",
        "pacing",
    ],
    "Floor layout and logistics": [
        "floor",
        "platform",
        "layout",
        "factory",
        "garden",
        "container",
        "belt",
        "pipe",
        "logistic",
        "rebuild",
    ],
    "Science and progression": [
        "science",
        "research",
        "pack",
        "unlock",
        "tech",
        "progression",
        "gleba",
        "fulgora",
        "vulcanus",
        "aquilo",
    ],
    "Combat pressure and defenses": [
        "enemy",
        "biter",
        "wave",
        "defense",
        "turret",
        "tesla",
        "drone",
        "demolisher",
        "asteroid",
    ],
    "Planet and surface mechanics": [
        "planet",
        "surface",
        "recipe",
        "offworld",
        "warpstation",
        "station",
        "space",
    ],
    "QoL and automation": [
        "quality of life",
        "qol",
        "option",
        "setting",
        "signal",
        "circuit",
        "interface",
        "automation",
        "blueprint",
    ],
    "Loot, rewards, and bonuses": [
        "loot",
        "chest",
        "reward",
        "beacon",
        "module",
        "bonus",
    ],
    "Multiplayer and co-op": ["multiplayer", "co-op", "coop", "server", "friends"],
}


@dataclass
class ModCard:
    slug: str
    title: str
    owner: str
    summary: str
    downloads: int
    category: str


@dataclass
class ThreadRef:
    id: str
    title: str
    url: str


def slugify(value: str) -> str:
    normalized = unicodedata.normalize("NFKD", value)
    ascii_text = normalized.encode("ascii", "ignore").decode("ascii")
    cleaned = re.sub(r"[^a-zA-Z0-9]+", "-", ascii_text.lower()).strip("-")
    return cleaned or "untitled"


def absolute_url(path_or_url: str) -> str:
    return urljoin(BASE_URL, path_or_url)


def normalize_url(value: str) -> str:
    url = value.strip()
    if not url:
        return ""
    if url.startswith("#"):
        return url
    if url.startswith("javascript:"):
        return url
    if url.startswith("//"):
        return f"https:{url}"
    if url.startswith("/"):
        return absolute_url(url)

    parsed = urlparse(url)
    if parsed.scheme:
        return url

    if url.startswith("www."):
        return f"https://{url}"

    if re.match(r"^[A-Za-z0-9.-]+\.[A-Za-z]{2,}([/:?#].*)?$", url):
        return f"https://{url}"

    return url


def normalize_links_in_tag(tag: Tag) -> None:
    for node in tag.select("[href]"):
        href = node.get("href", "")
        if href:
            node["href"] = normalize_url(href)
    for node in tag.select("[src]"):
        src = node.get("src", "")
        if src:
            node["src"] = normalize_url(src)


def tag_to_markdown(tag: Tag) -> str:
    fragment = BeautifulSoup(f"<div>{tag.decode_contents()}</div>", "html.parser")
    root = fragment.find()
    if not isinstance(root, Tag):
        return ""
    normalize_links_in_tag(root)
    markdown = md(str(root), heading_style="ATX").strip()
    markdown = re.sub(r"\s*\n\s*", " ", markdown)
    return markdown.strip()


def unique_preserve_order(values: list[str]) -> list[str]:
    seen: set[str] = set()
    output: list[str] = []
    for value in values:
        if value and value not in seen:
            seen.add(value)
            output.append(value)
    return output


def make_session() -> requests.Session:
    session = requests.Session()
    session.headers.update({"User-Agent": USER_AGENT})
    return session


def fetch_soup(session: requests.Session, url: str, *, params: dict[str, Any] | None = None) -> BeautifulSoup:
    last_error: Exception | None = None
    for attempt in range(1, 5):
        try:
            response = session.get(url, params=params, timeout=40)
            response.raise_for_status()
            return BeautifulSoup(response.text, "html.parser")
        except Exception as exc:  # noqa: BLE001
            last_error = exc
            sleep_seconds = 0.8 * attempt
            time.sleep(sleep_seconds)
    raise RuntimeError(f"Failed to fetch {url} after retries") from last_error


def parse_download_count(card: Tag) -> int:
    node = card.select_one('div.pb8[title="Downloads, updated daily"] span[title]')
    if not node:
        return 0
    raw = node.get("title", "").strip()
    if raw.isdigit():
        return int(raw)
    cleaned = re.sub(r"[^0-9]", "", raw)
    return int(cleaned) if cleaned else 0


def parse_search_page(soup: BeautifulSoup) -> tuple[list[ModCard], int]:
    cards: list[ModCard] = []
    for card in soup.select("div.mod-list > div.panel-inset-lighter.flex-column.p0"):
        title_link = card.select_one("h2 a.result-field")
        if not title_link:
            continue

        href = title_link.get("href", "").split("?")[0]
        if "/mod/" not in href:
            continue
        slug = href.split("/mod/", 1)[1]

        owner_node = card.select_one("a.orange.bold.result-field")
        summary_node = card.select_one("p.result-field.pre-line.line-clamp-4")
        category_node = card.select_one("div.pb8.result-field.category-label")

        cards.append(
            ModCard(
                slug=slug,
                title=" ".join(title_link.stripped_strings),
                owner=" ".join(owner_node.stripped_strings) if owner_node else "",
                summary=" ".join(summary_node.stripped_strings) if summary_node else "",
                downloads=parse_download_count(card),
                category=" ".join(category_node.stripped_strings) if category_node else "",
            )
        )

    page_numbers = [1]
    for link in soup.select("a.button.square-sm[href]"):
        href = link.get("href", "")
        query = urlparse(href).query
        if not query:
            continue
        page_values = parse_qs(query).get("page", [])
        for value in page_values:
            if value.isdigit():
                page_numbers.append(int(value))

    return cards, max(page_numbers)


def discover_mods(
    session: requests.Session,
    *,
    min_downloads: int,
    include_core_below_threshold: bool,
) -> list[ModCard]:
    discovered: dict[str, ModCard] = {}

    for query in SEARCH_QUERIES:
        page = 1
        while True:
            soup = fetch_soup(
                session,
                f"{BASE_URL}/search",
                params={
                    "query": query,
                    "exclude_category": "internal",
                    "factorio_version": "any",
                    "sort_attribute": "most_downloads",
                    "show_deprecated": "True",
                    "only_bookmarks": "False",
                    "page": str(page),
                },
            )
            cards, max_page = parse_search_page(soup)
            for card in cards:
                key = card.slug.lower()
                existing = discovered.get(key)
                if not existing or card.downloads > existing.downloads:
                    discovered[key] = card

            if page >= max_page:
                break
            page += 1

    selected: dict[str, ModCard] = {}
    for key, card in discovered.items():
        label = f"{card.slug} {card.title}".lower()
        is_warptorio_family = "warptorio" in label
        is_warp_machine = "warp drive machine" in label or key == "warp-drive-machine"
        if card.downloads >= min_downloads and (is_warptorio_family or is_warp_machine):
            selected[key] = card

    if include_core_below_threshold:
        forced_slugs = ["warptorio", "warptorio2", "warptorio-space-age", "warp-drive-machine"]
        for forced_slug in forced_slugs:
            card = discovered.get(forced_slug)
            if card and forced_slug not in selected:
                selected[forced_slug] = card

    return sorted(selected.values(), key=lambda item: item.downloads, reverse=True)


def extract_dl_fields(dl: Tag) -> dict[str, str]:
    fields: dict[str, str] = {}
    dt_nodes = dl.find_all("dt", recursive=False)
    dd_nodes = dl.find_all("dd", recursive=False)
    for dt_node, dd_node in zip(dt_nodes, dd_nodes):
        key = " ".join(dt_node.stripped_strings).rstrip(":")
        value = tag_to_markdown(dd_node)
        if not value:
            value = " ".join(dd_node.stripped_strings)
        if key:
            fields[key] = value
    return fields


def parse_mod_page(soup: BeautifulSoup, mod_slug: str) -> dict[str, Any]:
    title_node = soup.select_one("h2.mb0 a.result-field")
    owner_link = soup.select_one('dl.panel-hole a[href^="/user/"]')
    summary_node = soup.select_one('meta[property="og:description"]')

    meta: dict[str, Any] = {
        "slug": mod_slug,
        "title": " ".join(title_node.stripped_strings) if title_node else mod_slug,
        "owner": " ".join(owner_link.stripped_strings) if owner_link else "",
        "summary": summary_node.get("content", "").strip() if summary_node else "",
        "info": {},
        "demo_images": [],
        "inline_images": [],
        "description_markdown": "",
    }

    dls = soup.select("div.mod-page-info dl.panel-hole")
    info: dict[str, str] = {}
    for dl in dls:
        info.update(extract_dl_fields(dl))
    meta["info"] = info

    gallery_images: list[str] = []
    for img in soup.select("div.mod-page-info div.gallery.gallery-detail img"):
        src = img.get("src")
        if not src:
            continue
        gallery_images.append(normalize_url(src))
    gallery_images = unique_preserve_order(gallery_images)

    article = soup.select_one("article.panel-hole-combined")
    if article:
        article_fragment = BeautifulSoup(str(article), "html.parser")
        article_root = article_fragment.find()
        if isinstance(article_root, Tag):
            normalize_links_in_tag(article_root)
            inline_images = [normalize_url(img.get("src", "")) for img in article_root.select("img[src]")]
            meta["inline_images"] = unique_preserve_order(inline_images)
            markdown = md(str(article_root), heading_style="ATX")
        else:
            markdown = md(str(article), heading_style="ATX")
        meta["description_markdown"] = markdown.strip()

    inline_image_set = set(meta.get("inline_images", []))
    meta["demo_images"] = [image for image in gallery_images if image not in inline_image_set]

    return meta


def parse_discussion_page_count(soup: BeautifulSoup, mod_slug: str) -> int:
    pattern = re.compile(rf"^/mod/{re.escape(mod_slug)}/discussion/page/(\d+)$", re.IGNORECASE)
    pages = [1]
    for link in soup.select("a[href]"):
        href = link.get("href", "")
        match = pattern.match(href)
        if match:
            pages.append(int(match.group(1)))
    return max(pages)


def collect_threads(session: requests.Session, mod_slug: str) -> list[ThreadRef]:
    first_page_soup = fetch_soup(session, f"{BASE_URL}/mod/{mod_slug}/discussion")
    max_page = parse_discussion_page_count(first_page_soup, mod_slug)

    thread_map: dict[str, ThreadRef] = {}

    def collect_from_soup(soup: BeautifulSoup) -> None:
        # Real discussion IDs are long hex tokens. Single-letter routes like
        # /discussion/a and /discussion/b are category filters, not threads.
        pattern = re.compile(rf"^/mod/{re.escape(mod_slug)}/discussion/([0-9a-f]{{16,}})$", re.IGNORECASE)
        for link in soup.select("a[href]"):
            href = link.get("href", "")
            match = pattern.match(href)
            if not match:
                continue
            thread_id = match.group(1)
            title = link.get("title") or " ".join(link.stripped_strings)
            title = html.unescape(title).strip()
            if thread_id not in thread_map:
                thread_map[thread_id] = ThreadRef(
                    id=thread_id,
                    title=title,
                    url=absolute_url(href),
                )

    collect_from_soup(first_page_soup)

    for page_number in range(2, max_page + 1):
        soup = fetch_soup(session, f"{BASE_URL}/mod/{mod_slug}/discussion/page/{page_number}")
        collect_from_soup(soup)

    return sorted(thread_map.values(), key=lambda thread: thread.url)


def parse_thread_page_count(soup: BeautifulSoup, mod_slug: str, thread_id: str) -> int:
    pattern = re.compile(
        rf"^/mod/{re.escape(mod_slug)}/discussion/{re.escape(thread_id)}/page/(\d+)$",
        re.IGNORECASE,
    )
    pages = [1]
    for link in soup.select("a[href]"):
        href = link.get("href", "")
        match = pattern.match(href)
        if match:
            pages.append(int(match.group(1)))
    return max(pages)


def extract_message_markdown(message_body: Tag) -> str:
    raw_markdown = md(str(message_body), heading_style="ATX")
    lines = [line.rstrip() for line in raw_markdown.splitlines()]
    collapsed = "\n".join(lines).strip()
    return collapsed


def scrape_thread(
    session: requests.Session,
    mod_slug: str,
    thread: ThreadRef,
) -> tuple[str, list[dict[str, Any]]]:
    first_page = fetch_soup(session, thread.url)
    max_page = parse_thread_page_count(first_page, mod_slug, thread.id)

    messages: list[dict[str, Any]] = []
    op_author: str | None = None

    for page in range(1, max_page + 1):
        if page == 1:
            soup = first_page
        else:
            soup = fetch_soup(session, f"{thread.url}/page/{page}")

        for message in soup.select("div.discussion-message"):
            author_link = message.select_one("div.discussion-message-author a")
            body = message.select_one("div.discussion-message-body")
            if not author_link or not body:
                continue

            author = " ".join(author_link.stripped_strings)
            if op_author is None:
                op_author = author

            is_mod_author = bool(message.select_one('div.discussion-message-author i[title="Mod author"]'))
            content_markdown = extract_message_markdown(body)
            messages.append(
                {
                    "author": author,
                    "is_mod_author": is_mod_author,
                    "is_op": author == op_author,
                    "content": content_markdown,
                }
            )

    return (op_author or ""), messages


def render_mod_readme(mod: ModCard, meta: dict[str, Any]) -> str:
    lines: list[str] = []
    lines.append(f"# {meta['title']}")
    lines.append("")
    mod_url = f"{BASE_URL}/mod/{mod.slug}"
    lines.append(f"- Mod URL: [{mod_url}]({mod_url})")
    lines.append(f"- Owner: {meta.get('owner') or mod.owner}")
    lines.append(f"- Downloads: {mod.downloads}")
    lines.append(f"- Category: {mod.category or 'Unknown'}")
    if meta.get("summary"):
        lines.append(f"- Summary: {meta['summary']}")

    demo_images: list[str] = meta.get("demo_images", [])
    if demo_images:
        max_cols = min(4, len(demo_images))
        lines.append("")
        lines.append("## Demo Images")
        lines.append("")
        headers = [f"Image {index + 1}" for index in range(max_cols)]
        lines.append(f"| {' | '.join(headers)} |")
        lines.append(f"| {' | '.join(['---'] * max_cols)} |")
        for row_start in range(0, len(demo_images), max_cols):
            row_images = demo_images[row_start : row_start + max_cols]
            cells = [
                f"[![demo-{row_start + idx + 1}]({url})]({url})"
                for idx, url in enumerate(row_images)
            ]
            while len(cells) < max_cols:
                cells.append(" ")
            lines.append(f"| {' | '.join(cells)} |")

    info = meta.get("info", {})
    if info:
        lines.append("")
        lines.append("## Mod Info")
        lines.append("")
        for key, value in info.items():
            lines.append(f"- {key}: {value}")

    lines.append("")
    lines.append("## Main Page Content")
    lines.append("")
    description = meta.get("description_markdown", "").strip()
    if description:
        lines.append(description)
    else:
        lines.append("No main page content found.")

    lines.append("")
    return "\n".join(lines)


def write_thread_markdown(
    output_path: Path,
    *,
    thread: ThreadRef,
    op_author: str,
    messages: list[dict[str, Any]],
) -> None:
    lines: list[str] = []
    lines.append(f"# {thread.title}")
    lines.append("")
    lines.append(f"- URL: {thread.url}")
    lines.append(f"- Thread ID: {thread.id}")
    lines.append(f"- Started by: {op_author or 'Unknown'}")
    lines.append("")

    for index, msg in enumerate(messages):
        lines.append("---")
        tag_bits: list[str] = []
        if msg.get("is_op"):
            tag_bits.append("(op)")
        if msg.get("is_mod_author"):
            tag_bits.append("(mod author)")
        tags = f" {' '.join(tag_bits)}" if tag_bits else ""
        lines.append(f"**{msg['author']}{tags}:** {msg['content']}")
        if index != len(messages) - 1:
            lines.append("")

    lines.append("")
    output_path.write_text("\n".join(lines), encoding="utf-8")


def title_is_bug_like(title: str) -> bool:
    lowered = title.lower()
    return any(keyword in lowered for keyword in BUG_KEYWORDS)


def extract_message_blocks(raw: str) -> list[str]:
    sections = [section.strip() for section in raw.split("\n---\n") if section.strip()]
    messages: list[str] = []
    for section in sections:
        header_match = re.match(r"\*\*[^*]+:\*\*\s*(.*)", section, flags=re.DOTALL)
        if header_match:
            messages.append(header_match.group(1).strip())
    return messages


def theme_matches(text: str) -> list[str]:
    lowered = text.lower()
    matches: list[str] = []
    for theme, keywords in THEMES.items():
        if any(keyword in lowered for keyword in keywords):
            matches.append(theme)
    if not matches:
        matches.append("General gameplay loop")
    return matches


def count_terms(text: str, terms: list[str]) -> int:
    lowered = text.lower()
    return sum(1 for term in terms if term in lowered)


def create_highlights(mod_dir: Path) -> None:
    discussion_files = sorted(mod_dir.glob("discussion_*.md"))

    analyzed_threads = 0
    feature_counts: dict[str, int] = {}
    positive_counts: dict[str, int] = {}
    negative_counts: dict[str, int] = {}
    grievance_counts: dict[str, int] = {}

    for file_path in discussion_files:
        raw = file_path.read_text(encoding="utf-8")
        lines = raw.splitlines()
        if not lines:
            continue
        title = lines[0].replace("#", "", 1).strip()
        if title_is_bug_like(title):
            continue

        messages = extract_message_blocks(raw)
        if not messages:
            continue

        analyzed_threads += 1
        joined = "\n\n".join([title, *messages])
        themes = theme_matches(joined)
        positivity = count_terms(joined, POSITIVE_TERMS)
        negativity = count_terms(joined, NEGATIVE_TERMS)
        grievances = count_terms(joined, GRIEVANCE_TERMS)

        for theme in themes:
            feature_counts[theme] = feature_counts.get(theme, 0) + 1
            if positivity > 0:
                positive_counts[theme] = positive_counts.get(theme, 0) + 1
            if negativity > 0:
                negative_counts[theme] = negative_counts.get(theme, 0) + 1
            if grievances > 0:
                grievance_counts[theme] = grievance_counts.get(theme, 0) + 1

    def top_items(counts: dict[str, int], limit: int = 6) -> list[tuple[str, int]]:
        return sorted(counts.items(), key=lambda item: (-item[1], item[0]))[:limit]

    feature_top = top_items(feature_counts)
    positive_top = top_items(positive_counts)
    negative_top = top_items(negative_counts)
    grievance_top = top_items(grievance_counts)

    lines: list[str] = []
    lines.append("# Highlights")
    lines.append("")
    lines.append(f"Analyzed non-bug threads: {analyzed_threads} / {len(discussion_files)}")
    lines.append("")

    lines.append("## Features")
    lines.append("")
    if feature_top:
        for theme, count in feature_top:
            lines.append(f"- {theme}: repeatedly discussed across {count} threads.")
    else:
        lines.append("- No non-bug feature discussions were found.")

    lines.append("")
    lines.append("## Highlights")
    lines.append("")
    if positive_top:
        for theme, count in positive_top:
            lines.append(f"- {theme}: positive feedback appeared in {count} threads.")
    else:
        lines.append("- Positive design/functionality feedback was limited in the available threads.")

    lines.append("")
    lines.append("## Complaints")
    lines.append("")
    if negative_top:
        for theme, count in negative_top:
            lines.append(f"- {theme}: dissatisfaction appeared in {count} threads.")
    else:
        lines.append("- No strong non-bug complaint signal was found.")

    lines.append("")
    lines.append("## Grievances")
    lines.append("")
    if grievance_top:
        for theme, count in grievance_top:
            lines.append(f"- {theme}: recurring frustration language appears in {count} threads.")
    else:
        lines.append("- No sustained grievance pattern was detected in non-bug discussions.")

    lines.append("")
    (mod_dir / "highlights.md").write_text("\n".join(lines), encoding="utf-8")


def process_mod(mod: ModCard, research_dir: Path) -> dict[str, Any]:
    session = make_session()
    mod_dir = research_dir / mod.slug
    mod_dir.mkdir(parents=True, exist_ok=True)

    print(f"[start] {mod.slug}", file=sys.stderr, flush=True)

    mod_page = fetch_soup(session, f"{BASE_URL}/mod/{mod.slug}")
    meta = parse_mod_page(mod_page, mod.slug)
    readme = render_mod_readme(mod, meta)
    (mod_dir / "README.md").write_text(readme, encoding="utf-8")

    threads = collect_threads(session, mod.slug)

    used_names: dict[str, int] = {}
    thread_count = 0
    message_count = 0

    for thread in threads:
        op_author, messages = scrape_thread(session, mod.slug, thread)
        message_count += len(messages)
        thread_count += 1

        base_name = slugify(thread.title)
        seen = used_names.get(base_name, 0)
        used_names[base_name] = seen + 1
        filename = f"discussion_{base_name}.md" if seen == 0 else f"discussion_{base_name}-{seen+1}.md"

        write_thread_markdown(
            mod_dir / filename,
            thread=thread,
            op_author=op_author,
            messages=messages,
        )

    create_highlights(mod_dir)

    report = {
        "slug": mod.slug,
        "title": mod.title,
        "downloads": mod.downloads,
        "threads": thread_count,
        "messages": message_count,
    }
    print(
        f"[done] {mod.slug} threads={thread_count} messages={message_count}",
        file=sys.stderr,
        flush=True,
    )
    return report


def main() -> None:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--output", default="research", help="Output directory path")
    parser.add_argument("--min-downloads", type=int, default=1000, help="Minimum downloads threshold")
    parser.add_argument(
        "--include-core-below-threshold",
        action="store_true",
        help="Force include core mods even if below --min-downloads",
    )
    parser.add_argument("--workers", type=int, default=4, help="Number of parallel workers")
    parser.add_argument("--manifest", default="manifest.json", help="Manifest filename in output directory")
    args = parser.parse_args()

    output_dir = Path(args.output)
    output_dir.mkdir(parents=True, exist_ok=True)

    discovery_session = make_session()
    mods = discover_mods(
        discovery_session,
        min_downloads=args.min_downloads,
        include_core_below_threshold=args.include_core_below_threshold,
    )

    if not mods:
        raise RuntimeError("No matching mods discovered. Check filters and portal availability.")

    reports: list[dict[str, Any]] = []
    failures: list[dict[str, str]] = []

    with concurrent.futures.ThreadPoolExecutor(max_workers=max(1, args.workers)) as executor:
        futures = {executor.submit(process_mod, mod, output_dir): mod for mod in mods}
        for future in concurrent.futures.as_completed(futures):
            mod = futures[future]
            try:
                result = future.result()
                reports.append(result)
            except Exception as exc:  # noqa: BLE001
                failures.append({"slug": mod.slug, "error": str(exc)})

    manifest = {
        "generated_at": time.strftime("%Y-%m-%dT%H:%M:%SZ", time.gmtime()),
        "base_url": BASE_URL,
        "min_downloads": args.min_downloads,
        "include_core_below_threshold": args.include_core_below_threshold,
        "mods": sorted(reports, key=lambda item: item["downloads"], reverse=True),
        "failures": failures,
    }

    (output_dir / args.manifest).write_text(json.dumps(manifest, indent=2), encoding="utf-8")

    print(json.dumps(manifest, indent=2))


if __name__ == "__main__":
    main()
