# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.18

# Delete rule output on recipe failure.
.DELETE_ON_ERROR:


#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:


# Disable VCS-based implicit rules.
% : %,v


# Disable VCS-based implicit rules.
% : RCS/%


# Disable VCS-based implicit rules.
% : RCS/%,v


# Disable VCS-based implicit rules.
% : SCCS/s.%


# Disable VCS-based implicit rules.
% : s.%


.SUFFIXES: .hpux_make_needs_suffix_list


# Command-line flag to silence nested $(MAKE).
$(VERBOSE)MAKESILENT = -s

#Suppress display of executed commands.
$(VERBOSE).SILENT:

# A target that is always out of date.
cmake_force:

.PHONY : cmake_force

#=============================================================================
# Set environment variables for the build.

# The shell in which to execute make rules.
SHELL = /bin/sh

# The CMake executable.
CMAKE_COMMAND = /usr/local/Cellar/cmake/3.18.4/bin/cmake

# The command to remove a file.
RM = /usr/local/Cellar/cmake/3.18.4/bin/cmake -E rm -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /Users/peacesong/Workspace/College_Materials/2020-2/Computer_Programming/labs/11NOV20

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /Users/peacesong/Workspace/College_Materials/2020-2/Computer_Programming/labs/11NOV20

# Include any dependencies generated for this target.
include CMakeFiles/problem5.dir/depend.make

# Include the progress variables for this target.
include CMakeFiles/problem5.dir/progress.make

# Include the compile flags for this target's objects.
include CMakeFiles/problem5.dir/flags.make

CMakeFiles/problem5.dir/problem5.cpp.o: CMakeFiles/problem5.dir/flags.make
CMakeFiles/problem5.dir/problem5.cpp.o: problem5.cpp
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/Users/peacesong/Workspace/College_Materials/2020-2/Computer_Programming/labs/11NOV20/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building CXX object CMakeFiles/problem5.dir/problem5.cpp.o"
	/Library/Developer/CommandLineTools/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/problem5.dir/problem5.cpp.o -c /Users/peacesong/Workspace/College_Materials/2020-2/Computer_Programming/labs/11NOV20/problem5.cpp

CMakeFiles/problem5.dir/problem5.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/problem5.dir/problem5.cpp.i"
	/Library/Developer/CommandLineTools/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /Users/peacesong/Workspace/College_Materials/2020-2/Computer_Programming/labs/11NOV20/problem5.cpp > CMakeFiles/problem5.dir/problem5.cpp.i

CMakeFiles/problem5.dir/problem5.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/problem5.dir/problem5.cpp.s"
	/Library/Developer/CommandLineTools/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /Users/peacesong/Workspace/College_Materials/2020-2/Computer_Programming/labs/11NOV20/problem5.cpp -o CMakeFiles/problem5.dir/problem5.cpp.s

# Object files for target problem5
problem5_OBJECTS = \
"CMakeFiles/problem5.dir/problem5.cpp.o"

# External object files for target problem5
problem5_EXTERNAL_OBJECTS =

problem5: CMakeFiles/problem5.dir/problem5.cpp.o
problem5: CMakeFiles/problem5.dir/build.make
problem5: CMakeFiles/problem5.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/Users/peacesong/Workspace/College_Materials/2020-2/Computer_Programming/labs/11NOV20/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Linking CXX executable problem5"
	$(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/problem5.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
CMakeFiles/problem5.dir/build: problem5

.PHONY : CMakeFiles/problem5.dir/build

CMakeFiles/problem5.dir/clean:
	$(CMAKE_COMMAND) -P CMakeFiles/problem5.dir/cmake_clean.cmake
.PHONY : CMakeFiles/problem5.dir/clean

CMakeFiles/problem5.dir/depend:
	cd /Users/peacesong/Workspace/College_Materials/2020-2/Computer_Programming/labs/11NOV20 && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /Users/peacesong/Workspace/College_Materials/2020-2/Computer_Programming/labs/11NOV20 /Users/peacesong/Workspace/College_Materials/2020-2/Computer_Programming/labs/11NOV20 /Users/peacesong/Workspace/College_Materials/2020-2/Computer_Programming/labs/11NOV20 /Users/peacesong/Workspace/College_Materials/2020-2/Computer_Programming/labs/11NOV20 /Users/peacesong/Workspace/College_Materials/2020-2/Computer_Programming/labs/11NOV20/CMakeFiles/problem5.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : CMakeFiles/problem5.dir/depend

