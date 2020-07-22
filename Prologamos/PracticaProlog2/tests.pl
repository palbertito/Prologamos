%TEST PROLOG

% eliminar_comodines()

?-eliminar_comodines(regs(1,1,+,5,*), regs(1,1,+,5,_), [1,1,+,5]).
      yes

?-eliminar_comodines(regs(1,1,+,*,5), regs(1,1,+,_,5), [1,1,+,5]).
      yes

?-eliminar_comodines(regs(1,1,+,5,*), regs(1,1,+,5,_), [1,1,+,5,_]).
      no

?-eliminar_comodines(regs(1,1,+,5), regs(1,1,+,5), [1,1,+,5]).
      yes

?-eliminar_comodines(regs(a,b,1,+,2,*,c), regs(a,b,1,+,2,_,c), [a,b,1,+,2,c]).
      yes

?-eliminar_comodines(regs(0,*,-,f,*), regs(0,_,-,f,_), [0,-,f]).
      yes

?-eliminar_comodines(regs(a,b,1,+,2,*,c), regs(a,b,1,+,2,_,c),  [1,1,+,5,_]).
      no

% ejecutar_instruccion

?- ejecutar_instruccion(regs(1,2,+,5,*),swap(1,2),regs(2,1,+,5,*)).
      yes

?- ejecutar_instruccion(regs(a,b,1,+,2,*,c),swap(a,b)regs(b,a,1,+,2,*,c)).
      yes

?- ejecutar_instruccion(regs(1,2,+,5,*),swap(1,2),regs(1,2,+,5,*)).
      no

?- ejecutar_instruccion(regs(1,2,+,5,*),swap(-,2),regs(1,2,+,5,*)).
      no

?- ejecutar_instruccion(regs(1,2,+,5,*),move(1),regs(1,1,+,5,*)).
      yes

?- ejecutar_instruccion(regs(0,*,-,f,*),move(0),regs(0,0,-,f,*)).
      yes

?- ejecutar_instruccion(regs(1,2,+,5,*),move(2),regs(1,2,+,5,*)).
      no

?- ejecutar_instruccion(regs(1,2,+,5,*),move(7),regs(1,2,+,5,*)).
      no
