mop
recompileAll

	(recompiling notNil and: [ recompiling ]) ifTrue: [ ^ self ].
	recompiling := true.
	[ module definitions do: [ :each | each isClass ifTrue: [ self recompileClass: each ] ] ]
		ensure: [recompiling := false]