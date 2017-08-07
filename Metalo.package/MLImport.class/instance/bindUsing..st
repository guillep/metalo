importing
bindUsing: aNameResolver
	"Returns the binding described by the import in the context of the name resolver.
	If the names cannot be resolved, throws an exception"
	
	| importedModule |
	importedModule := aNameResolver
		at: bindingSourceName
		ifAbsentPut: [ MLUnresolvedModuleError named: bindingSourceName ].
	
	(importedModule includesName: nameToImport)
		ifFalse: [ MLUnresolvedNameError named: nameToImport inModuleNamed: bindingSourceName ].
	
	^ importedModule bindingOf: nameToImport