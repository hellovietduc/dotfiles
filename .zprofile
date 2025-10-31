# We should put PATHs here instead of .zshrc
# See: https://gist.github.com/Linerre/f11ad4a6a934dcf01ee8415c9457e7b2#choosing-the-right-init-file

export PATH=/opt/homebrew/bin:$PATH
export PATH=/opt/homebrew/sbin:$PATH
export PATH=/opt/homebrew/opt/asdf/bin:$PATH
export PATH=/Users/vietduc/.local/bin:$PATH

# For Neovide:
# Neovide doesn't load Neovim in a traditional way (via login shell).
# When Neovide is loaded, it only loads the .zprofile file, not .zshrc file
# so we need to add the asdf shims here for LSP (mostly Node programs) to work.
export PATH=/Users/vietduc/.asdf/shims:$PATH 

