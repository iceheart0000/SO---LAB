#!/bin/bash

# W zadanym drzewie katalogów wylistować wszystkie pliki regularne,
# mające jedno z rozszerzeń o postaci „exe” (wielokrotne rozszerzenia to rozszerzenia,
# od kropki do kropki lub do końca nazwy, gdy plik ma wiele kropek w nazwie).

directory="$1"

if [ $# -ne 1 ]; then
    echo "Błąd: Skrypt używa 1 argumentu."
    exit 1
fi

if [ ! -d "$directory" ]; then
    echo "Błąd: '$directory' nie jest katalogiem."
    exit 1
fi


find "$directory" -type f | awk -F/ '{
    file = $NF
    n = split(file, parts, ".")
    if (n < 2) next
    for (i = 2; i <= n; i++) {
        if (parts[i] == "exe") { print $0; break }
    }
}'
