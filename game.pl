:- dynamic location/1.
:- dynamic item/2.
:- dynamic has/1.
:- dynamic status/1.
:- dynamic result/1.
:- dynamic locked/1.

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
    ansi_format([bold], 'nechat(Předmět) = zanechání daného předmětu v místnosti, kde se hráč právě nachází', []), nl,
    ansi_format([bold], 'mluvit = promluvit s člověkem v místnosti, kde se hráč právě nachází', []), nl,
    ansi_format([bold], 'odpovedet(Výsledek) = odpovědět na problém', []), nl,
    ansi_format([bold], 'veci = zobrazení všech věcí, které má hráč u sebe', []), nl,
    ansi_format([bold], 'kdejsem = zobrazení informací o místnosti, kde se hráč právě nachází', []), nl.

% --- Room definitions ---

room('Výtah').
room('Respirium').
room('Schodiště').
room('Kuchyňka').
room('Malá učebna').
room('Velká učebna').
room('Kabinet').
room('Testovací místnost').
room('Toalety').
room('Společenská místnost').
room('Síťová laboratoř').

info('Výtah', 'Jsi u výtahu. Tlačítka jsou rozbitá, takže budeš muset pěšky.').
info('Respirium', 'Obvykle je respirium plné sténajících studentů, dnes je tu ale úplně prázdno. Je zde spousta židlí, takže se můžeš posadit a v klidu zamyslet, co dál. Doporuřuji nakouknout i pod stoly, často tam bývají roztroušené různé zapomenuté věci.').
info('Malá učebna', 'Jsi v malé učebně, která v tobě vyvolává mnoho nepříjemných vzpomínek. Najednou jsi rád, že tě ze školy vyhodili. Místnost je temná a když se ti konečně podaří nahmatat vypínač, zjistíš, že v ní nejsi sám. V rohu se krčí temná postava bušící něco do notebooku. Možná si budete mít co říct.').
info('Kabinet', 'Už na první pohled je ti jasné, že tady nemáš co dělat. Místnost je špatně osvícená, plná tabulí s výpočty a plakáty se vzorečky a v rohu se kupí hrnky od čaje. Evidentně tu sídlí matematici a jednoho dokonce vidíš stát v rohu. Pokud se cítíš odvážně, možná si s tebou bude i povídat.').
info('Velká učebna', 'Dostal jsi se do další z učeben. Zdá se, že tu kromě jedné poblikávající zářivky nefunguje žádné světlo. Místní věc vyřešili rozestavením několika svíček po obvodu místnosti a jejich plameny hází na stěny děsivé stíny. Necítíš se tu ani trochu příjemně a proto tě překvapuje, že tu někdo sedí.').
info('Toalety', 'Záchody jako každé jiné. Trochu divná je jenom ta sprcha - k čemu tady je? Dobře víš, že programátoři takové věci nepotřebují. Na umyvadle také stojí skleněná lahev s neznámou tekutinou.').
info('Společenská místnost', 'Světlo, žádná hudba a hlouček lidí sedících u stolu nad notebookem - zdá se, že jsi dorazil na programátorskou party. To taky znamená, že by si s tebou možná mohl někdo z nich i povídat.').
info('Síťová laboratoř', 'Jsi ve velké místnosti plné hučících počítačů, díky kterým je tu narozdíl od zbytku patra krásně teplo. Dochází ti, že toto je ta místnost, kde sídlí všechny důležité servery téhle školy. To by byla ale smůla, kdyby někdo přišel a nešťastnou náhodou vyhodil pojistky. Naštěstí je v místnosti někdo, kdo zřejmě ví, co dělá, když jde o počítače, jelikož se právě v jednom z velkých serverů hrabe.').
info('Testovací místnost', 'A kruci. Dostal jsi se do místnosti, kde se zrovna píše test. Učitel si tě zatím nevšiml, takže máš šanci na úprk. Také s nim ale můžeš zkusit mluvit, přeci jen vypadá, že by mohl vědět kudy kam.').
info('Kuchyňka', 'Jsi v malé místnůstce, která působí jako stroze vybavená kuchyňka. V rohu u kávovaru se krčí drobná postava a něco si pro sebe mručí.').
info('Schodiště', 'Snaha se vyplatila a konečně jsi se dostal přes zamčené dveře. Teď rychle pryč, než budeš muset zase něco počítat.').

door('Výtah', 'Respirium').
door('Výtah', 'Schodiště').
door('Respirium', 'Malá učebna').
door('Respirium', 'Velká učebna').
door('Respirium', 'Testovací místnost').
door('Testovací místnost', 'Síťová laboratoř').
door('Síťová laboratoř', 'Schodiště').
door('Velká učebna', 'Toalety').
door('Velká učebna', 'Kabinet').
door('Malá učebna', 'Kabinet').
door('Malá učebna', 'Kuchyňka').
door('Kabinet', 'Společenská místnost').

locked('Schodiště').
locked('Toalety').
locked('Síťová laboratoř').

connected(X, Y) :- door(X, Y).
connected(X, Y) :- door(Y, X).

% item(ITEM, ROOM)
item('Skripta', 'Respirium').
item('Sušenka', 'Respirium').
item('Kafe', 'Kuchyňka').
item('Flaška', 'Toalety').
item('Sušenka', 'Testovací místnost').
item('Počítač', 'Síťová laboratoř').

person('Malá učebna', 'student').
person('Kabinet', 'učitel').
person('Kuchyňka', 'student').
person('Testovací místnost', 'zkoušející').
person('Velká učebna', 'hladovec').
person('Společenská místnost', 'alkoholik').
person('Síťová laboratoř', 'síťař').

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

