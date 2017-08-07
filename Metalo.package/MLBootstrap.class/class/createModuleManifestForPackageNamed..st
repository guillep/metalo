manifest generation
createModuleManifestForPackageNamed: aPackageName
	| manifestClass dict codeToCompile |
	manifestClass := self createManifestClassForPackageNamed: aPackageName.
	dict := self computePackageDependenciesOfPackageNamed: aPackageName.
	codeToCompile := dict associations
		collect: [ :assoc | assoc key -> assoc value asArray ].
	codeToCompile := 'imports ^ ' , codeToCompile asString.
	codeToCompile := (RBParser parseMethod: codeToCompile) formattedCode.
	manifestClass compile: codeToCompile classified: 'imports'