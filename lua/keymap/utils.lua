local utils = {}
local path_join = require("core.utils").path_join

function utils.close_buffer(force)
  local opts = {
    next = "cycle", -- how to retrieve the next buffer
    quit = false, -- exit when last buffer is deleted
  }
  local function switch_buffer(windows, buf)
    local cur_win = vim.fn.winnr()
    for _, winid in ipairs(windows) do
      winid = tonumber(winid) or 0
      vim.cmd(string.format("%d wincmd w", vim.fn.win_id2win(winid)))
      vim.cmd(string.format("buffer %d", buf))
    end
    vim.cmd(string.format("%d wincmd w", cur_win)) -- return to original window
  end

  local function get_next_buf(buf)
    local next = vim.fn.bufnr "#"
    if opts.next == "alternate" and vim.fn.buflisted(next) == 1 then
      return next
    end
    for i = 0, vim.fn.bufnr "$" - 1 do
      next = (buf + i) % vim.fn.bufnr "$" + 1 -- will loop back to 1
      if vim.fn.buflisted(next) == 1 then
        return next
      end
    end
  end

  local buf = vim.fn.bufnr()
  if vim.fn.buflisted(buf) == 0 then -- exit if buffer number is invalid
    vim.cmd "close"
    return
  end

  if #vim.fn.getbufinfo { buflisted = 1 } < 2 then
    if opts.quit then
      if force then
        vim.cmd "qall!"
      else
        vim.cmd "confirm qall"
      end
      return
    end

    local chad_term, _ = pcall(function()
      return vim.api.nvim_buf_get_var(buf, "term_type")
    end)

    if chad_term then
      vim.cmd(string.format("setlocal nobl", buf))
      vim.cmd "enew"
      return
    end
    vim.cmd "enew"
    vim.cmd "bp"
  end

  local next_buf = get_next_buf(buf)
  local windows = vim.fn.getbufinfo(buf)[1].windows

  if force or vim.fn.getbufvar(buf, "&buftype") == "terminal" then
    local chad_term, type = pcall(function()
      return vim.api.nvim_buf_get_var(buf, "term_type")
    end)

    if chad_term then
      if type == "wind" then
        vim.cmd(string.format("%d bufdo setlocal nobl", buf))
        vim.cmd "BufferLineCycleNext"
      else
        local cur_win = vim.fn.winnr()
        vim.cmd(string.format("%d wincmd c", cur_win))
        return
      end
    else
      switch_buffer(windows, next_buf)
      vim.cmd(string.format("bd! %d", buf))
    end
  else
    switch_buffer(windows, next_buf)
    vim.cmd(string.format("silent! confirm bd %d", buf))
  end
  if vim.fn.buflisted(buf) == 1 then
    switch_buffer(windows, buf)
  end
end

utils.runner = {
  c = function()
    return "clang -o a.exe " .. vim.fn.expand "%" .. " && .\\a.exe"
  end,
  cpp = function()
    return "clang++ -std=c++11 -o a.exe " .. vim.fn.expand "%" .. " && .\\a.exe"
  end,
  python = function()
    return "python " .. vim.fn.expand "%"
  end,
  tcl = function()
    return "tclsh " .. vim.fn.expand "%"
  end,
  rust = function()
    return "cargo run"
  end,
}

function utils.async_run_code()
  local function is_run_script(path)
    return string.match(path, "_nvim_run_?.*%.ps1")
  end
  local run_scripts = vim.fs.find(is_run_script, { path = vim.fn.getcwd(), type = "file", limit = 20 })
  if #run_scripts > 0 then
    if #run_scripts == 1 then
      require("toggleterm").exec(run_scripts[1] .. " " .. vim.fn.expand "%:t")
    else
      vim.ui.select(run_scripts, {
        prompt = "Choose run script",
        format_item = function(item)
          local name = string.match(item, "_nvim_run_?(.*)%.ps1")
          if #name == 0 then
            return "Default"
          end
          return name
        end,
      }, function(choice)
        if choice == nil then
          vim.notify "Abort run"
          return
        end
        require("toggleterm").exec(choice .. " " .. vim.fn.expand "%:t")
      end)
    end
  elseif utils.runner[vim.bo.filetype] ~= nil then
    require("toggleterm").exec(utils.runner[vim.bo.filetype]())
  else
    vim.notify("No nvim_run script and no default runner", vim.log.levels.ERROR)
  end
end

function utils.toggle_preview()
  local md_path = vim.api.nvim_buf_get_name(0)
  local extension = md_path:match "^.+%.(.+)$"
  if extension == "md" then
    vim.cmd "MarkdownPreview"
  end
end

utils.Commit = {}

function utils.docommit(win)
  local commit_message = vim.trim(vim.fn.getline ".")
  vim.api.nvim_win_close(win, true)
  os.execute(string.format("git commit -m '%s'", commit_message))
end

function utils.commit()
  local opts = {
    relative = "editor",
    col = math.ceil(0.5 * (vim.o.columns - 60)),
    row = math.ceil(0.5 * (vim.o.lines - 4) - 1),
    width = 60,
    height = 4,
    style = "minimal",
    border = "double",
  }
  local buf = vim.api.nvim_create_buf(false, true)
  local win = vim.api.nvim_open_win(buf, true, opts)
  local fmt = "<cmd>lua require('keymap.utils').docommit(%d)<CR>"

  vim.api.nvim_buf_set_lines(buf, 0, -1, false, {})
  vim.api.nvim_buf_set_keymap(buf, "i", "<CR>", string.format(fmt, win), { silent = true })
