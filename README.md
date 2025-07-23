1. Require neovim 0.10 or higher
2. Install:
`sudo apt install nodejs npm clangd vim-airline` 
3. Download vim-plug:
```bash
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```
4. Launch in nvim:
```
:PlugInstall
:CocCommand clangd.install
:CocInstall coc-clangd
```


