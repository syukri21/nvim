#!/bin/bash
export JAVA_HOME="/opt/homebrew/opt/openjdk@17"
echo $JAVA_HOME
echo $PATH
exec /Users/syukri.khairi/.local/share/nvim/mason/bin/jdtls "$@"
