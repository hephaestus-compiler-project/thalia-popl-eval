#!/usr/bin/env bash
#
# Install the Kotlin compiler

export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
sdk install kotlin 1.9.0 < /dev/null
