flex++ flex.l

if [ $? != 0 ]; then
    echo Error de flex, abortando...
    exit $?
fi

g++ lex.yy.cc -lfl -o prog

if [ $? != 0 ]; then
    Error del compilador, abortando...
    exit $?
fi

./prog $1