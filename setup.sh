prompt_install() {
  echo "Checking to see if $1 is installed..."
  case $1 in
    Homebrew)
      if [ -x "$(command -v $2)" ]; then
        echo "$1 is already installed"
      else
        echo "Installing Homebrew..."
        /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
      fi;;
    oh-my-zsh)
      if [ -f $2 ] || [ -d $2 ]; then
        echo "Installing oh-my-zsh..."
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
      else
        echo "$1 is already installed"
      fi;;
    *)
      echo "Installing $1..."
      brew install $1;;
  esac
  printf '\n––––––––––\n\n'
}

apm_install_by_list() {
  while IFS='' read -r line || [[ -n "$line" ]]; do
    apm install $line
  done < "$1"
}

echo "We're going to do the following:"
echo "- - 1. Check to make sure you have xcode terminal tools up-to-date"
echo "- - 2. We'll install homebrew and homebrew's cask library"
echo "- - 3. We're going to upgrade the terminal with zsh, oh-my-zsh, and a good mac vim client"
echo "- - 4. We'll install atom and some really great packages for it too"
echo "- - 5. We'll move those new dotfiles over"
echo
echo "It's recommended that you backup your setup before you begin. Otherwise things might get deleted."
echo
echo "Are you ready to get started? (Type num to choose)"

select yn in "Yes" "No"; do
    case $yn in
        Yes ) printf "Awesome, let's go!\n\n"; break;;
        No )  echo "Quitting, nothing was changed."; exit;;
    esac
done

# Make sure xcode is up-to-date! If it's not then stuff can go wonky
xcode-select --install

# Installing homebrew and cask
prompt_install Homebrew brew

# Installing terminal tools: zsh, oh-my-zsh, vim
prompt_install zsh
if ! [ -z "${SHELL##*zsh*}" ];then
  chsh -s $(which zsh); fi
prompt_install oh-my-zsh "$HOME/.oh-my-zsh"
cp -R ./zsh\ files/zsh\ plugins/* $HOME/.zsh/
prompt_install macvim


# Installing atom & select packages
brew tap caskroom/cask
brew cask install atom
apm_install_by_list atom-package-list.txt.filter
cp -R ./atom\ packages/* $HOME/.atom/

# Replacing old dotfiles
printf "Replacing dotfiles...\n\n"
cp -R ./dotfiles/.vimrc $HOME/.vimrc
cp -R ./dotfiles/.zshrc $HOME/.zshrc
sed -i -e "2s/rjhill/${USER}/g" $HOME/.zshrc
cp -R ./zsh\ files/ryanjhill.zsh-theme $HOME/.oh-my-zsh/themes/ryanjhill.zsh-theme

# Adding vim packages
mkdir -p $HOME/.vim/
cp -R ./vim\ packages/* $HOME/.vim/
git clone https://github.com/ratazzi/blackboard.vim $HOME/.vim/bundle/blackboard
git clone https://github.com/myusuf3/numbers.vim $HOME/.vim/bundle/numbers
git clone https://github.com/vim-airline/vim-airline $HOME/.vim/bundle/vim-airline

printf "\nPlease log out and log back in for default shell to be initialized.\n\n"
