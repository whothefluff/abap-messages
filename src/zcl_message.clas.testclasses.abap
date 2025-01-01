*"* use this source file for your ABAP unit test classes

class _xco_msg_stub definition ##CLASS_FINAL
                    create public
                    for testing.

  public section.

    interfaces: if_xco_message partially implemented.

    methods constructor
              importing
                i_value type symsg.

endclass.
class _xco_msg_stub implementation.

  method constructor.

    if_xco_message~value = i_value.

  endmethod.
  method if_xco_message~write_to_t100_dyn_msg.

    return.

  endmethod.

endclass.

class _xco_message_spy definition ##CLASS_FINAL
                       create public
                       for testing.

  public section.

    interfaces: if_xco_message partially implemented.

    data last_t100_dyn_msg type ref to if_t100_dyn_msg read-only.

endclass.
class _xco_message_spy implementation.

  method if_xco_message~write_to_t100_dyn_msg.

    last_t100_dyn_msg = io_t100_dyn_msg.

  endmethod.

endclass.

class _ definition deferred.

class zcl_message definition local friends _.

class _ definition
        final
        for testing
        risk level harmless
        duration short.

  private section.

    class-methods class_setup.

    methods setup.

    methods const_sets_attr for testing.

    "! Verifies a side-effect, which is why it's a separate test
    methods const_calls_xco_wtm_w_self for testing.

    methods content_returns_msg_stmt_txt for testing.

    methods longtext_returns_bapi_txt for testing.

    methods type_returns_attribute for testing.

    methods variables_returns_attribute for testing.

    methods get_stxt_delegates_content for testing.

    methods get_ltxt_delegates_longtext for testing.

    methods xco_get_msgs_delegates for testing.

    methods xco_get_stxt_delegates for testing.

    methods xco_get_txt_delegates for testing.

    methods xco_get_type_delegates for testing.

    methods xco_overwrite_delegates for testing.

    methods xco_place_string_delegates for testing.

    methods xco_wtm_delegates for testing.

    class-methods class_teardown.

    class-data _xco_msg_fty_backup type ref to zcl_xco_msg_fty.

