#!/usr/bin/env bash
#
# Install the Kotlin compiler

export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
sdk install kotlin 1.8.20 < /dev/null
