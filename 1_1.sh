#!/bin/bash

# Zadanie 12 Porównanie zawartości dwóch zadanych katalogów (argumenty skryptu). 
# Przy porównaniu należy ignorować podkatalogi.
# W wyniku wyświetlić na ekranie listę plików o identycznych nazwach w obu katalogach.

if [ "$#" -ne 2 ]; then
    echo "Użycie: $0 katalog1 katalog2"
    exit 1
fi

_dir1=$1
_dir2=$2

if [ ! -d "$_dir1" ] || [ ! -d "$_dir2" ]; then
    echo "Oba argumenty musza byc istniejacymi katalogami."
    exit 1
fi


for _file1 in "$_dir1"/*; do
    [ -f "$_file1" ] || continue  
    for _file2 in "$_dir2"/*; do
        [ -f "$_file2" ] || continue  
        if [[ $(basename "$_file1") = $(basename "$_file2") ]]; then
            echo $(stat -f "%N" "$_file1")
            echo $(stat -f "%N" "$_file2")
        fi
    done
done
