# MC-FLEX

## Analizador léxico construido en FLEX y C++

### ¿Qué hace este programa?

Este programa lee una lista de correos electrónicos e identifica que tipo de dirección de correo electrónico es. Identifica direcciones Gmail, Outlook, Yahoo, Proton y de la Universidad de Granada; aunque también puede identificar direcciones de correo de organizaciones desconocidas para el programa.

### ¿Cómo puedo ejecutarlo?

#### Linux (Debian)

Necesitas tener los paquetes `flex` y `g++` instalados.

```bash
$ sudo apt install flex g++
```

Después ejecuta el script `ejecutar.sh`
para compilar y ejecutar el programa.

```bash
% ./ejecutar.sh <fichero_de_texto>
```

Donde `fichero_de_texto` es el fichero que contiene las direcciones de correo electrónico. Si quieres probarlo sin necesidad de crear un nuevo archivo de texto, puedes usar el fichero `entrada.txt` que puedes encontrar en este repositorio.

#### Windows

Descarga Flex [aquí](https://gnuwin32.sourceforge.net/packages/flex.htm), e instala un compilador de C++ para Windows como MSYS2 o MINGW si no tienes uno.

Si tienes un intérprete bash en tu sistema, ejecuta `ejecutar.sh`, como lo harías
en Linux.

Si no tienes un intérprete bash en tu sistema, ejecuta los comandos que hay en el fichero `ejecutar.sh` uno por uno *(intentaré hacer un script para que sea más cómodo)*.

```bash
flex++ flex.l
g++ lex.yy.cc -lfl -o prog
prog <fichero_de_texto>
```

### *Yo tengo que hacer un programa en FLEX ¿Puedo usar este programa como inspiración para hacer el mío?*

Sin problema.
Además, esta práctica tuvo una calificación perfecta.
