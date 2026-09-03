# Grizak/dotfiles

My personal configuration files for Bash, Zsh, Vim, Powerlevel10k, and Git.

Zsh is my primary shell, so it receives the most attention and includes the more polished prompt and features. Bash is supported but intentionally has a simpler appearance.

## Installation

Clone the repository to `~/.shell`:

```bash
git clone https://github.com/Grizak/dotfiles.git ~/.shell
```

The setup script expects the repository to be located at `~/.shell`.

Make the setup script executable:

```bash
chmod +x ~/.shell/setup.sh
```

Run the setup script:

```bash
~/.shell/setup.sh
```

The script creates hard links for the following files:

| Installed file | Repository file |
|---|---|
| `~/.zshrc` | `~/.shell/zsh` |
| `~/.bashrc` | `~/.shell/bash` |
| `~/.vimrc` | `~/.shell/vim` |
| `~/.p10k.zsh` | `~/.shell/.p10k` |
| `~/.gitconfig` | `~/.shell/gitconf` |

## Overwriting existing files

Arguments passed to the setup script are passed directly to `ln`.

For example:

```bash
~/.shell/setup.sh -f
```

runs `ln -f` for each file. This allows existing destination files to be removed and replaced with hard links.

Only use `-f` if you are sure you want existing files to be overwritten. Back up your current configuration files first if you want to preserve them.

Other `ln` options can also be passed to the setup script, although they have not necessarily been tested with this script.

## How it works

The setup script creates hard links rather than symbolic links. This means that each repository file and its installed location refer to the same underlying file.

For example, changes made to either of these paths affect the same file:

```text
~/.shell/zsh
~/.zshrc
```

Changes do not need to be copied between the repository and the installed locations. They can be committed directly from `~/.shell`.

The repository and your home directory must be on the same filesystem because hard links cannot cross filesystem boundaries. The setup script links individual files; it does not link directories.

If a linked file is deleted and recreated, the new file will no longer be hard-linked to the repository file. Modify linked files in place when possible.

Because `.gitconfig` may contain personal settings, review the repository contents before installing these dotfiles on another machine.

## Updates

Changes made locally to files in `~/.shell` are immediately reflected in their installed locations because of the hard links.

The Zsh configuration includes automatic update functionality for this repository. Bash does not currently include that functionality, so Bash users must update the repository manually:

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
- The setup script passes its arguments directly to `ln`.
- Using `-f` can replace existing configuration files.
- Hard links cannot be created across filesystems.
- Deleting and recreating a linked file breaks the link between that file and the repository.
