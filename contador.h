#ifndef _CONTADOR_H_
#define _CONTADOR_H_

#include <string>
#include <vector>

struct Contador {
    std::string desc;
    unsigned int valor = 0;
};

std::vector<Contador> contadores(100);

void iniciar_contadores() {
    contadores[0 ].desc = "Direcciones de correo totales";
    contadores[1 ].desc = "Direcciones de correo ajenas a la UGR";
    contadores[2 ].desc = "\tde Gmail";
    contadores[3 ].desc = "\tde Outlook";
    contadores[4 ].desc = "\tde Yahoo";
    contadores[5 ].desc = "\tde Proton";
    contadores[6 ].desc = "\totros";
    contadores[7 ].desc = "Direcciones de la UGR";
    contadores[8 ].desc = "\tde estudiantes";
    contadores[9 ].desc = "\tde profesores";
    contadores[10].desc = "Direcciones institucionales de la UGR";
    contadores[11].desc = "\tde estudiantes";
    contadores[12].desc = "\tde profesores";
    contadores[13].desc = "Direcciones Google de la UGR";
    contadores[14].desc = "\tde estudiantes";
    contadores[15].desc = "\tde profesores";
    contadores[16].desc = "Direcciones Microsoft de la UGR";
    contadores[17].desc = "\tde estudiantes";
    contadores[18].desc = "\tde profesores";
}


#endif // _CONTADOR_H_