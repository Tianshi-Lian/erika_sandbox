#include "graphics/window.h"

using namespace erika;

Window::Window(u32 width, u32 height, std::string title)
	: m_width(width)
	, m_height(height) {
}

Window::~Window() {
}

void Window::beginRender() {
}

void Window::endRender() {
}

void Window::clear() {
}

bool Window::shouldClose() const {
	return false;
}

u32 Window::getWidth() const {
	return m_width;
}

u32 Window::getHeight() const {
	return m_height;
}
