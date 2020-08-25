#!/usr/bin/env bash

source /home/juozas/nix-config/variables.env

desktop_dir="/home/juozas/nix-config/nixpkgs/desktop"
ln -sf "${desktop_dir}/${NIX_CONFIG_DE}.nix" \
  "${desktop_dir}/current.nix"

machine_dir="/home/juozas/nix-config/nixpkgs/machine"
ln -sf "${machine_dir}/${NIX_CONFIG_MACHINE}.nix" \
  "${machine_dir}/current.nix"

user_dir="/home/juozas/nix-config/nixpkgs/environment"
ln -sf "${user_dir}/${NIX_CONFIG_ENV}.nix" \
  "${user_dir}/current.nix"
