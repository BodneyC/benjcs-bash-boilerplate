#!/usr/bin/env bash

###
# FN: standard-help-version.sh
# DS: Provides help and version functionality 
#      in the manner which is default for 
#      sub-command-pattern of the same 
#      repository
###

func_help() {
	printf "%s\n" "Little help"
}

func_HELP() {
	printf "%s\n" "Big help"
}

func_version() {
	printf "%s\n" "Little version"
}

func_VERSION() {
	printf "%s\n" "Big version"
}

