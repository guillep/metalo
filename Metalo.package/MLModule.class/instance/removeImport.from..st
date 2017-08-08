imports
removeImport: aName from: aContainerModuleName
	
	| import references undeclaredBinding |
	import := self imports detect: [ :each | 
		each importedName = aName
			and: [ each moduleName = aContainerModuleName ] ].
	self imports remove: import.
	
	references := self referencesToBinding: import binding.
	references ifEmpty: [ ^ self ].
	
	undeclaredBinding := self declareUndeclaredBinding: import importedName.
	undeclaredBinding value: import binding value.
	references do: [ :each | each replaceBindingWith: undeclaredBinding  ]