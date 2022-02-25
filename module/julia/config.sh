#!/bin/bash
mkdir -p $HOME/.julia
mkdir -p $HOME/.julia/config
ln -sf $DOTFILES/julia/config/startup.jl $HOME/.julia/config/startup.jl
