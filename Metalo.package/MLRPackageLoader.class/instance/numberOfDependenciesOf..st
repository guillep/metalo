helpers
numberOfDependenciesOf: aClass 

	^ (aClass allSuperclasses select: [ :e | e package = aClass package ]) size