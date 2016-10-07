accessing
messageText

	^ 'Unresolved Name ''{name}'' in module ''{module}'''
		format: {
			'name' -> name asString.
			'module' -> moduleName asString } asDictionary