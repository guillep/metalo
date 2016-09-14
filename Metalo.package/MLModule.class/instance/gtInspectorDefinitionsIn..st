ide
gtInspectorDefinitionsIn: composite
	<gtInspectorPresentationOrder: 1> 
	composite tabulator 
		title: 'Definitions';
		with: [ :t |  
			t row: #definitions.
			t transmit to: #definitions; andShow: [:a | 
				a list
					title: 'Definitions';
					display: [ :module | module definitions ];
					icon: [ :definition | definition icon ]].
"			t transmit from: #pragmas; to: #methods; andShow: [:a | 
				a list 
					title: 'Methods';
					display: [ :pragma | 
						| methods | 
						methods := OrderedCollection new.
						Object withAllSubclassesDo: [ :each | 
							methods addAll: ((Pragma allNamed: pragma keyword in: each) collect: #method) ].
						methods ];
					format: #selector ]."
			t transmit
				toOutsidePort: #selection;
				from: #definitions port: #selection
		];
		startOn: self