instance creation
newNamed: aName fromRPackages: anRPackageCollection withImports: imports
	
	| moduleDefinition |
	moduleDefinition := self new.
	moduleDefinition name: aName.
	moduleDefinition imports: imports.
	moduleDefinition rPackages: anRPackageCollection.
	^ moduleDefinition