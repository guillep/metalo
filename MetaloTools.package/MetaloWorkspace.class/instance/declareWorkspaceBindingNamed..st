bindings
declareWorkspaceBindingNamed: aString 
	
	| newBinding |
	newBinding := WorkspaceVariable named: aString.
	bindings add: newBinding.
	^ newBinding