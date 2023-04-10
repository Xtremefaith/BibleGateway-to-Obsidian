#!/bin/bash
translation="ESV" # Set translation
boldwords="false" # Set 'true' for bolding words of Jesus
headers="false" # Set 'true' for including editorial headers
splitverses="true" # Set 'true' to split the verse into separate folders and notes afterwards
masterfiles="true" # Set 'true' to generate a master file (only works if verses are split)
versesections="true" # Set 'true' to insert ^verse sections and references (only works if verses are split)
verseheaders="true" # Set 'true' to include Notes and Reference Headers in the verse notes
versebreadcrumbs="true" # Set 'true' to include breadcrumb navigation

book_counter=0 # Setting the counter to 0
book_counter_max=66 # Setting the max amount to 66, since there are 66 books we want to import

# Book list
declare -a bookarray # Declaring the Books of the Bible as a list
bookarray=(Genesis Exodus Leviticus Numbers Deuteronomy Joshua Judges Ruth "1 Samuel" "2 Samuel" "1 Kings" "2 Kings" "1 Chronicles" "2 Chronicles" Ezra Nehemiah Esther Job Psalm Proverbs Ecclesiastes "Song of Solomon" Isaiah Jeremiah Lamentations Ezekiel Daniel Hosea Joel Amos Obadiah Jonah Micah Nahum Habakkuk Zephaniah Haggai Zechariah Malachi Matthew Mark Luke John Acts Romans "1 Corinthians" "2 Corinthians" Galatians Ephesians Philippians Colossians "1 Thessalonians" "2 Thessalonians" "1 Timothy" "2 Timothy" Titus Philemon Hebrews James "1 Peter" "2 Peter" "1 John" "2 John" "3 John" Jude Revelation)

# Book chapter list
declare -a lengtharray # Declaring amount of chapters in each book
lengtharray=(50 40 27 36 34 24 21 4 31 24 22 25 29 36 10 13 10 42 150 31 12 8 66 52 5 48 12 14 3 9 1 4 7 3 3 3 2 14 4 28 16 24 21 28 16 16 13 6 6 4 4 5 3 6 4 3 1 13 5 5 3 5 1 1 1 22)

# Abbreviation list
declare -a abbarray # Delaring the abbreviations for each book. You can adapt if you'd like
abbarray=(Gen Exod Lev Num Deut Josh Judg Ruth "1 Sam" "2 Sam" "1 Kings" "2 Kings" "1 Chron" "2 Chron" Ezr Neh Esth Job Ps Prov Eccles Song Isa Jer Lam Ezek Dan Hos Joel Am Obad Jonah Micah Nah Hab Zeph Hag Zech Mal Matt Mark Luke John Acts Rom "1 Cor" "2 Cor" Gal Ephes Phil Col "1 Thess" "2 Thess" "1 Tim" "2 Tim" Titus Philem Heb James "1 Pet" "2 Pet" "1 John" "2 John" "3 John" Jude Rev)

