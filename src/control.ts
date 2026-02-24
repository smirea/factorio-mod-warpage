import '@/modules/ship/control.ts';
import '@/modules/thermite/control.ts';
import { registerGlobal } from './lib/utils';

script.on_init(() => {
	initStorage();
});

registerGlobal('initStorage', initStorage);

function initStorage() {
	storage.surface ||= 'nauvis';
}
