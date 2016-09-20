importing
importInto: aModule

	| resolvedBinding |
	resolvedBinding := bindingSource bindingOf: nameToImport.
	aModule addBinding: resolvedBinding.