*"* use this source file for your ABAP unit test classes

class _sy_message definition ##CLASS_FINAL
                  inheriting from zcl_sy_message
                  create public
                  for testing.

  public section.

  protected section.

endclass.
class _sy_message implementation.

endclass.

class _ definition
        final
        for testing
        risk level harmless
        duration short.

  private section.

    methods set_sy_structure.

    class-methods class_setup.

    methods setup.

    methods constructor_sets_attr for testing.

    "! Technically testing the constructor of the super class, so it's not independent (but no other possibility)
    methods constructor_uses_type_fty for testing.

    class-methods class_teardown.

    class-data _type_fty_backup type ref to zcl_message_type_fty.

endclass.

class zcl_sy_message definition local friends _.

class _ implementation.

  method set_sy_structure.

    message e001(ZMSG) with 1 2 3 4 into final(dummy) ##NEEDED.

  endmethod.
  method class_setup.

    _type_fty_backup = zcl_sy_message=>_type_fty.

  endmethod.
  method setup.

    zcl_sy_message=>_type_fty = _type_fty_backup.

  endmethod.
  method constructor_sets_attr.

    "act
    final(o) = new zcl_sy_message( ).

    "assert
    cl_abap_unit_assert=>assert_bound( o->_type_fty ).

  endmethod.
  method constructor_uses_type_fty.

    "arrange
    final(type_fty) = cast zcl_message_type_fty( cl_abap_testdouble=>create( 'ZCL_MESSAGE_TYPE_FTY' ) ).

    final(some_type) = cast zif_message_type( cl_abap_testdouble=>create( 'ZIF_MESSAGE_TYPE' ) ).

    cl_abap_testdouble=>configure_call( type_fty )->returning( some_type ).

    type_fty->from_old( sy-msgty ).

    zcl_sy_message=>_type_fty = type_fty.

    "act
    final(o) = new zcl_sy_message( ).

    "assert
    cl_abap_unit_assert=>assert_equals( exp = some_type
                                        act = o->_type ).

  endmethod.
  method class_teardown.

    zcl_sy_message=>_type_fty = _type_fty_backup.

  endmethod.

endclass.
