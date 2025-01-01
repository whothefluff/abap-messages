*"* use this source file for your ABAP unit test classes

class _fty_spy definition ##CLASS_FINAL
               inheriting from zcl_message_fty
               create public
               for testing.

  public section.

    data last_free_text type string.

    data last_type type ref to zif_message_type.

    methods from_string redefinition.

endclass.
class _fty_spy implementation.

  method from_string.

    last_free_text = i_free_text.

    last_type = i_type.

    return super->from_string( i_free_text ).

  endmethod.

endclass.

class _ definition deferred.

class zcl_message_fty definition local friends _.

class _ definition
        final
        for testing
        risk level harmless
        duration short.

  private section.

    methods constr_sets_attr for testing.

    methods from_str_strct_long_throws for testing.

    methods from_txt_symbol_calls_from_str for testing.

endclass.
class _ implementation.

  method constr_sets_attr.

    "act
    final(o) = new zcl_message_fty( ).

    "assert
    cl_abap_unit_assert=>assert_true( xsdbool( o->_type_fty is bound
                                               and o->_msg_vars_reader is bound
                                               and o->_error_msg_vars_reader is bound
                                               and o->_type_severities is bound ) ).

  endmethod.
  method from_str_strct_long_throws.

    "arrange
    final(long_text) = repeat( val = `A`
                               occ = 201 ).

    final(fty) = new zcl_message_fty( ).

    "act
    try.

      fty->from_string_strict( long_text ).

    catch cx_sy_conversion_data_loss into final(e).

    endtry.

    "assert
    cl_abap_unit_assert=>assert_bound( e ).

  endmethod.
  method from_txt_symbol_calls_from_str.

    "arrange
    final(fty_spy) = new _fty_spy( ).

    final(msg_type_stub) = cast zif_message_type( cl_abap_testdouble=>create( 'ZIF_MESSAGE_TYPE' ) ).

    "act
    fty_spy->from_text_symbol( i_text_symbol = 'abc &1 &2 &3 &4'
                               i_type = msg_type_stub
                               i_placeholder1 = '1'
                               i_placeholder2 = '2'
                               i_placeholder3 = '3'
                               i_placeholder4 = '4' ).

    "assert
    cl_abap_unit_assert=>assert_true( xsdbool( fty_spy->last_free_text eq 'abc 1 2 3 4'
                                               and fty_spy->last_type eq msg_type_stub ) ).

  endmethod.

endclass.
