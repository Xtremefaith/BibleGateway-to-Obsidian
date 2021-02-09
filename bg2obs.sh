#!/bin/bash
#----------------------------------------------------------------------------------
# This script runs Jonathan clark's bg2md.rb ruby script and formats the output
# to be useful in Obsidian. Find the script here: https://github.com/jgclark/BibleGateway-to-Markdown
#
# It needs to be run in the same directoy as the 'bg2md.rb' script and will output
# one .md file for each chapter, organising them in folders corresponding to the book.
# Navigation on the top and bottom is also added.
#
#----------------------------------------------------------------------------------
# SETTINGS
#----------------------------------------------------------------------------------
# Setting a different translation:
# Using the abbreviation, you can call on a different translation.
# It defaults to the "World English Bible", if you change the translation,
# make sure to honour the copyright restrictions.
#----------------------------------------------------------------------------------

# OPTIONS
translation="ESV" # Set translation
boldwords="false" # Set 'true' for bolding words of Jesus
headers="false" # Set 'true' for including editorial headers

book_counter=0 # Setting the counter to 0
book_counter_max=66 # Setting the max amount to 66, since there are 66 books we want to import

# Book list
declare -a bookarray # Declaring the Books of the Bible as a list
bookarray=(Genesis Exodus Leviticus Numbers Deuteronomy Joshua Judges Ruth "1 Samuel" "2 Samuel" "1 Kings" "2 Kings" "1 Chronicles" "2 Chronicles" Ezra Nehemiah Esther Job Psalm Proverbs Ecclesiastes "Song of Solomon" Isaiah Jeremiah Lamentations Ezekiel Daniel Hosea Joel Amos Obadiah Jonah Micah Nahum Habakkuk Zephaniah Haggai Zechariah Malachi Matthew Mark Luke John Acts
Romans "1 Corinthians" "2 Corinthians" Galatians Ephesians Philippians Colossians "1 Thessalonians" "2 Thessalonians" "1 Timothy" "2 Timothy" Titus Philemon Hebrews James "1 Peter" "2 Peter" "1 John" "2 John" "3 John" Jude Revelation)
x
# Book chapter list
declare -a lengtharray # Declaring amount of chapters in each book
lengtharray=(50 40 27 36 34 24 21 4 31 24 22 25 29 36 10 13 10 42 150 31 12 8 66 52 5 48 12 14 3 9 1 4 7 3 3 3 2 14 4 28 16 24 21 28 16 16 13 6 6 4 4 5 3 6 4 3 1 13 5 5 3 5 1 1 1 22)

# Abbreviation list
declare -a abbarray # Delaring the abbreviations for each book. You can adapt if you'd like
abbarray=(Gen Exod Lev Num Deut Josh Judg Ruth "1 Sam" "2 Sam" "1 Kings" "2 Kings" "1 Chron" "2 Chron" Ezr Neh Esth Job Ps Prov Eccles Song Isa Jer Lam Ezek Dan Hos Joel Am Obad Jonah Micah Nah Hab Zeph Hag Zech Mal Matt Mark Luke John Acts Rom "1 Cor" "2 Cor" Gal Ephes Phil Col "1 Thess" "2 Thess" "1 Tim" "2 Tim" Titus Philem Heb James "1 Pet" "2 Pet" "1 John" "2 John" "3 John" Jude Rev)


 # Cycling through the book counter, setting which book and it's maxchapter
  for ((book_counter=0; book_counter <= book_counter_max; book_counter++))
  do

    book=${bookarray[$book_counter]}
    maxchapter=${lengtharray[$book_counter]}
    abbreviation=${abbarray[$book_counter]}

    for ((chapter=1; chapter <= maxchapter; chapter++))
    do

((prev_chapter=chapter-1)) # Counting the previous and next chapter for navigation
((next_chapter=chapter+1))

# Exporting
  export_prefix="${book} " # Setting the first half of the filename

  export_number=${chapter}

filename=${export_prefix}$export_number # Setting the filename


  prev_file=${export_prefix}$prev_chapter # Naming previous and next files
  next_file=${export_prefix}$next_chapter

  # Formatting Navigation and omitting links that aren't necessary
  if [ ${maxchapter} -eq 1 ]; then
    # For a book that only has one chapter
    navigation="[[${book}]]"
  elif [ ${chapter} -eq ${maxchapter} ]; then
    # If this is the last chapter of the book
    navigation="[[${prev_file}|← ${book} ${prev_chapter}]] | [[${book}]]"
  elif [ ${chapter} -eq 1 ]; then
    # If this is the first chapter of the book
    navigation="[[${book}]] | [[${next_file}|${book} ${next_chapter} →]]"
  else
    # Navigation for everything else
    navigation="[[${prev_file}|← ${book} ${prev_chapter}]] | [[${book}]] | [[${next_file}|${book} ${next_chapter} →]]"
  fi

  if ${boldwords} -eq "true" && ${headers} -eq "false"; then
    text=$(ruby BibleGateway-to-Markdown/bg2md.rb -e -c -b -f -l -r -v "${translation}" ${book} ${chapter}) # This calls the 'bg2md_mod script'
  elif ${boldwords} -eq "true" && ${headers} -eq "true"; then
    text=$(ruby BibleGateway-to-Markdown/bg2md.rb -c -b -f -l -r -v "${translation}" ${book} ${chapter}) # This calls the 'bg2md_mod script'
  elif ${boldwords} -eq "false" && ${headers} -eq "true"; then
    text=$(ruby BibleGateway-to-Markdown/bg2md.rb -e -c -f -l -r -v "${translation}" ${book} ${chapter}) # This calls the 'bg2md_mod script'
  else
    text=$(ruby BibleGateway-to-Markdown/bg2md.rb -e -c -f -l -r -v "${translation}" ${book} ${chapter}) # This calls the 'bg2md_mod script'
  fi


  text=$(echo $text | sed 's/^(.*?)v1/v1/') # Deleting unwanted headers

  # Formatting the title for markdown
  title="# ${book} ${chapter}"

  # Navigation format
  export="${title}\n\n$navigation\n***\n\n$text\n\n***\n$navigation"


  # Export
  echo -e $text >> "$filename.md"

  # Creating a folder

  ((actual_num=book_counter+1)) # Proper number counting for the folder

  if (( $actual_num < 10 )); then
    #statements
    actual_num="${actual_num}"
  else
    actual_num=$actual_num
  fi

  folder_name="${book}" # Setting the folder name

  # Creating a folder for the book of the Bible it not existing, otherwise moving new file into existing folder
  mkdir -p "./${translation}/${folder_name}"; mv "${filename}".md "${translation}/${folder_name}"


done # End of the book exporting loop

  # Create an overview file for each book of the Bible:
  overview_file="links: [[The Bible]]\n# ${book}\n\n[[${abbreviation}-01|Start Reading →]]"
  echo -e $overview_file >> "$book.md"
  #mkdir -p ./Scripture ("${translation}")/"${folder_name}"; mv "$book.md" './Scripture ('"${translation}"')/'"${folder_name}"
  mv "$book.md" "${translation}/${folder_name}"

  done

  #----------------------------------------------------------------------------------
  # The Output of this text needs to be formatted slightly to fit with use in Obsidian
  # Enable Regex and run find and replace:
    # *Clean up unwanted headers*
      # Find: ^[\w\s]*(######)
      # Replace: \n$1
      # file: *.md
    # Clean up verses
      # Find: (######\sv\d)
      # Replace: \n\n$1\n
      # file: *.md
  #----------------------------------------------------------------------------------
