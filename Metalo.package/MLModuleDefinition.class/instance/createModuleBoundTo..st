binding
createModuleBoundTo: aNameResolver 

	| bindings |
	bindings := imports collect: [ :import | import resolveUsing: aNameResolver ].

	^ MLMetaModule
		newNamed: name
		fromModuleDefinition: self
		withImports: bindings