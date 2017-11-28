tests-name invariants
testLoadingModuleWithUnresolvedImportsCreatesUndeclareds

	| module |
	module := self class networkCore createModuleBoundTo: MLModuleRegistry new.