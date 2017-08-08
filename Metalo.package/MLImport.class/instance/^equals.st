comparing
= anotherImport

	^ self importedName = anotherImport importedName
		and: [ self moduleName = anotherImport moduleName ]