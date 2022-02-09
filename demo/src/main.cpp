#include <erika.h>

#include <iostream>

int main() {
	std::cout << "Hello, World" << std::endl;

	erika::test(5);

	erika::Window window;

	while (!window.shouldClose()) {
		window.beginRender();
		window.clear();
		window.endRender();
	}

	return 0;
}
