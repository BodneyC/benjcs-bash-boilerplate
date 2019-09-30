#!/usr/bin/env bash

# shellcheck disable=SC2034

###
# FN: standard-help-version.sh
# DS: Provides help and version functionality 
#     in the manner which is default for 
#     sub-command-pattern of the same 
#     repository
###

ESUCC=0
EPROG=1
EOPTN=2
EFILE=3
EARGS=4

TRUTH=0
FALSE=1

ERRO_COL=$(tput setaf 1)
SUCC_COL=$(tput setaf 2)
WARN_COL=$(tput setaf 3)
NORM_COL=$(tput sgr0)

DEBUG=0
DEBG_COL=$(tput setaf 6)
