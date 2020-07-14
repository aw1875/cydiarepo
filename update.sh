#!/bin/bash

# Remove old Packages
echo "Removing old Packages"
rm Packages.gz;
rm Packages.bz2;
echo "Removed old packages"


# Create new ones
echo "Creating new packages"
gzip -c9 Packages > Packages.gz
bzip2 -c9 Packages > Packages.bz2
echo "New Packages created"
