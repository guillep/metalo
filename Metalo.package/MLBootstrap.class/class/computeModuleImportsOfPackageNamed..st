dependencies computing
computeModuleImportsOfPackageNamed: aPackageName
	| dependencies imports  |

	dependencies := self computePackageDependenciesOfPackageNamed: aPackageName.
	imports := Dictionary new.
	dependencies keysAndValuesDo: [ :packageName :requiredClasses |
		imports at: (self moduleNameForPackageName: packageName) put: requiredClasses ].
	^ imports