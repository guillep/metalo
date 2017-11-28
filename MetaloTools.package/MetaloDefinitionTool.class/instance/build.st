initialization
build
	"perhaps use a subclass of ClyTextEditorTool to show the current module definition"
	self addMorph: ('here is your definition of ', self selectedPackage name) asMorph fullFrame: LayoutFrame identity