dependencies computing
computePackageDependenciesOfPackageNamed: aPackageName
	| dict  dependentClasses |

	dict := Dictionary new.
	dependentClasses := [ 
		(((DAPackageRelationGraph onPackagesNamed: {aPackageName})
		computeStaticDependencies;
		classToPackage) keys
		collect: [ :aClass | aClass theNonMetaClass name ])
		 ] on: PotentialOutDatedDependencyWarning do: [ :w | w resume  ].
	
	dependentClasses do: [ :dependantName | 
			| class |
			class := Smalltalk globals at: dependantName asSymbol.
			class isTrait
				ifFalse: [ (dict
						at: class package name
						ifAbsent: [ dict at: class package name put: OrderedCollection new ])
						add: dependantName ] ].
	(self computePackageToGlobalDependencies
		at: aPackageName
		ifAbsent: [ #() ])
		do: [ :globalName | 
			| globalPackageOwner |
			globalPackageOwner := (Smalltalk globals at: globalName) class
				package name.
			(dict at: globalPackageOwner ifAbsentPut: [ OrderedCollection new ])
				add: globalName ].
	dict removeKey: aPackageName ifAbsent: [].
	dict := dict associations
		collect: [ :assoc | assoc key -> assoc value asArray ].
	^ dict asDictionary 