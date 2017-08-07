tests-binding
testModuleBindingFailsWithNonResolvableNames

	registry registerModule: networkModule.
	
	"This test should fail because the test module depends on other than"
	[self class networkTests createModuleBoundTo: registry.
	self fail ]
		on: Error
		do: [ :error | self deny: (networkModule includesName: error name) ]