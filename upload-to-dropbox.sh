#!/bin/bash

# Check if the first parameter exists
if [ -z "$1" ]; then
  echo "Error: First parameter (filename) does not exist"
  echo "Usage: ./upload-to-dropbox.sh filename"
  exit 1  # Exit with a non-zero status to indicate an error
fi

# Continue with the script if the first parameter exists
echo "First parameter (filename) exists and is: $1"

# Extract filename using basename
filename=$(basename "$1")

echo "Filename: $filename"

# https://stackoverflow.com/questions/42120767/upload-file-on-linux-cli-to-dropbox-via-bash-sh

# KEY=sl.Bu-SQDQztEo99SyhJXF_bhuccZVc3QPssEJ6smC5xv6oO-ekeg44O6_0u0yGwtg04y97prup0OPfFWVpRtyTJ3-6hcxOnGpvFE4fySnnkhdJQ0GBjP8Uk7ScVQZvmsmRJDbvq2j9lJlk

KEY=sl.Bv4bF3bSRK1Wht3hOLd60cGblSXz0RE30bY2JCRXaw3VsZ52GB1Z3lLLUhFP27vFelNLfHsynXI45THwvF1_iT1dpkdjYRGd0TQPsGZ4_HPNPjsnKGfkuZCduxMVQHNAKIXeim2Yyaz_

echo "some content here" > matrices.txt

curl -X POST https://content.dropboxapi.com/2/files/upload \
    --header "Authorization: Bearer $KEY" \
    --header "Dropbox-API-Arg: {\"path\": \"/bu/$filename\"}" \
    --header "Content-Type: application/octet-stream" \
    --data-binary @"$1"


# this worked
#    --header "Dropbox-API-Arg: {\"path\": \"/Apps/dean-wpbu/Matrices.txt\"}" \

#    --header "Dropbox-API-Arg: {\"path\": \"/Apps/dean-wpbu/Matrices.txt\"}" \


#    --header "Dropbox-API-Arg: {\"path\": \"/Matrices.txt\"}" \
