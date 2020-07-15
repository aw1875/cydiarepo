#!/bin/bash

# Remove old Packages
echo "Removing old Packages"
sleep 1

rm Packages.gz;
rm Packages.bz2;

sleep 1
echo "Removed old packages"


# Create new ones
sleep 1
echo "Creating new packages"

sleep 1
gzip -c9 Packages > Packages.gz
bzip2 -c9 Packages > Packages.bz2

sleep 1
echo "New Packages created"
