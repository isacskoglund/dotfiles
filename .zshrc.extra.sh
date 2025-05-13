eval "$(fzf --zsh)"

autoload -U promptinit; promptinit
zstyle ':prompt:pure:path' color red
zstyle ':prompt:pure:prompt:*' color red
zstyle ':prompt:pure:git:stash' show yes 
prompt pure

zstyle ':completion:*' menu select 
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zmodload zsh/complist
compinit
_comp_options+=(globdots)

bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey '^?' backward-delete-char
bindkey '^ ' autosuggest-accept

# Cursor style
function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd ]] || [[ $1 = 'block' ]]; then
    echo -ne '\e[1 q'
  elif [[ ${KEYMAP} == main ]] || [[ ${KEYMAP} == viins ]] || [[ ${KEYMAP} = '' ]] || [[ $1 = 'beam' ]]; then
    echo -ne '\e[6 q'
  fi
}
zle -N zle-keymap-select
zle-line-init() {
  zle -K viins
  echo -ne "\e[6 q"
}
zle -N zle-line-init
echo -ne '\e[6 q'
preexec() { echo -ne '\e[6 q' ; }

# Change directory using lf
lfcd() {
  local tmp="$(mktemp)"
  lf -last-dir-path="$tmp" --command "set hidden" "$@"
  if [ -f "$tmp" ]; then
    local dir="$(cat "$tmp")"
    rm -f "$tmp"
    [ -d "$dir" ] && [ "$dir" != "$(pwd)" ] && cd "$dir"
  fi
}

lfcd-widget() {
  zle -I
  lfcd
  zle reset-prompt
}
zle -N lfcd-widget
bindkey -M viins '^O' lfcd-widget
bindkey -M emacs '^O' lfcd-widget

autoload -U +X bashcompinit && bashcompinit
