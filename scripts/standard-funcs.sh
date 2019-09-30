#!/usr/bin/env bash

###
# FN: standard-funcs.sh
# DS: Functions which I tend to use in most scripts; 
#      particularly _exit_msg() I write at the top of 
#      pretty much every script, allows one to one-
#      line conditionals.
###

ERRO_COL=$(tput setaf 1)
SUCC_COL=$(tput setaf 2)
WARN_COL=$(tput setaf 3)
NORM_COL=$(tput sgr0)
DEBG_COL=$(tput setaf 6)

_msg_ext() { # exit_{msg,code}
	_msg_dbg "$@"
	printf "%s\n" "$ERRO_COL$1, exiting...$NORM_COL"; exit "$2"
}

_msg_dbg() { # exit_{msg,code}
	if [[ "$DEBUG" == 1 ]]; then
		if [[ -n "$2" ]]; then
			printf "%s\n" "${ERRO_COL}[${FUNCNAME[1]//func_/}] $1$NORM_COL"
			# shellcheck disable=SC2001
			printf "%s\n%s\n" "${ERRO_COL}Functrace:" \
				"  $(sed 's/ /\n  /g' <<< "${FUNCNAME[@]}")$NORM_COL"
			exit "$2"
		fi
		printf "%s\n" "${DEBG_COL}[${FUNCNAME[1]//func_/}] $1$NORM_COL"
	fi
}
 
_sig_recv() {
	printf "\n%s\n" "${WARN_COL}Signal recieved$NORM_COL"; exit 1
}
 
_check_dir_exists() { # dirname, create_dir
	if [[ ! -d "$1" ]]; then
		if [[ -n "$2" ]]; then
			printf "%s\n" "$WARN_COL$1 not found, creating...$NORM_COL"
			mkdir -p "$1"
			printf "%s\n" "$SUCC_COL$1 created$NORM_COL"
		else
			return 1
		fi
	fi
}
 
_check_file_exists() { # filename, touch_file
	if [[ ! -f "$1" ]]; then
		if [[ -n "$2" ]]; then
			printf "%s\n" "$WARN_COL$1 not found, touching...$NORM_COL"
			_check_dir_exists "$(dirname "$1")" Y
			touch "$1"
			printf "%s\n" "$SUCC_COL$1 touched$NORM_COL"
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
			*)     printf "%s\n" "${ERRO_COL}Invalid option$NORM_COL"
		esac
	done
}

_no_args() { # [exit_func, [args,]]
	if [[ $# -eq 0 ]]; then
		"$@"
		exit "$EARGS"
	fi
}

# NOTE: Must `declare -A B` first
_validate_software() { # progs,
	for s in "$@"; do
		hash "$s" || continue
		# shellcheck disable=SC2034,SC2230
		B["$s"]="$(which "$s")"
	done
}
