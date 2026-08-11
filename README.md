# dotfiles

My personal dotfiles managed with chezmoi.

## Homebrew

The `dot_brewleaves` file contains the Homebrew packages I use. To install them:

```sh
xargs brew install < .brewleaves
```

## Oh My Tmux
Install oh my tmux using the following:

```sh
curl -fsSL "https://github.com/gpakosz/.tmux/raw/refs/heads/master/install.sh#$(date +%s)" | bash
```

This will create `$HOME/.config/tmux/tmux.conf.local` for you to overwrite.
