methods
compileMethod: sourceCode forClass: aClass 
	
	^ OpalCompiler new
		class: (MLClassCompilerScope new class: aClass; module: self; sourceCode: sourceCode; yourself);
		source: sourceCode;
		compile