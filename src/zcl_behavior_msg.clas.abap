"! <p class="shorttext synchronized" lang="EN">Behavior processing message</p>
"! Inherits from {@link zcl_msg}.
class zcl_behavior_msg definition
                       public
                       create public
                       inheriting from zcl_msg.

  public section.

    interfaces: if_abap_behv_message.

    "! <p class="shorttext synchronized" lang="EN"></p>
    "!
    "! @parameter i_id | <p class="shorttext synchronized" lang="EN"></p>
    "! @parameter i_number | <p class="shorttext synchronized" lang="EN"></p>
    "! @parameter i_type | <p class="shorttext synchronized" lang="EN"></p>
    "! @parameter i_var1 | <p class="shorttext synchronized" lang="EN"></p>
    "! @parameter i_var2 | <p class="shorttext synchronized" lang="EN"></p>
    "! @parameter i_var3 | <p class="shorttext synchronized" lang="EN"></p>
    "! @parameter i_var4 | <p class="shorttext synchronized" lang="EN"></p>
    methods constructor
              importing
                i_id like if_t100_message=>t100key-msgid
                i_number like if_t100_message=>t100key-msgno
                i_type like if_t100_dyn_msg=>msgty
                i_var1 like if_t100_dyn_msg=>msgv1 optional
                i_var2 like if_t100_dyn_msg=>msgv2 optional
                i_var3 like if_t100_dyn_msg=>msgv3 optional
                i_var4 like if_t100_dyn_msg=>msgv4 optional.

    "! <p class="shorttext synchronized" lang="EN"></p>
    "!
    "! @parameter i_message | <p class="shorttext synchronized" lang="EN"></p>
    "! @parameter r_behavior_message | <p class="shorttext synchronized" lang="EN"></p>
    class-methods from_message
                    importing
                      i_message type ref to if_t100_dyn_msg
                    returning
                      value(r_behavior_message) type ref to if_abap_behv_message.

    methods as_error redefinition.

    methods as_abortion redefinition.

    methods as_exit redefinition.

    methods as_information redefinition.

    methods as_success redefinition.

    methods as_warning redefinition.

endclass.
class zcl_behavior_msg implementation.

  method constructor.

    super->constructor( i_id = i_id
                        i_number = i_number
                        i_type = i_type
                        i_var1 = i_var1
                        i_var2 = i_var2
                        i_var3 = i_var3
                        i_var4 = i_var4 ).

    me->if_abap_behv_message~m_severity = switch #( i_type
                                                    when 'E' or 'A' or 'X'
                                                    then if_abap_behv_message=>severity-error
                                                    when 'W'
                                                    then if_abap_behv_message=>severity-warning
                                                    when 'I'
                                                    then if_abap_behv_message=>severity-information
                                                    when 'S'
                                                    then if_abap_behv_message=>severity-success
                                                    else if_abap_behv_message=>severity-none ).

  endmethod.
  method from_message.

    r_behavior_message = new zcl_behavior_msg( i_id = i_message->if_t100_message~t100key-msgid
                                               i_number = i_message->if_t100_message~t100key-msgno
                                               i_type = i_message->msgty
                                               i_var1 = i_message->msgv1
                                               i_var2 = i_message->msgv2
                                               i_var3 = i_message->msgv3
                                               i_var4 = i_message->msgv4 ).

  endmethod.
  method as_abortion.

    r_abortion_msg = new zcl_behavior_msg( i_id = me->if_t100_message~t100key-msgid
                                           i_number = me->if_t100_message~t100key-msgno
                                           i_type = 'A'
                                           i_var1 = me->if_t100_dyn_msg~msgv1
                                           i_var2 = me->if_t100_dyn_msg~msgv2
                                           i_var3 = me->if_t100_dyn_msg~msgv3
                                           i_var4 = me->if_t100_dyn_msg~msgv4 ).

  endmethod.
  method as_error.

    r_error_msg = new zcl_behavior_msg( i_id = me->if_t100_message~t100key-msgid
                                        i_number = me->if_t100_message~t100key-msgno
                                        i_type = 'E'
                                        i_var1 = me->if_t100_dyn_msg~msgv1
                                        i_var2 = me->if_t100_dyn_msg~msgv2
                                        i_var3 = me->if_t100_dyn_msg~msgv3
                                        i_var4 = me->if_t100_dyn_msg~msgv4 ).

  endmethod.
  method as_exit.

    r_exit_msg = new zcl_behavior_msg( i_id = me->if_t100_message~t100key-msgid
                                       i_number = me->if_t100_message~t100key-msgno
                                       i_type = 'X'
                                       i_var1 = me->if_t100_dyn_msg~msgv1
                                       i_var2 = me->if_t100_dyn_msg~msgv2
                                       i_var3 = me->if_t100_dyn_msg~msgv3
                                       i_var4 = me->if_t100_dyn_msg~msgv4 ).

  endmethod.
  method as_information.

    r_information_msg = new zcl_behavior_msg( i_id = me->if_t100_message~t100key-msgid
                                              i_number = me->if_t100_message~t100key-msgno
                                              i_type = 'I'
                                              i_var1 = me->if_t100_dyn_msg~msgv1
                                              i_var2 = me->if_t100_dyn_msg~msgv2
                                              i_var3 = me->if_t100_dyn_msg~msgv3
                                              i_var4 = me->if_t100_dyn_msg~msgv4 ).

  endmethod.
  method as_success.

    r_success_msg = new zcl_behavior_msg( i_id = me->if_t100_message~t100key-msgid
                                          i_number = me->if_t100_message~t100key-msgno
                                          i_type = 'S'
                                          i_var1 = me->if_t100_dyn_msg~msgv1
                                          i_var2 = me->if_t100_dyn_msg~msgv2
                                          i_var3 = me->if_t100_dyn_msg~msgv3
                                          i_var4 = me->if_t100_dyn_msg~msgv4 ).

  endmethod.
  method as_warning.

    r_warning_msg = new zcl_behavior_msg( i_id = me->if_t100_message~t100key-msgid
                                          i_number = me->if_t100_message~t100key-msgno
                                          i_type = 'W'
                                          i_var1 = me->if_t100_dyn_msg~msgv1
                                          i_var2 = me->if_t100_dyn_msg~msgv2
                                          i_var3 = me->if_t100_dyn_msg~msgv3
                                          i_var4 = me->if_t100_dyn_msg~msgv4 ).

  endmethod.

endclass.

