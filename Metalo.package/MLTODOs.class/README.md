Idea of Experiment: Use a Unit test that creates classes and ensure that it does not impact the system (isolation)

- Code a StaticModuleChecker that analyses a module and ensures that it is closed i.e. only refers to defined, imported, ... things

- extends TestRunner to run tests given a ModuleRegistery

- execute tests but bound on a new SUnit module

- Life cycle of a Module

- Module API
-- Module creation 
-- Class definition
-- Variable definition
-- Imports declaration
-- Method definition 
-- Method extension definition 
-- Reflexive API of a module i.e. specific compiler, class builder, class installer 

We should test:

 - If we have a declared variable and we remove it
     - case where the variable is used as a superclass. What do we do? this is a strange case.

- If we have a declared class and we remove it
     - case where the class is unused

- If we have a subclass of an undefined class
   - and we remove the subclass

Test all the same but with bindings

Undeclare ref  -> we use it as subclass
Undeclared ref -> we use it as ref
Undeclared Superclass -> we use it as ref

