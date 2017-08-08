comparing
hash

	^ self moduleName hash << 20 bitXor: self importedName hash