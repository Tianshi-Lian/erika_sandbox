# Project Rob  
A collection of my game projects, developed while developing my personal game engine `erika`, which will be used for my upcoming untitled game.  
  
## Build:
#### Global Dependencies:
- Python3  (may require aliasing `python3` to `python` on cmd/terminal)
  
### Windows:
#### Additional Dependencies:
- Visual Studio 2021 or MSBuild on PATH with C++ compiler  
- Alias for `./cli.bat` to `cli` - alternatively use all commands as `./cli.bat command`.  
  
#### Usage:  
- Use the built-in command line tool `cli gen` to generate a Visual Studio 2021 solution and project.  
- Use the command `cli build` which will build the project using MSBuild for Windows x64.  
- Use `cli run` to run the project.  
  
### Linux:
#### Additional Dependencies:
- g++
- Make  
- Alias in ~/.bash_aliases for `./cli.sh` to `cli` - alternatively use all commands as `./cli.sh command`.  
  
#### Usage:  
- Use the built-in command line tool `cli gen` to generate project Makefiles.  
- Use the command `cli build` which will build the project using Make and g++ for Linux x64.  
- Use `cli run` to run the project.  