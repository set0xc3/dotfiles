#!/bin/sh
set -e

stow --dir="$PWD" --target="$HOME" --adopt common
