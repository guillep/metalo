bootstrapping
bootstrap

	"Be careful. This will cleanup the global registry and override it"
	MLModuleRegistry global reset.
	RPackageOrganizer default packages do: [ :each | | module |
		module := MLModule loadRPackage: each.
		MLModuleRegistry global at: each name put: module.
	]