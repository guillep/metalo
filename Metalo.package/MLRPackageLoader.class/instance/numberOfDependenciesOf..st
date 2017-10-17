helpers
numberOfDependenciesOf: aClass 
	
	^ ((aClass allSuperclasses, aClass traits)
		select: [ :e | e package = aClass package ]) size