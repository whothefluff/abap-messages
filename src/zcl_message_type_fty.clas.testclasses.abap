*"* use this source file for your ABAP unit test classes

class _type definition ##CLASS_FINAL
            inheriting from message_type
            create public
            for testing.

  public section.

endclass.
class _type implementation.

endclass.

class _message_type definition
                    final
                    for testing
                    risk level harmless
                    duration short.

  private section.

    methods constructor_fills_components for testing.

endclass.
class _message_type implementation.

  method constructor_fills_components.

    "arrange
    final(some_val_type) = zif_message_type=>warning.

    final(some_old_type) = 'Z'.

    final(some_rap_type) = if_abap_behv_message=>severity-success.

    final(some_xco_type) = xco_cp_message=>type->error.

    "act
    final(type) = new _type( i_val = some_val_type
                             i_old = some_old_type
                             i_rap = some_rap_type
                             i_xco = some_xco_type ).

    "assert
    cl_abap_unit_assert=>assert_equals( exp = some_val_type
                                        act = type->val( )
                                        quit = if_abap_unit_constant=>quit-no ).

    cl_abap_unit_assert=>assert_equals( exp = some_old_type
                                        act = type->old( )
                                        quit = if_abap_unit_constant=>quit-no ).

    cl_abap_unit_assert=>assert_equals( exp = some_rap_type
                                        act = type->rap( )
                                        quit = if_abap_unit_constant=>quit-no ).

    cl_abap_unit_assert=>assert_equals( exp = some_xco_type
                                        act = type->xco( )
                                        quit = if_abap_unit_constant=>quit-no ).

  endmethod.

endclass.

class _ definition
        inheriting from zcl_message_type_fty
        final
        for testing
        risk level harmless
        duration short.

  private section.

    methods setup.

    methods success_instantiation for testing.

    methods information_instantiation for testing.

    methods warning_instantiation for testing.

    methods error_instantiation for testing.

    methods unspecified_instantiation for testing.

    methods equivalences_initialization for testing.

    methods from_val_uses_equiv_tab_data for testing.

    methods from_old_uses_equiv_tab_data for testing.

    methods from_old_notfound_usesdefaults for testing.

    methods from_old_notfound_throws_exc for testing.

    methods from_rap_uses_equiv_tab_data for testing.

    methods from_xco_uses_equiv_tab_data for testing.

    methods from_xco_notfound_usesdefaults for testing.

    methods from_xco_notfound_throws_exc for testing.

