set SPACEFISH_CHAR_SYMBOL λ

# opam configuration
source /home/dalbonio/.opam/opam-init/init.fish > /dev/null 2> /dev/null; or true

set -x FZF_DEFAULT_COMMAND 'fd'

alias code "code &>/dev/null"

export PATH="$HOME/.rbenv/bin:$PATH"
status --is-interactive; and . (rbenv init -|psub)
