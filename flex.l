/****************************************************/
/* Declaraciones e includes */
%{
#include <iostream>
#include <fstream>
#include "contador.h"

using namespace std;

ifstream fichero;
string direccion, parteLocal;
void escribir_datos(vector<Contador> &contadores);
%}
/****************************************************/
/* Opciones */
%option c++
%option noyywrap

/* Alias de expresiones regulares */
LINEA               \n
MIN                 [a-z]
MAY                 [A-Z]
DIGITO              [0-9]
NUMERO              ({DIGITO})+
PALABRA_MIN         ({MIN})+
PALABRA_MAY         ({MAY})+
LETRA               ({MAY}|{MIN})
PALABRA             {LETRA}+
ALFNUM              ({MIN}|{MAY}|{DIGITO})
ALFNUM_PALABRA      {ALFNUM}+
DOMINIO             ({MIN}){2,}
PALABRA_PL_OUTLOOK  ({ALFNUM}|"-"|"_")+

/* --- Partes locales */

PL_GMAIL        {LETRA}((".")?{ALFNUM_PALABRA})*
PL_OUTLOOK      {LETRA}((".")?{PALABRA_PL_OUTLOOK})*
PL_YAHOO        {LETRA}(("."|"_")?{ALFNUM_PALABRA})*
PL_PROTON       {ALFNUM}(("."|"_"|"-")?{ALFNUM_PALABRA})*
PL_UNKNOWN      {PL_PROTON}
PL_UGR          ({ALFNUM}){6,8}

/* --- Organizaciones */
ORG_GMAIL       "gmail.com"
ORG_OUTLOOK     (("outlook."("com"|"es"))|"hotmail.com")
ORG_YAHOO       "yahoo.com"
ORG_PROTON      "proton"(".me"|"mail.com")
ORG_UNKNOWN     {PALABRA_MIN}("."{PALABRA_MIN})*"."{DOMINIO}
ORG_DOC_UGR     "ugr.es"
ORG_EST_UGR     "correo."{ORG_DOC_UGR}
ORG_GO_UGR      "go."{ORG_DOC_UGR}
ORG_MS_UGR      "ms."{ORG_DOC_UGR}

EMAIL_GMAIL         ^{PL_GMAIL}@{ORG_GMAIL}
EMAIL_OUTLOOK       ^{PL_OUTLOOK}@{ORG_OUTLOOK}
EMAIL_YAHOO         ^{PL_YAHOO}@{ORG_YAHOO}
EMAIL_PROTON        ^{PL_PROTON}@{ORG_PROTON}
EMAIL_UNKNOWN       ^{PL_UNKNOWN}@{ORG_UNKNOWN}
EMAIL_DOC_UGR       ^{PL_UGR}@{ORG_DOC_UGR}
EMAIL_EST_UGR       ^{PL_UGR}@{ORG_EST_UGR}
EMAIL_DOC_GO_UGR    ^{PL_UGR}@{ORG_GO_UGR}
EMAIL_EST_GO_UGR    ^"e."{PL_UGR}@{ORG_GO_UGR}
EMAIL_DOC_MS_UGR    ^{PL_UGR}@{ORG_MS_UGR}
EMAIL_EST_MS_UGR     ^"e."{PL_UGR}@{ORG_MS_UGR}

/* Declaración de reglas */
/* LAS RESTRICCIONES DE LONGITUD SE ANALIZARAN EN LA SECCION DE ACCIONES (ABAJO) */
%%

{EMAIL_GMAIL} {
    // Separamos la parte local de la dirección de correo
    direccion = YYText();
    parteLocal = direccion.substr(0,direccion.find("@"));
    if (parteLocal.size() >= 6 && parteLocal.size() <= 30) {
        cout << direccion << "\n\tCorreo Gmail ajeno a la UGR\n";
        contadores[0].valor++;
        contadores[1].valor++;
        contadores[2].valor++;
    }
}

{EMAIL_OUTLOOK} {
    cout << YYText() << "\n\tCorreo Outlook ajeno a la UGR\n";
    contadores[0].valor++;
    contadores[1].valor++;
    contadores[3].valor++;
}

{EMAIL_YAHOO} {
    direccion = YYText();
    parteLocal = direccion.substr(0,direccion.find("@"));
    if (parteLocal.size() >= 4 && parteLocal.size() <= 32) {
        cout << YYText() << "\n\tCorreo Yahoo ajeno a la UGR\n";
        contadores[0].valor++;
        contadores[1].valor++;
        contadores[4].valor++;
    }
}

{EMAIL_PROTON} {
    direccion = YYText();
    parteLocal = direccion.substr(0,direccion.find("@"));
    if (parteLocal.size() <= 40) {
        cout << YYText() << "\n\tCorreo Proton ajeno a la UGR\n";
        contadores[0].valor++;
        contadores[1].valor++;
        contadores[5].valor++;
    }
}

{EMAIL_DOC_UGR} {
    cout << YYText() << "\n\tCorreo institucional de un profesor de la UGR\n";
    contadores[0].valor++;
    contadores[7].valor++;
    contadores[9].valor++;
    contadores[10].valor++;
    contadores[12].valor++;
}

{EMAIL_EST_UGR} {
    cout << YYText() << "\n\tCorreo institucional de un estudiante de la UGR\n";
    contadores[0].valor++;
    contadores[7].valor++;
    contadores[8].valor++;
    contadores[10].valor++;
    contadores[11].valor++;
}

{EMAIL_DOC_GO_UGR} {
    cout << YYText() << "\n\tCorreo Google de un profesor de la UGR\n";
    contadores[0].valor++;
    contadores[7].valor++;
    contadores[9].valor++;
    contadores[13].valor++;
    contadores[15].valor++;
}

{EMAIL_EST_GO_UGR} {
    cout << YYText() << "\n\tCorreo Google de un estudiante de la UGR\n";
    contadores[0].valor++;
    contadores[7].valor++;
    contadores[8].valor++;
    contadores[13].valor++;
    contadores[14].valor++;
}

{EMAIL_DOC_MS_UGR} {
    cout << YYText() << "\n\tCorreo Microsoft de un profesor de la UGR\n";
    contadores[0].valor++;
    contadores[7].valor++;
    contadores[9].valor++;
    contadores[16].valor++;
    contadores[18].valor++;
}

{EMAIL_EST_MS_UGR} {
    cout << YYText() << "\n\tCorreo Microsoft de un estudiante de la UGR\n";
    contadores[0].valor++;
    contadores[7].valor++;
    contadores[8].valor++;
    contadores[16].valor++;
    contadores[17].valor++;
}

{EMAIL_UNKNOWN} {
    cout << YYText() << "\n\tCorreo desconocido ajeno a la UGR\n";
    contadores[0].valor++;
    contadores[1].valor++;
    contadores[6].valor++;
}

{LINEA}

.

%%
/****************************************************/
// Implementación de funciones
int yywrap() {
    return 0;
}

int main(int argc, char *argv[])
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
    cout << "\n--- Lectura finalizada ---\n";
    for (Contador c : counters) {
        if (!c.desc.empty())
            cout << c.desc << ": " << c.valor << endl;
    }
}

// Ejecución:
// flex ejemplo.l
// g++ lex.yy.c -L/c/msys64/MINgw64/lib/libfl.a
// a.exe