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

if [ -f "tweaks/$NAME.html" ]; then
    echo "Deleting old depictions page"
    rm tweaks/$NAME.html
fi

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
echo "                <div class=\"cell\">" >> tweaks/$NAME.html
echo "                    <div class=\"title\">Source Code</div>" >> tweaks/$NAME.html
echo "                    <div class=\"text\"><a href=\"https://github.com/aw1875\"><img style=\"height: 28px; width: 28px; border-radius: 50%;\" src=\"data:image/png;base64,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\"/></a></div>" >> tweaks/$NAME.html
echo "                    <br><br>" >> tweaks/$NAME.html
echo "                </div>" >> tweaks/$NAME.html
echo "                <div class=\"cell\">" >> tweaks/$NAME.html
echo "                    <div class=\"title\">PayPal</div>" >> tweaks/$NAME.html
echo "                    <div class=\"text\"><a href=\"https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=YM522XYP26LWU&source=url\"><img style=\"height: 28px; width: 28px; border-radius: 50%;\" src=\"https://www.logotaglines.com/wp-content/uploads/2018/11/PayPal-Logo-Tagline-1200x1200.jpg\"/></a></div>" >> tweaks/$NAME.html
echo "                    <br><br>" >> tweaks/$NAME.html
echo "                </div>" >> tweaks/$NAME.html
echo "                <div class=\"cell\">" >> tweaks/$NAME.html
echo "                    <div class=\"title\">Twitter</div>" >> tweaks/$NAME.html
echo "                    <div class=\"text\"><a href=\"https://twitter.com/_wolfy33\"><img style=\"height: 28px; width: 28px; border-radius: 50%;\" src=\"https://cdn.vox-cdn.com/thumbor/yzCOIMTwgm75fFCk5AN4gqWjCxA=/71x0:769x465/1400x1400/filters:focal(71x0:769x465):format(png)/cdn.vox-cdn.com/assets/1167000/Screen_Shot_2012-06-06_at_12.17.44_PM.png\"/></a></div>" >> tweaks/$NAME.html
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
echo "        <div class=\"caption center footer\">© 2020 Adam Wolf</div>" >> tweaks/$NAME.html
echo "        <script>compatible(\"13.0\",\"13.6\",\"iOS 13.0 to 13.6\");externalize()</script>" >> tweaks/$NAME.html
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
