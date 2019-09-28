Bod's Bash Standard Functions and Variables
===========================================

Adding much unwanted boilerplate to Bash scripting...

## Description

Realistically this is a place to store regularly used functions and variables more as reference than anything else; however, it made sense (to me at least) to write the repo in a way that one could just clone the repo, source a couple of files in a script, and use the functions at will.

## Scripts

Most of these are self explanatory but I figured I should describe them anyway.

**standard-vars**

Variables including return codes, true/false, colors for use in `printf`.

**standard-funcs**

Functions I tend to use quite a bit such as `_exit_msg` which prints a message before exiting, `check_{dir,file}_exists` which checks a file's existence and optionally creates it if it doesn't, and several others.

**standard-help-version**

Defines four functions, `func_{help,HELP,version,VERSION}` which are left mainly blank but are useful with `sub-command-pattern.sh`.

**sub-command-pattern**

This is essentially an argument parser, however, as can be seen in `./examples/example-usage.sh` it can be used to provide subcommand functionality. 

The idea would be make a version of this file for each level and sub-level, in each of the functions which are named as subcommands, source the relevant file, redefine `_argparse` and run the function with the subcommand and its arguments. Getting only the subcommands and the following can be done with the second function of the file, `_find_next_subcommand`.

## Examples

Well, example, just the one file to show the use of some of these functions, how one may source the relevant files, and a small example of the sub-command functionality.

There is a test script which performs a few tests, obviously.
