#include <erika.h>

int main() {
	erika::test(5);

	erika::Window window;

	while (!window.shouldClose()) {
		window.beginRender();
		window.clear();
		window.endRender();
	}

	return 0;
}
