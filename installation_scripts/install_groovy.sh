#!/usr/bin/env bash
#
# Install all the Groovy compiler

export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
sdk install groovy 5.0.0-alpha-2 < /dev/null
