workspace "erika_lib"
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

    include "erika.lua"

