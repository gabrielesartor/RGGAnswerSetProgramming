% Cinque case.
% Cinque persone di nazionalità diverse vivono in cinque case allineate lungo
% una strada, esercitano cinque professioni distinte, e ciascuna persona ha un
% animale favorito e una bevanda favorita, tutti diversi fra loro. Le cinque case
% sono dipinte con colori diversi. Sono noti i seguenti fatti:

numeroCase(1..5).
nazionalita(italiano;giapponese;inglese;norvegese;spagnolo).
colori(rosso;giallo;blu;bianco;verde).
professione(pittore;scultore;diplomatico;violinista;dottore).
bevanda(te;caffe;latte;succo).
animali(cane;lumache;volpe;cavallo;zebra).

1{ casa(X,Col,Naz,Prof,Bev,Anim) : nazionalita(Naz), colori(Col), professione(Prof), bevanda(Bev), animali(Anim) }1 :- numeroCase(X).

%------ VINCOLI ------%

%Vincolo: tutte le case hanno colore diverso
:- casa(X,Col,_,_,_,_),casa(XX,Col,_,_,_,_),X!=XX.

%Vincolo: ogni casa ha una persona di nazionalita diversa
:- casa(X,_,Naz,_,_,_),casa(XX,_,Naz,_,_,_),X!=XX.

%Vincolo: tutti hanno una professione diversa
:- casa(X,_,_,Prof,_,_),casa(XX,_,_,Prof,_,_),X!=XX.

%Vincolo: tutti hanno un animale preferito diverso
:- casa(X,_,_,_,_,Anim),casa(XX,_,_,_,_,Anim),X!=XX.

%Vincolo1: l'inglese vive nella casa rossa
:- casa(_,rosso,Naz,_,_,_), Naz!=inglese.

%Vincolo2: lo spagnolo ha un cane
:- casa(_,_,spagnolo,_,_,Anim), Anim!=cane.

%Vincolo3: Il giapponese è un pittore.
:- casa(_,_,giapponese,Prof,_,_), Prof!=pittore.

%Vincolo4: L’italiano beve tè.
:- casa(_,_,italiano,_,Bev,_), Bev!=te.

%Vincolo5: Il norvegese vive nella prima casa a sinistra.
:- casa(1,_,Naz,_,_,_), Naz!=norvegese.

%Vincolo6: Il proprietario della casa verde beve caffè.
:- casa(_,verde,_,_,Bev,_), Bev!=caffe.

%Vincolo7: La casa verde è immediatamente sulla destra di quella bianca.
:- casa(X,verde,_,_,_,_), casa(Y,bianco,_,_,_,_), X!= Y+1.

%Vincolo8: Lo scultore alleva lumache.
:- casa(_,_,_,scultore,_,Anim), Anim!=lumache.

%Vincolo9: Il diplomatico vive nella casa gialla.
:- casa(_,Col,_,diplomatico,_,_), Col!=giallo.

%Vincolo10: Nella casa di mezzo si beve latte.
:- casa(3,_,_,_,Bev,_), Bev!=latte.

%Vincolo11: La casa del norvegese è adiacente a quella blu
:- casa(X,_,norvegese,_,_,_), casa(Y,blu,_,_,_,_), |X-Y|>1.
:- casa(X,_,norvegese,_,_,_), casa(Y,blu,_,_,_,_), X==Y.

%Vincolo12: Il violinista beve succo di frutta.
:- casa(_,_,_,violinista,Bev,_), Bev!=succo.

%Vincolo13: La volpe è nella casa adiacente a quella del dottore.
:- casa(X,_,_,_,_,volpe), casa(Y,_,_,dottore,_,_), |X-Y|>1.
:- casa(X,_,_,_,_,volpe), casa(Y,_,_,dottore,_,_), X==Y.

%Vincolo14: Il cavallo è nella casa adiacente a quella del diplomatico.
:- casa(X,_,_,_,_,cavallo), casa(Y,_,_,diplomatico,_,_), |X-Y|>1.
:- casa(X,_,_,_,_,cavallo), casa(Y,_,_,diplomatico,_,_), X==Y.

chiHaZebra(Naz) :- casa(_,_,Naz,_,_,zebra).

%#show casa/6.
#show chiHaZebra/1.
