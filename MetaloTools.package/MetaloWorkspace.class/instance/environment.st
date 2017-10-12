accessing
environment

	environment ifNotNil: [ ^ environment ].
	
	environment := MLWorkspaceEnvironment new
		workspace: self;
		parentEnvironment: (MLModuleEnvironment new module: module);
		yourself.
	^ environment