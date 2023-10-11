baseline
baseline: spec

	<baseline>
	spec for: #common do: [
		spec
			package: 'Metalo';
			package: 'MetaloTools' with: [ spec requires: #( 'Metalo' ) ] ]