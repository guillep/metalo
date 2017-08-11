We should test:

 - If we have a declared variable and we remove it
     - case where the variable is used as a superclass. What do we do? this is a strange case.

- If we have a declared class and we remove it
     - case where the class is unused

- If we have a subclass of an undefined class
   - and we remove the subclass

Test all the same but with bindings

Introduce class definition

Undeclare ref  -> we use it as subclass
Undeclared ref -> we use it as ref
Undeclared Superclass -> we use it as ref

