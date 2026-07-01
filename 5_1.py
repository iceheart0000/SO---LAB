#!/usr/bin/python3
import sys
import os
# W zadanym katalogu przerób wszystkie dowiązania symboliczne wskazujące na pliki regularne
# (do których wykonujący skrypt nie ma prawa zapisu), tak aby ścieżki w dowiązaniach były bezwzględne.

def main():
    target_dir = sys.argv[1]

    if len(sys.argv) != 2: print(f"Użycie: {sys.argv[0]} <katalog>");  sys.exit(1)

    if not os.path.isdir(target_dir): print(f"Błąd: '{target_dir}' to nie katalog."); sys.exit(1)


    for filename in os.listdir(target_dir):
        link_path = os.path.join(target_dir, filename)

        if os.path.islink(link_path):
                current_target = os.readlink(link_path)
                real_target_path = os.path.realpath(link_path)
                if os.path.isfile(real_target_path):
                    if not os.access(real_target_path, os.W_OK):
                        if current_target != real_target_path:

                            os.unlink(link_path)
                            os.symlink(real_target_path, link_path)
                            print(f"Zamieniono: {filename} na {real_target_path}")



if __name__ == "__main__":
    main()