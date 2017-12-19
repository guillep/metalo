imports
declareImport: aName from: aContainerModuleName 
	
	| import |
	import := MLImport name: aName from: aContainerModuleName.
	import checkRedundancyOn: self ifRedundant: [ :existingImport | ^ existingImport ].
	import checkConflictsOn: self.
	
	self declareBinding: import binding.
	importsEnvironment add: import binding.
	imports add: import.
	^ import