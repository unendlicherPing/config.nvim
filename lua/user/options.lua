local M = {}

function M.setup()
	local set = vim.opt
	local let = vim.g

    -- set shell
    set.shell = "pwsh"

	-- show hybride line numbers
	set.number = true
	set.relativenumber = true

	-- set tab size
	set.tabstop = 4
	set.shiftwidth = 4
	set.expandtab = true
    set.autoindent = true

	-- remove statusline
	set.showmode = false
    set.ruler = false
    set.laststatus = 0
    set.showcmd = false

	-- enable folding
	set.foldenable = false -- Disable folding at startup.
    set.foldlevel = 99
    set.fillchars = "fold:\\"
    set.foldtext = "CustomFoldText()"
	set.foldmethod = "expr"
	set.foldexpr = "nvim_treesitter#foldexpr()"

    vim.cmd [[
    function! NextNonBlankLine(lnum)
        let numlines = line('$')
        let current = a:lnum + 1
        while current <= numlines
            if getline(current) =~? '\v\S'
                return current
            endif
            let current += 1
        endwhile
        return -2
    endfunction

    function! CustomFoldText()
        " get first non-blank line
        let fs = v:foldstart
        while getline(fs) =~ '^\s*$' | let fs = nextnonblank(fs + 1)
        endwhile
        if fs > v:foldend
            let line = getline(v:foldstart)
        else
            let line = substitute(getline(fs), '\t', repeat(' ', &tabstop), 'g')
        endif
        let w = winwidth(0) - &foldcolumn - (&number ? 8 : 0)
        let foldSize = 1 + v:foldend - v:foldstart
        let foldSizeStr = " " . foldSize . " lines "
        let foldLevelStr = repeat("+--", v:foldlevel)
        let expansionString = repeat(" ", w - strwidth(foldSizeStr.line.foldLevelStr))
        return line . expansionString . foldSizeStr . foldLevelStr
    endfunction
    ]]
end

return M
