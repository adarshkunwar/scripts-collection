#!/usr/bin/env bash

# Read the URL from the user

echo "Enter the URL of the website you want to download"
read URL

# Download the website
curl $URL >>website.html
