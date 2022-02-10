#include <erika.h>
#include <debug/instrumentor.h>

#include <iostream>

int main() {
	PROFILE_BEGIN_SESSION("demo", "timings.json");

	{
		PROFILE_SCOPE("main");

		std::cout << "Hello, World" << std::endl;

		erika::test(5);

		erika::Window window;

		//while (!window.shouldClose()) {
		window.beginRender();
		window.clear();
		window.endRender();
		//}
	}

	PROFILE_END_SESSION();
	return 0;
}
