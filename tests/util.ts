import { execFileSync } from "node:child_process";
import { existsSync } from "node:fs";
import { dirname, join, resolve } from "node:path";
import { fileURLToPath } from "node:url";

export type CreateTestEnvironmentOptions = {
  repo_root?: string;
  launch_root?: string;
  save_name?: string;
  until_tick?: number;
};

export type TestEnvironment = {
  repo_root: string;
  launch_root: string;
  save_file: string;
  until_tick: number;
};

const DEFAULT_UNTIL_TICK = 180;

function ensure_factorio_bin_exists(): void {
  const factorio_bin = process.env.FACTORIO_BIN ?? "/Applications/factorio.app/Contents/MacOS/factorio";
  if (!existsSync(factorio_bin)) {
    throw new Error(`Factorio binary is missing at '${factorio_bin}'. Set FACTORIO_BIN first.`);
  }
}

function clear_launch_root(launch_root: string): void {
  if (!existsSync(launch_root)) {
    return;
  }

  execFileSync("trash", ["-rf", launch_root], {
    stdio: "inherit"
  });
}

function run_headless_once(repo_root: string, launch_root: string, save_name: string, until_tick: number): void {
  execFileSync(join(repo_root, "scripts", "launch.sh"), [save_name], {
    cwd: repo_root,
    stdio: "inherit",
    env: {
      ...process.env,
      LAUNCH_ROOT: launch_root,
      HEADLESS: "1",
      UNTIL_TICK: String(until_tick)
    }
  });
}

export function create_test_environment(options: CreateTestEnvironmentOptions = {}): TestEnvironment {
  ensure_factorio_bin_exists();

  const this_file = fileURLToPath(import.meta.url);
  const default_repo_root = resolve(dirname(this_file), "..");

  const repo_root = options.repo_root ?? default_repo_root;
  const launch_root = options.launch_root ?? join(repo_root, ".tmp", "factorio-test-env");
  const save_name = options.save_name ?? "warpage-ship-tests";
  const until_tick = options.until_tick ?? DEFAULT_UNTIL_TICK;

  if (!Number.isInteger(until_tick) || until_tick < 1) {
    throw new Error(`until_tick must be a positive integer, got '${String(until_tick)}'.`);
  }

  clear_launch_root(launch_root);
  run_headless_once(repo_root, launch_root, save_name, until_tick);

  return {
    repo_root,
    launch_root,
    save_file: join(launch_root, "write-data", "saves", `${save_name}.zip`),
    until_tick
  };
}
