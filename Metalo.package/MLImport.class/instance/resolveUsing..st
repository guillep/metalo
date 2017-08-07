importing
resolveUsing: moduleRegistry
	"Returns a (potentially undeclared) binding as described by the import in the context of the name resolver.
	If the imported module or class names cannot be resolved, returns an entry of the undeclared dictionary of the module"
	
	| newBinding |
	(moduleRegistry
		definesName: nameToImport
		inModuleNamed: bindingSourceName)
			ifTrue: [ newBinding := moduleRegistry bindingOf: nameToImport inModuleNamed: bindingSourceName ]
			ifFalse: [ newBinding := MLUnboundVariable named: nameToImport ].

	(self binding == newBinding)
		ifFalse: [ self binding redefineAs: newBinding ].
	^ self binding