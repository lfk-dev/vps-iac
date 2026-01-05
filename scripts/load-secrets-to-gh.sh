#!/usr/bin/env bash

# extracts the directory of the script using combination of dirname, cd, bash builtins and pwd
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )


# TODO: i don't know if i like the secrets.txt location handling :)
cat $SCRIPT_DIR/../secrets.txt | while read line
do
    if [[ ! $line == \#* ]] && [ -n "$line" ]; then
        # checks if the line is not a comment line or empty line
        
        # extracts two fileds with `=` as delimiter
        name=$(echo $line | cut -d= -f 1)
        value=$(echo $line | cut -d= -f 2-) # the `-` helps if there are more `=` in the value
        echo "Name: $name, value: $value" 
        echo $value | gh secret set $name # gh assumes remote of the current repo as the target
    fi
done
