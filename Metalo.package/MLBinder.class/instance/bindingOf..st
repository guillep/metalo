compiler API
bindingOf: aName

	"Hack.
	The compiler will call bindingOf: both for temps, arguments and globals.
	However, the module will only resolve names for globals and classes. We handle temps and arguments here."

	| ast |
	ast := RBParser parseMethod: sourceCode.
	(ast allDefinedVariables includes: aName) ifTrue: [ ^ nil ].

	^ class bindingOf: aName