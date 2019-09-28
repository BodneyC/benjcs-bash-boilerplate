#!/usr/bin/env bash

cd "$(dirname "${BASH_SOURCE[0]}")/.." || exit

_ERR=$(tput setaf 1)
_SUCCESS=$(tput setaf 2)
_NORMAL=$(tput sgr0)

test_case() {
	EXPECTED="$1"; shift
	echo "Test case: $EXPECTED"
	ACTUAL="$(./examples/example-usage.sh "$@" | paste -sd "," -)"
	if [[ "$ACTUAL" == "$EXPECTED" ]]; then
		printf "%s\n" "  ${_SUCCESS}Success${_NORMAL}"
	else
		printf "%s\n" "   Result: $ACTUAL"
		printf "%s\n" "  ${_ERR}Failure${_NORMAL}"
	fi
	echo
}

test_case "Little help"    -h
test_case "Big help"       -H
test_case "Little version" -v
test_case "Big version"    -V

test_case "${_ERR}Unknown command: func_INVALID_COMMAND, exiting...${_NORMAL}" \
	INVALID_COMMAND
test_case "in command1 [-v -f]" \
	command1 -v -f
test_case "in command1 [-v command4 -H],in command4 [-H]" \
	command1 -v command4 -H
