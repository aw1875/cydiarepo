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

########## Generate Depiction Page ##########

echo "Generating depictions page"
sleep 2

echo "<!DOCTYPE html>" >> tweaks/$NAME.html
echo "<html>" >> tweaks/$NAME.html
echo "<head>" >> tweaks/$NAME.html
echo "    <meta charset=\"utf-8\">" >> tweaks/$NAME.html
echo "    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1, minimum-scale=1.0, user-scalable=0\">" >> tweaks/$NAME.html
echo "    <title>$NAME</title>" >> tweaks/$NAME.html
echo "    <link rel=\"stylesheet\" type=\"text/css\" href=\"includes/style.css\">" >> tweaks/$NAME.html
echo "    <style>a, .tint, .table-btn:after {color: #16d887} .active {color: #16d887;border-bottom: 5px solid #16d887;}</style>" >> tweaks/$NAME.html
echo "    <script src=\"includes/script.js\"></script>" >> tweaks/$NAME.html
echo "</head>" >> tweaks/$NAME.html
echo "<body>" >> tweaks/$NAME.html
echo "    <div class=\"body\">" >> tweaks/$NAME.html
echo "        <div class=\"package package_head\">" >> tweaks/$NAME.html
echo "            <img src=\" ICON \">" >> tweaks/$NAME.html
echo "            <div class=\"package_info\">" >> tweaks/$NAME.html
echo "                <h1 class=\"package_name\">$NAME</h1>" >> tweaks/$NAME.html
echo "                <p class=\"package_caption\">Adam Wolf</p>" >> tweaks/$NAME.html
echo "            </div>" >> tweaks/$NAME.html
echo "        </div>" >> tweaks/$NAME.html
echo "        <div class=\"nav\">" >> tweaks/$NAME.html
echo "            <div class=\"nav_btn active tweak_info_btn\" onclick=\"swap('.changelog','.tweak_info');\">Details</div>" >> tweaks/$NAME.html
echo "            <div class=\"nav_btn changelog_btn\" onclick=\"swap('.tweak_info','.changelog');\">Changelog</div>" >> tweaks/$NAME.html
echo "        </div>" >> tweaks/$NAME.html
echo "        <div class=\"tweak_info\">            " >> tweaks/$NAME.html
echo "            <div class=\"md_view\">" >> tweaks/$NAME.html
echo "                <p>$DESCRIPTION</p>" >> tweaks/$NAME.html
echo "            </div>" >> tweaks/$NAME.html
echo "            <h3>Information</h3>" >> tweaks/$NAME.html
echo "            <div class=\"table\">" >> tweaks/$NAME.html
echo "                <div class=\"cell\">" >> tweaks/$NAME.html
echo "                    <div class=\"title\">Version</div>" >> tweaks/$NAME.html
echo "                    <div class=\"text\">$VERSION</div>" >> tweaks/$NAME.html
echo "                    <br><br>" >> tweaks/$NAME.html
echo "                </div>" >> tweaks/$NAME.html
echo "                <div class=\"cell\">" >> tweaks/$NAME.html
echo "                    <div class=\"title\">Section</div>" >> tweaks/$NAME.html
echo "                    <div class=\"text\">$SECTION</div>" >> tweaks/$NAME.html
echo "                    <br><br>" >> tweaks/$NAME.html
echo "                </div>" >> tweaks/$NAME.html
echo "            </div>" >> tweaks/$NAME.html
echo "        </div>" >> tweaks/$NAME.html
echo "        <div class=\"changelog\">" >> tweaks/$NAME.html
echo "            <div class=\"changelog_entry\">" >> tweaks/$NAME.html
echo "                <h4>$VERSION</h4>" >> tweaks/$NAME.html
echo "                <div class=\"md_view\"><p>Inital Tweak :)</p></div>" >> tweaks/$NAME.html
echo "            </div>" >> tweaks/$NAME.html
echo "        </div>" >> tweaks/$NAME.html
echo "    </div>" >> tweaks/$NAME.html
echo "</body>" >> tweaks/$NAME.html
echo "</html>" >> tweaks/$NAME.html

DEPICTION="https://repo.wolfyy.me/tweaks/$NAME.html"

########## Add to Packages file ##########

rm Packages

echo "Creating Packages file"
sleep 2

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
