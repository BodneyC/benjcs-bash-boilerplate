#!/usr/bin/env bash

###
# FN: standard-funcs.sh
# DS: Functions which I tend to use in most scripts; 
#      particularly _exit_msg() I write at the top of 
#      pretty much every script, allows one to one-
#      line conditionals.
###

_ERR=$(tput setaf 1)
_SUCCESS=$(tput setaf 2)
_WARNING=$(tput setaf 3)
_NORMAL=$(tput sgr0)

_exit_msg() { # exit_{msg,code}
	printf "%s\n" "$_ERR$1, exiting...$_NORMAL"; exit "$2"
}
 
_sig_recv() {
	printf "%s\n" "${_WARNING}Signal recieved\n$_NORMAL"; exit 1
}
 
_check_dir_exists() { # dirname, create_dir
	if [[ ! -d "$1" ]]; then
		if [[ -n "$2" ]]; then
			printf "%s\n" "$_WARNING$1 not found, creating...$_NORMAL"
			mkdir -p "$1"
			printf "%s\n" "$_SUCCESS$1 created$_NORMAL"
		else
			return 1
		fi
	fi
}
 
_check_file_exists() { # filename, touch_file
	if [[ ! -f "$1" ]]; then
		if [[ -n "$2" ]]; then
			printf "%s\n" "$_WARNING$1 not found, touching...$_NORMAL"
			_check_dir_exists "$(dirname "$1")" Y
			touch "$1"
			printf "%s\n" "$_SUCCESS$1 touched$_NORMAL"
		else
			return 1
		fi
	fi
}

 
_yes_or_no() { # msg
	# shellcheck disable=SC2050
	while [[ 1 == 1 ]]; do 
		read -rp "$1 [yn] "
		case "$REPLY" in
			[yY]*) return 0 ;;
			[nN]*) return 1 ;;
			*)     printf "%s\n" "${_ERR}Invalid option$_NORMAL"
		esac
	done
}

_no_args() { # [exit_func, [args,]]
	if [[ $# -eq 0 ]]; then
		"$@"
		exit "$EARGS"
	fi
}

declare -A B
_validate_software() { # progs,
	for s in "$@"; do
		hash "$s" || continue
		B["$s"]="$(which "$s")"
	done
}
