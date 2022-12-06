/****************************************************/
/* Declaraciones e includes */
%{
#include <iostream>
#include <fstream>
#include <vector>
#include <string>

using namespace std;

struct Contador {
    string desc;
    int valor = 0;
};

ifstream fichero;
vector<Contador> counters(100);
void escribir_datos(vector<Contador> &contadores);
%}
/****************************************************/
/* Opciones */
%option c++
%option noyywrap

/* Alias de expresiones regulares*/
PALABRA ([A-Za-z])+
DIGITO [0-9]
ENTERO {DIGITO}+
LINEA \n

/* Declaración de reglas */
%%

{PALABRA}		        {cout << YYText() << " es PALABRA" << endl; counters[0].valor++;}

{ENTERO}                {cout << YYText() << " es ENTERO" << endl; counters[1].valor++;}

{LINEA}                 {counters[99].valor++;} /* Evita que imprima saltos de linea por cada salto de linea del fichero */

. {}                                     /* Regla por defecto */

%%
/****************************************************/
// Implementación de funciones
int yywrap() {
    return 0;
}
int main (int argc, char *argv[])
{
    if (argc == 2)
    {
        fichero.open(argv[1]);
        if (!fichero.is_open())
        {
            cout << "error de lectura" << endl;
            exit (1);
        }
    }
    else exit(1);

    counters[0].desc = "Palabras";
    counters[1].desc = "Enteros";
    counters[99].desc = "Lineas"; counters[99].valor = 1;

    yyFlexLexer flujo(&fichero,0);
    flujo.yylex();
    escribir_datos(counters);
    return 0;
}

void escribir_datos(vector<Contador> &counters)
{
    for (Contador c : counters) {
        if (!c.desc.empty())
            cout << c.desc << " = " << c.valor << endl;
    }
}

// Ejecución:
// flex ejemplo.l
// g++ lex.yy.c -L/c/msys64/mingw64/lib/libfl.a
// a.exe