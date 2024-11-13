Class {
	#name : 'ExtensionMigrator',
	#superclass : 'Object',
	#category : 'ExtensionImpl-Core',
	#package : 'ExtensionImpl',
	#tag : 'Core'
}

{ #category : 'as yet unclassified' }
ExtensionMigrator class >> migrateExtensionsOn: aPackageName [

	| extendedClasses |
	extendedClasses := (PackageOrganizer default packageNamed:
		                    aPackageName) extendedClasses.
	extendedClasses do: [ :c |
		self migrateExtensionsTo: c on: aPackageName ]
]

{ #category : 'as yet unclassified' }
ExtensionMigrator class >> migrateExtensionsTo: aClass on: aPackageName [
	"Create an extension meta-object in the package named {PackageName}ExtensionOf{ExtendedClass}.
	Represent this extension meta-object as a class for now"

	| extensionName theExtension extensionMethods cleanPackageName |
	{
		aClass.
		aClass classSide } do: [ :c |

		cleanPackageName := aPackageName copyReplaceAll: '-' with: ''.
		cleanPackageName := cleanPackageName copyReplaceAll: ' ' with: ''.
		
		
		extensionName := (cleanPackageName , 'ExtensionOf' , c instanceSide name).
		c isClassSide ifTrue: [ extensionName := extensionName, 'classSide' ].
		extensionName := extensionName asSymbol.

		"self environment at: extensionName ifPresent: [ :c | self error: extensionName, ' already exists' ]."

		theExtension := (Object << extensionName)
			                package: aPackageName;
			                install.

		"Declare that this extension extends aClass"
		theExtension class compile: 'extends

	^ ' , c name.

		"Finally migrate the extension methods from the implicit model to the new explicit model"
		extensionMethods := (PackageOrganizer default packageNamed:
			                     aPackageName) extensionMethodsForClass: c.

		extensionMethods do: [ :m | | newMethod |
			newMethod := theExtension extends compiler compile: m sourceCode.
			theExtension
				addSelectorSilently: m selector
				withMethod: newMethod ] ]
]
