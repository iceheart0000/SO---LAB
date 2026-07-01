#!/usr/bin/env bash

# Odrabiane: W zadanym katalogu ($1) przerób dowiązania symboliczne, wskazujące na obiekty w tym katalogu,
# na dowiązania symboliczne ze ścieżkami względnymi.


if [ $# -ne 1 ]; then
    echo "Użycie: $0 <katalog>"
    exit 1
fi

DIR="$1"

if [ ! -d "$DIR" ]; then
    echo "Błąd: $DIR nie jest katalogiem"
    exit 2
fi


for file in "$DIR"/*; do

    if [ -L "$file" ]; then
        target=$(readlink -f "$file")
        dir_of_target=$(dirname "$target")
        dir_canonical=$(readlink -f "$DIR")

        if [ "$dir_of_target" = "$dir_canonical" ]; then

            base=$(basename "$target")
            rm -- "$file"
            ln -s "./$base" "$file"
            echo "Zmieniono dowiązanie: $file -> ./$base"
        fi
    fi
done 