import '@/modules/ship/control.ts';
import '@/modules/thermite/control.ts';
import { registerGlobal } from './lib/utils';

script.on_init(() => {
	initStorage();
	initStart();
});

registerGlobal('initStorage', initStorage);
registerGlobal('initStart', initStart);

function initStorage() {
	storage.surface ||= 'nauvis';
}

function initStart() {
	const freeplayInterfaceName = 'freeplay';
	const freeplay = remote.interfaces[freeplayInterfaceName];
	if (!freeplay) return;
	remote.call(freeplayInterfaceName, 'set_ship_items', {});
	remote.call(freeplayInterfaceName, 'set_debris_items', {});
	remote.call(freeplayInterfaceName, 'set_skip_intro', true);
	remote.call(freeplayInterfaceName, 'set_disable_crashsite', true);
}
