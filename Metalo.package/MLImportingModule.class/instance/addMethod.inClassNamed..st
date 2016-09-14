as yet unclassified
addMethod: sourceCode inClassNamed: aClassName
	
	| class method |
	class := self classNamed: aClassName.
	method := OpalCompiler new
				class: (MLBinder new class: class; module: self; yourself);
				source: sourceCode;
				compile.
	class
		addSelectorSilently: method selector
		withMethod: method