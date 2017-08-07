create module registry
createModuleForPackageName: aPackageName
	
	| className |
	className := self manifestNameForPackageName: aPackageName.
	
	^ MLModuleDefinition
			newNamed: (self moduleNameForPackageName: aPackageName)
			fromRPackages: ({ aPackageName } collect: [ :each | RPackage organizer packageNamed: each ])
			withImportDeclarations:  (Smalltalk globals at: className asSymbol) new imports 
			
		
