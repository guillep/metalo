accessing
environment

	environment ifNotNil: [ ^ environment ].
	
	environment := MLWorkspaceCompilationScope new
		workspace: self;
		module: module;
		parentEnvironment: (MLModuleCompilerScope new module: module);
		yourself.
	^ environment