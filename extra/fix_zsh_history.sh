#!/usr/bin/env bash

cd ~
mv .zsh_history .zsh_history_old
strings .zsh_history_old >.zsh_history
fc -R .zsh_history

# cd ~
# mv .zsh_history .zsh_history_bad
# strings .zsh_history_bad >.zsh_history
# fc -R .zsh_history
# rm ~/.zsh_history_bad
