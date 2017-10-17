accessing
environment

	environment ifNotNil: [ ^ environment ].
	
	environment := MLWorkspaceEnvironment new
		workspace: self;
		module: module;
		parentEnvironment: (MLModuleEnvironment new module: module);
		yourself.
	^ environment