import { MapPosition, MapPositionStruct } from 'factorio:prototype';
import { BoundingBox as FBoundingBox } from 'factorio:prototype';

export interface BBox {
	topLeft: MapPositionStruct;
	bottomRight: MapPositionStruct;
}

export function convertFactorioBoundingBox(bb: FBoundingBox, position: MapPositionStruct = { x: 0, y: 0 }): BBox {
	const pos = (p: MapPosition): MapPositionStruct => (Array.isArray(p) ? { x: p[0], y: p[1] } : (p as any));

	let tl: MapPositionStruct;
	let br: MapPositionStruct;
	let orientation = 0;

	if ('left_top' in bb) {
		tl = pos(bb.left_top);
		br = pos(bb.right_bottom);
		orientation = bb.orientation ?? 0;
	} else {
		tl = pos(bb[0]);
		br = pos(bb[1]);
		if (bb.length === 3) orientation = bb[2];
	}

	const halfW = (br.x - tl.x) / 2;
	const halfH = (br.y - tl.y) / 2;
	const cx = tl.x + halfW + position.x;
	const cy = tl.y + halfH + position.y;
	const angle = orientation * 2 * Math.PI;
	const cos = Math.abs(Math.cos(angle));
	const sin = Math.abs(Math.sin(angle));
	const rw = halfW * cos + halfH * sin;
	const rh = halfW * sin + halfH * cos;

	return {
		topLeft: { x: cx - rw, y: cy - rh },
		bottomRight: { x: cx + rw, y: cy + rh },
	};
}

export function bboxIntersect(a: BBox, b: BBox): boolean {
	return (
		a.topLeft.x < b.bottomRight.x &&
		a.bottomRight.x > b.topLeft.x &&
		a.topLeft.y < b.bottomRight.y &&
		a.bottomRight.y > b.topLeft.y
	);
}

export function rotateCoordinate(tile: MapPositionStruct, direction: defines.direction) {
	switch (direction) {
		case defines.direction.east:
			return { x: -tile.y, y: tile.x };
		case defines.direction.south:
			return { x: -tile.x, y: -tile.y };
		case defines.direction.west:
			return { x: tile.y, y: -tile.x };
		default:
			return { x: tile.x, y: tile.y };
	}
}
