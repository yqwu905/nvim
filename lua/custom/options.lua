local setup = function(domain, key, value)
  vim[domain][key] = value
end

setup("o", "shell", "zsh")
setup("o", "tabstop", 2)
vim.cmd("set relativenumber")

vim.g.clipboard = {
  name = "win32yank-wsl",
  copy = {
    ["+"] = "win32yank.exe -i --crlf",
    ["*"] = "win32yank.exe -i --crlf"
  },
  paste = {
    ["+"] = "win32yank.exe -o --lf",
    ["*"] = "win32yank.exe -o --lf"
  },
  cache_enabled = 0
}

