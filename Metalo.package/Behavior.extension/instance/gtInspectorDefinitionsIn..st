*Metalo
gtInspectorDefinitionsIn: composite
	<gtInspectorPresentationOrder: 1> 
	composite tabulator 
		title: 'Class';
		with: [ :t |  
			t row: #definition; row: #methods.
			t transmit to: #definition; andShow: [:a | 
				a pharoScript 
					display: [ :m | m definition ];
					doItReceiver: [ self ]].
			t transmit to: #methods; andShow: [:a | 
				a list 
					title: 'Methods';
					display: [ :class | class methods];
					icon: [ :method | method icon ];
					format: #selector ].
			t transmit
				toOutsidePort: #selection;
				from: #methods port: #selection
		];
		startOn: self