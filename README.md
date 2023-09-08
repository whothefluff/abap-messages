# abap-messages

Create messages easily from
  - t100
  - string
  - text-symbol
  - message system fields
  - exception

There are two possible ways of creating messages like those; one is to use the factory class, the other is to use the subclasses. The two are not too coupled (the factory uses only the class ZCL_MESSAGE, while the subclasses don't use the factory at all) and are a sort of convenience, for myself, in the form of code duplication

The interface does not consider types so a message from an object like this can only be sent with "MESSAGE ... TYPE ..."