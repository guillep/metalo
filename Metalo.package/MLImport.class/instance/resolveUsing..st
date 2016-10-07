importing
resolveUsing: aNameResolver

	^ (aNameResolver at: bindingSourceName)
		bindingOf: nameToImport