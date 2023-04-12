local utils = {}
local path_join = require("core.utils").path_join

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

function utils.switch_conceallevel()
  if vim.o.conceallevel == 2 then
    vim.o.conceallevel = 0
  else
    vim.o.conceallevel = 2
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

return utils

