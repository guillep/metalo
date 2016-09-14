mop
compileMethod: sourceCode forClass: aClass 
	
	^ OpalCompiler new
		class: (MLBinder new class: aClass; metaModule: module; yourself);
		source: sourceCode;
		addPlugin: (MLSelectorNamespaceCompilerPlugin new metaModule: self; yourself);
		compile