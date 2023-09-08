"! <p class="shorttext synchronized" lang="EN">{@link ZCL_MESSAGE} factory</p>
class zcl_message_factory definition
                          public
                          create public.

  public section.

    "! <p class="shorttext synchronized" lang="EN">Returns a new message from the system structure</p>
    "!
    "! @parameter r_system_message | <p class="shorttext synchronized" lang="EN"></p>
    methods from_system_message
              returning
                value(r_system_message) type ref to if_t100_message.

    "! <p class="shorttext synchronized" lang="EN">Returns a new message from a free text</p>
    "!
    "! @parameter i_free_text | <p class="shorttext synchronized" lang="EN"></p>
    "! @parameter i_type | <p class="shorttext synchronized" lang="EN"></p>
    "! @parameter r_free_message | <p class="shorttext synchronized" lang="EN"></p>
    methods from_string
              importing
                i_free_text type string
                i_type type sy-msgty default zcl_message=>valid_type-information
              returning
                value(r_free_message) type ref to if_t100_message.

    "! <p class="shorttext synchronized" lang="EN">Returns a new message from a text symbol</p>
    "! Replaces placeholders &1, &2, &3, and &4 if provided
    "!
    "! @parameter i_text_symbol | <p class="shorttext synchronized" lang="EN"></p>
    "! @parameter i_type | <p class="shorttext synchronized" lang="EN"></p>
    "! @parameter i_placeholder1 | <p class="shorttext synchronized" lang="EN">Value for &1</p>
    "! @parameter i_placeholder2 | <p class="shorttext synchronized" lang="EN">Value for &2</p>
    "! @parameter i_placeholder3 | <p class="shorttext synchronized" lang="EN">Value for &3</p>
    "! @parameter i_placeholder4 | <p class="shorttext synchronized" lang="EN">Value for &4</p>
    "! @parameter r_text_symbol_message | <p class="shorttext synchronized" lang="EN"></p>
    methods from_text_symbol
              importing
                i_text_symbol type rs38m-itex132
                i_type type sy-msgty default zcl_message=>valid_type-information
                i_placeholder1 type sy-msgv1 optional
                i_placeholder2 type sy-msgv2 optional
                i_placeholder3 type sy-msgv3 optional
                i_placeholder4 type sy-msgv4 optional
              returning
                value(r_text_symbol_message) type ref to if_t100_message.

    "! <p class="shorttext synchronized" lang="EN">Returns a new message from an exception message</p>
    "!
    "! @parameter i_exception | <p class="shorttext synchronized" lang="EN">Exception with {@link IF_T100_MESSAGE} message</p>
    "! @parameter r_error_message | <p class="shorttext synchronized" lang="EN"></p>
    "! @raising cx_sy_message_illegal_text | <p class="shorttext synchronized" lang="EN">Provided exc. does not implement {@link IF_T100_MESSAGE}</p>
    methods from_exception
              importing
                i_exception type ref to cx_root
              returning
                value(r_error_message) type ref to if_t100_message
              raising
                cx_sy_message_illegal_text.

    "! <p class="shorttext synchronized" lang="EN">Returns a new message from an existing message</p>
    "!
    "! @parameter i_message | <p class="shorttext synchronized" lang="EN"></p>
    "! @parameter i_new_type | <p class="shorttext synchronized" lang="EN">Override type of original message</p>
    "! @parameter r_copied_message | <p class="shorttext synchronized" lang="EN"></p>
    methods clone
              importing
                i_message type ref to if_t100_message
                i_new_type type sy-msgty optional
              returning
                value(r_copied_message) type ref to if_t100_message.

endclass.
class zcl_message_factory implementation.

  method from_system_message.

    r_system_message = cast #( new zcl_message( i_id = sy-msgid
                                                i_number = sy-msgno
                                                i_type = sy-msgty
                                                i_var1 = sy-msgv1
                                                i_var2 = sy-msgv2
                                                i_var3 = sy-msgv3
                                                i_var4 = sy-msgv4 ) ).

  endmethod.
  method from_string.

    types: begin of free_text_as_t100_message,
             part1 like zcl_message=>var1,
             part2 like zcl_message=>var2,
             part3 like zcl_message=>var3,
             part4 like zcl_message=>var4,
           end of free_text_as_t100_message.

    data(free_text_as_t100_message) = conv free_text_as_t100_message( i_free_text ).

    r_free_message = cast #( new zcl_message( i_id = '00'
                                              i_number = 001
                                              i_type = i_type
                                              i_var1 = free_text_as_t100_message-part1
                                              i_var2 = free_text_as_t100_message-part2
                                              i_var3 = free_text_as_t100_message-part3
                                              i_var4 = free_text_as_t100_message-part4 ) ).

  endmethod.
  method from_text_symbol.

    r_text_symbol_message = me->from_string( i_free_text = replace( val = replace( val = replace( val = replace( val = i_text_symbol
                                                                                                                 sub = '&1'
                                                                                                                 with = i_placeholder1 )
                                                                                                  sub = '&2'
                                                                                                  with = i_placeholder2 )
                                                                                   sub = '&3'
                                                                                   with = i_placeholder3 )
                                                                    sub = '&4'
                                                                    with = i_placeholder4 ) 
                                             i_type = i_type ).

  endmethod.
  method from_exception.

    cl_message_helper=>set_msg_vars_for_if_t100_msg( cast #( i_exception ) ).

    sy-msgty = 'E'.

    r_error_message = me->from_system_message( ).

  endmethod.
  method clone.

    cl_message_helper=>set_msg_vars_for_if_t100_msg( i_message ).

    sy-msgty = cond #( when i_new_type is supplied
                       then i_new_type
                       else sy-msgty ).

    r_copied_message = me->from_system_message( ).

  endmethod.

endclass.
