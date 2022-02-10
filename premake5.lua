workspace "project_rob"
    startproject "demo"
    --startproject "sample_runner"
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

-- Submodules
include "erika/erika.lua"

-- Change back to our workspace-relative path
tdir = "bin/%{cfg.system}-%{cfg.buildcfg}-%{cfg.architecture}"
odir = "bin-int/%{cfg.system}-%{cfg.buildcfg}-%{cfg.architecture}"
ptdir = tdir .. "/%{prj.name}"
podir = odir .. "/%{prj.name}"

-- Samples
include "samples.lua"
--include "sample_runner.lua"