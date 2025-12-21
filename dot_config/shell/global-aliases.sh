alias spp=spotify_player
alias gs='git status -s'
alias gb='git branch -l'
alias gbd='git branch -D $(gb | fzf)'
alias gl='git logline'
alias fzg='gb | fzf'
alias lg=lazygit
alias playing="spp get key playback | jq '{name: .item.name, artist: .item.artists[0].name, album: .item.album.name}'"
alias l="ls -lah"
alias gstl='gst-launch-1.0'
alias s='source .venv/bin/activate'
alias cnvim='nvim -c "cd ~/.config/nvim"'
alias dcd='docker compose down --remove-orphans'

