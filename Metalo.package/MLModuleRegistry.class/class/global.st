accessing
global
	
	^ global ifNil: [ 
		global := MLModuleRegistry new ]