We should test:

 - If we have a declared variable and we remove it
     - case where the variable is referenced
     - case where the variable is unused

- If we have a declared class and we remove it
     - case where the class is referenced
     - case where the class is subclasses
     - case where the class is unused

- If we have an undeclared reference in a method
   - and we remove the method

- If we have a subclass of an undefined class
   - and we remove the subclass

Introduce undefined classes

Test all the same but with bindings

Introduce class definition