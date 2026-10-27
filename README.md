# My Configs

A GitHub repository with my config files. Use GNU Stow to install the files. 

Usage: 

```bash
./install.sh           # Install dependencies and stow editor, terminal and shell
stow <package-name>    # Install a particular package (editor, terminal, etc.)
stow */                # Install all packages
```

`install.sh` (Arch Linux) installs the needed packages with pacman, initializes
submodules, sets up oh-my-zsh and rustup, stows the packages (backing up any
conflicting files), installs the neovim plugins and language servers, and
switches the login shell to zsh. Pass `--skip-packages` to skip the pacman step,
or name specific stow packages to install only those.
