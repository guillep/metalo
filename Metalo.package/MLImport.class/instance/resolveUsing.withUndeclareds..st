importing
resolveUsing: moduleRegistry withUndeclareds: aDictionary
	"This is a compatibility method that we should remove as soon as we split the module loading from module binding."
	| importedModule |
	importedModule := moduleRegistry
		at: bindingSourceName
		ifPresent: [ :importingModule |
			(importingModule includesKey: nameToImport)
				ifTrue: [ ^ importingModule bindingOf: nameToImport ] ].
	
	aDictionary
		at: nameToImport
		ifAbsent: [ aDictionary add: (GlobalVariable named: nameToImport) ].
	^ aDictionary bindingOf: nameToImport.