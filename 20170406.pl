
% to run the program 
% enter start().




missionaries(m1,m2).
missionaries(m2,m3).
missioables(m1,c1).
missionary(m1).
missionary(m2).
missionary(m3).
canibale(c1).
canibales(c2,c3).
canibales(c1,c2).

/* move 1 : m1 and c1, c1 is left and m1 is back */ 
moveforward(m1,c1,1,1,0,1).
movebackward(m1,c1,0,1).

/* move 2 : c3 and c2, c2 is left and m1 is back */ 
moveforward(c2,c3,0,1,0,2).
movebackward(c2,c3,0,2).

/* move 3 : m1 and m2, m1 is left and m2 is back with c2 */ 
moveforward(m1,m2,0,2,11,1).
movebackward(m1,c2,11,1).

/* move 4 : m2 and m3, m2 and m3 are left and c1 is back */
moveforward(m2,m3,11,1,3,0).
movebackward(c1,c1,3,0).

/* move 5 : c1 and c2, c1 is left and c2 is back */
moveforward(c1,c2,3,0,3,1).
movebackward(c1,c2,3,1).

/* move 6 : c2 and c3 , end */
moveforward(c2,c3,3,1,3,3).
movebackward(0,0,3,3).

move(X1,X2, X,Y):-
	missionaries(M,M1),
	missionary(M),
	moveforward(m2,M1,X,Y,ML,CL),	
	movebackward(C,C,ML,CL),	
	write('One '),write(M),write(' and one '),
	write(M1),write(' crosse the river '),nl,
	write('One '),write(C),write(' is goin back'),
	X1 is ML ,X2 is CL,nl,nl,nl.
	
move(X1,X2, X,Y):-
	missionaries(M,M1),
	moveforward(M,M1,X,Y,ML,CL),	
	movebackward(M,C,ML,CL),	
	write('One '),write(M),write(' and one '),
	write(M1),write(' crosse the river '),nl,
	write('One '),write(M1),write(' is goin back with one '),write(C),
	X1 is ML ,X2 is CL,nl,nl.
	
move(X1,X2, X,Y):-
	canibales(M,C),
	moveforward(M,C,X,Y,ML,CL),	
	E is ML ,F is CL ,
	movebackward(Q,R,E,F),Q = 0,R = 0 ,
	write('One '),write(M),write(' and one '),
	write(C),write(' crosse the river '),nl,
	write(' The end '),
	X1 is E ,X2 is F,nl,nl.
	
move(X1,X2, X,Y):-
	canibales(M,C),
	moveforward(M,C,X,Y,ML,CL),	
	E is ML ,F is CL ,
	movebackward(M,C,E,F),
	write('One '),write(M),write(' and one '),
	write(C),write(' crosse the river '),nl,
	write('One '),write(M),write(' is left and '),
	write(C),write(' go back '),
	X1 is E ,X2 is F,nl,nl.
	
/***************************/
move(X1,X2, X,Y):-
	missioables(M,C),
	missionary(M),
	canibale(C),
	moveforward(M,C,X,Y,ML,CL),	
	E is ML ,F is CL ,
	movebackward(M,C,E,F),	
	write('One '),write(M),write(' and one '),
	write(C),write(' crosse the river '),nl,
	write('One '),write(C),write(' is left and '),
	write(M),write(' go back '),
	X1 is E ,X2 is F,nl,nl.


% base case
go([_,_,_,3,3]).

go([1,1,0,0,0]):-
	move(X1,X2, 1,1),
	Nm is 1 ,
	go([ML,CL,Nm,X1,X2]).
	
go([LM,LC,M,RM,RC]):-
	move(X1,X2, RM,RC),
	Nl is M + 1 ,
	go([ML,CL,Nl,X1,X2]).

start():-
	go([1,1,0,0,0]).