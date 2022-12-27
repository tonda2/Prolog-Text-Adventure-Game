:- dynamic location/1.
:- dynamic item/2.
:- dynamic has/1.
:- dynamic status/1.
:- dynamic result/1.

% --- Game setup ---

location('Výtah').
status('alive').
result(0).
:- ansi_format([bold,fg(red)], 'Pro spuštění hry "start.". Pro nápovědu "help."', []).
start :- introduction, showinfo.

introduction :-
    ansi_format([bold,fg(red)], 'Jak už se to občas stává, výtah si dělá co chce a namísto do přízemí tě právě dovezl do 14. patra.', []), nl,
    ansi_format([bold,fg(red)], 'Už se těšíš do hospody a nenacháváš se rozhodit. Když ale vystoupíš, zamrazí tě.', []), nl,
    ansi_format([bold,fg(red)], 'Skupině studentů, která odsud před chvílí s brekem prchala, se totiž podařilo poničit ovládací desku k výtahu.', []), nl, 
    ansi_format([bold,fg(red)], 'Tvá jediná možnost, jak se dostat zpět na zem, jsou proto schody. Ty jsou ale, jak s hrůzou zjišťuješ, za zamčenými dveřmi.', []), nl, 
    ansi_format([bold,fg(red)], 'Z hezkého večera se stává noční můra. Vydáváš se na obhlídku patra a doufáš, že najdeš někoho, kdo ti dveře odemkne.', []), nl.

help :-
    ansi_format([bold,fg(green)], 'Ovládání', []), nl,
    ansi_format([bold], 'vstup(Místnost) = vstup do dané místnosti', []), nl,
    ansi_format([bold], 'vzit(Předmět) = sebrání daného předmětu', []), nl,
    ansi_format([bold], 'mluvit = promluvit s člověkem v místnosti, kde se hráč právě nachází', []), nl,
    ansi_format([bold], 'odpovedet(Výsledek) = odpovědět na problém', []), nl,
    ansi_format([bold], 'veci = zobrazení všech věcí, které má hráč u sebe', []), nl,
    ansi_format([bold], 'kdejsem = zobrazení informací o místnosti, kde se hráč právě nachází', []), nl.

% --- Room definitions ---

room('Výtah').
room('Respirium').
room('Schodiště').
room('Učitelská kuchyňka').
room('Malá učebna').
room('Velká učebna').
room('Kabinet').
room('Testovací místnost').

info('Výtah', 'Jsi u výtahu. Tlačítka jsou rozbitá, takže budeš muset pěšky.').
info('Respirium', 'Obvykle je respirium plné sténajících studentů, dnes je tu ale úplně prázdno. Je zde spousta židlí, takže se můžeš posadit a v klidu zamyslet, co dál. Doporuřuji nakouknout i pod stoly, často tam bývají roztroušené různé zapomenuté věci.').
info('Malá učebna', 'Jsi v malé učebně, která v tobě vyvolává mnoho nepříjemných vzpomínek. Najednou jsi rád, že tě ze školy vyhodili. Místnost je temná a když se ti konečně podaří nahmatat vypínač, zjistíš, že v ní nejsi sám. V rohu se krčí temná postava bušící něco do notebooku. Možná si budete mít co říct.').
info('Kabinet', 'Už na první pohled je ti jasné, že tady nemáš co dělat. Místnost je špatně osvícená, plná tabulí s výpočty a plakáty se vzorečky a v rohu se kupí hrnky od čaje. Evidentně tu sídlí matematici a jednoho dokonce vidíš stát v rohu. Pokud se cítíš odvážně, možná si s tebou bude i povídat.').
info('Velká učebna', '').
info('Toalety', '').
info('Společenská místnost', '').
info('Síťová laboratoř', '').
info('Testovací místnost', '').
info('Kuchyňka', '').
info('Schodiště', '').

door('Výtah', 'Respirium').
door('Respirium', 'Testovací místnost').
door('Respirium', 'Malá učebna').
door('Testovací místnost', 'Malá učebna').
door('Malá učebna', 'Kabinet').
door('Kabinet', 'Učitelská kuchyňka').

locked('Schodiště').

