"! <p class="shorttext synchronized" lang="EN">Message</p>
"!
"! <p>
"! Specializations {@link ZCL_FREE_MESSAGE} and
"! {@link ZCL_SY_MESSAGE} are easier to use in certain contexts
"! </p>
"! All methods implemented assuming the instances are immutable
class zcl_message definition
                  public
                  create public.

  public section.

    interfaces: if_abap_behv_message,
                if_xco_message.

    types t_variables type symsg.

    class-methods class_constructor.

    "! <p class="shorttext synchronized" lang="EN">Creates a T100 message</p>
    "!
    "! @parameter i_id | <p class="shorttext synchronized" lang="EN">Message class</p>
    "! @parameter i_number | <p class="shorttext synchronized" lang="EN">Message number</p>
    "! @parameter i_type | <p class="shorttext synchronized" lang="EN">Type</p>
    "! @parameter i_var1 | <p class="shorttext synchronized" lang="EN">Variable</p>
    "! @parameter i_var2 | <p class="shorttext synchronized" lang="EN">Variable</p>
    "! @parameter i_var3 | <p class="shorttext synchronized" lang="EN">Variable</p>
    "! @parameter i_var4 | <p class="shorttext synchronized" lang="EN">Variable</p>
    methods constructor
              importing
                i_id type zcl_message=>t_variables-msgid
                i_number type zcl_message=>t_variables-msgno
                i_type type ref to zif_message_type default zcl_message_type_fty=>unspecified
                i_var1 type zcl_message=>t_variables-msgv1 optional
                i_var2 type zcl_message=>t_variables-msgv2 optional
                i_var3 type zcl_message=>t_variables-msgv3 optional
                i_var4 type zcl_message=>t_variables-msgv4 optional.

    "! <p class="shorttext synchronized" lang="EN">Returns this message's type</p>
    "!
    "! @parameter r_val | <p class="shorttext synchronized" lang="EN">Message type</p>
    methods type
              returning
                value(r_val) type ref to zif_message_type.

    "! <p class="shorttext synchronized" lang="EN">Returns this message's variables</p>
    "!
    "! @parameter r_val | <p class="shorttext synchronized" lang="EN">Classic message variables</p>
    methods variables
              returning
                value(r_val) type zcl_message=>t_variables.

    "! <p class="shorttext synchronized" lang="EN">Returns this message's content</p>
    "! Same as <strong>MESSAGE... INTO</strong>
    "!
    "! @parameter r_val | <p class="shorttext synchronized" lang="EN">Message text</p>
    methods content
              returning
                value(r_val) type string.

    "! <p class="shorttext synchronized" lang="EN">Returns this message's long text, if it exists</p>
    "! Only relevant for messages from message classes that are not "self-explanatory"
    "!
    "! @parameter i_preserving_line_breaks | <p class="shorttext synchronized" lang="EN">When false, line breaks are replaced by spaces</p>
    "! @parameter r_val | <p class="shorttext synchronized" lang="EN">Long text or empty</p>
    methods long_text
              importing
                i_preserving_line_breaks type xsdboolean default abap_false
              returning
                value(r_val) type string.

  protected section.

    class-data _xco_msg_fty type ref to zcl_xco_msg_fty.

    data _type type ref to zif_message_type.

    data _xco type ref to if_xco_message.

    data _variables type zcl_message=>t_variables.

endclass.
class zcl_message implementation.

  method class_constructor.

    _xco_msg_fty = new zcl_xco_msg_fty( ).

  endmethod.
  method constructor.

    _type = i_type.

    final(vars) = value t_variables( msgid = i_id
                                     msgno = i_number
                                     msgv1 = i_var1
                                     msgv2 = i_var2
                                     msgv3 = i_var3
                                     msgv4 = i_var4
                                     msgty = i_type->old( ) ). "FINAL is broken so method has to be last

    cast if_abap_behv_message( me )->m_severity = i_type->rap( ).

    final(xco_msg) = _xco_msg_fty->for( vars ).

    _variables = vars.

    xco_msg->write_to_t100_dyn_msg( me ).

    if_xco_message~value = xco_msg->value.

    _xco = xco_msg.

  endmethod.
  method if_message~get_longtext.

    "get long text only, to get everything as in standard exception implementation concatenate short and long
    return long_text( preserve_newlines ).

  endmethod.
  method if_message~get_text.

    return content( ).

  endmethod.
  method if_xco_news~get_messages.

    return cast if_xco_news( _xco )->get_messages( ).

  endmethod.
  method if_xco_message~get_short_text.

    return _xco->get_short_text( ).

  endmethod.
  method if_xco_message~get_text.

    return _xco->get_text( ).

  endmethod.
  method if_xco_message~get_type.

    return _xco->get_type( ).

  endmethod.
  method if_xco_message~overwrite.

    return _xco->overwrite( iv_msgty = iv_msgty
                            iv_msgid = iv_msgid
                            iv_msgno = iv_msgno
                            iv_msgv1 = iv_msgv1
                            iv_msgv2 = iv_msgv2
                            iv_msgv3 = iv_msgv3
                            iv_msgv4 = iv_msgv4 ).

  endmethod.
  method if_xco_message~place_string.

    return _xco->place_string( iv_string = iv_string
                               iv_msgv1 = abap_false
                               iv_msgv2 = abap_false
                               iv_msgv3 = abap_false
                               iv_msgv4 = abap_false ).

  endmethod.
  method if_xco_message~write_to_t100_dyn_msg.

    _xco->write_to_t100_dyn_msg( io_t100_dyn_msg ).

  endmethod.
  method content.

    return cl_message_helper=>get_text_for_message( me ).

  endmethod.
  method long_text.

    return condense( val = cl_message_helper=>get_longtext_for_message( text = me
                                                                        preserve_newlines = i_preserving_line_breaks
                                                                        t100_prepend_short = abap_false )
                     from = `` ).

  endmethod.
  method type.

    return _type.

  endmethod.
  method variables.

    return _variables.

  endmethod.

endclass.
