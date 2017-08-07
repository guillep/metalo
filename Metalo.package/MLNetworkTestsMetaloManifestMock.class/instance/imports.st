imports
imports
	^ {(#'CollectionsStreams' -> #(#Stream)).
	(#'CollectionsNative' -> #(#ByteArray)).
	(#'NetworkKernel'
		->
			#(#ConnectionClosed #Socket #NoBroadcastAllowed #NetworkError #NetNameResolver #ConnectionTimedOut #SocketStream)).
	(#Kernel -> #(#Delay #Object #Character #Processor)).
	(#'NetworkMIME'
		-> #(#QuotedPrintableMimeConverter #Base64MimeConverter)).
	(#'NetworkProtocols' -> #(#SMTPClient)).
	(#Metalo -> #(#MLModule)).
	(#'SUnitCore' -> #(#TestCase #ClassTestCase)).
	(#'CollectionsStrings' -> #(#String)).
	(#'CollectionsUnordered' -> #(#Set)).
	(#'NetworkMail' -> #(#MailAddressParser #MailMessage)).
	(#'NetworkUUID' -> #(#UUIDGenerator #UUID))}