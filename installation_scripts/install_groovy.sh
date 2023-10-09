#!/usr/bin/env bash
#
# Install all the Groovy compiler

export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
sdk install groovy 4.0.12 < /dev/null
