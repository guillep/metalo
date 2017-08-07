binding
createModuleBoundTo: aNameResolver 
	"Create a module based on the receiver and in the context defined by aNameResolver (a module environment)"
	
	| bindings undeclareds |
	"We ignore the undeclareds so far"
	undeclareds := Dictionary new.
	bindings := imports collect: [ :import | import resolveUsing: aNameResolver withUndeclareds: undeclareds ].
	^ MLModule
		newNamed: name
		fromModuleDefinition: self
		withModuleVariableNames: moduleVariableNames
		withImports: bindings