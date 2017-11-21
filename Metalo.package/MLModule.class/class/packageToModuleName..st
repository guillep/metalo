rpackage-compatibility
packageToModuleName: aPackageName
	|className|
	className := aPackageName copyReplaceAll: ' ' with: ''.
	^ className copyReplaceAll: '-' with: ''