*"* use this source file for your ABAP unit test classes

class _msg_vars_reader_r_basic_stub definition ##CLASS_FINAL
                                    inheriting from zcl_msg_vars_reader
                                    create public
                                    for testing.

  public section.

    types: begin of t_args,
             begin of expected,
               msg type ref to if_message,
             end of expected,
             canned_answer type symsg,
           end of t_args.

    methods constructor
              importing
                i_args type _msg_vars_reader_r_basic_stub=>t_args.

    methods read_basic redefinition.

  protected section.

    data _args type _msg_vars_reader_r_basic_stub=>t_args.

endclass.
class _msg_vars_reader_r_basic_stub implementation.

  method constructor.

    super->constructor( value #( ) ).

    _args = i_args.

  endmethod.
  method read_basic.

    return cond #( when i_msg eq _args-expected-msg
                   then _args-canned_answer ).

  endmethod.

endclass.

class _type_fty_from_old_stub definition ##CLASS_FINAL
                              inheriting from zcl_message_type_fty
                              create public
                              for testing.

  public section.

    types: begin of t_args,
             begin of expected,
               old type sy-msgty,
             end of expected,
             canned_answer type ref to zif_message_type,
           end of t_args.

    methods constructor
              importing
                i_args type _type_fty_from_old_stub=>t_args.

    methods from_old redefinition.

  protected section.

    data _args type _type_fty_from_old_stub=>t_args.

endclass.
class _type_fty_from_old_stub implementation.

  method constructor.

    super->constructor( ).

    _args = i_args.

  endmethod.
  method from_old.

    return cond #( when i_old eq _args-expected-old
                   then _args-canned_answer ).

  endmethod.

endclass.

class _message_aggr_size_stub definition ##CLASS_FINAL
                              inheriting from zcl_message_aggr
                              create public
                              for testing.

  public section.

    types t_canned_answer type i.

    methods constructor
              importing
                i_canned_answer type _message_aggr_size_stub=>t_canned_answer.

    methods size redefinition.

  protected section.

    data _canned_answer type _message_aggr_size_stub=>t_canned_answer.

