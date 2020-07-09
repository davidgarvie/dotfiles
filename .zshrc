# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Path to oh-my-zsh installation.
export ZSH="/Users/davidgarvie/.oh-my-zsh"

ZSH_THEME=powerlevel10k/powerlevel10k

plugins=(docker git node npm zsh-autosuggestions)

source $ZSH/oh-my-zsh.sh

# Custom aliases
alias cat="bat"
alias h="helm"
alias k="kubectl"
alias rm="trash"
alias top="vtop"

# Stop the console doing stuff I don't want it to
ADBLOCK=true
DISABLE_OPENCOLLECTIVE=true
DOTNET_CLI_TELEMETRY_OPTOUT=true

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# NVM
  export NVM_DIR="$HOME/.nvm"
  [ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
  [ -s "/usr/local/opt/nvm/etc/bash_completion.d/nvm" ] && . "/usr/local/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

# Gcloud SDK
source "/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc"
source "/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc"

export PATH="/usr/local/opt/helm@2/bin:$PATH"
