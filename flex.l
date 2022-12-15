/****************************************************/
/* Declaraciones e includes */
%{
#include <iostream>
#include <fstream>
#include "contador.h"

using namespace std;

ifstream fichero;
void escribir_datos(vector<Contador> &contadores);
%}
/****************************************************/
/* Opciones */
%option c++
%option noyywrap

/* Alias de expresiones regulares*/
LINEA           \n
MIN             [a-z]
MAY             [A-Z]
DIGITO          [0-9]
ALFNUM          ({MIN}|{MAY}|{DIGITO})+
ORG_GMAIL       "gmail.com"
ORG_OUTLOOK     (("outlook".("com"|"es"))|("hotmail.com"))
ORG_YAHOO       "yahoo.com"
ORG_PROTON      "proton"(".me"|"mail.com")
ORG_UNKNOWN     {MIN}({MIN}|.{1})*
DOMINIO         "es"|"com"|"me"|"net"
ORGANIZACION    ({MIN})+.{DOMINIO}
CORREO          ^{ALFNUM}@{ORG_UNKNOWN}

/* Declaración de reglas */
%%

{CORREO} {
    cout << YYText() << endl;
    contadores[0].valor++;
}

{LINEA}

.                                    /* Regla por defecto */

%%
/****************************************************/
// Implementación de funciones
int yywrap() {
    return 0;
}

int main (int argc, char *argv[])
{
    if (argc >= 2)
    {
        fichero.open(argv[1]);
        if (!fichero.is_open())
        {
            cout << "error de lectura" << endl;
            exit(1);
        }
    }
    else {
        cerr << "no se paso un fichero" << endl;
        exit(1); 
    }

    iniciar_contadores();

    yyFlexLexer flujo(&fichero,0);
    flujo.yylex();
    escribir_datos(contadores);
    return 0;
}

void escribir_datos(vector<Contador> &counters)
{
    cout << "Lectura finalizada ---\n";
    for (Contador c : counters) {
        if (!c.desc.empty())
            cout << c.desc << ": " << c.valor << endl;
    }
}

// Ejecución:
// flex ejemplo.l
// g++ lex.yy.c -L/c/msys64/MINgw64/lib/libfl.a
// a.exe