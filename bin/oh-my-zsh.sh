powerlinefonts_installer(){
    echo "****** Installing Zsh ******"
        sudo apt install zsh
        sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

    echo "****** Installing powerline fonts ******"
        git clone https://github.com/powerline/fonts.git $1/powerlinefonts
        $1/powerlinefonts/install.sh
        rm -rf $1/powerlinefonts

        # Installing the powerlevel9k theme
        git clone https://github.com/bhilburn/powerlevel9k.git $2/.oh-my-zsh/custom/themes/powerlevel9k
}