instance-creation
createModuleNamed: aString 
	
	| module moduleClass metaModule |
	moduleClass := self basicCreateClassNamed: aString superclass: MLModule.
	metaModule := self new.
	
	module := moduleClass new.
	moduleClass environment: module.
	module name: aString.
	module metaModule: metaModule.
	metaModule module: module.
	
	metaModule initializeModule.
	^ module