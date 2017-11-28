manifest generation
createModuleManifestForPackageNamed: aPackageName
	| manifestClass codeToCompile |
	manifestClass := self
		createManifestClassForPackageNamed: aPackageName.
	codeToCompile := self computePackageDependenciesOfPackageNamed: aPackageName.
	codeToCompile := 'imports ^ ' , codeToCompile asString.
	codeToCompile := (RBParser parseMethod: codeToCompile) formattedCode.
	manifestClass compile: codeToCompile classified: 'imports'