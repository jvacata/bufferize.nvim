# bufferize.nvim
Small Neovim plugin to copy Vim/Neovim command output to a temporary, non-writable buffer. This is useful for easily copying or analyzing the output of the command. The buffer will be wiped out once it's no longer visible.

# Installation

Using lazy.nvim
```
{
    "jvacata/bufferize.nvim",
    config = true
}
```

# Usage
![alt text](https://i.imgur.com/ZIyhcbL.gif)


By default, run 
```:Bufferize <cmd>``` 
to execute \<cmd\> and open it's output in a new buffer. If the buffer already exists and is shown in any window, it will be focused instead and the content will be updated.
