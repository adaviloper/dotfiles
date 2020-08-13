brew link --overwrite vim

# Setup Vundle for Vim
mkdir -p ~/.vim/bundle
yellow "Installing Vundle"
echo ""
rm -rf ~/.vim/bundle/Vundle.vim
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

# Auto-install plugins after everything is finished linking
vim +PluginInstall +qall
