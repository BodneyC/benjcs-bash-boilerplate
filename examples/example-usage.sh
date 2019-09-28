#!/usr/bin/env bash

[[ -z "$BOD_BASH_PATH" ]] && BOD_BASH_PATH="$(git rev-parse --show-toplevel)/scripts"
# shellcheck disable=SC1090
for f in "$BOD_BASH_PATH"/*.sh; do
	if ! . "$f"; then
		printf "%s\n" "$(tput setaf 1)Could not source $f in $BOD_BASH_PATH$(tput sgr0)"
		return 1
	fi
done

trap _sig_recv SIGINT

func_command1() {
	echo "in command1 [$*]"
	IFS=', ' read -r -a argv <<< "$(_find_next_subcommand "$@")"
	if [[ ${#argv[@]} -gt 0 ]]; then
		_argparse "${argv[@]}"
	fi
}

func_command4() {
	echo "in command4 [$*]"
}

main() {
	_argparse "$@"
}

main "$@"
