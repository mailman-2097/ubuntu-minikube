#! /bin/bash -e
cp /etc/apt/sources.list /etc/apt/sources.list.0
sed -i -E "s|http://us.|http://|g" /etc/apt/sources.list
apt-get update -y

pushd /tmp
apt-key adv --fetch-keys https://apt.octopus.com/public.key
add-apt-repository "deb https://apt.octopus.com/ stretch main"
apt-get update
apt-get install tentacle -y
popd

echo "tentacle installed"