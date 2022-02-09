project "erika"
    kind "SharedLib"
    location "erika"
    language "C++"
    cppdialect "C++17"
    staticruntime "off"

    targetdir(ptdir)
    objdir(podir)

    files
    {
        "%{prj.name}/include/**.h",
        "%{prj.name}/src/**.h",
        "%{prj.name}/src/**.cpp",
        "%{prj.name}/vendor/**.c",
        "%{prj.name}/vendor/**.cpp",
        "%{prj.name}/vendor/**.h",
    }

    sysincludedirs
    {
        "vendor/src",
        "vendor/include",
        "%{prj.name}/vendor/include",
    }

    includedirs
    {
        "%{prj.name}/include",
    }

	postbuildcommands
	{
        "{COPY} %{prj.name}.build.meta ../" .. ptdir,
	}

    filter "system:windows"
        systemversion "latest"

        files
        {
            "%{prj.name}/vendor/**.natvis",
        }

        links
        {
            
        }

        defines
        {
            "ERIKA_WIN",
        }

        postbuildcommands
        {
            "{COPY} vendor/bin/*.dll ../../" .. ptdir,
            "{COPY} ../vendor/bin/*.dll ../" .. ptdir,
        }

    filter "system:linux"
        links
        {
            
        }

        defines
        {
            "ERIKA_LINUX",
        }

    filter "configurations:debug"
        runtime "Debug"
        symbols "on"

        defines
        {
            "ERIKA_DEBUG",
        }

    filter "configurations:release"
        runtime "Release"
        symbols "off"
        optimize "on"

		defines
        {
            "ERIKA_RELEASE",
        }
