# ETSIINF_Prolog

## Primera practica - Programación en Lógica Pura

## Objetivo
Poner en práctica conceptos vistos en el bloque de Lógica Pura

## Before to read
En este readme voy a resumir lo importante de los documentos:
- Instrucciones_generales.pdf
- Instrucciones_especificas.pdf

## Normas
Solo está permitido usar:
- Cláusulas (reglas y hechos)
- Términos (constantes, variables y estructuras)
- La unificación (términos en los argumentos o llamadas a =/2)
- La declaración inicial de módulo
- Hecho author_data/4

No está permitido usar:
- Los predicados predefinidos de ISO Prolog
- Librerías del sistema. Si fuese necesario usar alguno de estos predicados debe ser programado. (p.ej: si fuese necesaro definir la pertenencia a una lista mediante el predicado member/3, se debe programar una version propia del member/3 que deberá llevar un nombre diferente (my_member/3))

## Especificaciones
La práctica se basa en la implementación de los predicados definidos en el enunciado (resources/Instrucciones_especificas.pdf)
- El código debe poder ejecutarse y funcionar correctamente en Ciao Prolog
- El código deberá mandarse por Deliverit

### Documentacion
El código se encontrará documentado en src/code.pdf
Este manual/memoria se autogenera gracias al procesado del código fuente (code.pl) con el auto-documentador (lpdoc) mediante las aseciones y/o comentarios hallados en él.
* Pending: HACER DOCUMENTACIÓN BIEN

### Pruebas
Las pruebas se encuentran como un conjunto de aseciones :- test
Se incluyen en el mismo fichero code.pl
Los test aplicados por Deliverit son independientes de los que hay en el codigo (estos son para nuestro uso y documentación)

## Cómo usar
Esta práctica se desarrolla bajo el lenguaje Ciao Prolog, por lo que es necesario tener Ciao Prolog instalado localmente.
Para más información sobre su descarga y uso básico, se puede encontrar en Resources/Instalacion_Prolog.pdf y Resources/UsoBasico_Prolog.pdf

* Pending: How to to the documentation properly and how to execute it (lpdoc -t pdf code.pl)