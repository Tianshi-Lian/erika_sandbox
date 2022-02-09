#pragma once

#include "core/types.h"

namespace erika {

	class ERIKA_EXPORT Window {
	public:
		Window(u32 width = 1600, u32 height = 900, std::string title = "erika");
		~Window();

		void beginRender();
		void endRender();

		void clear();

		bool shouldClose() const;
		u32 getWidth() const;
		u32 getHeight() const;

	private:
		u32 m_width;
		u32 m_height;
	};

} // erika
