baseline
baseline: spec
	<baseline>
	
	spec for: #common do: [
		spec 
			baseline: 'UndefinedClasses' 
			with: [ spec repository: 'github://guillep/UndefinedClasses:master' ].
		spec
			baseline: 'Calypso'
			with: [ spec repository: 'github://dionisiydk/Calypso:master' ].
		spec 
			package: 'Metalo' with: [ spec requires: #( 'UndefinedClasses') ];
			package: 'MetaloTools' with: [ spec requires: #('Metalo' 'Calypso') ] ]