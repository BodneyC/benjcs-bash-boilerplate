#!/usr/bin/env bash

###
# FN: sub-command-pattern.sh
# DS: A configurable sub-command pattern for argument 
#      parsing in bash. One would need to set the cases 
#      to something a little more useful than command1, 
#      2, 3... to actually use this.
#     The idea is to have one of these files for each
#      subcommand and source the relevant file redefining
#      the _argparse() function, each time executing
#      func_$cmd with the args and switches.
###

_find_next_subcommand() {
	while [[ -n $1 ]]; do
		if ! [[ "$1" =~ ^-.* ]]; then
			echo "$@"
			return
		fi
		shift
	done
}

_argparse() {
	_argparse_done_check() {
		[[ -z "$1" && -z "$2" ]] && echo 1
	}

	argv=()
	cmd=""
	arg_end=""

	[[ $# == 0 ]] && cmd="help"

	shopt -s extglob
 
	while [[ -n "$1" ]]; do
		CHECK=$(_argparse_done_check "$cmd" "$arg_end")
		case "$1" in
			--) arg_end=1 ;;
			-*) case "$1" in
					-h)           [[ -n "$CHECK" ]] && cmd="help"    || argv+=("$1") ;;
					-H|--help)    [[ -n "$CHECK" ]] && cmd="HELP"    || argv+=("$1") ;;
					-v)           [[ -n "$CHECK" ]] && cmd="version" || argv+=("$1") ;;
					-V|--version) [[ -n "$CHECK" ]] && cmd="VERSION" || argv+=("$1") ;;
					*)            [[ -n "$CHECK" ]] \
					                  && _exit_msg "Unknown option: $1" "$EOPTN" \
					                  || argv+=("$1")
				esac ;;
			command1) [[ -n "$CHECK" ]] && cmd="command1" || argv+=("$1") ;;
			command2) [[ -n "$CHECK" ]] && cmd="command2" || argv+=("$1") ;;
			command3) [[ -n "$CHECK" ]] && cmd="command3" || argv+=("$1") ;;
			command4) [[ -n "$CHECK" ]] && cmd="command4" || argv+=("$1") ;;
			*)        [[ -n "$CHECK" ]] && cmd="$1"   || argv+=("$1") ;;
		esac
		shift
	done

	if ! type "func_$cmd" >& /dev/null; then
		_exit_msg "Unknown command: func_$cmd" "$EOPTN"
	fi

	"func_$cmd" "${argv[@]}"
}
