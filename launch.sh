#!/bin/bash
if [ $# == 2 ]; then
    if [ -f "./Day$1/Task$2/main.lua" ]; then
        lua ./Day$1/Task$2/main.lua
    else
        if [ -d "./Day$1" ]; then
            if [ -d "./Day$1/Task$2/" ]; then
                echo "Nothing to execute."
            else
                echo "Couldn't find task $2."
            fi
        else
            echo "This day ($1) does not exist."
        fi
    fi
else
    echo "Command needs exactly 2 arguments."
fi
