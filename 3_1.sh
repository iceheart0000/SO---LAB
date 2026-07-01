#!/usr/bin/env bash

# W zadanym drzewie katalogów wylistuj pliki regularne, do których właściciel ma prawo odczytu i nikt nie ma prawa wykonania,
# mające co najmniej 3 dowiązania twarde.


ROOT="$1"

if [ $# -ne 1 ]; then
    echo "Użycie: $0 KATALOG_KORZENNY" >&2
    exit 1
fi

if [ ! -d "$ROOT" ]; then
    echo "Błąd: '$ROOT' nie jest katalogiem." >&2
    exit 2
fi


find "$ROOT" -type f -perm -444 ! -perm /111 -links +2 -print
