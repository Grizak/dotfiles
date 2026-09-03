# Grizak/dotfiles

This is a repo with my dotfiles

If you want to use them, clone the repo into "~/.shell" and run the setup script:

```bash
# Make sure that the file is executable
chmod +x ~/.shell/setup

# Run it
~/.shell/setup # Use -f if it fails because the file exists and YOU ARE SURE YOU WANT TO OVERRIDE it
```

It will update automatically with new content when I update it locally.
It provides config for both bash and zsh, although zsh is what I use daily.
Because of that, bash looks really pale and zsh requires a nerd font.

The dotfiles contain some aliases and functions to update this repository, they will fail if you don't have read access to this repo (which I hope you don't have)
The commands this applies to is:
- shell-sync
- ssy

Please don't use them, or you'll mess up the automatic update system and you will have to figure that out yourself by reading the code (it's in zsh), if you use bash, we can't do automatic updates, and you'll have to update yourself.
