instance-creation
loadRPackageNamed: rpackageName

	| module |
	module := self newNamed: rpackageName.
	MLRPackageLoader new
		rpackageName: rpackageName;
		module: module;
		load.
	^ module