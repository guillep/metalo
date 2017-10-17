actions
evaluate: aString 

	| method |
	
	method := module compiler
		class: self environment;
		noPattern: true;
		compile: aString.
		
	^ module executeMethod: method 