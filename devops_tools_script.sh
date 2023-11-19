#!/bin/bash
echo "Installing Docker..."
curl -fsSL https://get.docker.com -o get-docker.sh
sh get-docker.sh
 sudo apt-get install docker-compose-plugin
echo "Docker & docker compose installed successfully."
echo "-----------------------------------v-------"

echo "Installing Vagrant..."
wget -O- https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
sudo apt update && sudo apt install vagrant -y
echo "Vagrant installed successfully."
echo "------------------------------------------"

echo "Installing Terraform..."
sudo apt-get install unzip -y
wget https://releases.hashicorp.com/terraform/1.5.7/terraform_1.5.7_linux_amd64.zip
unzip terraform_1.5.7_linux_amd64.zip
sudo mv terraform /usr/local/bin/
rm terraform_1.5.7_linux_amd64.zip
echo "Terraform installed successfully."
echo "------------------------------------------"

echo "Installing VirtualBox..."
#!/bin/bash

# Add the VirtualBox repository key
wget -q https://www.virtualbox.org/download/oracle_vbox_2016.asc -O- | sudo apt-key add -

# Add the VirtualBox repository
sudo add-apt-repository "deb [arch=amd64] https://download.virtualbox.org/virtualbox/debian $(lsb_release -cs) contrib"

# Update package lists
sudo apt update

# Install VirtualBox
sudo apt install virtualbox -y 

# Download the Extension Pack (Latest version)
LATEST_VERSION=$(curl -sL https://download.virtualbox.org/virtualbox/LATEST-STABLE.TXT)
EXTENSION_PACK="Oracle_VM_VirtualBox_Extension_Pack-$LATEST_VERSION.vbox-extpack"

wget "https://download.virtualbox.org/virtualbox/$LATEST_VERSION/$EXTENSION_PACK"

# Install the Extension Pack silently
sudo VBoxManage extpack install --replace "$EXTENSION_PACK"

# Cleanup downloaded Extension Pack file
rm "$EXTENSION_PACK"

echo "Oracle VM VirtualBox Extension Pack $LATEST_VERSION installed successfully."
echo "------------------------------------------"

echo "Installing kubectl..."
   curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
   sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

echo "kubectl installed successfully."

echo "------------------------------------------"

echo "Installing krew..."
(
  set -x; cd "$(mktemp -d)" &&
  OS="$(uname | tr '[:upper:]' '[:lower:]')" &&
  ARCH="$(uname -m | sed -e 's/x86_64/amd64/' -e 's/\(arm\)\(64\)\?.*/\1\2/' -e 's/aarch64$/arm64/')" &&
  KREW="krew-${OS}_${ARCH}" &&
  curl -fsSLO "https://github.com/kubernetes-sigs/krew/releases/latest/download/${KREW}.tar.gz" &&
  tar zxvf "${KREW}.tar.gz" &&
  ./"${KREW}" install krew
)

export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"


echo "------------------------------------------"

echo "Installing Minikube..."
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
sudo install minikube-linux-amd64 /usr/local/bin/minikube
rm minikube-linux-amd64
echo "Minikube installed successfully."
echo "------------------------------------------"

echo "Installing Kind..."
curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.20.0/kind-linux-amd64
chmod +x ./kind
sudo mv ./kind /usr/local/bin/
echo "Kind installed successfully."
echo "------------------------------------------"

echo "Installing kubectx and kubens..."
sudo git clone https://github.com/ahmetb/kubectx /opt/kubectx
sudo ln -s /opt/kubectx/kubectx /usr/local/bin/kubectx
sudo ln -s /opt/kubectx/kubens /usr/local/bin/kubens
echo "kubectx and kubens installed successfully."
echo "------------------------------------------"

echo "Installing Google Cloud SDK..."
sudo apt-get update
sudo apt-get install apt-transport-https ca-certificates gnupg curl sudo
echo "deb [signed-by=/usr/share/keyrings/cloud.google.asc] https://packages.cloud.google.com/apt cloud-sdk main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
sudo apt-get update && sudo apt-get install google-cloud-cli -y
gcloud components install gke-gcloud-auth-plugin

echo "Google Cloud SDK installed successfully."
echo "------------------------------------------"

echo "Installing Azure CLI..."
curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash
echo "Azure CLI installed successfully."
echo "------------------------------------------"

echo "Setting up kubectx and kubens..."
git clone https://github.com/ahmetb/kubectx.git ~/.kubectx
COMPDIR=$(pkg-config --variable=completionsdir bash-completion)
ln -sf ~/.kubectx/completion/kubens.bash $COMPDIR/kubens
ln -sf ~/.kubectx/completion/kubectx.bash $COMPDIR/kubectx
kubectl krew install ctx
kubectl krew install ns
cat << EOF >> ~/.bashrc
#kubectx and kubens
export PATH=~/.kubectx:\$PATH
EOF
echo "kubectx and kubens set up successfully."
echo "------------------------------------------"

echo "Installing Visual Studio Code..."
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
sudo install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg
sudo sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
rm packages.microsoft.gpg
sudo apt-get install apt-transport-https
sudo apt-get update
sudo apt-get install code -y
echo "Visual Studio Code installed successfully."
echo "------------------------------------------"

echo "Installing GitHub Desktop..."
sudo wget https://github.com/shiftkey/desktop/releases/download/release-3.1.1-linux1/GitHubDesktop-linux-3.1.1-linux1.deb
sudo gdebi GitHubDesktop-linux-3.1.1-linux1.deb
rm GitHubDesktop-linux-3.1.1-linux1.deb
echo "GitHub Desktop installed successfully."
echo "------------------------------------------"

echo "Installing Python and pip..."
sudo apt install -y python3.10-venv python3-pip

echo "Python and pip installed successfully."
echo "------------------------------------------"

echo "Installing pipx..."
python3 -m pip install --user pipx
python3 -m pipx ensurepath
echo "pipx installed successfully."
echo "------------------------------------------"

echo "Installing Ansible using pipx..."
pipx install --include-deps ansible
echo "Ansible installed successfully."
echo "------------------------------------------"

echo "Python, pip, pipx, and Ansible have been installed."
echo "------------------------------------------"


echo "INSTALLING OH MY Zsh"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/loket/oh-my-zsh/feature/batch-mode/tools/install.sh)" -s --batch || {
  echo "Could not install Oh My Zsh" >/dev/stderr
  exit 1
}

echo "------------------------------------------"

git clone https://github.com/pixegami/terminal-profile.git
terminal-profile
# Update your software repositories.
sudo apt-get update
sudo apt-get upgrade -y


sudo apt install terminator
# Install Vim.
# sudo apt-get install -y vim
# bash ./terminal-profile/install_powerline.sh
# bash ./terminal-profile/install_terminal.sh
# bash ./terminal-profile/install_profile.sh
# echo "Installation completed."

# echo "Please reboot the system"

# rm -rf terminal-profile
# rm -rf Git*
# rm -rf Ora*
echo CLEANING UP...

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
export PATH="/opt/homebrew/bin:$PATH" >> ~/.zshrc
 eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)  
# echo install terminal 

# touch ~/.zshrc
# ZSH_THEME="powerlevel10k/powerlevel10k"

sudo apt install fonts-font-awesome
