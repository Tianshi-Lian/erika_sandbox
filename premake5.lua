workspace "project_rob"
    startproject "demo"
    architecture "x64"

    configurations
    {
        "debug",
        "release"
    }

tdir = "bin/%{cfg.system}-%{cfg.buildcfg}-%{cfg.architecture}"
odir = "bin-int/%{cfg.system}-%{cfg.buildcfg}-%{cfg.architecture}"
ptdir = tdir .. "/%{prj.name}"
podir = odir .. "/%{prj.name}"

project "erika"
    location "erika"
    kind "SharedLib"
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
		"python ../tools/_postbuild.py project=%{prj.name}",
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
        "erika/include",
        "erika/vendor/include",
    }

    links
    {
        "erika",
    }

	postbuildcommands
	{
		"python ../tools/_postbuild.py project=%{prj.name}",
		"{COPY} %{prj.name}.build.meta ../" .. ptdir,
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
        }

        postbuildcommands
        {
            "{COPY} vendor/bin/*.dll ../../" .. ptdir,
            "{COPY} ../vendor/bin/*.dll ../" .. ptdir,
            "{COPY} ../" ..tdir .. "/erika/erika.dll ../" ..ptdir
        }

    filter "system:linux"
        links
        {
            
        }

        defines
        {
            "PR_LINUX",
        }

    filter "configurations:debug"
        runtime "Debug"
        symbols "on"

        defines
        {
            "PR_DEBUG",
        }

    filter "configurations:release"
        runtime "Release"
        symbols "off"
        optimize "on"

		defines
        {
            "PR_RELEASE",
        }
