% ------- la kb -------

tifoso(oreste;bruno).
tipo(bugiardo;onesto).
eta(anziano;giovane).
squadra(inter;torino).

% ----- aggregati -----

1{ha_eta(X,E):eta(E)}1:- tifoso(X).

1{ha_tipo(X,T):tipo(T)}1:-tifoso(X).

1{tifa(X,S):squadra(S)}1:-tifoso(X).

% ----- regole --------

ha_tipo(X,onesto):-tifa(X,inter),ha_eta(X,anziano).
ha_tipo(X,bugiardo):-tifa(X,inter),ha_eta(X,giovane).
ha_tipo(X,onesto):-tifa(X,torino),ha_eta(X,giovane).
ha_tipo(X,bugiardo):-tifa(X,torino),ha_eta(X,anziano).

o_dice:-tifa(bruno,torino),ha_eta(bruno,anziano).
b_dice:-tifa(oreste,inter),ha_eta(oreste,giovane).

% ----- vincoli -------


:-o_dice, ha_tipo(oreste,bugiardo). %se oreste è bugiardo non dice il vero
:-b_dice, ha_tipo(bruno,bugiardo). %se bruno è bugiardo non dice il vero
:-not o_dice, ha_tipo(oreste,onesto). %se oreste è onesto dice il vero
:-not b_dice, ha_tipo(bruno,onesto). %se bruno è onesto dice il vero

#show tifa/2.
#show ha_eta/2.
