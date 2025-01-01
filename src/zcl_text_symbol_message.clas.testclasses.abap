*"* use this source file for your ABAP unit test classes

class _ definition
        final
        for testing
        risk level harmless
        duration short.

  private section.

    methods constr_uses_txt_replacing_v1 for testing.

    methods constr_uses_txt_replacing_v2 for testing.

    methods constr_uses_txt_replacing_v3 for testing.

    methods constr_uses_txt_replacing_v4 for testing.

    "! Technically testing the constructor of the super class, so it's not independent (but no other possibility)
    methods constr_uses_type_argument for testing.

    "! Technically testing the constructor of the super class, so it's not independent (but no other possibility)
    methods constr_uses_excifloss_argument for testing.

endclass.

class zcl_text_symbol_message definition local friends _.

class _ implementation.

  method constr_uses_txt_replacing_v1.

    "act
    final(o) = cast if_t100_dyn_msg( new zcl_text_symbol_message( i_text_symbol = 'some &1'
                                                                  i_placeholder1 = 'var' ) ).

    "assert
    cl_abap_unit_assert=>assert_equals( exp = 'some var'
                                        act = o->msgv1 ).

  endmethod.
  method constr_uses_txt_replacing_v2.

    "act
    final(o) = cast if_t100_dyn_msg( new zcl_text_symbol_message( i_text_symbol = 'some &2'
                                                                  i_placeholder2 = 'var' ) ).

    "assert
    cl_abap_unit_assert=>assert_equals( exp = 'some var'
                                        act = o->msgv1 ).

  endmethod.
  method constr_uses_txt_replacing_v3.

    "act
    final(o) = cast if_t100_dyn_msg( new zcl_text_symbol_message( i_text_symbol = 'some &3'
                                                                  i_placeholder3 = 'var' ) ).

    "assert
    cl_abap_unit_assert=>assert_equals( exp = 'some var'
                                        act = o->msgv1 ).

  endmethod.
  method constr_uses_txt_replacing_v4.

    "act
    final(o) = cast if_t100_dyn_msg( new zcl_text_symbol_message( i_text_symbol = 'some &4'
                                                                  i_placeholder4 = 'var' ) ).

    "assert
    cl_abap_unit_assert=>assert_equals( exp = 'some var'
                                        act = o->msgv1 ).

  endmethod.
  method constr_uses_type_argument.

    "arrange
    final(some_type) = cast zif_message_type( cl_abap_testdouble=>create( 'ZIF_MESSAGE_TYPE' ) ).

    "act
    final(o) = new zcl_text_symbol_message( i_text_symbol = value #( )
                                            i_type = some_type ).

    "assert
    cl_abap_unit_assert=>assert_equals( exp = some_type
                                        act = o->_type ).

  endmethod.
  method constr_uses_excifloss_argument.

    "arrange
    final(long_text) = exact zcl_text_symbol_message=>t_value( |&1&2&3{ repeat( val = `A`
                                                                                occ = 126 ) }| ).

    "act
    try.

      new zcl_text_symbol_message( i_text_symbol = long_text
                                   i_placeholder1 = repeat( val = `B`
                                                            occ = 50 )
                                   i_placeholder2 = repeat( val = `C`
                                                            occ = 25 )
                                   i_exc_if_data_loss = abap_true ).

    catch cx_sy_conversion_data_loss into final(e).

    endtry.

    "assert
    cl_abap_unit_assert=>assert_bound( e ).

  endmethod.

endclass.
