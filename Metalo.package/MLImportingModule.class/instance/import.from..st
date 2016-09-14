as yet unclassified
import: aName from: aModule

	| scopedImport |
	scopedImport := MLImports new.
	scopedImport at: aName put: (aModule classNamed: aName).
	self import: scopedImport