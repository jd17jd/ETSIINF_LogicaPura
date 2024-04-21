:- module(_,_,[pure,assertions,regtypes]).

%author_data/4
author_data('Sanz', 'Guevara', 'Juan Diego', 'C200279').
:- doc(title, "Pr@'{a}ctica: Programci@'{o}n L@'{o}gica Pura.").
:- doc(author, "Juan Diego Sanz, C200279").

% PRACTICA 1

% ---------------------------------------------------------------------------

% Predicados utiles para trabajar con numeros de Peano

% nat/1
    % Params: num_peano
    % Description: True si N es un número de Peano
nat(0).
nat(s(N)) :- nat(N).

% suma/3
    %Params: num_peano1, num_peano2, num_peano3
    % Description: True si suma A y B da C
suma(0, A, A) :- nat(A).
suma(s(A), B, s(C)) :- suma(A, B, C).

% resta/3
    % Params: num_peano1, num_peano2, num_peano3
    % Description: True si resta A y B da C
resta(A, 0, A) :- nat(A).
resta(A, s(B), C) :- resta(A, B, s(C)).

% greater_peano/3
    % Params: num_peano1, num_peano2, num_peano3
    % Description: Comparacion entre dos numeros de peano para ver cual es mayor. Si A > B, Z = 0
greater_peano(_, 0, 0).
greater_peano(0, _, s(0)).
greater_peano(s(X), s(Y), Z) :-
    greater_peano(X, Y, Z).

% Division/3
    % Params: num_peano1, num_peano2, num_peano3
    % Description: Divide A entre B y lo pone en C. El resultado es por truncamiento
division(A, B, C) :-
    greater_peano(A, B, Z),
    division_aux(A, B, C, Z).

% Division_aux/4
    % Params: num_peano1, num_peano2, num_peano3, num_peano4
    % Description: Predicado auxiliar para division
division_aux(_, _, 0, s(0)).
division_aux(0, s(_), 0, _).
division_aux(A, B, s(C), _) :-
    resta(A, B, D),
    cmp(D, B, E),
    division_aux(E, B, C, _).

% cmp/3
    % Params: num_peano1, num_peano2, num_peano3
    % Description: Compara A y B y devuelve el mayor
cmp(A, B, C) :- greater_peano(A, B, Z), cmp_aux(A, Z, C).

% cmp_aux/3
    % Params: num_peano1, num_peano2, num_peano3
    % Description: Predicado auxiliar para cmp
cmp_aux(_, s(0), 0).
cmp_aux(A, 0, A).

% succ/2
    % Params: num_peano1, num_peano2
    % Description: Calcula el sucesor de un número de Peano
succ(0, s(0)).
succ(s(N), s(S)) :- succ(N, S).

% Cargas

% Carga/1
    % Params: carga
    % Description: True si C es una carga
charge( 0 ).
charge( + ).
charge( ++ ).
charge( +++ ).
charge( ++++ ).
charge( +++++ ).
charge( ++++++ ).
charge( +++++++ ).


% ---------------------------------------------------------------------------

% basic_surface/1
    % Params: lista
    % Description: True si es una superficie que tiene AL MENOS una linea y una celula por linea
basic_surface([Cabeza]) :- check_linea(Cabeza).
basic_surface([Cabeza|Resto]) :- check_linea(Cabeza), basic_surface(Resto).

% check_linea/1
    % Params: lista
    % Description: Pred. aux. --> True si cada celula de la linea es valida
check_linea([Cabeza]) :- charge(Cabeza).
check_linea([Cabeza|Resto]) :- charge(Cabeza), check_linea(Resto).




% surface/1
    % Params: lista
    % Description: True si una superfice es como la anterior pero ademas todas las lineas tienen el mismo numero de celulas
surface([PrimeraFila]) :- basic_surface([PrimeraFila]).
surface([PrimeraFila, RestoFilas]) :-
    mismo_numero_celulas(PrimeraFila, RestoFilas),
    surface([RestoFilas]).
surface([PrimeraFila|[SegundaFila|RestoFilas]]) :-
    mismo_numero_celulas(PrimeraFila, SegundaFila),
    surface([SegundaFila|RestoFilas]).

