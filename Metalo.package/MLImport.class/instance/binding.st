accessing
binding
	
	^ importBinding ifNil: [ importBinding := MLUnboundVariable named: nameToImport ]