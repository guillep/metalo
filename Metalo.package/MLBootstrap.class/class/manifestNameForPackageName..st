create module registry
manifestNameForPackageName: aPackageName
	^ (self moduleNameForPackageName: aPackageName) , 'MetaloManifest' 