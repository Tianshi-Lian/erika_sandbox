workspace "project_rob"
    startproject "demo"
    architecture "x64"

    configurations
    {
        "debug",
        "release"
    }

-- This ensures that the projects we're importing from other "workspace"-based submodules will build inside us and not them
tdir = "../bin/%{cfg.system}-%{cfg.buildcfg}-%{cfg.architecture}"
odir = "../bin-int/%{cfg.system}-%{cfg.buildcfg}-%{cfg.architecture}"
ptdir = tdir .. "/%{prj.name}"
podir = odir .. "/%{prj.name}"

include "erika/erika.lua"

-- Change back to our workspace-relative path
tdir = "bin/%{cfg.system}-%{cfg.buildcfg}-%{cfg.architecture}"
odir = "bin-int/%{cfg.system}-%{cfg.buildcfg}-%{cfg.architecture}"
ptdir = tdir .. "/%{prj.name}"
podir = odir .. "/%{prj.name}"

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
