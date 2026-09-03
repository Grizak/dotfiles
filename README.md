# Grizak/dotfiles

This is a repo with my dotfiles

If you want to use them:
```bash
# Clone the repo
git clone https://github.com/Grizak/dotfiles.git ~/.shell # <- Really important!

# And then run the setup script:
# Make sure that it's executable
chmod +x ~/.shell/setup

# Run it
~/.shell/setup # Use -f if it fails because the file exists and YOU ARE SURE YOU WANT TO OVERRIDE it
```

It will update automatically with new content when I update it locally. (That is only true on zsh, if you're using bash, you'll have to figure that out yourself.)
It provides config for both bash and zsh, although zsh is what I use daily.
Because of that, bash looks really pale and zsh requires a nerd font.

The dotfiles contain some aliases and functions to update this repository, they will fail if you don't have write access to this repo (which I hope you don't have)
The commands this applies to is:
- shell-sync
- ssy

Please don't use them, or you'll mess up the automatic update system and you will have to figure that out yourself by reading the code (it's in zsh, and if you use bash, as I said before, there's no automatic updates)
