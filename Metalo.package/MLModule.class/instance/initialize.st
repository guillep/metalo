initialization
initialize

	super initialize.	
	imports := Set new.
	importsEnvironment := Dictionary new.
	classBindings := Dictionary new.
	variableBindings := Dictionary new.
	undeclaredBindings := Dictionary new.