accessing
compileMethod: sourceCode inClass: aClass

	| methodCompiled |
	methodCompiled := super compileMethod: sourceCode inClass: aClass.
	"When a private method is installed. All methods in the class (or hierarchy) should be recompiled."
	(methodCompiled selector = #imports)
		ifTrue: [ self recompileAll ]