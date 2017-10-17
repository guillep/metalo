examples
setupGlobalRegistry

	MLModuleRegistry global
		at: #'Kernel' put: (MLModule withEnvironment: Smalltalk globals);
		at: #'Collections-Sequenceable' put: (MLModule withEnvironment: Smalltalk globals);
		at: #'System-Model' put: (MLModule withEnvironment: Smalltalk globals);
		at: #'System-Support' put: (MLModule withEnvironment: Smalltalk globals).