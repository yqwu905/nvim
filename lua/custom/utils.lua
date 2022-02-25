function AsyncRunCPP()
    if vim.fn.filereadable("CMakeLists.txt") ~= 0 then
        if vim.fn.isdirectory("cmake_build") == 0 then
            os.execute("mkdir cmake_build");
        end
        local handle = io.popen(
                           "sed -n \"s/^.*add_executable(\\(\\S*\\).*$/\\1/p\" CMakeLists.txt");
        local executable = handle:read("*a");
        handle:close();
        vim.cmd(
            "AsyncRun -mode=term -pos=bottom cd cmake_build && cmake -G Ninja .. && ninja && ./" ..
                executable)
    else
        vim.cmd("AsyncRun -mode=term -pos=bottom g++ -std=c++11 -o a.out " ..
                    vim.fn.expand("%") .. "&&./a.out")
    end
end

_G.AsyncRunCode = function()
    if vim.bo.filetype == 'cpp' then
        AsyncRunCPP();
        -- vim.cmd("AsyncRun -mode=term -pos=bottom g++ -std=c++11 -o a.out " ..
        --             vim.fn.expand("%") .. "&&./a.out")
    elseif vim.bo.filetype == 'python' then
        vim.cmd('AsyncRun -mode=term -pos=bottom python ' .. vim.fn.expand('%'))
    elseif vim.bo.filetype == 'mma' then
        vim.cmd('AsyncRun -mode=term -pos=bottom wolframscript -f ' ..
                    vim.fn.expand('%'))
    elseif vim.bo.filetype == 'julia' then
        vim.cmd('AsyncRun -mode=term -pos=bottom julia ' .. vim.fn.expand('%'))
    elseif vim.bo.filetype == 'tex' then
        vim.notify("Compling latex file.")
        vim.cmd('AsyncRun latexmk -xelatex ' .. vim.fn.expand('%'))
    end
end

local fterm = require("FTerm")
local wolfram_term = fterm:new({ft = 'fterm_wolfram', cmd = 'wolframscript'})
local btop_term = fterm:new({ft = 'fterm_btop', cmd = 'btop'})
local julia_term = fterm:new({ft = 'fterm_julia', cmd = 'julia'})
local python_term = fterm:new({ft = 'fterm_python', cmd = 'ipython'})

_G.__fterm_wolfram = function() wolfram_term:toggle() end
_G.__fterm_btop = function() btop_term:toggle() end
_G.__fterm_julia = function() julia_term:toggle() end
_G.__fterm_python = function() python_term:toggle() end

_G.SwitchConcealLevel = function()
    if vim.o.conceallevel ~= 0 then
        vim.o.conceallevel = 0
    else
        vim.o.conceallevel = 2
    end
end
