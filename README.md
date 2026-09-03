# Grizak/dotfiles

My personal shell configuration files for Bash and Zsh.

Zsh is my primary shell, so it receives the most attention and includes the more polished prompt and features. Bash is supported but intentionally has a simpler appearance.

## Installation

Clone the repository to `~/.shell`:

```bash
git clone https://github.com/Grizak/dotfiles.git ~/.shell
```

The setup script expects the repository to be located at `~/.shell`.

Make the setup script executable:

```bash
chmod +x ~/.shell/setup
```

Run the setup script:

```bash
~/.shell/setup
```

If the setup fails because one of the target files already exists, you can force the installation with:

```bash
~/.shell/setup -f
```

Only use `-f` if you are sure you want existing files to be overwritten. Back up your current configuration files first if you want to preserve them.

## How installation works

The setup script creates hard links from files in this repository to the locations expected by the relevant programs.

Examples include:

- `~/.zshrc`
- `~/.bashrc`
- `~/.vimrc`
- `~/.gitconfig`

This means that the repository files and their installed locations refer to the same underlying files. Editing either copy edits the other, and changes can be committed directly from the repository.

The repository must be located on the same filesystem as your home directory because hard links cannot cross filesystem boundaries. Directories cannot be hard-linked, so only individual files are linked.

Because `.gitconfig` may contain personal settings, review the files before installing these dotfiles on another machine.

## Updates

The hard links mean that changes made to files in `~/.shell` are immediately reflected in their installed locations. There is no separate copying step.

The Zsh configuration includes automatic repository-update functionality. Bash does not currently include this functionality, so Bash users must update the repository manually:

```bash
git -C ~/.shell pull
```

After updating, start a new shell or reload the relevant configuration files.

## Requirements

- Git
- Bash or Zsh
- A Nerd Font when using Zsh

Without a Nerd Font, some prompt symbols and icons may not render correctly.

## Included commands

The configuration includes commands for managing and updating this repository:

- `shell-sync`
- `ssy`

These commands are intended for my own workflow and may attempt to push changes to the repository. They require write access and are not necessary for normal use.

Use them only if you understand what they do and have configured them for your own repository.

## Important notes

- Changes made through the installed files are changes to the repository files.
- Run `git status` in `~/.shell` before pulling or committing changes.
- The setup script may overwrite existing files when run with `-f`.
- Hard links may be broken if a linked file is deleted and recreated instead of modified in place.
