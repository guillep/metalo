baseline
baseline: spec
	<baseline>
	
	spec for: #common do: [
		spec 
			baseline: 'UndefinedClasses' 
			with: [ spec repository: 'github://guillep/UndefinedClasses:master' ].
		spec
			baseline: 'Calypso'
			with: [ spec repository: 'github://dionisiydk/Calypso:f38f76e6b61c11d4109429327779d3c905976025' ]. "fixed version to no bother"
		spec 
			package: 'Metalo' with: [ spec requires: #( 'UndefinedClasses') ];
			package: 'MetaloTools' with: [ spec requires: #('Metalo' 'Calypso') ] ]