end

_G.get_visual_selection = function()
  local s_start = vim.fn.getpos "'<"
  local s_end = vim.fn.getpos "'>"
  local n_lines = math.abs(s_end[2] - s_start[2]) + 1
  local lines = vim.api.nvim_buf_get_lines(0, s_start[2] - 1, s_end[2], false)
  lines[1] = string.sub(lines[1], s_start[3], -1)
  if n_lines == 1 then
    lines[n_lines] = string.sub(lines[n_lines], 1, s_end[3] - s_start[3] + 1)
  else
    lines[n_lines] = string.sub(lines[n_lines], 1, s_end[3])
  end
  return lines
end

function utils.switch_conceallevel()
  if vim.o.conceallevel == 2 then
    vim.o.conceallevel = 0
  else
    vim.o.conceallevel = 2
  end
end

local function mysplit(inputstr, sep)
  if sep == nil then
    sep = "%s"
  end
  local t = {}
  for str in string.gmatch(inputstr, "([^" .. sep .. "]+)") do
    table.insert(t, str)
  end
  return t
end

local function setloclist(tbl)
  vim.call("setqflist", tbl)
  vim.cmd "copen"
end

function utils.async_check_code()
  if vim.fn.filereadable "nvim_check.ps1" ~= 0 then
    local stdout_res = {}
    local Job = require "plenary.job"
    local bufnr = vim.call("bufnr", "%")
    local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
    local job = Job:new {
      command = "pwsh.exe",
      args = { "nvim_check.ps1", vim.fn.expand "%:t" },
      on_stdout = function(_, line)
        local r = mysplit(line, "::")
        local lineNum = tonumber(r[1])
        local idxStart, idxEnd = 1, 2 --= string.find(lines[lineNum], r[3])
        table.insert(stdout_res, {
          bufnr = bufnr,
          lnum = tonumber(lineNum),
          endlnum = tonumber(lineNum),
          text = r[2],
          valid = 1,
          vcol = 0,
          type = "",
          pattern = "",
          col = idxStart,
          endcol = idxEnd,
          module = "",
          nr = 0,
        })
      end,
    }
    job:sync()
    setloclist(stdout_res)
  else
    vim.notify("No nvim_check.ps1 found", vim.log.levels.ERROR)
  end
end

utils.links = {}

local get_link = function()
  local row, col = unpack(vim.api.nvim_win_get_cursor(0))
  local bufnr = vim.call("bufnr", "%")
  local line = vim.api.nvim_buf_get_lines(bufnr, row - 1, row, false)[1]
  local startIdx = col
  while startIdx > 0 do
    if line:sub(startIdx, startIdx) == "[" then
      if line:sub(startIdx - 1, startIdx - 1) == "[" then
        break
      else
        startIdx = startIdx - 2
      end
    else
      startIdx = startIdx - 1
    end
  end
  local endIdx = col
  while endIdx < #line do
    if line:sub(endIdx, endIdx) == "]" then
      if line:sub(endIdx + 1, endIdx + 1) == "]" then
        break
      else
        endIdx = endIdx + 2
      end
    else
      endIdx = endIdx + 1
    end
  end
  if startIdx == 0 or endIdx == #line then
    return nil
  end
  return line:sub(startIdx + 1, endIdx - 1)
end

-- local prepare_link = function(link)
--     local cwd = vim.fn.getcwd()
--     local file = path_join(cwd, link .. '.md')
--     if vim.fn.filereadable(file) == 0 then
--         print('Create not exist link ' .. file)
--         io.open(file, 'w'):close()
--     end
--     return file
-- end

function utils.follow_link()
  local linkContent = get_link()
  if linkContent ~= nil then
    local cwd = vim.fn.getcwd()
    local file = path_join(cwd, linkContent .. ".md")
    table.insert(utils.links, vim.fn.expand "%")
    vim.cmd("e " .. file)
    print(vim.inspect(utils.links))
  end
end

function utils.jump_back()
  if utils.links ~= nil and #utils.links > 0 then
    vim.cmd("e " .. utils.links[#utils.links])
    table.remove(utils.links, #utils.links)
  end
end

function utils.pandoc_export()
  local filename = vim.fn.expand "%:p"
  local filename_no_ext = vim.fn.expand "%:p:r"
  local filetype_name = {
    docx = "Microsoft Office Docx",
    pdf = "PDF",
    html = "Web Page",
    md = "Markdown",
    tex = "LaTeX Source Code",
  }
  vim.ui.select({ "docx", "pdf", "html", "md", "tex" }, {
    prompt = "Choose export filetype",
    format_item = function(item)
      return filetype_name[item]
    end,
  }, function(choice)
    local export_filename = string.format("%s.%s", filename_no_ext, choice)
    -- print("pandoc " .. filename .. " -o " .. export_filename)
    local job = vim.fn.jobstart("pandoc " .. filename .. " -o " .. export_filename, {
      on_exit = function()
        vim.notify "Job Done"
      end,
    })
    print("Export to " .. export_filename .. " done.")
  end)
end

local Terminal = require("toggleterm.terminal").Terminal
local chatgpt = Terminal:new {
  cmd = "python D:\\repos\\chatgpt\\main.py",
  count = 9,
}
function utils.chatgpt()
  chatgpt:toggle()
end

return utils

