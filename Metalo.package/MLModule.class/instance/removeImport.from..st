imports
removeImport: aName from: aContainerModuleName
	
	| import |
	import := self imports detect: [ :each | 
		each importedName = aName
			and: [ each moduleName = aContainerModuleName ] ].
	self imports remove: import.
	self checkUndeclaredBinding: import binding