connected(X, Y) :- door(X, Y).
connected(X, Y) :- door(Y, X).

item('Skripta', 'Respirium').
item('Sušenka', 'Respirium').

person('Malá učebna', 'student').
person('Kabinet', 'učitel').

% --- Useful functions ---

kdejsem :- showinfo.

showitems(Room) :-
    item(Item, Room), 
    write(Item), nl, fail.
showitems(_) :- true.

showconnections(Room) :-
    connected(Dest, Room),
    write(Dest), nl, fail.

showinventory :-
    has(Item), write(Item), nl, fail.

veci :-
    write('Hráč má u sebe:'), nl, showinventory.

showinfo :-
    location(Location),
    info(Location, Info),
    ansi_format([bold], 'Nacházíš se v místnosti ', []), 
    ansi_format([bold], Location, []), nl,
    ansi_format([bold,fg(blue)], Info, []), nl,
    ansi_format([bold], 'Předměty v místnosti:', []), nl,
    showitems(Location),
    ansi_format([bold], 'Místnosti, do nichž se odsud dostaneš:', []), nl, 
    showconnections(Location).

% --- Moving ---

canEnter(_) :-
    status('counting'), !,
    write('Nejdřív dokonči svůj příklad!'), fail.

canEnter(Room) :- locked(Room), !, fail.

canEnter(Room) :-
    location(Location),
    connected(Location, Room), !.

canEnter(Room) :-
    location(Room),
    write('V místnosti '),
    write(Room),
    write(' právě jsi!'), fail.

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

% --- Interacting ---

equal(X, X).

getResult(N1, N2, 1) :- !, write(N1), write(' + '), write(N2), write(' = ??'), Res is N1 + N2, retract(result(_)), asserta(result(Res)).
getResult(N1, N2, 2) :- !, write(N1), write(' - '), write(N2), write(' = ??'), Res is N1 - N2, retract(result(_)), asserta(result(Res)).
getResult(N1, N2, 3) :- !, write(N1), write(' * '), write(N2), write(' = ??'), Res is N1 * N2, retract(result(_)), asserta(result(Res)).
getResult(N1, N2, 4) :- !, write(N1), write(' / '), write(N2), write(' = ??'), Res is N1 / N2, retract(result(_)), asserta(result(Res)).

getProblem :-
    random(1, 100, N1),
    random(1, 100, N2),
    random(1, 4, S),
    getResult(N1, N2, S).

odpovedet(Got) :-
    result(Wanted),
    equal(Wanted, Got), !,
    write('Gratuluji. Zkoušku jsi ustál a jsi propuštěn.'),
    retract(status('counting')),
    asserta(status('alive')).

odpovedet(_) :-
    write('To bohužel není správně. Za pohoršení všech znalých matematiky budeš měsíc mít nádobí v místní kuchyňce').

vzit(Item) :-
    location(Room),
    item(Item, Room), !,
    retract(item(Item, Room)),
    asserta(has(Item)).

vzit(_) :-
    write('Tento předmět tu není!').

mluvitTyp('student') :-
    not(has('Skripta')), !,
    asserta(has('Skripta')),
    write('Student má radost, že na něj poprvé za celý den někdo promluvil. Jako poděkování ti věnuje svoje skripta z analýzy a přeje ti hodně štěstí.').

mluvitTyp('student') :-
    write('Student na tebe bázlivě vzhlédl od obrazovky a dál se věnuje své práci. Tato interakce nikam nepovede.').

mluvitTyp('učitel') :- !,
    retract(status('alive')),
    asserta(status('counting')),
    write('Narazil si na jednoho z všemi obávaných učitelů matematiky. Na úprk už ale není čas, budeš s ním muset hovořit.'), nl,
    write('Než se stačíš rozkoukat, už ti podává fixu a ty nemáš na výběr. Jinak, než počítáním, se odsud živý nedostaneš.'), nl,
    write('Máš za úkol spočítat '),
    getProblem(), 
    write('.').

mluvit :- location(Room), not(person(Room, _)), !, write('V této místnosti není s kým mluvit!').

mluvit :-
    location(Room), !,
    person(Room, Typ),
    mluvitTyp(Typ).