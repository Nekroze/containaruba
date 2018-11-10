#!/bin/sh
set -euf
C_CYAN='\033[0;36m'
C_YELLOW='\033[0;33m'
C_GRAY='\033[0;30m'
C_CLR='\033[0m'

inform() {
	echo "\n${C_YELLOW}(${C_GRAY}⌐■_■${C_YELLOW}) ${C_CYAN}$*${C_CLR}\n"
}

if [ ! -d features/support ]; then
	mkdir -p features/support
	trap 'rm -rf features/support' EXIT QUIT TERM
	cleaning='true'
fi

# Ensure aruba is included in your support files.
support_line="require 'aruba/cucumber'"
if ! grep "$support_line" -R features/support/; then
	echo "$support_line" >> features/support/aruba.rb
	[ "${cleaning:-false}" ] || trap 'rm -f features/support/aruba.rb' EXIT QUIT TERM
fi

inform 'Linting feature files with cucumber_lint!'
cucumber_lint

inform 'Executing feature files with cucumber!'
cucumber --color --fail-fast --strict --expand "$@"
