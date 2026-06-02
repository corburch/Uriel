# =====================================================================
# URIEL CORE TERMINAL PROFILE (.zshrc)
# =====================================================================

# 1. Powerlevel10k Instant Prompt Initialization
# Speeds up shell startup times dramatically by rendering the prompt ahead of modules
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# 2. Oh My ZSH Base System Architecture
export ZSH="$HOME/.oh-my-zsh"

# 3. Theme Allocation
# Instructs Oh My ZSH to hand prompt management over to Powerlevel10k
ZSH_THEME="powerlevel10k/powerlevel10k"

# 4. Oh My ZSH Behavior Configurations
CASE_SENSITIVE="false"     # Lowercase matching works on tabs
HYPERLINK_SUPPORT="true"   # Enables terminal clickable link paths
DISABLE_UNTRACKED_FILES_DIRTY="true" # Boosts large git repo terminal navigation speed

# 5. Native Core Plugins
# Adds foundational helpers without clunky external scripts
plugins=(
  git
  colored-man-pages
)

# 6. Source Oh My ZSH Execution Loop
if [ -f "$ZSH/oh-my-zsh.sh" ]; then
  source "$ZSH/oh-my-zsh.sh"
fi

# ---------------------------------------------------------------------
# APPLICATION INTEGRATIONS & ALIASES
# ---------------------------------------------------------------------

# Modern LSDeluxe Directory Overrides
if command -v lsd &> /dev/null; then
  alias ls='lsd'
  alias l='lsd -l'
  alias lsa='lsd -a'
  alias lla='lsd -la'
  alias lst='lsd --tree'
fi

# System Conveniences
alias c='clear'
alias cls='clear; ls'
alias cff='clear; fastfetch'
alias ff='fastfetch'

alias ..='cd ..'


# ---------------------------------------------------------------------
# TERMINAL INITIALIZATION RUNTIME
# ---------------------------------------------------------------------

# Launch Minimalist Fastfetch System Check
# Evaluates if fastfetch is available on the path and runs it seamlessly on login
if command -v fastfetch &> /dev/null; then
  fastfetch
fi

# 7. Local Powerlevel10k Custom Configuration Hook
# Looks for your custom configuration profile layout if configured
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh