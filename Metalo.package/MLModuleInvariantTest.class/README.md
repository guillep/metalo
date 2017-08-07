Two issues so far.

since for now a Module is a subclass of MLModule (created after the import generation) we should add in the import the following:
	(#Metalo -> #(#MLModule)).
https://github.com/guillep/metalo/issues/1

We should remove the self reference to the package.
https://github.com/guillep/metalo/issues/2