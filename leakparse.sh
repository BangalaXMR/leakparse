#!/bin/bash

# Prompt the user to enter the word to search for
search_word=$(zenity --entry --title="LeakParse" --text="Enter the word to search for:")

# Check if the user canceled the input
if [ $? -ne 0 ]; then
    zenity --error --text="Search canceled."
    exit 1
fi

# Prompt the user to select the directory to search in
search_directory=$(zenity --file-selection --directory --title="Select Directory")

# Check if the user canceled the directory selection
if [ $? -ne 0 ]; then
    zenity --error --text="Directory selection canceled."
    exit 1
fi

# Search for the word in the selected directory using grep
search_results=$(grep -r -n -H "$search_word" "$search_directory" 2>/dev/null)

# Check if there are any search results
if [ -z "$search_results" ]; then
    zenity --info --text="No matches found for '$search_word' in '$search_directory'."
    exit 0
fi

# Display the search results in a Zenity text info dialog
zenity --text-info --title="Search Results" --filename=<(echo "$search_results") --width=800 --height=600
