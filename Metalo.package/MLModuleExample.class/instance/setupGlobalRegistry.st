examples
setupGlobalRegistry

	MLModuleRegistry global
		at: #'Kernel' put: ((MLModule newNamed: 'Kernel') environment: Smalltalk globals);
		at: #'Collections-Sequenceable' put: ( (MLModule newNamed: 'Collections-Sequenceable') environment: Smalltalk globals);
		at: #'System-Model' put: ((MLModule newNamed: 'System-Model') environment: Smalltalk globals);
		at: #'System-Support' put: ((MLModule newNamed: 'System-Model') environment: Smalltalk globals).