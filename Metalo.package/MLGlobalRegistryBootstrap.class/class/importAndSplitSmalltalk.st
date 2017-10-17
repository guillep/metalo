bootstrapping
importAndSplitSmalltalk

	"Be careful. This will cleanup the global registry and override it"
	MLModuleRegistry global reset.
	RPackageOrganizer default packages do: [ :each |
		MLModuleRegistry global at: each name put: (MLModule withEnvironment: Smalltalk globals).
	]