"! <p class="shorttext synchronized" lang="EN">Integration Testing</p>
"!
"! @testing ZCL_MESSAGE_TYPE_FTY
"! @testing ZCL_MESSAGE
"! @testing ZCL_FREE_MESSAGE
"! @testing ZCL_TEXT_SYMBOL_MESSAGE
"! @testing ZCL_SY_MESSAGE
"! @testing ZCL_MESSAGE_FTY
"! @testing ZCL_MESSAGE_AGGR
class zcl_messages_it definition
                      public
                      create private
                      for testing
                      risk level harmless
                      duration short.

  public section.

    methods basic_message_content for testing.

    methods free_message_content for testing.

    methods text_symbol_message_content for testing.

    methods sy_message_content for testing.

    methods sy_message_reads_system_state for testing.

    methods fty_from_system_eqs_sy_msg for testing.

    methods fty_from_sys_msg_rets_vars for testing.

    methods fty_from_vars_rets_vars for testing.

    methods fty_from_vars_a_becomes_error for testing.

    methods fty_from_string_eqs_free_msg for testing.

    methods fty_from_str_rets_vars for testing.

    methods fty_from_str_strct_rets_vars for testing.

    methods fty_from_txtsym_eqs_txtsym_msg for testing.

    methods fty_from_exc_eqs_standard_exc for testing.

    methods fty_from_exc_rets_vars for testing.

    methods fty_clone_eqs_original_msg for testing.

    methods fty_clone_bnd_new_typ_uses for testing.

    methods fty_clone_unbnd_new_typ_infrs for testing.

    methods fty_clone_xco_eqs_original_msg for testing.

    methods fty_clone_xco_bnd_new_typ_uses for testing.

    methods fty_clone_xco_unbnd_typ_infrs for testing.

    methods aggr_content_eqs_default_msg for testing.

    methods aggr_type_eqs_default_msg_type for testing.

  protected section.

    methods set_sy_structure.

