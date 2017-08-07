imports
imports
	^ {(#'CollectionsStreams'
		-> #(#LimitingLineStreamWrapper #RWBinaryOrTextStream #ReadWriteStream)).
	(#'ZincResourceMetaCore' -> #(#ZnMimeType)).
	(#'CollectionsNative' -> #(#ByteArray)).
	(#Metalo -> #(#MLModule)).
	(#Kernel -> #(#Character #Object)).
	(#Files -> #(#FileStream)).
	(#'CollectionsStrings' -> #(#String)).
	(#'CollectionsUnordered' -> #(#Dictionary)).
	(#'NetworkMail' -> #(#MailMessage)).
	(#'CollectionsSequenceable' -> #(#OrderedCollection #Array))}