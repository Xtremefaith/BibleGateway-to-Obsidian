#!/bin/bash

source config.sh

echo "Adding ^verse to verse note files..."

# Loop through each book folder
for book_folder in "${translation}"/*/; do

    # Loop through each chapter folder in the book folder
    for chapter_folder in "${book_folder}"*/; do

        echo "Processing chapter: ${chapter_folder#${book_folder}}"

        # Set chapter note file path
        chapter_note=$(basename "${chapter_folder}")
        chapter_note_file="${chapter_folder}${chapter_note}.md"

        # Check if chapter note file exists
        if [ ! -f "$chapter_note_file" ]; then
            echo "Chapter note not found: ${chapter_note_file}. Skipping..."
            continue
        fi

        # Clear chapter note's content
        echo -n "" > "$chapter_note_file"

        # Add verse references to chapter note
        for verse_file in "${chapter_folder}"*.md; do
            if [ "$verse_file" != "$chapter_note_file" ]; then
                verse_number=$(basename "${verse_file%.*}" | cut -d '.' -f 2)
                verse_note=$(basename "$(basename "${verse_file%.*}")")

                # Add translucent verse reference to the chapter note
                echo "v${verse_number} ![[${verse_note}#^verse]]" >> "$chapter_note_file"

                # Insert ^verse after the first line of text in verse note
                if grep -qF '^verse' "$verse_file"; then
                    echo "Skipping file: $(basename "$verse_file") (already contains ^verse)"
                else
                    if awk 'NR==1{print $0 "\n^verse"} NR!=1{print}' "$verse_file" > temp_file && mv temp_file "$verse_file"; then
                        # Add verse headers to the verse note
                        if [ "$verseheaders" = true ]; then
                            if grep -qF '## Notes' "$verse_file"; then
                                echo "Skipping file: $(basename "$verse_file") (already contains Notes header)"
                            else
                                echo -e "## Notes\n- \n\n## References\n- " >> "$verse_file"
                            fi
                        fi
                        # echo " ^verse inserted into $(basename "$verse_file")."
                    else
                        echo "Error inserting ^verse into $(basename "$verse_file"). Exiting..."
                        exit 1
                    fi
                fi

                # Add breadcrumb navigation to the verse notes
                if [ "$versebreadcrumbs" = true ]; then
                    chapter_name=$(basename "$chapter_folder")
                    echo "Chapter Name: ${chapter_name}"
                    
                    prev_verse=$((verse_number-1))
                    prev_file=$(printf "%s%s.%.0f.md" "$chapter_folder" "$chapter_name" "$prev_verse")
                    
                    next_verse=$((verse_number+1))
                    next_file=$(printf "%s%s.%.0f.md" "$chapter_folder" "$chapter_name" "$next_verse")
                    
                    chapter_link="[[${chapter_name}]]"
                    echo "Chapter Link: ${chapter_link}"
                    
                    prev_link=""
                    next_link=""

                    if [ -f "$prev_file" ]; then
                        prev_link="[[${chapter_name}.${prev_verse} | <<]] \| "
                    fi
                    if [ -f "$next_file" ]; then
                        next_link=" \| [[${chapter_name}.${next_verse} | >>]]"
                    fi
                    breadcrumb="${prev_link}${chapter_link}${next_link}"
                    
                    if awk -v b="$breadcrumb" 'NR==1{$0=b"\n"$0}1' "$verse_file" > temp_file && mv temp_file "$verse_file"; then
                        echo "Breadcrumb navigation added to $(basename "$verse_file")."
                    else
                        echo "Error adding breadcrumb to $(basename "$verse_file"). Exiting..."
                        exit 1
                    fi

                fi
            fi
        done

        # Sort chapter note's content by verse number
        if awk 'NR==1{print $0} NR!=1{print $0 | "sort -V"}' "$chapter_note_file" > temp_file && mv temp_file "$chapter_note_file"; then
            echo "Chapter created successfully"
        else
            echo "Error sorting chapter note content by verse number. Exiting..."
            exit 1
        fi

    done

done

echo "Done adding ^verse to verse note files."
