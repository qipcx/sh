## Origin: https://gist.github.com/Kerren-Entrostat/9f4999715408beb9a5c6abd89558fc93
## Full instructions: https://blog.entrostat.com/install-byobu-on-any-linux-distro/

sudo yum install -y tar screen tmux make

BYOBU_VERSION=5.133

set -e

echo "Please make sure you have the following dependencies installed:"
echo "  [+] tar"
echo "  [+] screen"
echo "  [+] tmux"
echo "  [+] make"

which tar
which screen
which tmux
which make

echo "We are going to download version ${BYOBU_VERSION} of byobu and install it..."

echo "Setting up temporary folder"
UNIQUE_FOLDER=$(date +%s)
cd /tmp
mkdir /tmp/${UNIQUE_FOLDER}
cd /tmp/${UNIQUE_FOLDER}

echo "Downloading source package"
wget "https://launchpad.net/byobu/trunk/${BYOBU_VERSION}/+download/byobu_${BYOBU_VERSION}.orig.tar.gz"

echo "Extracting the source files"
tar -xvf "byobu_${BYOBU_VERSION}.orig.tar.gz"
BYOBU_FOLDER_NAME=$(ls | grep byobu | grep -v .tar.gz)
cd "byobu-${BYOBU_VERSION}"

echo "Configuring and building"
./configure
sudo make install
byobu-select-backend tmux


echo ""
echo ""
echo ""
echo ""
echo "You're ready to go! Just type:"
echo ""
echo ""
echo "byobu"
