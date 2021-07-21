
#include <glad.h>
#include <iostream>
#include "backend.h"


void gl_init()
{
	static bool Initialized = false;
	if (!Initialized)
	{
		Initialized = true;
		if (gladLoadGL())
		{
			std::cout << glGetString(GL_RENDERER) << "\n";
			std::cout << glGetString(GL_VERSION) << "\n";
		}
		else
		{
			std::cout << "Failed to load OpenGL!\n";
		}
	}
}


void gl_draw()
{
	glClearColor(1.0, 0.0, 1.0, 1.0);
	glClear(GL_COLOR_BUFFER_BIT);
}


void gl_halt()
{
	std::cout << "Shutting down...\n";
}
