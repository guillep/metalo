mop
compileMethod: sourceCode forClass: aClass 
	
	^ OpalCompiler new
		class: (MLBinder new class: aClass; metaModule: self; yourself);
		source: sourceCode;
		compile