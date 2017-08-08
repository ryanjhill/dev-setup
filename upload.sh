echo "Prepping dotfiles and preferences for github..."
echo

# copy dotfiles
cp -R  -R  $HOME/.vimrc ./dotfiles/.vimrc
cp -R  $HOME/.zshrc ./dotfiles/.zshrc

# copy atom's package list, also save preferences
apm list --installed --bare > atom-package-list.txt
sed -i.filter 's/@.*//g' ./atom-package-list.txt
cp -R $HOME/.atom/*.* ./atom\ packages/

# copy zsh plugins
sudo cp -R  ~/.zsh/* ./zsh\ files/zsh\ plugins/

# copy zsh theme
cp -R  $ZSH/themes/ryanjhill.zsh-theme ./zsh\ files/

# copy .vim content (packages & bundles)
sudo cp -R  $HOME/.vim/* ./vim\ packages

# creating public version of BTT w/o personal links
cat Better\ Touch\ Tool\ Preferences.json | sed '/Paste/d' > BTT-pub.json
awk '/Paste/{print NR}' Better\ Touch\ Tool\ Preferences.json > tmp.txt
awk "{print ($1 - 4)}" tmp.txt > sed -e "$1/+11d" Better\ Touch\ Tool\ Preferences.json > final.json
# -4, +11
#
# sed -e '5,10d;12d' BTT-pub.json
# rm tmp.txt


echo "All backed up! Pushing to github..."
echo

# create a timestamp
now="$(date +'%m/%d/%Y at %r')"

# push to git
git pull
git add -A
git commit -m "dev setup script: backed up on $now"
git push origin master

echo
echo "Done! Pushed to github on $now"
echo "You might want to back up BTT settings manually."
