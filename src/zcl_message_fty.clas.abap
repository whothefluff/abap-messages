"! <p class="shorttext synchronized" lang="EN">Message Factory</p>
"!
"! <p>Creates instances of {@link ZCL_MESSAGE}</p>
"!
"! Can be used instead of the sub-classes
class zcl_message_fty definition
                      public
                      create public.

  public section.

    class-methods class_constructor.

    "! <p class="shorttext synchronized" lang="EN">Returns a new message from the system structure</p>
    "!
    "! @parameter r_val | <p class="shorttext synchronized" lang="EN">New system message</p>
    methods from_system_message
              returning
                value(r_val) type ref to zcl_message.

    "! <p class="shorttext synchronized" lang="EN">Returns a new message from classic variables</p>
    "!
    "! Types are respected, except for 'A' and 'X' that become <em>error</em>
    "!
    "! @parameter i_variables | <p class="shorttext synchronized" lang="EN">Classic message variables</p>
    "! @parameter r_val | <p class="shorttext synchronized" lang="EN">New message</p>
    methods from_variables
              importing
                i_variables type zcl_message=>t_variables
              returning
                value(r_val) type ref to zcl_message.

    "! <p class="shorttext synchronized" lang="EN">Returns a new message from a free text</p>
    "!
    "! @parameter i_free_text | <p class="shorttext synchronized" lang="EN">Text up to 200 characters</p>
    "! @parameter i_type | <p class="shorttext synchronized" lang="EN">Type</p>
    "! @parameter r_val | <p class="shorttext synchronized" lang="EN">New free message</p>
    methods from_string
              importing
                i_free_text type string
                i_type type ref to zif_message_type default zcl_message_type_fty=>unspecified
              returning
                value(r_val) type ref to zcl_message.

    "! <p class="shorttext synchronized" lang="EN">Returns a new message from a free text</p>
    "!
    "! @parameter i_free_text | <p class="shorttext synchronized" lang="EN">Text up to 200 characters</p>
    "! @parameter i_type | <p class="shorttext synchronized" lang="EN">Type</p>
    "! @parameter r_val | <p class="shorttext synchronized" lang="EN">New free message</p>
    "! @raising cx_sy_conversion_data_loss | <p class="shorttext synchronized" lang="EN">New free message</p>
    methods from_string_strict
              importing
                i_free_text type string
                i_type type ref to zif_message_type default zcl_message_type_fty=>unspecified
              returning
                value(r_val) type ref to zcl_message
              raising
                cx_sy_conversion_data_loss.

    "! <p class="shorttext synchronized" lang="EN">Returns a new message from a text symbol</p>
    "!
    "! Replaces place-holders &1, &2, &3, and &4 if provided
    "!
    "! @parameter i_text_symbol | <p class="shorttext synchronized" lang="EN">Text symbol text</p>
    "! @parameter i_type | <p class="shorttext synchronized" lang="EN">Type</p>
    "! @parameter i_placeholder1 | <p class="shorttext synchronized" lang="EN">Value for '&1'</p>
    "! @parameter i_placeholder2 | <p class="shorttext synchronized" lang="EN">Value for '&2'</p>
    "! @parameter i_placeholder3 | <p class="shorttext synchronized" lang="EN">Value for '&3'</p>
    "! @parameter i_placeholder4 | <p class="shorttext synchronized" lang="EN">Value for '&4'</p>
    "! @parameter r_val | <p class="shorttext synchronized" lang="EN">New text symbol message</p>
    methods from_text_symbol
              importing
                i_text_symbol type zcl_text_symbol_message=>t_value
                i_type type ref to zif_message_type default zcl_message_type_fty=>unspecified
                i_placeholder1 type sy-msgv1 optional
                i_placeholder2 type sy-msgv2 optional
                i_placeholder3 type sy-msgv3 optional
                i_placeholder4 type sy-msgv4 optional
              returning
                value(r_val) type ref to zcl_message.

    "! <p class="shorttext synchronized" lang="EN">Returns a new message from an exception message</p>
    "!
    "! The type is whichever the exception has if it implements {@link IF_T100_DYN_MSG}, or error if it doesn't
    "!
    "! @parameter i_exception | <p class="shorttext synchronized" lang="EN">Exception with {@link IF_T100_MESSAGE} message</p>
    "! @parameter r_val | <p class="shorttext synchronized" lang="EN">New error message</p>
    "! @raising cx_sy_message_illegal_text | <p class="shorttext synchronized" lang="EN">Provided exception doesn't implement {@link IF_T100_MESSAGE}</p>
    methods from_exception
              importing
                i_exception type ref to cx_root
              returning
                value(r_val) type ref to zcl_message
              raising
                cx_sy_message_illegal_text.

    "! <p class="shorttext synchronized" lang="EN">Returns a new message from an existing message</p>
    "!
    "! <p>Allows changing the type</p>
    "!
    "! @parameter i_message | <p class="shorttext synchronized" lang="EN">Other message</p>
    "! @parameter i_new_type | <p class="shorttext synchronized" lang="EN">Type override</p>
    "! @parameter r_val | <p class="shorttext synchronized" lang="EN">New copy</p>
    methods clone
              importing
                i_message type ref to if_message
                i_new_type type ref to zif_message_type optional
              returning
                value(r_val) type ref to zcl_message.

    "! <p class="shorttext synchronized" lang="EN">Returns a new message from an XCO message</p>
    "!
    "! <p>Allows changing the type</p>
    "!
    "! @parameter i_message | <p class="shorttext synchronized" lang="EN">Other message</p>
    "! @parameter i_new_type | <p class="shorttext synchronized" lang="EN">Type override</p>
    "! @parameter r_val | <p class="shorttext synchronized" lang="EN">New copy</p>
    methods clone_xco
              importing
                i_message type ref to if_xco_message
                i_new_type type ref to zif_message_type optional
              returning
                value(r_val) type ref to zcl_message.

  protected section.

    class-data _type_fty type ref to zcl_message_type_fty.

    class-data _msg_vars_reader type ref to zcl_msg_vars_reader.

    class-data _error_msg_vars_reader type ref to zcl_msg_vars_reader.

    class-data _type_severities type ref to zcl_msg_type_severity_pairs.

