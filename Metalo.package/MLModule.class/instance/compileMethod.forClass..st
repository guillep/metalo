class creation
compileMethod: sourceCode forClass: aClass 
	
	^ OpalCompiler new
		class: (MLBinder new class: aClass; module: self; sourceCode: sourceCode; yourself);
		source: sourceCode;
		compile