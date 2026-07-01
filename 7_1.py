#!/usr/bin/python3
import re

# W zadanym pliku tekstowym należy znaleźć i wylistować na ekran wszystkie teksty cytowane,
# tzn. zamknięte w parach znaków ‘. Należy uwzględnić, że w tej samej linii może być wiele tekstów cytowanych,
# oraz że wewnątrz tekstu cytowanego mogą występować nowe linie.


def znajdz(sciezka_pliku):
        with open(sciezka_pliku, 'r', encoding='utf-8') as plik:
            tekst = plik.read()
        wzorzec = r"'(.*?)'"
        znalezione = re.findall(wzorzec, tekst, flags=re.DOTALL)
        for i, cytat in enumerate(znalezione, 1):
            print(f"{cytat}")
            print("")

if __name__ == "__main__":
    nazwa_pliku = "dotestu.txt"

    znajdz(nazwa_pliku)