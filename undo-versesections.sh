#!/bin/bash

source config.sh

echo "Removing ^verse from verse note files..."

# Loop through each book folder
for book_folder in "${translation}"/*/; do

  # Loop through each chapter folder in the book folder
  for chapter_folder in "${book_folder}"*/; do

    echo "Processing chapter: ${chapter_folder#${book_folder}}"

    # Loop through each verse note file in the chapter folder
    for verse_file in "${chapter_folder}"*.?.md "${chapter_folder}"*.??.md; do


      echo "Processing file: ${verse_file}"

      # Remove any existing ^verse entries from the file
      awk '!/^(\^verse)/' "$verse_file" > "$verse_file.tmp"
      mv "$verse_file.tmp" "$verse_file"

    done

  done

done

echo "Done removing ^verse from verse note files."