canEnter(Room) :- locked(Room), !, write('Tato místnost je uzamčená!'), fail.

canEnter(Room) :-
    location(Location),
    connected(Location, Room), !.

canEnter(Room) :-
    location(Room), !,
    write('V místnosti '),
    write(Room),
    write(' právě jsi!'), fail.

canEnter(Room) :-
    room(Room), !,
    write('Do této místnosti odsud nevede cesta!'), fail.

canEnter(_) :-
    write('Taková místnost tu není!'), fail.

vstup('Schodiště') :-
    not(locked('Schodiště')), !, 
    write('Gratuluji k dokončení hry!'), nl, halt.

vstup(Room) :-
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

getProblem :-
    random(1, 100, N1),
    random(1, 100, N2),
    random(1, 3, S),
    getResult(N1, N2, S).

odpovedet(Got) :-
    result(Wanted), equal(Wanted, Got),
    location(Room), equal(Room, 'Testovací místnost'), !,
    write('Gratuluji! Zkoušející z tebe má radost a nechá tě jít. Jelikož v tobě vidí nadějného technika, dokonce ti odemkl i síťovou laboratoř!'),
    retract(locked('Síťová laboratoř')), retract(status('counting')), asserta(status('alive')).

odpovedet(Got) :-
    result(Wanted),
    equal(Wanted, Got), !,
    write('Gratuluji. Zkoušku jsi ustál a jsi propuštěn.'),
    retract(status('counting')),
    asserta(status('alive')).

odpovedet(_) :-
    has('Skripta'), !,
    write('To bohužel není správně. Naštěstí jsi u sebe ale měl skripta a dokázal v nich rychle najít odpověď. Můžeš jít dál.'),
    retract(has('Skripta')),
    retract(status('counting')),
    asserta(status('alive')).

odpovedet(_) :-
    write('To bohužel není správně. Byl jsi odsouzen k doživotnímu vaření kafe místním matematikům.'), nl,
    retract(status('counting')), asserta(status('dead')), halt.

vzit(Item) :-
    location(Room),
    item(Item, Room), !,
    retract(item(Item, Room)),
    asserta(has(Item)).

vzit(_) :-
    write('Tento předmět tu není!').

nechat(Item) :-
    has(Item), !,
    location(Room),
    retract(has(Item)),
    asserta(item(Item, Room)).

nechat(_) :-
    write('Takový předmět u sebe nemáš!').

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
    getProblem, 
    write('.').

mluvitTyp('hladovec') :-
    not(has('Sušenka')), !,
    write('Narazil jsi na evidentně vystresovaného a hladového studenta. Jestli s ním chceš mluvit, budeš ho muset nakrmit.').

mluvitTyp('hladovec') :- 
    retract(has('Sušenka')),
    write('Potkal jsi jednoho z místních studentů. Počítá tu už tak dlouho, že hlady skoro nevidí.'), nl,
    write('Naštěstí máš u sebe sušenku, kterou mu ochotně nabízíš. Student je ti vděčný a jako odměnu ti odemkl toalety na tomto patře. Prý kdyby náhodou.'),
    retract(locked('Toalety')).

mluvitTyp('alkoholik') :-
    not(has('Flaška')), !,
    write('Slavící skupina se s tebou odmítla bavit, dokud jim nepřineseš něco k pití.'), nl.

mluvitTyp('alkoholik') :-
    retract(has('Flaška')),
    write('Skupinka má radost z flašky, kterou jsi jim přinesl, a už kolují panáky.'), nl,
    write('Když po chvíli dojde řeč na tvůj problém, nikdo ti neumí poradit.'), nl,
    write('Ať už v tvé flašce ale bylo cokoliv, všem to chutnalo. Na poděkovanou jsi dostal jakýsi kabel.'), nl,
    asserta(has('Kabel')).

mluvitTyp('zkoušející') :-
    retract(status('alive')),
    asserta(status('counting')),
    write('Ať se snažíš sebevíc, zkoušející si nechce nechat vysvětlit, že jsi nepřišel psát žádný test. Zdá se, že budeš muset něco spočítat. Snad se pak uklidní.'), nl,
    write('Rychle se chopíš fixy a jdeš na to. Zadání je '), getProblem, write('.').

mluvitTyp('síťař') :-
    not(has('Kabel')), !,
    write('Ukázalo se, že jsi narazil na místního síťaře. Do serveru se dostala myš a překousala některé kabely a server teď nefunguje.'), nl,
    write('Správcí bohužel došly další kabely, takže nemůž server uvést zpátky do provozu. Pokud mu nějaký kabel přineseš, prý se ti bohatě odmění.'), nl.

mluvitTyp('síťař') :-
    retract(has('Kabel')), 
    write('Ukázalo se, že jsi narazil na místního síťaře. Do serveru se dostala myš a překousala některé kabely a server teď nefunguje.'), nl,
    write('Tebe mu ale seslalo samo nebe - stále u sebe máš totiž kabel, který jsi dostal výměnou za flašku od slavící skupinky.'), nl,
    write('Kabel mu samozřejmě nabídneš a server je hned navrácen do provozu. Správce je ti nadmíru vděčný, díky tobě nepřijde o práci.'), nl,
    write('Jako poděkování ti nabídne, že ho můžeš požádat naprosto o cokoliv. Samozřejmě si řekneš o klíče ke schodišti a je ti to dopřáno. Gratuluji, můžeš odejít!'),
    retract(locked('Schodiště')).

mluvit :- location(Room), not(person(Room, _)), !, write('V této místnosti není s kým mluvit!').

mluvit :-
    location(Room), !,
    person(Room, Typ),
    mluvitTyp(Typ).