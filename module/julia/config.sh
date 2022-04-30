#!/usr/bin/env sh
mkdir -p "$HOME/.julia"
mkdir -p "$HOME/.julia/config"
ln -sf "$DOTMODULE/julia/config/startup.jl" "$HOME/.julia/config/startup.jl"
