#!/bin/bash

########## Get data from arguements ##########

# Get deb location/name
DEB="$1"

# Get tweak name
NAME="$2"

# Get file size
SIZE=$(stat -f%z $DEB)

# Get MD5 key
temp=$(md5 $DEB)
MD5="$(cut -d'=' -f2 <<<"$temp" | sed -e 's/^[[:space:]]*//')"

# Get SHA1 key
temp=$(shasum $DEB)
SHA1="$(cut -d' ' -f1 <<<"$temp")"

# Get SHA256 key
temp=$(shasum -a 256 $DEB)
SHA256="$(cut -d' ' -f1 <<<"$temp")"

########## Get User Input ##########

# Get Package
read -p "Package (ex: com.wolfyy.test): " PACKAGE

# Get Version
read -p "Version (ex: 0.0.1): " VERSION

# Get Description
read -p "Enter Description: " DESCRIPTION

# Get Section
read -p "Enter Section (ex: Tweaks): " SECTION

# Set depiction page
DEPICTION="https://repo.wolfyy.me/tweaks/$NAME.html"

########## Add to Packages file ##########

echo "Updating Packages file"
sleep 2

echo "" >> Packages
echo "Package: $PACKAGE" >> Packages
echo "Name: $NAME" >> Packages
echo "Version: $VERSION" >> Packages
echo "Architecture: iphoneos-arm" >> Packages
echo "Description: $DESCRIPTION" >> Packages
echo "Depiction: $DEPICTION" >> Packages
echo "Maintainer: Adam Wolf" >> Packages
echo "Author: Adam Wolf" >> Packages
echo "Section: $SECTION" >> Packages
echo "Depends: mobilesubstrate" >> Packages
echo "Filename: $DEB" >> Packages
echo "Size: $SIZE" >> Packages
echo "MD5sum: $MD5" >> Packages
echo "SHA1: $SHA1" >> Packages
echo "SHA256: $SHA256" >> Packages

########## Update Packages .bz2 and .gz ##########

# Remove old Packages
echo "Removing old Packages"
sleep 1

rm Packages.gz;
rm Packages.bz2;

sleep 1
echo "Removed old Packages"


# Create new ones
sleep 1
echo "Creating new Packages"

sleep 1
gzip -c9 Packages > Packages.gz
bzip2 -c9 Packages > Packages.bz2

sleep 1
echo "New Packages created"

sleep 1
echo "All processes finished"
