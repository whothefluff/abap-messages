"! <p class="shorttext synchronized" lang="EN">System Fields Message</p>
"!
"! Inherits from {@link ZCL_MESSAGE}
class zcl_sy_message definition
                     public
                     inheriting from zcl_message
                     create public.

  public section.

    class-methods class_constructor.

    "! <p class="shorttext synchronized" lang="EN">Creates msg. with SY MSGID, MSGTY, MSGNO, and MSGV1 to MSGV4</p>
    methods constructor.

  protected section.

    class-data _type_fty type ref to zcl_message_type_fty.

endclass.
class zcl_sy_message implementation.

  method class_constructor.

    _type_fty = new zcl_message_type_fty( ).

  endmethod.
  method constructor.

    super->constructor( i_id = sy-msgid
                        i_number = sy-msgno
                        i_type = _type_fty->from_old( sy-msgty )
                        i_var1 = sy-msgv1
                        i_var2 = sy-msgv2
                        i_var3 = sy-msgv3
                        i_var4 = sy-msgv4 ).

  endmethod.

endclass.