endclass.
class zcl_message_fty implementation.

  method class_constructor.

    _type_fty = new zcl_message_type_fty( ).

    _msg_vars_reader = new zcl_msg_vars_reader( new zcl_msg_type_severity_pairs( i_severity_of_default = if_abap_behv_message=>severity-information
                                                                                 i_type_of_default = xco_cp_message=>type->information->value ) ).

    _error_msg_vars_reader = new zcl_msg_vars_reader( new zcl_msg_type_severity_pairs( i_severity_of_default = if_abap_behv_message=>severity-error
                                                                                       i_type_of_default = xco_cp_message=>type->error->value ) ).

    _type_severities = new zcl_msg_type_severity_pairs( ).

  endmethod.
  method from_system_message.

    final(vars) = _msg_vars_reader->read_system( xco_cp=>sy ).

    return new zcl_message( i_id = vars-msgid
                            i_number = vars-msgno
                            i_type = _type_fty->from_old( vars-msgty )
                            i_var1 = vars-msgv1
                            i_var2 = vars-msgv2
                            i_var3 = vars-msgv3
                            i_var4 = vars-msgv4 ).

  endmethod.
  method from_variables.

    return new zcl_message( i_id = i_variables-msgid
                            i_number = i_variables-msgno
                            i_type = _type_fty->from_old( _type_severities->clean_type( i_variables-msgty ) )
                            i_var1 = i_variables-msgv1
                            i_var2 = i_variables-msgv2
                            i_var3 = i_variables-msgv3
                            i_var4 = i_variables-msgv4 ).

  endmethod.
  method from_string.

    types: begin of free_text_as_t100_message,
             part1 like if_t100_dyn_msg=>msgv1,
             part2 like if_t100_dyn_msg=>msgv2,
             part3 like if_t100_dyn_msg=>msgv3,
             part4 like if_t100_dyn_msg=>msgv4,
           end of free_text_as_t100_message.

    final(free_text_as_t100_message) = conv free_text_as_t100_message( i_free_text ) ##OPERATOR[CONV].

    return new zcl_message( i_id = 'ZMSG'
                            i_number = 001
                            i_type = i_type
                            i_var1 = free_text_as_t100_message-part1
                            i_var2 = free_text_as_t100_message-part2
                            i_var3 = free_text_as_t100_message-part3
                            i_var4 = free_text_as_t100_message-part4 ).

  endmethod.
  method from_string_strict.

    types: begin of free_text_as_t100_message,
             part1 like if_t100_dyn_msg=>msgv1,
             part2 like if_t100_dyn_msg=>msgv2,
             part3 like if_t100_dyn_msg=>msgv3,
             part4 like if_t100_dyn_msg=>msgv4,
           end of free_text_as_t100_message.

    return cond #( when strlen( i_free_text ) le 200
                   then let free_text_as_t100_message = conv free_text_as_t100_message( i_free_text ) in ##OPERATOR[CONV]
                        new zcl_message( i_id = 'ZMSG'
                                         i_number = 001
                                         i_type = i_type
                                         i_var1 = free_text_as_t100_message-part1
                                         i_var2 = free_text_as_t100_message-part2
                                         i_var3 = free_text_as_t100_message-part3
                                         i_var4 = free_text_as_t100_message-part4 )
                   else throw cx_sy_conversion_data_loss( value = i_free_text ) ).

  endmethod.
  method from_text_symbol.

    return from_string( i_free_text = replace( val = replace( val = replace( val = replace( val = i_text_symbol
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

    final(vars) = _error_msg_vars_reader->read_basic( i_exception ).

    return new zcl_message( i_id = vars-msgid
                            i_number = vars-msgno
                            i_type = _type_fty->from_old( vars-msgty )
                            i_var1 = vars-msgv1
                            i_var2 = vars-msgv2
                            i_var3 = vars-msgv3
                            i_var4 = vars-msgv4 ).

  endmethod.
  method clone.

    final(vars) = _msg_vars_reader->read_basic( i_message ).

    return new zcl_message( i_id = vars-msgid
                            i_number = vars-msgno
                            i_type = cond #( when i_new_type is bound
                                             then i_new_type
                                             else _type_fty->from_old( vars-msgty ) )
                            i_var1 = vars-msgv1
                            i_var2 = vars-msgv2
                            i_var3 = vars-msgv3
                            i_var4 = vars-msgv4 ).

  endmethod.
  method clone_xco.

    return new zcl_message( i_id = i_message->value-msgid
                            i_number = i_message->value-msgno
                            i_type = cond #( when i_new_type is bound
                                             then i_new_type
                                             else _type_fty->from_xco( i_message->get_type( ) ) )
                            i_var1 = i_message->value-msgv1
                            i_var2 = i_message->value-msgv2
                            i_var3 = i_message->value-msgv3
                            i_var4 = i_message->value-msgv4 ).

  endmethod.

endclass.
