#!/usr/bin/env bash

set -euo pipefail

source "${XDG_CONFIG_HOME}/bash/functions"
source "${XDG_CONFIG_HOME}/bash/exports"

readonly link_file='/etc/dnf/dnf.conf'
readonly target_file="${HOME}/.etc/dnf.conf"

if ! executable_exists 'dnf'; then
  exit 0
fi
if [[ -L "${link_file}" && "$(readlink --canonicalize "${link_file}")" == "$(readlink --canonicalize "${target_file}")" ]]; then
  exit 0
fi
if [[ -f "${link_file}" ]]; then
  diff --color --unified "${link_file}" "${target_file}" || true
  if ! prompt_yn "${link_file} exists - Link: ${target_file} -> ${link_file}?"; then
    exit 0
  fi
else
  if ! prompt_yn "Link: ${target_file} -> ${link_file}?"; then
    exit 0
  fi
fi

log "Linking: ${target_file} -> ${link_file}"
if [[ -f "${link_file}" ]]; then
  sudo rm "${link_file}"
fi
sudo mkdir --parents "$(dirname "${link_file}")"
sudo ln --symbolic "${target_file}" "${link_file}"
log "Linked: ${target_file} -> ${link_file}"
