# bufferize.nvim
Small neovim plugin to copy vim/nvim command output to disposable buffer

# Installation

Using lazy.nvim
```
{
    "jvacata/bufferize.nvim",
    config = function()
        require("bufferize").setup()
    end
}
```

# Usage

By default, run 
```:Bufferize <cmd>``` 
to execute \<cmd\> and open it's output in a new buffer. If the buffer already exists and is shown in any window, it will be focused instead.
