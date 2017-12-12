running
setUp
	super setUp.
	
	module compileMethod: self definedMethodSelector,' ^', self undeclaredVariableName inClass: definedClass