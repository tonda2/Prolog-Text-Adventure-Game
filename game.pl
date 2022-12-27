:- dynamic location/1.

% --- Game setup ---

location('Výtah').
status('alive').
start :- introduction.

introduction :-
    ansi_format([bold,fg(red)], 'Jak už se to občas stává, výtah si dělá co chce a namísto do přízemí tě právě dovezl do 14. patra.', []), nl,
    ansi_format([bold,fg(red)], 'Už se těšíš do hospody a nenacháváš se rozhodit. Když ale vystoupíš, zamrazí tě.', []), nl,
    ansi_format([bold,fg(red)], 'Skupině studentů, která odsud před chvílí s brekem prchala, se totiž podařilo poničit ovládací desku k výtahu.', []), nl, 
    ansi_format([bold,fg(red)], 'Tvá jediná možnost, jak se dostat zpět na zem, jsou proto schody. Ty jsou ale, jak s hrůzou zjišťuješ, za zamčenými dveřmi.', []), nl, 
    ansi_format([bold,fg(red)], 'Z hezkého večera se stává noční můra. Vydáváš se na obhlídku patra a doufáš, že najdeš někoho, kdo ti dveře odemkne.', []), nl.

% --- Room definitions ---

room('Výtah').
room('Respirium').
room('Schodiště').
room('Učitelská kuchyňka').

info('Výtah', '').
info('Respirium', 'Obvykle je respirium plné sténajících studentů, dnes je tu ale úplně prázdno. Je zde spousta židlí, takže se můžeš posadit a v klidu zamyslet, co dál. Doporuřuji nakouknout i pod stoly, často tam bývají roztroušené různé zapomenuté věci.').

door('Výtah', 'Respirium').

item('Zapomenutá skripta', 'Respirium').
item('Sladká sušenka', 'Respirium').

connected(X, Y) :- door(X, Y).
connected(X, Y) :- door(Y, X).

kdejsem :-
    location(Location),
    write('Jsi v místnosti s názvem '), write(Location), write('.'), nl.

showitems(Room) :-
    ansi_format([bold], 'Předměty v místnosti:', []), nl, 
    item(Item, Room),
    write(Item), nl.

showconnections(Room) :-
    ansi_format([bold], 'Místnosti, do nichž se odsud dostaneš:', []), nl, 
    connected(Dest, Room),
    write(Dest), nl, fail.

showinfo :-
    location(Location),
    info(Location, Info),
    ansi_format([bold], 'Nacházíš se v místnosti ', []), 
    ansi_format([bold], Location, []), nl,
    ansi_format([bold,fg(blue)], Info, []), nl,
    showitems(Location),
    showconnections(Location).

canEnter(Room) :-
    location(Location),
    connected(Location, Room), !.

canEnter(Room) :-
    location(Room),
    write('V místnosti '),
    write(Room),
    write(' právě jsi!'), !.

canEnter(Room) :-
    room(Room),
    write('Do této místnosti odsud nevede cesta!'), fail.

canEnter(_) :-
    write('Taková místnost tu není!'), fail.

vstup(Room) :-
    room(Room),
    canEnter(Room),
    location(Location), !,
    retract(location(Location)),
    asserta(location(Room)),
    showinfo.