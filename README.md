# dotfiles

My macOS dotfiles, managed with [mise][mise] — one declarative `mise.toml` handles
symlinks, tools, macOS defaults, and Homebrew packages. Shell is [zsh][zsh] with
[Powerlevel10k][p10k]; editor is [Helix][helix]; terminal is [Ghostty][ghostty]
(iTerm kept as a backup).

## Setup

```sh
git clone https://github.com/JSaterdalen/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
mise trust
mise bootstrap -E personal   # or: -E work
```

`mise bootstrap` symlinks the dotfiles (`[dotfiles]`), writes the iTerm macOS
defaults (`[bootstrap.macos.defaults]`), installs the tool versions (`[tools]`),
and runs the `bootstrap` task, which `brew bundle`s the Brewfile plus the
machine-specific one under `machines/`.

## Layout

| Path                | What                                             |
| ------------------- | ------------------------------------------------ |
| `mise.toml`         | tools, settings, dotfile symlinks, macOS defaults, brew task |
| `mise.{personal,work}.toml` | per-machine Homebrew bundles              |
| `Brewfile`          | base Homebrew formulae + casks                   |
| `machines/*/Brewfile` | per-machine Homebrew extras                     |
| `zsh/`              | `.zshenv` + `.zshrc`, aliases, functions, plugins, p10k |
| `git/` `helix/` `karabiner/` `ghostty/` `iTerm/` | app configs        |
| `scripts/` `sd/`    | scripts on `$PATH`                               |

Everyday changes are made directly in `~/.dotfiles` (the symlinks point here);
re-run `mise bootstrap dotfiles apply` if you add a new dotfile entry.

[mise]: https://mise.jdx.dev/
[zsh]: https://www.zsh.org/
[p10k]: https://github.com/romkatv/powerlevel10k
[helix]: https://helix-editor.com/
[ghostty]: https://ghostty.org/
