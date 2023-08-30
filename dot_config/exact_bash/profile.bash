#!/usr/bin/env bash

if [[ -r "${HOME}/.profile" ]]; then
  source "${HOME}/.profile"
fi

if [[ -r "${HOME}/.bashrc" ]]; then
  source "${HOME}/.bashrc"
fi
