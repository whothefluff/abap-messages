"! <p class="shorttext synchronized" lang="EN">SY structure message</p>
"! Inherits from {@link ZCL_MESSAGE}.
class zcl_sy_message definition
                     public
                     create public
                     inheriting from zcl_message.

  public section.

    "! <p class="shorttext synchronized" lang="EN">Creates msg. with SY MSGID, MSGTY, MSGNO, and MSGV1 to MSGV4</p>
    methods constructor.

endclass.
class zcl_sy_message implementation.

  method constructor.

    super->constructor( i_id = sy-msgid
                        i_number = sy-msgno
                        i_type = switch #( sy-msgty
                                           when 'E' then type-error
                                           when 'I' then type-information
                                           when 'W' then type-warning
                                           when 'S' then type-success
                                           else throw cx_sy_message_illegal_text( ) )
                        i_var1 = sy-msgv1
                        i_var2 = sy-msgv2
                        i_var3 = sy-msgv3
                        i_var4 = sy-msgv4 ).

  endmethod.

endclass.