endclass.
class _message_aggr_size_stub implementation.

  method constructor.

    super->constructor( value #( ) ).

    _canned_answer = i_canned_answer.

  endmethod.
  method size.

    return _canned_answer.

  endmethod.

endclass.

class _message_aggr_list_stub definition ##CLASS_FINAL
                              inheriting from zcl_message_aggr
                              create public
                              for testing.

  public section.

    types t_canned_answer type zcl_message_aggr=>t_list.

    methods constructor
              importing
                i_canned_answer type _message_aggr_list_stub=>t_canned_answer.

    methods list redefinition.

  protected section.

    data _canned_answer type _message_aggr_list_stub=>t_canned_answer.

endclass.
class _message_aggr_list_stub implementation.

  method constructor.

    super->constructor( value #( ) ).

    _canned_answer = i_canned_answer.

  endmethod.
  method list.

    return _canned_answer.

  endmethod.

endclass.

class _ definition deferred.

class zcl_message_aggr definition local friends _.

"! <p class="shorttext synchronized" lang="EN">Tests</p>
class _ definition
        final
        for testing
        risk level harmless
        duration short.

  private section.

    class-methods class_setup.

    methods setup.

    methods class_constructor_sets_attr for testing.

    methods constructor_sets_attr for testing.

    "! Technically testing the constructor of the super class, so it's not independent (but no other possibility)
    methods constructor_uses_default_msg for testing.

    methods list_rets_attr for testing.

    methods is_empty_rets_true_for_no_size for testing.

    methods is_empty_rets_false_for_size for testing.

    methods size_rets_lines_of_list for testing.

    class-methods class_teardown.

    class-data _type_fty_backup type ref to zcl_message_type_fty.

    class-data _msg_vars_reader_backup type ref to zcl_msg_vars_reader.

endclass.
class _ implementation.

  method class_setup.

    _type_fty_backup = zcl_message_aggr=>_type_fty.

    _msg_vars_reader_backup = zcl_message_aggr=>_msg_vars_reader.

  endmethod.
  method setup.

    zcl_message_aggr=>_type_fty = _type_fty_backup.

    zcl_message_aggr=>_msg_vars_reader = _msg_vars_reader_backup.

  endmethod.
  method class_constructor_sets_attr.

    "assert
    cl_abap_unit_assert=>assert_true( xsdbool( zcl_message_aggr=>_type_fty is bound
                                               and zcl_message_aggr=>_msg_vars_reader is bound
                                               and zcl_message_aggr=>_fallback_for_default_msg is bound ) ).

  endmethod.
  method constructor_sets_attr.

    "arrange
    zcl_message_aggr=>_msg_vars_reader = new _msg_vars_reader_r_basic_stub( value #( ) ).

    final(some_list) = value zcl_message_aggr=>t_list( ( new zcl_message( i_id = 'ZMSG'
                                                                          i_number = 999 ) )
                                                       ( ) ).

    "act
    final(o) = new zcl_message_aggr( some_list ).

    "assert
    cl_abap_unit_assert=>assert_equals( exp = some_list
                                        act = o->_list ).

  endmethod.
  method constructor_uses_default_msg.

    "arrange
    final(some_default) = cast if_message( cl_abap_testdouble=>create( 'IF_MESSAGE' ) ).

    final(some_vars) = value symsg( msgid = 'TEST'
                                    msgno = 123
                                    msgty = 'Z'
                                    msgv1 = '1'
                                    msgv2 = '2'
                                    msgv3 = '3'
                                    msgv4 = '4' ).

    zcl_message_aggr=>_msg_vars_reader = new _msg_vars_reader_r_basic_stub( value #( expected = value #( msg = some_default )
                                                                                     canned_answer = some_vars ) ).

    final(some_type) = cast zif_message_type( cl_abap_testdouble=>create( 'ZIF_MESSAGE_TYPE' ) ).

    cl_abap_testdouble=>configure_call( some_type )->returning( some_vars-msgty ).

    some_type->old( ).

    zcl_message_aggr=>_type_fty = new _type_fty_from_old_stub( value #( expected = value #( old = some_vars-msgty )
                                                                        canned_answer = some_type ) ).

    "act
    final(o) = new zcl_message_aggr( i_default = some_default
                                     i_list = value #( ) ).

    "assert
    cl_abap_unit_assert=>assert_true( xsdbool( o->_variables eq some_vars
                                               and o->_type eq some_type ) ).

  endmethod.
  method list_rets_attr.

    "arrange
    zcl_message_aggr=>_msg_vars_reader = new _msg_vars_reader_r_basic_stub( value #( ) ).

    final(o) = new zcl_message_aggr( value #( ) ).

    final(some_list) = value zcl_message_aggr=>t_list( ( new zcl_message( i_id = 'ZMSG'
                                                                          i_number = 999 ) )
                                                       ( ) ).

    o->_list = some_list.

    "act & assert
    cl_abap_unit_assert=>assert_equals( exp = some_list
                                        act = o->list( ) ).

  endmethod.
  method is_empty_rets_true_for_no_size.

    "arrange
    zcl_message_aggr=>_msg_vars_reader = new _msg_vars_reader_r_basic_stub( value #( ) ).

    final(o) = new _message_aggr_size_stub( 0 ).

    "act & assert
    cl_abap_unit_assert=>assert_true( o->is_empty( ) ).

  endmethod.
  method is_empty_rets_false_for_size.

    "arrange
    zcl_message_aggr=>_msg_vars_reader = new _msg_vars_reader_r_basic_stub( value #( ) ).

    final(o) = new _message_aggr_size_stub( 1 ).

    "act & assert
    cl_abap_unit_assert=>assert_false( o->is_empty( ) ).

  endmethod.
  method size_rets_lines_of_list.

    "arrange
    zcl_message_aggr=>_msg_vars_reader = new _msg_vars_reader_r_basic_stub( value #( ) ).

    final(some_list) = value _message_aggr_list_stub=>t_canned_answer( ( )
                                                                       ( new zcl_message( i_id = 'ZMSG'
                                                                                          i_number = 999 ) )
                                                                       ( ) ).

    final(o) = new _message_aggr_list_stub( some_list ).

    "act & assert
    cl_abap_unit_assert=>assert_equals( exp = 3
                                        act = o->size( ) ).

  endmethod.
  method class_teardown.

    zcl_message_aggr=>_type_fty = _type_fty_backup.

    zcl_message_aggr=>_msg_vars_reader = _msg_vars_reader_backup.

  endmethod.

endclass.
