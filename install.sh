# settings for zig
export TARGET=https://ziglang.org/download/0.11.0/zig-linux-x86_64-0.11.0.tar.xz
export FILENAME=zig.tar.xz

wget $TARGET -O $FILENAME
mkdir -p /usr/local/zig
tar Jxvf $FILENAME -C /usr/local/zig --strip-components 1
rm $FILENAME
echo 'PATH=/usr/local/zig:$PATH' >> ~/.profile
source ~/.profile

# settings for git
sed -i -e "s/sslCAInfo = .*/sslCAInfo = \/etc\/ssl\/certs\/ca-certificates.crt/" ~/.gitconfig 

# clone zig exercises
git clone https://ziglings.org
echo ================================
echo source ~/.profile
echo cd ziglings.org
echo zig build
echo ================================
