accessing
messageText

	^ 'Unresolved Module named ''{name}'''
		format: { 'name' -> moduleName asString } asDictionary