% mismo_numero_celulas/2
    % Params: Fila1 (lista), Fila2 (lista)
    % Description: Pred. aux. --> True si dos filas tienen el mismo número de células
mismo_numero_celulas([], []).
mismo_numero_celulas([Celula1|Resto1], [Celula2|Resto2]) :- charge(Celula1), charge(Celula2), mismo_numero_celulas(Resto1, Resto2).




% h_line/3 
    % Params: Superficie (lista), NumeroFila (num_peano), Fila (lista)
    % Description: True si Fila es la línea horizontal N-ésima de la superficie S
h_line(Superficie, NumeroFila, Fila) :-
    surface(Superficie), % Verifica si Superficie es válida
    obtener_fila(Superficie, NumeroFila, Fila).

% obtener_fila/3
    % Params: Superficie (lista), NumeroFila (num_peano), Fila (lista)
    % Description: Pred. aux. -->  True si PrimeraFila es la linea horizontal N-ésima de la superficie S
obtener_fila([PrimeraFila|_], s(0), PrimeraFila).
obtener_fila([_|RestoFilas], s(NumeroFila), Fila) :-
    obtener_fila(RestoFilas, NumeroFila, Fila).




% v_line/3
    % Params: Superficie (lista), NumeroColumna (num_peano), Columna (lista)
    % Description: True si Columna es la línea vertical n-ésima de la superficie S
v_line(Superficie, NumeroColumna, Columna) :-
    surface(Superficie), % Verifica si Superficie es válida
    v_line_auxiliar(Superficie, NumeroColumna, Columna).

% v_line_auxiliar/3
    % Params: Superficie (lista), NumeroColumna (num_peano), Columna (lista)
    % Description: Pred. aux --> True si Columna es la línea vertical n-ésima de la superficie S
v_line_auxiliar([PrimeraFila], NumeroColumna, Columna) :-
    get_celula(PrimeraFila, NumeroColumna, Celula),
    my_append(Celula, [], Columna).
v_line_auxiliar([PrimeraFila|RestoFilas], NumeroColumna, Columna) :-
    v_line(RestoFilas, NumeroColumna, RestoColumna),
    get_celula(PrimeraFila, NumeroColumna, Celula),
    my_append(Celula, RestoColumna, Columna).

% get_celula/3
    % Params: Fila (lista), NumeroColumna (num_peano), Celula (lista)
    % Description: Pred. aux --> True si Celula es la celula N-ésima de la superficie Cabeza
get_celula([Cabeza|_], s(0), [Cabeza]).
get_celula([_|Resto], s(NumeroColumna), Celula) :-
    get_celula(Resto, NumeroColumna, Celula).

% my_append/3
    % Params: (lista, lista, lista)
    % Description: True si todos los argumentos son listas. Concatena las dos primeras listas y el resultado en L3
my_append([], L, L).
my_append([H|T], L2, [H|L3]) :- my_append(T, L2, L3).




% v_lines/2
    % Params: Superficie (lista), LineasVerticales (lista)
    % Description: True si LineasVerticales es la lista de las líneas verticales de células de la superficie S
v_lines(Superficie, LineasVerticales) :-
    surface(Superficie), % Verifica si Superficie es válida
    obtener_lineas_verticales(Superficie, LineasVerticales).

% obtener_lineas_verticales/2
    % Params: Superficie (lista), LineasVerticales (lista)
    % Description: Predicado auxiliar que obtiene la lista de las líneas verticales de células de la superficie S
obtener_lineas_verticales(S, L) :-
    transpose(S, Transpuesta), % Transpone la superficie para obtener las líneas verticales
    obtener_lineas_no_vacias(Transpuesta, L).

% obtener_lineas_no_vacias/2
    % Params: Lineas (lista), LineasNoVacias (lista)
    % Description: Predicado auxiliar que obtiene las líneas verticales que no están vacías
obtener_lineas_no_vacias([], []).
obtener_lineas_no_vacias([Linea|Resto], [Linea|LineasNoVacias]) :-
    num_cel(Linea, _), % Verifica si la línea tiene células (para evitar líneas vacías)
    obtener_lineas_no_vacias(Resto, LineasNoVacias).
obtener_lineas_no_vacias([_|Resto], LineasNoVacias) :-
    obtener_lineas_no_vacias(Resto, LineasNoVacias).

