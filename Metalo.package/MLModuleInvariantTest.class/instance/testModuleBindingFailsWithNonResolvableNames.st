tests-binding
testModuleBindingFailsWithNonResolvableNames

	| registry |
	registry := MLModuleRegistry new.
	registry registerModule: networkModule.
	
	"This test should fail because the test module depends on other than"
	[MLModuleDefinition networkTests createModuleBoundTo: registry.
	self fail ]
		on: Error
		do: [ :error | self deny: (networkModule includesName: error name) ]