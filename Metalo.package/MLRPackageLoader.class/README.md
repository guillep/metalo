I take an RPackage and inject everything it contains into a module.
I recompile things so it implies that classes, .. etc. are duplicated.

module := MLModule newNamed: #'Transcript-Core'.
MLRPackageLoader new
		rpackageName: #'Transcript-Core';
		module: module;
		load.
