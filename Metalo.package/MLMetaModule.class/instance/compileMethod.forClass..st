mop
compileMethod: sourceCode forClass: aClass 
	
	^ OpalCompiler new
		class: (MLBinder new class: aClass; metaModule: self; sourceCode: sourceCode; yourself);
		source: sourceCode;
		compile