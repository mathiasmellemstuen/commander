# Commander

Install this plugin with <a href="https://github.com/junegunn/vim-plug">vim-plug</a>: `Plug 'mathiasmellemstuen/commander'`

Commander is a neovim plugin that makes it easy to quickly call project dependent scripts from neovim with key mappings. The plugin contains two functions:
- edit
- run

This plugin stores the created commands (created with the edit function) locally to each project inside a `.commander` folder inside your project directory. This means it is possible to bind different commands to different projects, and that it does not support global commands.

## Edit function
The edit function can be called with `:lua require"commander".edit({id})` where `{id}` can be whatever you want. Example `:lua require"commander".edit(1)` will create a new script with 1 as id. You can have a unlimited amount of id's and scripts (as long as the id is unique, although it does not need to be unique cross-projects). The edit function then opens the newly created script file in vim for you to edit the scripts content. It creates a .bat file when using windows and .sh when using macOS/linux.

## Run function
The run function can be called to run pre-existing scripts created with the edit function. `:lua require"commander".run(1)` will run the script with id 1 in a new window inside vim.

## Keybindings
Example of some keybindings for this plugin:
```vim
" Mapping commander run
nnoremap <leader>1 <cmd>lua require"commander".run(1)<cr>
nnoremap <leader>2 <cmd>lua require"commander".run(2)<cr>
nnoremap <leader>3 <cmd>lua require"commander".run(3)<cr>

" Mapping commander edit
nnoremap <leader><del>1 <cmd>lua require"commander".edit(1)<cr>
nnoremap <leader><del>2 <cmd>lua require"commander".edit(2)<cr>
nnoremap <leader><del>1 <cmd>lua require"commander".edit(3)<cr>
```
