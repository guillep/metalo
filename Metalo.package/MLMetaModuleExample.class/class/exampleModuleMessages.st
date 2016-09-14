examples
exampleModuleMessages

	| math zero |
	math := self exampleModule.
	zero := (math classNamed: #Zero) new.
	zero next next inspect