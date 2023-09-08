# abap-messages

Create messages easily from
  - t100
  - string
  - text-symbol
  - message system fields
  - exception

There are two possible ways of creating messages like those; one is to use the factory class, the other is to use the subclasses. The two are not too coupled (the factory uses only the class ZCL_MESSAGE, while the subclasses don't use the factory at all) and are a sort of convenience, for myself, in the form of code duplication

The interface has a type so a message from an object like this should be sent with "MESSAGE ..." (without the TYPE addition)

While it is technically possible to modify the value of the attribute "severity" of the new interface, the code was implemented assuming that the severity and the type will match