endclass.
class _ implementation.

  method class_setup.

    _xco_msg_fty_backup = zcl_message=>_xco_msg_fty.

  endmethod.
  method setup.

    zcl_message=>_xco_msg_fty = _xco_msg_fty_backup.

  endmethod.
  method const_sets_attr.

    "arrange
    final(vars) = value zcl_message=>t_variables( msgid = 1
                                                  msgno = 2
                                                  msgty = 3
                                                  msgv1 = 4
                                                  msgv2 = 5
                                                  msgv3 = 6
                                                  msgv4 = 7 ).

    final(type_stub) = cast zif_message_type( cl_abap_testdouble=>create( 'ZIF_MESSAGE_TYPE' ) ).

    final(rap_severity) = if_abap_behv_message=>severity-warning.

    cl_abap_testdouble=>configure_call( type_stub )->returning( vars-msgty ).

    type_stub->old( ).

    cl_abap_testdouble=>configure_call( type_stub )->returning( rap_severity ).

    type_stub->rap( ).

    final(some_val) = value symsg( msgv1 = 'test' ).

    final(xco_msg_stub) = cast if_xco_message( new _xco_msg_stub( some_val ) ).

    final(xco_fty_td) = cast zcl_xco_msg_fty( cl_abap_testdouble=>create( 'ZCL_XCO_MSG_FTY' ) ).

    cl_abap_testdouble=>configure_call( xco_fty_td )->returning( xco_msg_stub ).

    xco_fty_td->for( vars ).

    zcl_message=>_xco_msg_fty = xco_fty_td.

    "act
    final(o) = new zcl_message( i_id = vars-msgid
                                i_number = vars-msgno
                                i_type = type_stub
                                i_var1 = vars-msgv1
                                i_var2 = vars-msgv2
                                i_var3 = vars-msgv3
                                i_var4 = vars-msgv4 ).

    "assert
    cl_abap_unit_assert=>assert_true( act = xsdbool( o->_variables eq vars
                                                     and o->_xco eq xco_msg_stub
                                                     and cast if_abap_behv_message( o )->m_severity eq rap_severity
                                                     and o->_type eq type_stub
                                                     and o->if_xco_message~value eq some_val ) ).

  endmethod.
  method const_calls_xco_wtm_w_self.

    "arrange
    final(xco_spy) = new _xco_message_spy( ).

    final(fty_td) = cast zcl_xco_msg_fty( cl_abap_testdouble=>create( 'ZCL_XCO_MSG_FTY' ) ).

    cl_abap_testdouble=>configure_call( fty_td )->ignore_all_parameters( )->returning( xco_spy ).

    fty_td->for( value #( ) ).

    zcl_message=>_xco_msg_fty = fty_td.

    final(type_stub) = cast zif_message_type( cl_abap_testdouble=>create( 'ZIF_MESSAGE_TYPE' ) ).

    "act
    final(o) = new zcl_message( i_id = value #( )
                                i_number = value #( )
                                i_type = type_stub ).

    "assert
    cl_abap_unit_assert=>assert_equals( exp = o
                                        act = xco_spy->last_t100_dyn_msg ).

  endmethod.
  method content_returns_msg_stmt_txt.

    "arrange
    final(var1) = 'ex1'.

    final(var3) = 'ex2'.

    message e999(ZMSG) with var1 '' var3 into final(t).

    final(type_stub) = cast zif_message_type( cl_abap_testdouble=>create( 'ZIF_MESSAGE_TYPE' ) ).

    cl_abap_testdouble=>configure_call( type_stub )->returning( 'E' ).

    type_stub->old( ).

    final(o) = new zcl_message( i_id = 'ZMSG'
                                i_number = 999
                                i_type = type_stub
                                i_var1 = exact #( var1 )
                                i_var3 = exact #( var3 ) ).

    "act & assert
    cl_abap_unit_assert=>assert_equals( exp = t
                                        act = o->content( ) ).

  endmethod.
  method longtext_returns_bapi_txt.

    "arrange
    types text type standard table of bapitgb with default key.

    data(text) = value text( ).

    call function 'BAPI_MESSAGE_GETDETAIL'
      exporting
        id         = 'ZMSG'
        number     = 999
        textformat = 'ASC'
      tables
        text       = text.

    final(type_stub) = cast zif_message_type( cl_abap_testdouble=>create( 'ZIF_MESSAGE_TYPE' ) ).

    final(o) = new zcl_message( i_id = 'ZMSG'
                                i_number = 999
                                i_type = type_stub ).

    "act & assert
    cl_abap_unit_assert=>assert_equals( exp = concat_lines_of( table = value string_table( for <e> in text
                                                                                           ( conv #( <e>-line ) ) )
                                                               sep = ` ` )
                                        act = o->long_text( i_preserving_line_breaks = abap_false ) ).

    cl_abap_unit_assert=>assert_equals( exp = concat_lines_of( table = value string_table( for <e> in text
                                                                                           ( conv #( <e>-line ) ) )
                                                               sep = cl_abap_char_utilities=>newline )
                                        act = o->long_text( i_preserving_line_breaks = abap_true ) ).

  endmethod.
  method type_returns_attribute.

    "arrange
    final(type_stub) = cast zif_message_type( cl_abap_testdouble=>create( 'ZIF_MESSAGE_TYPE' ) ).

    cl_abap_testdouble=>configure_call( type_stub )->returning( 'E' ).

    type_stub->old( ).

    final(o) = new zcl_message( i_id = 'ZMSG'
                                i_number = 999
                                i_type = type_stub ).

    "act & assert
    cl_abap_unit_assert=>assert_equals( exp = type_stub
                                        act = o->type( ) ).

  endmethod.
  method variables_returns_attribute.

    "arrange
    final(type_stub) = cast zif_message_type( cl_abap_testdouble=>create( 'ZIF_MESSAGE_TYPE' ) ).

    cl_abap_testdouble=>configure_call( type_stub )->returning( 'E' ).

    type_stub->old( ).

    final(o) = new zcl_message( i_id = 'ZMSG'
                                i_number = 999
                                i_type = type_stub
                                i_var3 = 'varvarvar' ).

    "act & assert
    cl_abap_unit_assert=>assert_equals( exp = value zcl_message=>t_variables( msgid = 'ZMSG'
                                                                              msgno = 999
                                                                              msgty = 'E'
                                                                              msgv3 = 'varvarvar' )
                                        act = o->variables( ) ).

  endmethod.
  method get_ltxt_delegates_longtext.

    "arrange
    final(type_stub) = cast zif_message_type( cl_abap_testdouble=>create( 'ZIF_MESSAGE_TYPE' ) ).

    cl_abap_testdouble=>configure_call( type_stub )->returning( 'E' ).

    type_stub->old( ).

    final(o) = new zcl_message( i_id = 'ZMSG'
                                i_number = 999
                                i_type = type_stub ).

    "act & assert
    cl_abap_unit_assert=>assert_equals( exp = o->long_text( )
                                        act = cast if_message( o )->get_longtext( ) ).

  endmethod.
  method get_stxt_delegates_content.

    "arrange
    final(type_stub) = cast zif_message_type( cl_abap_testdouble=>create( 'ZIF_MESSAGE_TYPE' ) ).

    cl_abap_testdouble=>configure_call( type_stub )->returning( 'E' ).

    type_stub->old( ).

    final(o) = new zcl_message( i_id = 'ZMSG'
                                i_number = 999
                                i_type = type_stub ).

    "act & assert
    cl_abap_unit_assert=>assert_equals( exp = o->content( )
                                        act = cast if_message( o )->get_text( ) ).

  endmethod.
  method xco_get_msgs_delegates.

    "arrange
    final(xco_stub) = cast if_xco_message( cl_abap_testdouble=>create( 'IF_XCO_MESSAGE' ) ).

    final(some_messages) = value sxco_t_messages( ( xco_stub ) ).

    cl_abap_testdouble=>configure_call( xco_stub )->returning( some_messages )->and_expect( )->is_called_once( ).

    xco_stub->if_xco_news~get_messages( ).

    final(type_stub) = cast zif_message_type( cl_abap_testdouble=>create( 'ZIF_MESSAGE_TYPE' ) ).

    cl_abap_testdouble=>configure_call( type_stub )->returning( 'E' ).

    type_stub->old( ).

    final(o) = new zcl_message( i_id = 'ZMSG'
                                i_number = 999
                                i_type = type_stub ).

    o->_xco = xco_stub.

    "act & assert
    cl_abap_unit_assert=>assert_equals( exp = some_messages
                                        act = cast if_xco_news( o )->get_messages( ) ).

  endmethod.
  method xco_get_stxt_delegates.

    "arrange
    final(some_short_text) = cast if_xco_message_short_text( cl_abap_testdouble=>create( 'IF_XCO_MESSAGE_SHORT_TEXT' ) ).

    final(xco_stub) = cast if_xco_message( cl_abap_testdouble=>create( 'IF_XCO_MESSAGE' ) ).

    cl_abap_testdouble=>configure_call( xco_stub )->returning( some_short_text )->and_expect( )->is_called_once( ).

    xco_stub->get_short_text( ).

    final(type_stub) = cast zif_message_type( cl_abap_testdouble=>create( 'ZIF_MESSAGE_TYPE' ) ).

    cl_abap_testdouble=>configure_call( type_stub )->returning( 'E' ).

    type_stub->old( ).

    final(o) = new zcl_message( i_id = 'ZMSG'
                                i_number = 999
                                i_type = type_stub ).

    o->_xco = xco_stub.

    "act & assert
    cl_abap_unit_assert=>assert_equals( exp = some_short_text
                                        act = cast if_xco_message( o )->get_short_text( ) ).

  endmethod.
  method xco_get_txt_delegates.

    "arrange
    final(some_text) = `ads asdfkajñklñ jñkljaj`.

    final(xco_stub) = cast if_xco_message( cl_abap_testdouble=>create( 'IF_XCO_MESSAGE' ) ).

    cl_abap_testdouble=>configure_call( xco_stub )->returning( some_text )->and_expect( )->is_called_once( ).

    xco_stub->get_text( ).

    final(type_stub) = cast zif_message_type( cl_abap_testdouble=>create( 'ZIF_MESSAGE_TYPE' ) ).

    cl_abap_testdouble=>configure_call( type_stub )->returning( 'E' ).

    type_stub->old( ).

    final(o) = new zcl_message( i_id = 'ZMSG'
                                i_number = 999
                                i_type = type_stub ).

    o->_xco = xco_stub.

    "act & assert
    cl_abap_unit_assert=>assert_equals( exp = some_text
                                        act = cast if_xco_message( o )->get_text( ) ).

  endmethod.
  method xco_get_type_delegates.

    "arrange
    final(some_type) = xco_cp_message=>type->for( 'S' ).

    final(xco_stub) = cast if_xco_message( cl_abap_testdouble=>create( 'IF_XCO_MESSAGE' ) ).

    cl_abap_testdouble=>configure_call( xco_stub )->returning( some_type )->and_expect( )->is_called_once( ).

    xco_stub->get_type( ).

    final(type_stub) = cast zif_message_type( cl_abap_testdouble=>create( 'ZIF_MESSAGE_TYPE' ) ).

    cl_abap_testdouble=>configure_call( type_stub )->returning( 'E' ).

    type_stub->old( ).

    final(o) = new zcl_message( i_id = 'ZMSG'
                                i_number = 999
                                i_type = type_stub ).

    o->_xco = xco_stub.

    "act & assert
    cl_abap_unit_assert=>assert_equals( exp = some_type
                                        act = cast if_xco_message( o )->get_type( ) ).

  endmethod.
  method xco_overwrite_delegates.

    "arrange
    final(some_ovrwrt_msg) = cast if_xco_message( cl_abap_testdouble=>create( 'IF_XCO_MESSAGE' ) ).

    final(xco_stub) = cast if_xco_message( cl_abap_testdouble=>create( 'IF_XCO_MESSAGE' ) ).

    final(msgty) = 'E'.

    final(msgid) = conv symsgid( 'TEST' ).

    final(msgno) = conv symsgno( '123' ).

    final(msgv1) = conv symsgv( 'V1' ).

    final(msgv2) = conv symsgv( 'V2' ).

    final(msgv3) = conv symsgv( 'V3' ).

    final(msgv4) = conv symsgv( 'V4' ).

    cl_abap_testdouble=>configure_call( xco_stub )->returning( some_ovrwrt_msg ).

    xco_stub->overwrite( iv_msgty = msgty
                         iv_msgid = msgid
                         iv_msgno = msgno
                         iv_msgv1 = msgv1
                         iv_msgv2 = msgv2
                         iv_msgv3 = msgv3
                         iv_msgv4 = msgv4 ).

    final(type_stub) = cast zif_message_type( cl_abap_testdouble=>create( 'ZIF_MESSAGE_TYPE' ) ).

    cl_abap_testdouble=>configure_call( type_stub )->returning( 'E' ).

    type_stub->old( ).

    final(o) = new zcl_message( i_id = 'ZMSG'
                                i_number = 999
                                i_type = type_stub ).

    o->_xco = xco_stub.

    "act & assert
    cl_abap_unit_assert=>assert_equals( exp = some_ovrwrt_msg
                                        act = cast if_xco_message( o )->overwrite( iv_msgty = msgty
                                                                                   iv_msgid = msgid
                                                                                   iv_msgno = msgno
                                                                                   iv_msgv1 = msgv1
                                                                                   iv_msgv2 = msgv2
                                                                                   iv_msgv3 = msgv3
                                                                                   iv_msgv4 = msgv4 ) ).

  endmethod.
  method xco_place_string_delegates.

    "arrange
    final(some_string) = cast if_xco_message( cl_abap_testdouble=>create( 'IF_XCO_MESSAGE' ) ).

    final(xco_stub) = cast if_xco_message( cl_abap_testdouble=>create( 'IF_XCO_MESSAGE' ) ).

    cl_abap_testdouble=>configure_call( xco_stub )->returning( some_string ).

    xco_stub->place_string( iv_string = `test`
                            iv_msgv1 = abap_false
                            iv_msgv2 = abap_false
                            iv_msgv3 = abap_false
                            iv_msgv4 = abap_false ).

    final(type_stub) = cast zif_message_type( cl_abap_testdouble=>create( 'ZIF_MESSAGE_TYPE' ) ).

    cl_abap_testdouble=>configure_call( type_stub )->returning( 'E' ).

    type_stub->old( ).

    final(o) = new zcl_message( i_id = 'ZMSG'
                                i_number = 999
                                i_type = type_stub ).

    o->_xco = xco_stub.

    "act & assert
    cl_abap_unit_assert=>assert_equals( exp = some_string
                                        act = cast if_xco_message( o )->place_string( `test` ) ).

  endmethod.
  method xco_wtm_delegates.

    "arrange
    final(xco_stub) = cast if_xco_message( cl_abap_testdouble=>create( 'IF_XCO_MESSAGE' ) ).

    final(dyn_msg) = cast if_t100_dyn_msg( cl_abap_testdouble=>create( 'IF_T100_DYN_MSG' ) ).

    cl_abap_testdouble=>configure_call( xco_stub )->and_expect( )->is_called_once( ).

    xco_stub->write_to_t100_dyn_msg( dyn_msg ).

    final(type_stub) = cast zif_message_type( cl_abap_testdouble=>create( 'ZIF_MESSAGE_TYPE' ) ).

    cl_abap_testdouble=>configure_call( type_stub )->returning( 'E' ).

    type_stub->old( ).

    final(o) = new zcl_message( i_id = 'ZMSG'
                                i_number = 999
                                i_type = type_stub ).

    o->_xco = xco_stub.

    "act
    cast if_xco_message( o )->write_to_t100_dyn_msg( dyn_msg ).

    "assert
    cl_abap_testdouble=>verify_expectations( xco_stub ).

  endmethod.
  method class_teardown.

    zcl_message=>_xco_msg_fty = _xco_msg_fty_backup.

  endmethod.

endclass.
