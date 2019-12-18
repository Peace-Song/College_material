//------------------------------------------------------------------------------
/// @file  fileinfo.c
/// @brief sample solution to practice problem 1
///
/// @author Bernhard Egger <bernhard@csap.snu.ac.kr>
/// @section changelog Change Log
/// - 2019/12/03 Bernhard Egger created
///
/// @section license_section License
/// Copyright (c) 2019, Computer Systems and Platforms Laboratory, SNU
/// All rights reserved.
///
/// Redistribution and use in source and binary forms,  with or without modifi-
/// cation, are permitted provided that the following conditions are met:
///
/// - Redistributions of source code must retain the above copyright notice,
///   this list of conditions and the following disclaimer.
/// - Redistributions in binary form must reproduce the above copyright notice,
///   this list of conditions and the following disclaimer in the documentation
///   and/or other materials provided with the distribution.
///
/// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
/// AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING,  BUT NOT LIMITED TO,  THE
/// IMPLIED WARRANTIES OF MERCHANTABILITY  AND FITNESS FOR A PARTICULAR PURPOSE
/// ARE DISCLAIMED.  IN NO EVENT SHALL THE COPYRIGHT HOLDER  OR CONTRIBUTORS BE
/// LIABLE FOR ANY DIRECT,  INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSE-
/// QUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF  SUBSTITUTE
/// GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
/// HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN  CONTRACT, STRICT
/// LIABILITY, OR TORT  (INCLUDING NEGLIGENCE OR OTHERWISE)  ARISING IN ANY WAY
/// OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH
/// DAMAGE.
//------------------------------------------------------------------------------

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <dirent.h>
#include <time.h>

/// @brief print information about a single @a file
/// @param file file name
void list_file(const char *file)
{
  struct stat s;

  // retrieve information about file
  if (stat(file, &s) < 0) {
    perror(file);
    return;
  }

  //
  // print file info
  //

  // file size
  fprintf(stdout, "%9ld ", s.st_size);

  // file type. See man 7 inode
  if (S_ISREG(s.st_mode))  fprintf(stdout, "F "); else
  if (S_ISDIR(s.st_mode))  fprintf(stdout, "D "); else
  if (S_ISCHR(s.st_mode))  fprintf(stdout, "C "); else
  if (S_ISBLK(s.st_mode))  fprintf(stdout, "B "); else
  if (S_ISFIFO(s.st_mode)) fprintf(stdout, "P "); else
  if (S_ISLNK(s.st_mode))  fprintf(stdout, "L "); else
  if (S_ISSOCK(s.st_mode)) fprintf(stdout, "S ");
  else fprintf(stdout, "? ");

  // file modification time
  struct tm *t;
  char dtstr[32];

  t = localtime(&(s.st_mtime));
  strftime(dtstr, sizeof(dtstr), "%F %T", t);
  fprintf(stdout, "%s ", dtstr);

  // file name
  fprintf(stdout, "%s\n", file);
}

/// @brief list contents of a directory by calling list_file() for each entry
/// @param dir directory name
void list_directory(const char *dir)
{
  DIR *d;
  struct dirent *de;

  // try to open directory
  d = opendir(dir);
  if (d == NULL) {
    perror(dir);
    return;
  }

  // remember current directory and change into dir
  char *curdir = getcwd(NULL, 0);
  if (chdir(dir) < 0) {
    perror(dir);
    return;
  }

  // iterate through directory
  fprintf(stdout, "%s:\n", dir);
  while ((de = readdir(d)) != NULL) {
    list_file(de->d_name);
  }

  // change back into original directory and free memory
  if (chdir(curdir) < 0) perror(curdir);
  free(curdir);

  // and close directory
  closedir(d);
}

/// @brief list contents of @a path. If @a path is a file, the file is listed
///        using list_file(). If @a path is a directory, its contents are
///        printed using list_dir().
/// @param path path string
void list(const char *path)
{
  struct stat s;

  // retrieve information about path
  if (stat(path, &s) < 0) {
    perror(path);
    return;
  }

  // if it's a directory, list the entire directory
  // if it's not a directory, show only the file itself
  if (S_ISDIR(s.st_mode)) list_directory(path);
  else list_file(path);
}

int main(int argc, char *argv[])
{
  // list contents of current directory if no argument was provided
  if (argc == 1) list(".");
  else {
    for (int i=1; i<argc; i++) {
      list(argv[i]);
    }
  }

  return EXIT_SUCCESS;
}
