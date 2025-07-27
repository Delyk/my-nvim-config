1. Require neovim 0.10 or higher
2. Install:
`sudo apt install nodejs npm clangd vim-airline` 
3. Download vim-plug:
```bash
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```
4. Install nerd-fonts:
`cd ~/.local/share/fonts && curl -fLO https://github.com/ryanoasis/nerd-fonts/raw/HEAD/patched-fonts/DroidSansMono/DroidSansMNerdFont-Regular.otf`
5. Launch in nvim:
```
:PlugInstall
:CocCommand clangd.install
:CocInstall coc-clangd
```
6. Commands:
- Ctrl+>/< - :bn/:bp
- Ctrl+x - nerdtree
- gcc - comment line


