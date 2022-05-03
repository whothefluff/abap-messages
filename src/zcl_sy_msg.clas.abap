"! <p class="shorttext synchronized" lang="EN">SY structure message</p>
"! Inherits from {@link zcl_msg}.
class zcl_sy_msg definition
                 public
                 create public
                 inheriting from zcl_msg.

  public section.

    "! <p class="shorttext synchronized" lang="EN">Create msg. with SY MSGID, MSGTY, MSGNO, and MSGV1 to MSGV4</p>
    methods constructor.

endclass.
class zcl_sy_msg implementation.

  method constructor.

    super->constructor( i_id = sy-msgid
                        i_number = sy-msgno
                        i_type = sy-msgty
                        i_var1 = sy-msgv1
                        i_var2 = sy-msgv2
                        i_var3 = sy-msgv3
                        i_var4 = sy-msgv4 ).

  endmethod.

endclass.

