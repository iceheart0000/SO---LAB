#!/usr/bin/python3
import os
import sys
import stat

# W zadanym drzewie katalogów znaleźć pliki regularne, do których są dowiązania twarde (nieważne,
# czy wewnątrz czy poza drzewem), do których właściciel nie ma prawa zapisu ani wykonania,
# właścicele grupowi nie mają prawa zapisu, a inni mają prawo wykonania.

if len(sys.argv) != 2: print(f"Użycie: {sys.argv[0]} <katalog>"); sys.exit(1)

target_dir = sys.argv[1]

if not os.path.isdir(target_dir):
    print(f"Błąd: '{target_dir}' to nie katalog.")
    sys.exit(1)


for root, dirs, files in os.walk(target_dir, topdown=True):
    for name in files:
        path = os.path.join(root, name)
        try:
            st = os.stat(path)
        except OSError:
            continue

        if not stat.S_ISREG(st.st_mode):
            continue

        if st.st_nlink <= 1:
            continue

        mode = st.st_mode

        owner_no_write = not (mode & stat.S_IWUSR)
        owner_no_exec  = not (mode & stat.S_IXUSR)

        group_no_write = not (mode & stat.S_IWGRP)
        others_exec = bool(mode & stat.S_IXOTH)

        if owner_no_write  and owner_no_exec and  others_exec and group_no_write:
            print(path)