% num_cel/2
    % Params: Linea (lista), NumeroCelulas (num_peano)
    % Description: Pred. aux --> Verifica si NumeroCelulas es el número de células de la línea
num_cel([], 0).
num_cel([_|X], N) :-
    num_cel(X, Z), % Llama recursivamente para el resto de la lista
    succ(Z, N). % Incrementa N en 1

% transpose/2
    % Params: Matriz (lista), Transpuesta (lista)
    % Description: Pred. aux. --> Transponer una matriz
transpose([], []).
transpose([A|X], T) :-
    transpose_aux(X, A, T).

transpose_aux([], _, []).
transpose_aux([[A|Y]|X], [A|Z], [Z|N]) :-
    transpose_aux(X, Y, N).




% total_charge/2
    % Params: Superficie (lista), CargaTotal (num_peano)
    % Description: True si CargaTotal es la suma de todas las cargas de la superficie S
total_charge([], 0).
total_charge(Superficie, CargaTotal) :-
    surface(Superficie), % Verifica si Superficie es válida
    total_charge_aux(Superficie, CargaTotal).

% total_charge_aux/2
    % Params: Superficie (lista), CargaTotal (num_peano)
    % Description: Pred. aux. --> Calcula la suma de todas las cargas de la superficie S
total_charge_aux([], 0).
total_charge_aux([Fila|Resto], CargaTotal) :-
    total_charge_aux(Resto, CargaResto),
    sumar_carga(Fila, CargaResto, CargaTotal).

% sumar_carga/3
    % Params: Fila (lista), CargaResto (num_peano), CargaTotal (num_peano)
    % Description: Pred. aux. --> Suma la carga de una fila a la carga total
sumar_carga([], CargaResto, CargaResto).
sumar_carga([Cabeza|Resto], CargaResto, CargaTotal) :-
    sumar_carga(Resto, CargaResto, CargaRestoAux),
    sumar_carga_aux(Cabeza, CargaRestoAux, CargaTotal).

% sumar_carga_aux/3
    % Params: Carga (carga), CargaResto (num_peano), CargaTotal (num_peano)
    % Description: Pred. aux. --> Suma la carga de una célula a la carga total
sumar_carga_aux(0, CargaResto, CargaResto).
sumar_carga_aux(+, CargaResto, CargaTotal) :- suma(CargaResto, s(0), CargaTotal).
sumar_carga_aux(++, CargaResto, CargaTotal) :- suma(CargaResto, s(s(0)), CargaTotal).
sumar_carga_aux(+++, CargaResto, CargaTotal) :- suma(CargaResto, s(s(s(0))), CargaTotal).
sumar_carga_aux(++++, CargaResto, CargaTotal) :- suma(CargaResto, s(s(s(s(0)))), CargaTotal).
sumar_carga_aux(+++++, CargaResto, CargaTotal) :- suma(CargaResto, s(s(s(s(s(0))))), CargaTotal).
sumar_carga_aux(++++++, CargaResto, CargaTotal) :- suma(CargaResto, s(s(s(s(s(s(0)))))), CargaTotal).
sumar_carga_aux(+++++++, CargaResto, CargaTotal) :- suma(CargaResto, s(s(s(s(s(s(s(0))))))), CargaTotal).




% average/2
    % Params: Superficie (lista), CargaPromedio (num_peano)
    % Description: True si CargaPromedio es el promedio de todas las cargas de la superficie S
average_charge(Superficie, CargaPromedio) :-
    surface(Superficie), % Verifica si Superficie es válida
    total_charge(Superficie, CargaTotal),
    num_celulas(Superficie, NumeroCelulas),
    division(CargaTotal, NumeroCelulas, CargaPromedio).

% num_celulas/2
    % Params: Superficie (lista), NumeroCelulas (num_peano)
    % Description: Pred. aux --> Calcula el número de células de la superficie
num_celulas([], 0).
num_celulas([Fila|Resto], NumeroCelulas) :-
    num_cel(Fila, NumeroCelulasFila),
    num_celulas(Resto, NumeroCelulasResto),
    suma(NumeroCelulasFila, NumeroCelulasResto, NumeroCelulas).
