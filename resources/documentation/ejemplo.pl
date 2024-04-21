:- module(_, _, [assertions,nativeprops]).

:- doc(title, "An example of documentation and tests").

:- doc(author, "Isabel GarcÃ­a, C347963").
:- doc(author, "Manuel Hermenegildo, D165125").

:- doc(module, "

@begin{note}
@bf{Note:} This file is a simple tutorial to explain the use of
@apl{LPdoc} to document programs.  If you are reading this as an
already formatted document (i.e., as an @tt{html} or @tt{pdf} file)
you need to look first at the source file (the @tt{calculator.pl}
file) that this is generated from in order to learn about the commands
that generate the output.
For more details please consult the
@href{http://ciao-lang.org/ciao/build/doc/lpdoc.html/index.html}{LPdoc manual}.

In this case this source file is in @apl{LPdoc}`'s @bf{markup} format
(there is a companion file @tt{calculator_md.pl} written in @em{markdown} for 
comparison).
@end{note}

@section{Introduction}

@begin{note}
A module's documentation should start with an introduction describing
what it does.  This is the introduction for this sample calculator
module.
@end{note}

This module defines a calculator for Peano numbers.  The numbers
accepted by this calculator have to be of the form: @includedef{nat/1}

@subsection{Some examples of use:}

@begin{enumerate}
@item Adding two numbers:
@begin{verbatim}
  ?- calculate(+, 0, s(0), X).

  X = s(0) ? 
  yes
  ?- 
@end{verbatim}
@item Subtracting two numbers:
@begin{verbatim}
  ?- calculate(-, s(s(0)), s(0), X).

  X = s(0) ? 
  yes
  ?- 
@end{verbatim}
@end{enumerate}

The available operations are:
@includedef{operation/1}

@begin{note}
The following sections are about how to write documentation files and
how to generate the documentation from them, as well as how to write tests.
@end{note}

@section{Generating the documentation}

This documentation has been generated automatically by the
@href{http://ciao-lang.org/ciao/build/doc/lpdoc.html/}{@bf{LPdoc}}
tool. 

To generate and view the documentation for a @tt{.pl} file:

@begin{itemize}

@item In Emacs, open the file and select in the menus @tt{LPdoc ->
  Generate documentation for buffer} (or type @key{C-c} @key{D}
  @key{B}) to run the documenter. For visualizing the output, select:
  @tt{LPdoc -> View documentation in selected format} (or type
  @key{C-c} @key{D} @key{V}).

@item In VSC, open the file and select the @tt{bookworm} icon on the
  top left window (@tt{Generate and view documentation}).

@item In the @href{https://ciao-lang.org/playgorund}{playground},
  upload or paste the file into the editor window and select
  @tt{More... -> Preview Documentation} (or type @key{C-c} @key{D}).

@item Finally, at the command line you can type: 

  @tt{lpdoc -t html calculator.pl} 

  or 

  @tt{lpdoc -t pdf calculator.pl} 

  and 

  @tt{lpdoc --view calculator.pl} 

@end{itemize}

You can select different formats such as @tt{html} or @tt{pdf} at
generation time. @tt{html} is the default and should be fine for most
purposes. For generating @tt{pdf} directly from @tt{lpdoc} you
need to have a TeX/LaTeX distribution such as TeX Live, etc. installed
(depending on the distribution you may need to install @tt{texlive},
@tt{texinfo}, and @tt{imagemagick}). An alternative way to generate a
@tt{pdf} file that does not require TeX/LaTeX is to generate the
@tt{html}, open it in a browser, and then save it from the browser to
@tt{pdf}, e.g., by 'printing' the page to a @tt{pdf} file.

@section{Writing the documentation}

@begin{alert}
In this module a few basic formatting commands are used, but there are
many more.  See the
@href{http://ciao-lang.org/ciao/build/doc/lpdoc.html/comments.html#stringcommand/1}{corresponding
section} in the @apl{LPdoc} manual.
@end{alert}

@subsection{Documenting predicates}

To document each predicate, specific assertions, such as @tt{pred},
@tt{regtype} and @tt{prop}, are used. For example, the following 
@tt{pred} assertion:
@begin{verbatim}
  :- pred calculate(Op,A,B,C) 
     # ""@var{C} is the result from applying operation 
        @var{Op} to @var{A} and @var{B}."".
@end{verbatim}
@noindent
can be used to document the @tt{calculate/4} predicate.  @tt{pred}
assertions are the most common and are used to specify and document
almost all predicates.

With assertions you can also specify and check types and many other
properties.  @tt{prop} is used instead of @tt{pred} when a predicate
is to be used as a property in an assertion.  For example, to document
@tt{len/2}, we would like to use @tt{nat} and @tt{list}, so we mark
them as properties with @tt{prop} assertions:

@begin{verbatim}
  :- module(_,_,[assertions]).

  :- prop nat(N) # \"@var{N} is a natural number.\".
  nat(0).
  nat(s(X)) :- nat(X).

  :- prop lst(L) # \"@var{L} is a list.\".
  lst([]).
  lst([_|T]) :- lst(T).
@end{verbatim}

Since they are marked as properties, @tt{nat} and @tt{list} can be
used in a @tt{pred} assertion for @tt{len/2}:

@begin{verbatim}
  :- pred len(L,N) :: (list(L), nat(N))
     # \"@var{N} is the length of @var{L}\".
  len([],0).
  len([_|T],s(N)) :- len(T,N).
@end{verbatim}

@comment{@tt{regtype} assertions can be used to mark properties that are also
'regular types' (not required for generating your documentation).}

For more information consult the 
@href{http://ciao-lang.org/ciao/build/doc/lpdoc.html/assertions_doc.html}{documentation on assertions}.


@subsection{Accents}

A question often asked is how to do accents: in most places, such as
text within strings, you can simply use utf8 accents:

@begin{verbatim}
  :- doc(title, \"ProgramaciÃ³n LÃ³gica\"). 
@end{verbatim}

Alternatively, you can use @tt{@@'@{...@}} and @tt{@@~@{...@}} for
e@~{n}e. E.g.:

@begin{verbatim}
  :- doc(title, \"Programaci@'{o}n L@'{o}gica\"). 
@end{verbatim}

In @tt{alumno_prode/4} facts you can use accents, but please remember
to always put the arguments in single quotes, @tt{'...'}, to make sure
they are constants:

@begin{verbatim}
  alumno_prode('Ãlvaro', 'FernÃ¡ndez', 'GÃ³mez', 'Y16M025').
@end{verbatim}


@section{Writing tests}

This module also includes some assertions that start with @tt{:- test}. For example: 
@begin{verbatim}
  :- test calculate(Op,A,B,C) 
     :  (Op = '+', A = 0, B = 0) 
     => (C = 0) + not_fails # ""Base case."".
@end{verbatim}

These assertions define test cases. Given an assertion:

  @tt{:- test} @em{Head} @tt{:} @em{Call} @tt{=>} @em{Exit} @tt{+} @em{Comp}@tt{.}

@var{Head} denotes the predicate to which the assertion applies,
@var{Call} describes the values to call the predicate with for the
test, @var{Exit} defines the expected values upon exit @bf{if the
predicate succeeds} and @var{Comp} will be used to define global
properties, for example if the predicate should fail or succeed for
that call:

@begin{itemize}

@item @tt{not_fails}: means that the call to the predicate with the
values in @var{Call} will generate at least one solution.

@item @tt{fails}: means that the call to the predicate with the values
in @var{Call} will fail.

@end{itemize}

@subsection{Running the tests}

To run the tests: 

@begin{itemize}

@item In Emacs open the @tt{.pl} file and select in the menus 
  @tt{CiaoDbg -> Run tests in current module} (or type @key{C-c}
  @key{u}).

@item In In VSC, in the search box above, start typing @tt{> Ciao} and
  select @tt{> CiaoDbg: Run tests in current module}.

@item In the @href{https://ciao-lang.org/playground}{playground},
  upload or paste the file into the editor window and select
  @tt{More... -> Run tests} (or type @key{C-c} @key{u}).

@item Alternatively, at the Ciao top level, you can type: 

@tt{?- run_tests_in_module(calculator).}
@end{itemize}

Note that when these tests are run, the system by default tries to also
find a second solution for each test (i.e., like typing @key{;} in the
top level).

@subsection{Including tests in the documentation}

You can have @apl{lpdoc} include the tests in the documentation. For
this, include option @tt{--doc_mainopts=tests} in the @apl{lpdoc}
command. E.g., at the command line:

@tt{lpdoc -t html --doc_mainopts=tests calculator.pl} 

Or, if you are generating the manual from Emacs, switch to
the @tt{*LPdoc*} buffer (you can use the @tt{Buffers} menu) and 
issue the command:  

@tt{lpdoc ?- doc_cmd('SETTINGS.pl',[name_value(doc_mainopts,tests)],gen(html)).}

").

:- doc(operation/1,"Defines the operations that the calculator
   accepts. It is defined as: @includedef{operation/1}").

:- prop operation(Op) # "@var{Op} is an operation accepted by the calculator.".
operation(+).
operation(-).

:- pred calculate(Op,A,B,C) :: (operation(Op), nat(A), nat(B), nat(C))
   # "@var{C} is the result of applying operation @var{Op} to @var{A} and @var{B}.
      It is defined by: @includedef{calculate/4}".

calculate(+,A,B,C) :-
    sum(A,B,C).
calculate(-,A,B,C) :-
    sum(B,C,A).

:- test calculate(Op,A,B,C) : (Op = +, A = 0, B = 0) => (C = 0) + not_fails # "Base case".
:- test calculate(Op,A,B,C) : (Op = +, A = s(s(0)), B = s(0)) => (C = s(s(s(0)))) + not_fails.
:- test calculate(Op,A,B,C) : (Op = -, A = 0, B = s(0)) + fails # "The result can only be a negative number.".

:- pred sum(A,B,C) :: (nat(A), nat(B), nat(C))
   # "@var{C} is @var{A} plus @var{B}.
      It is defined by: @includedef{calculate/4}".

sum(0,X,X) :- nat(X).
sum(s(X),Y,s(Z)) :-
    sum(X,Y,Z).

:- doc(nat/1, "Defines the natural numbers. It is defined as:  @includedef{nat/1}").

:- prop nat(N) # "@var{N} is a natural number.".
nat(0).
nat(s(X)) :-
    nat(X).