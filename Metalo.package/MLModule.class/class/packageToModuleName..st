as yet unclassified
packageToModuleName: aPackageName
	|className|
	className := aPackageName copyReplaceAll: ' ' with: ''.
	^ className copyReplaceAll: '-' with: ''