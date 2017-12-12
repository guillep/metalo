private
dictionaryOfModulesByNumberOfDependencies

	| dependenciesDict |
	dependenciesDict := Dictionary new.

	moduleEnvironment keysAndValuesDo: [ :k :module |
		|numberOfDependencies|
		numberOfDependencies := module imports size.
		dependenciesDict at: numberOfDependencies ifAbsentPut: [ Set new ].
		(dependenciesDict at: numberOfDependencies) add: module ].
	
	^ dependenciesDict