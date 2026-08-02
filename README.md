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
mise bootstrap
```

`mise bootstrap` symlinks the dotfiles (`[dotfiles]`), writes the iTerm macOS
defaults (`[bootstrap.macos.defaults]`), installs the tool versions (`[tools]`),
and runs the `bootstrap` task, which `brew bundle`s the Brewfile.

One Brewfile covers every machine. Regenerate it from what's actually installed
with:

```sh
brew bundle dump --file ~/.dotfiles/Brewfile --no-vscode --force
```

## Layout

| Path                | What                                             |
| ------------------- | ------------------------------------------------ |
| `mise.toml`         | tools, settings, dotfile symlinks, macOS defaults, brew task |
| `Brewfile`          | Homebrew taps, formulae, casks, and Mac App Store apps |
| `zsh/`              | `zshenv` / `zprofile` / `zshrc` / `path.zsh`, aliases, functions, plugins, p10k |
| `git/` `helix/` `karabiner/` `ghostty/` `iTerm/` | app configs        |
| `scripts/` `sd/`    | scripts on `$PATH`                               |

Everyday changes are made directly in `~/.dotfiles` (the symlinks point here);
re-run `mise bootstrap dotfiles apply` if you add a new dotfile entry.

## zsh startup

`~/.zshenv` (also linked as `$ZDOTDIR/.zshenv`, since zsh stops consulting
`~/.zshenv` once `ZDOTDIR` is exported) sets XDG vars, `ZDOTDIR`, and `$EDITOR`,
then sources `path.zsh`. It runs for *every* zsh, so it forks nothing.

`.zprofile` runs once per login shell and owns anything that shells out. It
re-sources `path.zsh` because macOS's `/etc/zprofile` runs `path_helper`, which
rebuilds `PATH` with the system entries first; `typeset -U path` makes the
second pass reorder rather than duplicate.

`.zshrc` is interactive-only: completions, plugins, prompt, history.

Config lives in `$ZDOTDIR`; anything zsh *generates* does not — history goes to
`$XDG_STATE_HOME/zsh`, the completion dump to `$XDG_CACHE_HOME/zsh`, and cloned
plugins to `$XDG_DATA_HOME/zsh/plugins`.

[mise]: https://mise.jdx.dev/
[zsh]: https://www.zsh.org/
[p10k]: https://github.com/romkatv/powerlevel10k
[helix]: https://helix-editor.com/
[ghostty]: https://ghostty.org/
