"! <p class="shorttext synchronized" lang="EN">Message</p>
class zcl_message definition
                  public
                  create public.

  public section.

    interfaces: if_t100_message.

    aliases: get_longtext for if_message~get_longtext,
             get_text for if_message~get_text.

    constants: begin of valid_type,
                 abortion type sy-msgty value 'A',
                 error type sy-msgty value 'E',
                 information type sy-msgty value 'I',
                 warning type sy-msgty value 'W',
                 exit type sy-msgty value 'X',
                 success type sy-msgty value 'S',
               end of valid_type.

    data var1 type sy-msgv1 read-only.

    data var2 type sy-msgv2 read-only.

    data var3 type sy-msgv4 read-only.

    data var4 type sy-msgv4 read-only.

    "! <p class="shorttext synchronized" lang="EN">Used for {@link .METH:send} and {@link .METH:send_like}</p>
    data type type sy-msgty read-only.

    "! <p class="shorttext synchronized" lang="EN">Creates a T100 message</p>
    "!
    "! @parameter i_id | <p class="shorttext synchronized" lang="EN"></p>
    "! @parameter i_number | <p class="shorttext synchronized" lang="EN"></p>
    "! @parameter i_type | <p class="shorttext synchronized" lang="EN">Used for {@link .METH:send} and {@link .METH:send_like}</p>
    "! @parameter i_var1 | <p class="shorttext synchronized" lang="EN"></p>
    "! @parameter i_var2 | <p class="shorttext synchronized" lang="EN"></p>
    "! @parameter i_var3 | <p class="shorttext synchronized" lang="EN"></p>
    "! @parameter i_var4 | <p class="shorttext synchronized" lang="EN"></p>
    methods constructor
              importing
                i_id like if_t100_message=>t100key-msgid
                i_number like if_t100_message=>t100key-msgno
                i_type like sy-msgty
                i_var1 like sy-msgv1 optional
                i_var2 like sy-msgv2 optional
                i_var3 like sy-msgv3 optional
                i_var4 like sy-msgv4 optional.

    "! <p class="shorttext synchronized" lang="EN">Sends message</p>
    "!
    "! @parameter r_self | <p class="shorttext synchronized" lang="EN"></p>
    methods send
              returning
                value(r_self) type ref to if_t100_message.

    "! <p class="shorttext synchronized" lang="EN">Sends message and displays it like a specific type</p>
    "!
    "! @parameter i_display_like | <p class="shorttext synchronized" lang="EN"></p>
    "! @parameter r_self | <p class="shorttext synchronized" lang="EN"></p>
    methods send_like
              importing
                i_type type sy-msgty
              returning
                value(r_self) type ref to if_t100_message.

    "! <p class="shorttext synchronized" lang="EN">Sends message that displays at the end of the process</p>
    "!
    "! @parameter r_self | <p class="shorttext synchronized" lang="EN"></p>
    methods display
              returning
                value(r_self) type ref to if_t100_message.

    "! <p class="shorttext synchronized" lang="EN">Sends message that displays before continuing the process</p>
    "!
    "! @parameter r_self | <p class="shorttext synchronized" lang="EN"></p>
    methods display_immediately
              returning
                value(r_self) type ref to if_t100_message.

endclass.
class zcl_message implementation.

  method constructor.

    me->var1 = i_var1.

    me->var2 = i_var2.

    me->var3 = i_var3.

    me->var4 = i_var4.

    me->type = i_type.

    me->if_t100_message~t100key = value #( msgid = i_id
                                           msgno = i_number
                                           attr1 = 'VAR1'
                                           attr2 = 'VAR2'
                                           attr3 = 'VAR3'
                                           attr4 = 'VAR4' ).

  endmethod.
  method if_message~get_longtext.

    result = cl_message_helper=>get_longtext_for_message( text = me
                                                          preserve_newlines = preserve_newlines ).

  endmethod.
  method if_message~get_text.

    result = cl_message_helper=>get_text_for_message( me ).

  endmethod.
  method send.

    message me type me->type.

  endmethod.
  method send_like.

    message me type me->type display like i_type.

  endmethod.
  method display.

    message me type 'S' display like me->type.

  endmethod.
  method display_immediately.

    message me type 'I' display like me->type.

  endmethod.

endclass.
