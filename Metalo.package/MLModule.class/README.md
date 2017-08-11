1) The reflective API should pass always through the Module because it's him that decides what are the methods in the module, or its environment.

Class >> moduleCompile: aString
    self module compile: aString in: self

This will become a key point upon the introduction of extension methods. For example, Imagine the extension #asParser from petit parser to String

String >> asParser
  ^ PPTokenParser on: self

That method belongs to the Petit parser module but is installed in the Collections-Strings module. If we want to add such method, we need to ask the extending module and not the extended module.

petitParser compile: 'asParser ... ' in: String.

This means that String should have been imported in the petitParser module to access it.

If we ask a class for its methods it should only answer its local module methods:

 String methods / localMethods / module methods
   => my local methods (and no asParser here)

If we would like to remove the extension method

2) MLModule should import automatically UndefinedClass ?
See:
MLModuleClassBindingsTest >> #testRemoveClassUsedAsSuperclassShouldBecomeUndeclared
MLModuleClassBindingsTest >> #testRemoveReferencedClassShouldBecomeUndeclared