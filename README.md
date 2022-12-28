# Textová adventura v prologu
### Minimální požadavky

V Prologu implementujte textovou adventuru, která podporuje inventář postavy, nepřátele, mapy, apod. ! Bodové ohodnocení uvedené pod odkazem letos neplatí. !

### Implementované funkce
- Pohyb -> pomocí funkce vstup(Místnost) dojde ke vstupu do místnosti s daným názvem. Pokud neexistuje nebo je zamčená, je to ohlášeno
- Inventář -> příkaz vzit(Název) a nechat(Název), příkaz veci pro vypsání inventáře
- Zamčené dveře -> některé dveře jsou na začátku zamčené, hráč si postupně musí od postav ve hře vysloužit jejich odemčení
- Nepřátelé -> namísto násilných zbraní jsem implementoval nepřátele, kteří zadávají matematické příklady a za jejich vyřešení dávají odměny. Zároveň jsou tu přátelé, se kterými lze komunikovat a vyměňovat předměty za užitečnosti.
- Teleport -> na začátku je do jedné zmístností náhodně umístěn teleport, když ho hráč najde, může se jednou přemístit do libovolné již navštívené místnosti

## Ovládání

Hra se spustí příkazem start. Příkazem help lze zobrazit stejnou nápovědu, jako je zde.

### Podporované operace: 
- kdejsem             = zobrazení informací o místnosti, kde se hráč právě nachází
- veci                = zobrazení všech věcí, které má hráč u sebe
- vstup(Místnost)     = vstup do dané místnosti
- teleport(Místnost)  = přenesení do dané místnosti, pokud má hráč u sebe teleport
- vzit(Předmět)       = sebrání daného předmětu
- nechat(Předmět)     = zanechání daného předmětu v místnosti, kde se hráč právě nachází
- mluvit              = promluvit s člověkem v místnosti, kde se hráč právě nachází
- odpovedet(Výsledek) = odpovědět na problém
