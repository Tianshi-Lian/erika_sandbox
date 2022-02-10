project "demo"
    location "demo"
    kind "ConsoleApp"
    language "C++"
    cppdialect "C++17"
    staticruntime "off"

    targetdir(ptdir)
    objdir(podir)
    debugdir("data")

    files
    {
        "%{prj.name}/include/**.h",
        "%{prj.name}/src/**.h",
        "%{prj.name}/src/**.cpp",
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
        "erika/erika/include",
        "erika/erika/vendor/include",
    }

    links
    {
        "erika",
    }

	postbuildcommands
	{
		"python ../tools/_postbuild.py project=%{prj.name}",
		"{COPY} %{prj.name}.build.meta ../" .. ptdir,
        "{COPY} ../" ..tdir .. "/erika/erika.dll ../" ..ptdir
	}

    filter "system:windows"
        systemversion "latest"
        
        debugdir(ptdir)

        files
        {
            "%{prj.name}/vendor/**.natvis",
        }

        links
        {
            
        }

        defines
        {
            "PR_WIN",
            "ERIKA_WIN",
        }

        postbuildcommands
        {
            "IF NOT EXIST vendor {MKDIR} vendor",
            "IF NOT EXIST vendor/bin {MKDIR} vendor/bin",
            "{COPY} vendor/bin/*.dll ../../" .. ptdir,
            "IF NOT EXIST ../vendor {MKDIR} ../vendor",
            "IF NOT EXIST ../vendor/bin {MKDIR} ../vendor/bin",
            "{COPY} ../vendor/bin/*.dll ../" .. ptdir,
        }

    filter "system:linux"
        links
        {
            
        }

        defines
        {
            "PR_LINUX",
            "ERIKA_LINUX",
        }

    filter "configurations:debug"
        runtime "Debug"
        symbols "on"

        defines
        {
            "PR_DEBUG",
            "ERIKA_DEBUG",
        }

    filter "configurations:release"
        runtime "Release"
        symbols "off"
        optimize "on"

		defines
        {
            "PR_RELEASE",
            "ERIKA_RELEASE"
        }
