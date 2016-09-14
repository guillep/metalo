as yet unclassified
description

	^ ('Name ''{name}'' not defined in ''{module}'''
		format: { 
			'name' -> undefinedName asString.
			'module' -> module asString } asDictionary)