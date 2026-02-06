# -----------------------------------------------------
# EXPORTS & PATHS
# -----------------------------------------------------
export ZSH="$HOME/.oh-my-zsh"
export EDITOR=nvim
export PATH="$HOME/.cargo/bin:$HOME/.local/bin:/usr/lib/ccache/bin/:$HOME/.local/share/go/bin:$PATH"
export FZF_DEFAULT_COMMAND='rg --files --hidden --follow --glob "!.git/*"'

# -----------------------------------------------------
# OH-MY-ZSH CONFIG
# -----------------------------------------------------
plugins=(
    git
    sudo
    archlinux
    zsh-autosuggestions
    fast-syntax-highlighting
    copyfile
    copybuffer
    dirhistory
)

source $ZSH/oh-my-zsh.sh

# -----------------------------------------------------
# HISTORY & KEYBINDINGS
# -----------------------------------------------------
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory

# FZF (Ctrl+R to search history)
source <(fzf --zsh)

# -----------------------------------------------------
# ALIASES
# -----------------------------------------------------
# System
alias c='clear'
alias shutdown='systemctl poweroff'
alias wifi='nmtui'

# Editors
alias v='$EDITOR'
alias vim='$EDITOR'

# Tools (Modern replacements)
alias cat='bat'
alias ls='eza -a --icons=always'
alias ll='eza -al --icons=always'
alias lt='eza -a --tree --level=1 --icons=always'
alias grep='grep --color=auto'

# Safety
alias rm='rm -I'

# Fastfetch
alias ff='fastfetch'
alias neofetch='fastfetch'

# -----------------------------------------------------
# PROMPT & THEME
# -----------------------------------------------------
# Ensure oh-my-posh is configured
if [ -f "$HOME/.config/ohmyposh/EDM115-newline.omp.json" ]; then
    eval "$(oh-my-posh init zsh --config $HOME/.config/ohmyposh/EDM115-newline.omp.json)"
fi

# -----------------------------------------------------
# LANGUAGE & RUNTIME ENVIRONMENTS (Restored from loader)
# -----------------------------------------------------
# Load local env if it exists
[ -f "$HOME/.local/bin/env" ] && . "$HOME/.local/bin/env"

# Haskell (GHCup)
[ -f "$HOME/.ghcup/env" ] && . "$HOME/.ghcup/env"

# Bun (JavaScript Runtime)
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"

# -----------------------------------------------------
# AUTOSTART
# -----------------------------------------------------
# Only run fastfetch if opening a terminal (not a script)
if [[ $(tty) == *"pts"* ]]; then
    fastfetch 
fi
