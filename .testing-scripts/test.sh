#!/bin/bash

function get_array {
    local array=()
    local i=0

    # find all files in the directory test-folder
    readarray -t found_files < <(find test-folder -type f -name "with *")
    #readarray -t found_files_only_filenames < <(${found_files[@]} | xargs -n 1 basename)
    #echo "Found files: ${found_files[*]}"
    echo "Second file in func: ${found_files[0]}"  >&2 
    #echo ${found_files[*]} # nur als string übergeben
    #for file in "${found_files_only_filenames[@]}"; do
    #    echo "$file" 
    #done
    for filename in "${found_files[@]}"; do
        echo $(echo "$filename" | xargs -n 1 basename)
    done
}

readarray -t array < <(get_array)


echo "Array: ${array[*]}"
echo "Second element: ${array[0]}"

 # start rofi with each element of the array as an option
echo "${array[*]}" | rofi -dmenu -p "Select a file" -selected-row 0
# array to string with enter as delimiter
string=$(printf "%s\n" "${array[@]}")
echo "$string" | rofi -dmenu -p "Select a file" -selected-row 0

# if string more than one line, then select the first line
if [[ $(echo "$string" | wc -l) -gt 1 ]]; then
    echo "more than one line"
else
    echo "only one line"
fi

echo "================================================"

function get_string {
    echo -e "inner function\n$(find test-folder -type f)" >&2
    echo "$(find test-folder -type f)" # the questionmarks are important to get the \n nuwlines in the output
}

function check_counts {
    local string=$1
    local count=$(echo "$string" | wc -l)
    echo "count: $count" >&2

}
#files=$(find test-folder -type f)
files=$(get_string)
check_counts "$files"

echo "files"
echo "$files"  # the questionmarks are important to get the \n nuwlines in the output. An echo -e is not necessary   
echo "===================="
echo "count files: $(echo "$files" | wc -l)"
echo "===================="
echo "first file: $(echo "$files" | head -n 1)"
echo "first two files: $(echo "$files" | head -n 2)"
echo "only second file: $(echo "$files" | head -n 2 | tail -n 1)"
echo "===================="
#filesBasename=$(echo -e "$files" | xargs -n 2 basename)
firstFile=$(echo -e "$files" | head -n 1 | awk -F/ '{print $NF}')
echo "first file basename: $firstFile"
secondFile=$(echo -e "$files" | head -n 2 | tail -n 1 | awk -F/ '{print $NF}')
echo "second file basename: $secondFile"
echo "====================================================="
filesBasenames=$(echo -e "$files" | awk -F/ '{print $NF}')
echo -e "filesBasenames\n--------------\n$filesBasenames"
echo "$filesBasenames" | rofi -dmenu -p "Select a file" -selected-row 0

