#!/bin/sh
set -e

stow --dir="$PWD/hosts" --target="$HOME" --adopt common

