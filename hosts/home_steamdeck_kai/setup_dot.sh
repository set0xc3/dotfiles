#!/bin/sh

stow --dir="$PWD" --target="$HOME" --adopt dotfiles