endclass.
class zcl_messages_it implementation.

  method set_sy_structure.

    message i001(ZMSG) with `hello` into final(dummy) ##NEEDED.

  endmethod.
  method basic_message_content.

    "arrange
    final(msg) = new zcl_message( i_id = 'ZMSG'
                                  i_number = 001
                                  i_var1 = `hello` ).

    "act & assert
    cl_abap_unit_assert=>assert_equals( exp = `hello`
                                        act = msg->content( ) ).

  endmethod.
  method free_message_content.

    "arrange
    final(msg) = new zcl_free_message( `hello` ).

    "act & assert
    cl_abap_unit_assert=>assert_equals( exp = `hello`
                                        act = msg->content( ) ).

  endmethod.
  method text_symbol_message_content.

    "arrange
    final(msg) = new zcl_text_symbol_message( 'hello'(000) ) ##TEXT_POOL.

    "act & assert
    cl_abap_unit_assert=>assert_equals( exp = 'hello'(000) ##TEXT_POOL
                                        act = msg->content( ) ).

  endmethod.
  method sy_message_content.

    "arrange
    set_sy_structure( ).

    final(msg) = new zcl_sy_message( ).

    "act & assert
    cl_abap_unit_assert=>assert_equals( exp = `hello`
                                        act = msg->content( ) ).

  endmethod.
  method sy_message_reads_system_state.

    "arrange
    set_sy_structure( ).

    "act
    final(o) = new zcl_sy_message( ).

    "assert
    cl_abap_unit_assert=>assert_equals( exp = value symsg( let sy_msg = xco_cp=>sy->message( ) in
                                                           msgid = sy_msg->value-msgid
                                                           msgno = sy_msg->value-msgno
                                                           msgv1 = sy_msg->value-msgv1
                                                           msgv2 = sy_msg->value-msgv2
                                                           msgv3 = sy_msg->value-msgv3
                                                           msgv4 = sy_msg->value-msgv4 )
                                        act = value symsg( msgid = o->if_t100_message~t100key-msgid
                                                           msgno = o->if_t100_message~t100key-msgno
                                                           msgv1 = o->if_t100_dyn_msg~msgv1
                                                           msgv2 = o->if_t100_dyn_msg~msgv2
                                                           msgv3 = o->if_t100_dyn_msg~msgv3
                                                           msgv4 = o->if_t100_dyn_msg~msgv4 ) ).

  endmethod.
  method fty_from_system_eqs_sy_msg.

    "arrange
    set_sy_structure( ).

    final(sy_msg) = new zcl_sy_message( ).

    final(fty_msg) = new zcl_message_fty( )->from_system_message( ).

    "act & assert
    cl_abap_unit_assert=>assert_equals( exp = sy_msg->content( )
                                        act = cast if_message( fty_msg )->get_text( ) ).

  endmethod.
  method fty_from_sys_msg_rets_vars.

    "arrange
    set_sy_structure( ).

    "act
    final(o) = new zcl_message_fty( )->from_system_message( ).

    "assert
    final(expected_vars) = value zcl_message=>t_variables( msgid = 'ZMSG'
                                                           msgno = 001
                                                           msgty = 'I'
                                                           msgv1 = `hello` ).

    cl_abap_unit_assert=>assert_true( act = xsdbool( o->variables( ) eq expected_vars
                                                     and o->type( )->old( ) eq 'I' ) ).

  endmethod.
  method fty_from_vars_rets_vars.

    "arrange
    final(vars) = value zcl_message=>t_variables( msgid = 'ZMSG'
                                                  msgno = 001
                                                  msgty = 'W'
                                                  msgv1 = '1'
                                                  msgv2 = '2'
                                                  msgv3 = '3'
                                                  msgv4 = '4' ).

    "act
    final(o) = new zcl_message_fty( )->from_variables( vars ).

    "assert
    cl_abap_unit_assert=>assert_true( act = xsdbool( o->variables( ) eq vars
                                                     and o->type( )->old( ) eq 'W' ) ).

  endmethod.
  method fty_from_vars_a_becomes_error.

    "act
    final(o) = new zcl_message_fty( )->from_variables( value #( msgid = 'ZMSG'
                                                                msgno = 001
                                                                msgty = 'A' ) ).

    "assert
    cl_abap_unit_assert=>assert_equals( exp = 'E'
                                        act = o->type( )->old( ) ).

  endmethod.
  method fty_from_string_eqs_free_msg.

    "arrange
    final(some_text) = `asdf a9083 nasdf98`.

    final(free_msg) = new zcl_free_message( some_text ).

    final(fty_msg) = new zcl_message_fty( )->from_string( some_text ).

    "act & assert
    cl_abap_unit_assert=>assert_equals( exp = free_msg->content( )
                                        act = cast if_message( fty_msg )->get_text( ) ).

  endmethod.
  method fty_from_str_rets_vars.

    "arrange
    final(text) = `part1 part2`.

    final(msg_type_stub) = cast zif_message_type( cl_abap_testdouble=>create( 'ZIF_MESSAGE_TYPE' ) ).

    cl_abap_testdouble=>configure_call( msg_type_stub )->returning( 'I' ).

    msg_type_stub->old( ).

    "act
    final(o) = new zcl_message_fty( )->from_string( i_free_text = text
                                                    i_type = msg_type_stub ).

    "assert
    cl_abap_unit_assert=>assert_true( act = xsdbool( o->variables( )-msgty eq 'I'
                                                     and o->type( ) eq msg_type_stub
                                                     and o->content( ) eq text ) ).

  endmethod.
  method fty_from_str_strct_rets_vars.

    "arrange
    final(text) = `short text`.

    final(msg_type_stub) = cast zif_message_type( cl_abap_testdouble=>create( 'ZIF_MESSAGE_TYPE' ) ).

    cl_abap_testdouble=>configure_call( msg_type_stub )->returning( 'W' ).

    msg_type_stub->old( ).

    "act
    final(o) = new zcl_message_fty( )->from_string_strict( i_free_text = text
                                                           i_type = msg_type_stub ).

    "assert
    cl_abap_unit_assert=>assert_true( act = xsdbool( o->variables( )-msgty eq 'W'
                                                     and o->type( ) eq msg_type_stub
                                                     and o->content( ) eq text ) ).

  endmethod.
  method fty_from_txtsym_eqs_txtsym_msg.

    "arrange
    final(some_text) = conv zcl_text_symbol_message=>t_value( 'ñlkfd spoisdfg &1' ).

    final(some_var) = conv symsgv( 8 ).

    final(text_symb_msg) = new zcl_text_symbol_message( i_text_symbol = some_text
                                                        i_placeholder1 = some_var ).

    final(fty_msg) = new zcl_message_fty( )->from_text_symbol( i_text_symbol = some_text
                                                               i_placeholder1 = some_var ).

    "act & assert
    cl_abap_unit_assert=>assert_equals( exp = text_symb_msg->content( )
                                        act = cast if_message( fty_msg )->get_text( ) ).

  endmethod.
  method fty_from_exc_eqs_standard_exc.

    "arrange
    try.

      raise exception type cx_abap_api_state message e001(ZMSG) with 1 2 3 4.

    catch cx_abap_api_state into final(e).

      final(exc_msg) = new zcl_message_fty( )->from_exception( e ).

    endtry.

    "act & assert
    cl_abap_unit_assert=>assert_equals( exp = e->get_text( )
                                        act = cast if_message( exc_msg )->get_text( ) ).

  endmethod.
  method fty_from_exc_rets_vars.

    "arrange
    try.

      raise exception type cx_abap_api_state message e001(ZMSG) with '1' '2' '3' '4'.

    catch cx_abap_api_state into final(e).

      "act
      final(o) = new zcl_message_fty( )->from_exception( e ).

    endtry.

    "assert
    final(expected_vars) = value zcl_message=>t_variables( msgid = 'ZMSG'
                                                           msgno = 001
                                                           msgty = 'E'
                                                           msgv1 = '1'
                                                           msgv2 = '2'
                                                           msgv3 = '3'
                                                           msgv4 = '4' ).

    cl_abap_unit_assert=>assert_true( act = xsdbool( o->variables( ) eq expected_vars
                                                     and o->type( )->old( ) eq 'E' ) ).

  endmethod.
  method fty_clone_eqs_original_msg.

    "arrange
    try.

      raise exception new cx_abap_random( ).

    catch cx_abap_random into final(if_message_msg).

      final(cloned_msg) = new zcl_message_fty( )->clone( if_message_msg ).

    endtry.

    "act & assert
    cl_abap_unit_assert=>assert_equals( exp = if_message_msg->get_text( )
                                        act = cast if_message( cloned_msg )->get_text( ) ).

  endmethod.
  method fty_clone_bnd_new_typ_uses.

    "arrange
    final(orig_msg) = new zcl_free_message( `random text` ).

    final(new_type) = cast zif_message_type( cl_abap_testdouble=>create( 'ZIF_MESSAGE_TYPE' ) ).

    "act
    final(cloned_msg) = new zcl_message_fty( )->clone( i_message = orig_msg
                                                       i_new_type = new_type ).

    "assert
    cl_abap_unit_assert=>assert_true( act = xsdbool( cast if_message( cloned_msg )->get_text( ) eq orig_msg->content( )
                                                     and cloned_msg->type( ) eq new_type ) ).

  endmethod.
  method fty_clone_unbnd_new_typ_infrs.

    "arrange
    final(orig_msg) = new zcl_message( i_id = 'ZMSG'
                                       i_number = 001
                                       i_var1 = 'A' ).

    "act
    final(cloned_msg) = new zcl_message_fty( )->clone( orig_msg ).

    "assert
    cl_abap_unit_assert=>assert_equals( exp = 'I'
                                        act = cloned_msg->type( )->old( ) ).

  endmethod.
  method fty_clone_xco_eqs_original_msg.

    "arrange
    final(some_msg) = xco_cp=>message( value #( msgid = 'ZMSG'
                                                msgno = 001
                                                msgty = xco_cp_message=>type->warning->value
                                                msgv1 = `random text` ) ).

    final(fty_msg) = new zcl_message_fty( )->clone_xco( some_msg ).

    "act & assert
    cl_abap_unit_assert=>assert_equals( exp = some_msg->get_text( )
                                        act = fty_msg->content( ) ).

  endmethod.
  method fty_clone_xco_bnd_new_typ_uses.

    "arrange
    final(some_msg) = xco_cp=>message( value #( msgid = 'ZMSG'
                                                msgno = 001
                                                msgty = xco_cp_message=>type->warning->value
                                                msgv1 = `random text` ) ).

    final(new_type) = cast zif_message_type( cl_abap_testdouble=>create( 'ZIF_MESSAGE_TYPE' ) ).

    "act
    final(fty_msg) = new zcl_message_fty( )->clone_xco( i_message = some_msg
                                                        i_new_type = new_type ).

    "assert
    cl_abap_unit_assert=>assert_true( act = xsdbool( some_msg->get_text( ) eq fty_msg->content( )
                                                     and fty_msg->type( ) eq new_type ) ).

  endmethod.
  method fty_clone_xco_unbnd_typ_infrs.

    "arrange
    final(some_msg) = xco_cp=>message( value #( msgid = 'ZMSG'
                                                msgno = 001
                                                msgty = xco_cp_message=>type->warning->value
                                                msgv1 = `random text` ) ).

    "act
    final(fty_msg) = new zcl_message_fty( )->clone_xco( some_msg ).

    "assert
    cl_abap_unit_assert=>assert_equals( exp = 'W'
                                        act = fty_msg->type( )->old( ) ).

  endmethod.
  method aggr_content_eqs_default_msg.

    "arrange
    final(default_msg) = new zcl_free_message( `hello` ).

    final(aggr) = new zcl_message_aggr( i_default = default_msg
                                        i_list = value #( ( default_msg ) ) ).

    "act & assert
    cl_abap_unit_assert=>assert_equals( exp = default_msg->content( )
                                        act = aggr->content( ) ).

  endmethod.
  method aggr_type_eqs_default_msg_type.

    "arrange
    final(default_msg) = new zcl_free_message( i_text = `hello`
                                               i_type = zcl_message_type_fty=>warning ).

    "act
    final(aggr) = new zcl_message_aggr( i_default = default_msg
                                        i_list = value #( ) ).

    "assert
    cl_abap_unit_assert=>assert_equals( exp = default_msg->type( )
                                        act = aggr->type( ) ).

  endmethod.

endclass.