endclass.
class _ implementation.

  method setup.

    equivalences = _equivalences( ).

  endmethod.
  method success_instantiation.

    "assert
    cl_abap_unit_assert=>assert_equals( exp = zif_message_type=>success
                                        act = zcl_message_type_fty=>success->val( )
                                        quit = if_abap_unit_constant=>quit-no ).

    cl_abap_unit_assert=>assert_equals( exp = 'S'
                                        act = zcl_message_type_fty=>success->old( )
                                        quit = if_abap_unit_constant=>quit-no ).

    cl_abap_unit_assert=>assert_equals( exp = if_abap_behv_message=>severity-success
                                        act = zcl_message_type_fty=>success->rap( )
                                        quit = if_abap_unit_constant=>quit-no ).

    cl_abap_unit_assert=>assert_equals( exp = xco_cp_message=>type->success
                                        act = zcl_message_type_fty=>success->xco( )
                                        quit = if_abap_unit_constant=>quit-no ).

  endmethod.
  method information_instantiation.

    "assert
    cl_abap_unit_assert=>assert_equals( exp = zif_message_type=>information
                                        act = zcl_message_type_fty=>information->val( )
                                        quit = if_abap_unit_constant=>quit-no ).

    cl_abap_unit_assert=>assert_equals( exp = 'I'
                                        act = zcl_message_type_fty=>information->old( )
                                        quit = if_abap_unit_constant=>quit-no ).

    cl_abap_unit_assert=>assert_equals( exp = if_abap_behv_message=>severity-information
                                        act = zcl_message_type_fty=>information->rap( )
                                        quit = if_abap_unit_constant=>quit-no ).

    cl_abap_unit_assert=>assert_equals( exp = xco_cp_message=>type->information
                                        act = zcl_message_type_fty=>information->xco( )
                                        quit = if_abap_unit_constant=>quit-no ).

  endmethod.
  method warning_instantiation.

    "assert
    cl_abap_unit_assert=>assert_equals( exp = zif_message_type=>warning
                                        act = zcl_message_type_fty=>warning->val( )
                                        quit = if_abap_unit_constant=>quit-no ).

    cl_abap_unit_assert=>assert_equals( exp = 'W'
                                        act = zcl_message_type_fty=>warning->old( )
                                        quit = if_abap_unit_constant=>quit-no ).

    cl_abap_unit_assert=>assert_equals( exp = if_abap_behv_message=>severity-warning
                                        act = zcl_message_type_fty=>warning->rap( )
                                        quit = if_abap_unit_constant=>quit-no ).

    cl_abap_unit_assert=>assert_equals( exp = xco_cp_message=>type->warning
                                        act = zcl_message_type_fty=>warning->xco( )
                                        quit = if_abap_unit_constant=>quit-no ).

  endmethod.
  method error_instantiation.

    "assert
    cl_abap_unit_assert=>assert_equals( exp = zif_message_type=>error
                                        act = zcl_message_type_fty=>error->val( )
                                        quit = if_abap_unit_constant=>quit-no ).

    cl_abap_unit_assert=>assert_equals( exp = 'E'
                                        act = zcl_message_type_fty=>error->old( )
                                        quit = if_abap_unit_constant=>quit-no ).

    cl_abap_unit_assert=>assert_equals( exp = if_abap_behv_message=>severity-error
                                        act = zcl_message_type_fty=>error->rap( )
                                        quit = if_abap_unit_constant=>quit-no ).

    cl_abap_unit_assert=>assert_equals( exp = xco_cp_message=>type->error
                                        act = zcl_message_type_fty=>error->xco( )
                                        quit = if_abap_unit_constant=>quit-no ).

  endmethod.
  method unspecified_instantiation.

    "assert
    cl_abap_unit_assert=>assert_initial( act = zcl_message_type_fty=>unspecified->val( )
                                         quit = if_abap_unit_constant=>quit-no ).

    cl_abap_unit_assert=>assert_initial( act = zcl_message_type_fty=>unspecified->old( )
                                         quit = if_abap_unit_constant=>quit-no ).

    cl_abap_unit_assert=>assert_initial( act = zcl_message_type_fty=>unspecified->rap( )
                                         quit = if_abap_unit_constant=>quit-no ).

    cl_abap_unit_assert=>assert_initial( act = zcl_message_type_fty=>unspecified->xco( )
                                         quit = if_abap_unit_constant=>quit-no ).

  endmethod.
  method equivalences_initialization.

    "assert
    cl_abap_unit_assert=>assert_table_contains( line = value zcl_message_type_fty=>t_equivalence( val = zif_message_type=>error
                                                                                                  old = xco_cp_message=>type->error->value
                                                                                                  rap = if_abap_behv_message=>severity-error
                                                                                                  xco = xco_cp_message=>type->error
                                                                                                  ref = zcl_message_type_fty=>error )
                                                table = zcl_message_type_fty=>equivalences
                                                quit = if_abap_unit_constant=>quit-no ).

    cl_abap_unit_assert=>assert_table_contains( line = value zcl_message_type_fty=>t_equivalence( val = zif_message_type=>warning
                                                                                                  old = xco_cp_message=>type->warning->value
                                                                                                  rap = if_abap_behv_message=>severity-warning
                                                                                                  xco = xco_cp_message=>type->warning
                                                                                                  ref = zcl_message_type_fty=>warning )
                                                table = zcl_message_type_fty=>equivalences
                                                quit = if_abap_unit_constant=>quit-no ).

    cl_abap_unit_assert=>assert_table_contains( line = value zcl_message_type_fty=>t_equivalence( val = zif_message_type=>information
                                                                                                  old = xco_cp_message=>type->information->value
                                                                                                  rap = if_abap_behv_message=>severity-information
                                                                                                  xco = xco_cp_message=>type->information
                                                                                                  ref = zcl_message_type_fty=>information )
                                                table = zcl_message_type_fty=>equivalences
                                                quit = if_abap_unit_constant=>quit-no ).

    cl_abap_unit_assert=>assert_table_contains( line = value zcl_message_type_fty=>t_equivalence( val = zif_message_type=>success
                                                                                                  old = xco_cp_message=>type->success->value
                                                                                                  rap = if_abap_behv_message=>severity-success
                                                                                                  xco = xco_cp_message=>type->success
                                                                                                  ref = zcl_message_type_fty=>success )
                                                table = zcl_message_type_fty=>equivalences
                                                quit = if_abap_unit_constant=>quit-no ).

  endmethod.
  method from_old_uses_equiv_tab_data.

    "arrange
    final(some_entry) = value zcl_message_type_fty=>t_equivalence( old = 'I'
                                                                   ref = zcl_message_type_fty=>warning ).

    zcl_message_type_fty=>equivalences = value #( ( some_entry ) ).

    "act
    final(type) = new zcl_message_type_fty( )->from_old( some_entry-old ).

    "assert
    cl_abap_unit_assert=>assert_equals( exp = some_entry-ref
                                        act = type ).

  endmethod.
  method from_old_notfound_usesdefaults.

    "act
    final(type) = new zcl_message_type_fty( )->from_old( '%' ).

    "assert
    cl_abap_unit_assert=>assert_equals( exp = value zcl_message_type_fty=>t_equivalence( val = zif_message_type=>unspecified
                                                                                         old = value #( )
                                                                                         rap = if_abap_behv_message=>severity-none
                                                                                         xco = value #( ) )
                                        act = value zcl_message_type_fty=>t_equivalence( val = type->val( )
                                                                                         old = type->old( )
                                                                                         rap = type->rap( )
                                                                                         xco = type->xco( ) ) ).

  endmethod.
  method from_old_notfound_throws_exc.

    "act
    try.

      new zcl_message_type_fty( )->from_old( i_old = '%'
                                             i_exc_if_not_found = abap_true ).

    catch cx_sy_itab_line_not_found into final(e) ##NO_HANDLER.

    endtry.

    "assert
    cl_abap_unit_assert=>assert_bound( e ).

  endmethod.
  method from_rap_uses_equiv_tab_data.

    "arrange
    final(some_entry) = value zcl_message_type_fty=>t_equivalence( rap = if_abap_behv_message=>severity-success
                                                                   ref = zcl_message_type_fty=>error ).

    zcl_message_type_fty=>equivalences = value #( ( some_entry ) ).

    "act
    final(type) = new zcl_message_type_fty( )->from_rap( some_entry-rap ).

    "assert
    cl_abap_unit_assert=>assert_equals( exp = some_entry-ref
                                        act = type ).

  endmethod.
  method from_val_uses_equiv_tab_data.

    "arrange
    final(some_entry) = value zcl_message_type_fty=>t_equivalence( val = zif_message_type=>error
                                                                   ref = zcl_message_type_fty=>success ).

    zcl_message_type_fty=>equivalences = value #( ( some_entry ) ).

    "act
    final(type) = new zcl_message_type_fty( )->from_val( some_entry-val ).

    "assert
    cl_abap_unit_assert=>assert_equals( exp = some_entry-ref
                                        act = type ).

  endmethod.
  method from_xco_uses_equiv_tab_data.

    "arrange
    final(some_entry) = value zcl_message_type_fty=>t_equivalence( xco = xco_cp_message=>type->warning
                                                                   ref = zcl_message_type_fty=>information ).

    zcl_message_type_fty=>equivalences = value #( ( some_entry ) ).

    "act
    final(type) = new zcl_message_type_fty( )->from_xco( some_entry-xco ).

    "assert
    cl_abap_unit_assert=>assert_equals( exp = some_entry-ref
                                        act = type ).

  endmethod.
  method from_xco_notfound_usesdefaults.

    "act
    final(type) = new zcl_message_type_fty( )->from_xco( value #( ) ).

    "assert
    cl_abap_unit_assert=>assert_equals( exp = value zcl_message_type_fty=>t_equivalence( val = zif_message_type=>unspecified
                                                                                         old = value #( )
                                                                                         rap = if_abap_behv_message=>severity-none
                                                                                         xco = value #( ) )
                                        act = value zcl_message_type_fty=>t_equivalence( val = type->val( )
                                                                                         old = type->old( )
                                                                                         rap = type->rap( )
                                                                                         xco = type->xco( ) ) ).

  endmethod.
  method from_xco_notfound_throws_exc.

    "act
    try.

      new zcl_message_type_fty( )->from_xco( i_xco = value #( )
                                             i_exc_if_not_found = abap_true ).

    catch cx_sy_itab_line_not_found into final(e) ##NO_HANDLER.

    endtry.

    "assert
    cl_abap_unit_assert=>assert_bound( e ).

  endmethod.

endclass.
