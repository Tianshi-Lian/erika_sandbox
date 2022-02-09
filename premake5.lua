workspace "project_rob"
    startproject ""
    architecture "x64"

    configurations
    {
        "debug",
        "release"
    }

tdir = "bin/%{cfg.system}-%{cfg.buildcfg}-%{cfg.architecture}/%{prj.name}"
odir = "bin-int/%{cfg.system}-%{cfg.buildcfg}-%{cfg.architecture}/%{prj.name}"

project "erika"
    location "erika"
    kind "StaticLib"
    language "C++"
    cppdialect "C++17"
    staticruntime "on"

    targetdir(tdir)
    objdir(odir)

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
		"{COPY} %{prj.name}.build.meta ../" .. tdir,
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
            "ERIKA_WIN"
        }

        postbuildcommands
        {
            "{COPY} vendor/bin/*.dll ../../" .. tdir,
            "{COPY} ../vendor/bin/*.dll ../" .. tdir,
        }

    filter "system:linux"
        links
        {
            
        }

        defines
        {
            "ERIKA_LINUX"
        }

    filter "configurations:debug"
        runtime "Debug"
        symbols "on"

        defines
        {
            "ERIKA_DEBUG"
        }

    filter "configurations:release"
        runtime "Release"
        symbols "off"
        optimize "on"

		defines
        {
            "ERIKA_RELEASE"
        }

project "demo"
    location "demo"
    kind "ConsoleApp"
    language "C++"
    cppdialect "C++17"
    staticruntime "on"

    targetdir(tdir)
    objdir(odir)
    debugdir("data")

    files
    {
        "%{prj.name}/include/**.h",
        "%{prj.name}/src/**.h",
        "%{prj.name}/src/**.cpp"
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
        "erika"
    }

	postbuildcommands
	{
		"python ../tools/_postbuild.py project=%{prj.name}",
		"{COPY} %{prj.name}.build.meta ../" .. tdir,
	}

    filter "system:windows"
        systemversion "latest"
        
        debugdir(tdir)

        files
        {
            "%{prj.name}/vendor/**.natvis",
        }

        links
        {
            
        }

        defines
        {
            "PR_WIN"
        }

        postbuildcommands
        {
            "{COPY} vendor/bin/*.dll ../../" .. tdir,
            "{COPY} ../vendor/bin/*.dll ../" .. tdir,
        }

    filter "system:linux"
        links
        {
            
        }

        defines
        {
            "PR_LINUX"
        }

    filter "configurations:debug"
        runtime "Debug"
        symbols "on"

        defines
        {
            "PR_DEBUG"
        }

    filter "configurations:release"
        runtime "Release"
        symbols "off"
        optimize "on"

		defines
        {
            "PR_RELEASE"
        }
