set -e

ascii_art='   ____  __  ______    __ ____  ______     __  ___    __
  / __ \/  |/  /   |  / //_/ / / / __ )   /  |/  /   / /
 / / / / /|_/ / /| | / ,< / / / / __  |  / /|_/ /_  / / 
/ /_/ / /  / / ___ |/ /| / /_/ / /_/ /  / /  / / /_/ /  
\____/_/  /_/_/  |_/_/ |_\____/_____/  /_/  /_/\____/   
'

echo -e "$ascii_art"
echo "=> Omakub is for fresh Manjaro GNOME 24 or newer installations only!"
echo -e "\nBegin installation (or abort with ctrl+c)..."

command -v yay >/dev/null 2>&1 || sudo pacman -S --noconfirm yay git
yay -Syyuu --noconfirm

fresh_instalation() {
  echo "Fresh installation. Cloning Omakub..."
  rm -rf ~/.local/share/omakub
  git clone https://github.com/akitaonrails/omakub.git ~/.local/share/omakub >/dev/null
  if [[ $OMAKUB_REF != "master" ]]; then
    cd ~/.local/share/omakub
    git fetch origin "${OMAKUB_REF:-stable}" && git checkout "${OMAKUB_REF:-stable}"
    cd -
  fi
}

DIR=~/.local/share/omakub

if [[ -d "$DIR" ]]; then
  echo "Instalation found!"
  read -n 1 -p "Do you want to have a fresh instalation? [Y/N] (enter/empty/default: N): " yn
  echo "" # Add a new line after reading answer
  case $yn in
  [yY]*)
    fresh_instalation
    break
    ;;
  esac
else
  fresh_instalation
fi

echo "Installation starting..."
source ~/.local/share/omakub/install.sh
