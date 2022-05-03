"! <p class="shorttext synchronized" lang="EN">Message</p>
class zcl_msg definition
                  public
                  create public.

  public section.

    interfaces if_t100_dyn_msg.

    aliases: get_longtext for if_message~get_longtext,
             get_text for if_message~get_text.

    "! <p class="shorttext synchronized" lang="EN"></p>
    "!
    "! @parameter i_exception | <p class="shorttext synchronized" lang="EN"></p>
    "! @parameter r_error_message | <p class="shorttext synchronized" lang="EN"></p>
    class-methods from_exception
                    importing
                      i_exception type ref to zcx_static_check
                    returning
                      value(r_error_message) type ref to if_t100_dyn_msg.

  "! <p class="shorttext synchronized" lang="EN">Create a T100 message</p>
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

  "! <p class="shorttext synchronized" lang="EN">Return a copy of the current message with type E</p>
  "!
  "! @parameter r_error_msg | <p class="shorttext synchronized" lang="EN"></p>
  methods as_error
            returning
              value(r_error_msg) type ref to if_t100_dyn_msg.

  "! <p class="shorttext synchronized" lang="EN">Return a copy of the current message with type A</p>
  "!
  "! @parameter r_abortion_msg | <p class="shorttext synchronized" lang="EN"></p>
  methods as_abortion
            returning
              value(r_abortion_msg) type ref to if_t100_dyn_msg.

  "! <p class="shorttext synchronized" lang="EN">Return a copy of the current message with type X</p>
  "!
  "! @parameter r_exit_msg | <p class="shorttext synchronized" lang="EN"></p>
  methods as_exit
            returning
              value(r_exit_msg) type ref to if_t100_dyn_msg.

  "! <p class="shorttext synchronized" lang="EN">Return a copy of the current message with type I</p>
  "!
  "! @parameter r_information_msg | <p class="shorttext synchronized" lang="EN"></p>
  methods as_information
            returning
              value(r_information_msg) type ref to if_t100_dyn_msg.

  "! <p class="shorttext synchronized" lang="EN">Return a copy of the current message with type S</p>
  "!
  "! @parameter r_success_msg | <p class="shorttext synchronized" lang="EN"></p>
  methods as_success
            returning
              value(r_success_msg) type ref to if_t100_dyn_msg.

  "! <p class="shorttext synchronized" lang="EN">Return a copy of the current message with type W</p>
  "!
  "! @parameter r_warning_msg | <p class="shorttext synchronized" lang="EN"></p>
  methods as_warning
            returning
              value(r_warning_msg) type ref to if_t100_dyn_msg.

  "! <p class="shorttext synchronized" lang="EN">Return a copy of the current message as behavior msg</p>
  "!
  "! @parameter r_behavior_msg | <p class="shorttext synchronized" lang="EN"></p>
  methods as_behavior_message
            returning
              value(r_behavior_msg) type ref to if_abap_behv_message.

endclass.
class zcl_msg implementation.

  method from_exception.

    r_error_message = new zcl_msg( i_id = i_exception->if_t100_message~t100key-msgid
                                   i_number = i_exception->if_t100_message~t100key-msgno
                                   i_type = 'E'
                                   i_var1 = i_exception->if_t100_dyn_msg~msgv1
                                   i_var2 = i_exception->if_t100_dyn_msg~msgv2
                                   i_var3 = i_exception->if_t100_dyn_msg~msgv3
                                   i_var4 = i_exception->if_t100_dyn_msg~msgv4 ).

  endmethod.
  method constructor.

    me->if_t100_dyn_msg~msgv1 = i_var1.

    me->if_t100_dyn_msg~msgv2 = i_var2.

    me->if_t100_dyn_msg~msgv3 = i_var3.

    me->if_t100_dyn_msg~msgv4 = i_var4.

    me->if_t100_dyn_msg~msgty = i_type.

    me->if_t100_message~t100key = value #( msgid = i_id
                                           msgno = i_number
                                           attr1 = 'IF_T100_DYN_MSG~MSGV1'
                                           attr2 = 'IF_T100_DYN_MSG~MSGV2'
                                           attr3 = 'IF_T100_DYN_MSG~MSGV3'
                                           attr4 = 'IF_T100_DYN_MSG~MSGV4' ).

  endmethod.
  method if_message~get_longtext.

    result = cl_message_helper=>get_longtext_for_message( text = me
                                                          preserve_newlines = preserve_newlines ).

  endmethod.
  method if_message~get_text.

    result = cl_message_helper=>get_text_for_message( me ).

  endmethod.
  method as_error.

    r_error_msg = new zcl_msg( i_id = me->if_t100_message~t100key-msgid
                               i_number = me->if_t100_message~t100key-msgno
                               i_type = 'E'
                               i_var1 = me->if_t100_dyn_msg~msgv1
                               i_var2 = me->if_t100_dyn_msg~msgv2
                               i_var3 = me->if_t100_dyn_msg~msgv3
                               i_var4 = me->if_t100_dyn_msg~msgv4 ).

  endmethod.
  method as_abortion.

    r_abortion_msg = new zcl_msg( i_id = me->if_t100_message~t100key-msgid
                                  i_number = me->if_t100_message~t100key-msgno
                                  i_type = 'A'
                                  i_var1 = me->if_t100_dyn_msg~msgv1
                                  i_var2 = me->if_t100_dyn_msg~msgv2
                                  i_var3 = me->if_t100_dyn_msg~msgv3
                                  i_var4 = me->if_t100_dyn_msg~msgv4 ).

  endmethod.
  method as_exit.

    r_exit_msg = new zcl_msg( i_id = me->if_t100_message~t100key-msgid
                              i_number = me->if_t100_message~t100key-msgno
                              i_type = 'X'
                              i_var1 = me->if_t100_dyn_msg~msgv1
                              i_var2 = me->if_t100_dyn_msg~msgv2
                              i_var3 = me->if_t100_dyn_msg~msgv3
                              i_var4 = me->if_t100_dyn_msg~msgv4 ).

  endmethod.
  method as_information.

    r_information_msg = new zcl_msg( i_id = me->if_t100_message~t100key-msgid
                                     i_number = me->if_t100_message~t100key-msgno
                                     i_type = 'I'
                                     i_var1 = me->if_t100_dyn_msg~msgv1
                                     i_var2 = me->if_t100_dyn_msg~msgv2
                                     i_var3 = me->if_t100_dyn_msg~msgv3
                                     i_var4 = me->if_t100_dyn_msg~msgv4 ).

  endmethod.
  method as_success.

    r_success_msg = new zcl_msg( i_id = me->if_t100_message~t100key-msgid
                                 i_number = me->if_t100_message~t100key-msgno
                                 i_type = 'S'
                                 i_var1 = me->if_t100_dyn_msg~msgv1
                                 i_var2 = me->if_t100_dyn_msg~msgv2
                                 i_var3 = me->if_t100_dyn_msg~msgv3
                                 i_var4 = me->if_t100_dyn_msg~msgv4 ).

  endmethod.
  method as_warning.

    r_warning_msg = new zcl_msg( i_id = me->if_t100_message~t100key-msgid
                                 i_number = me->if_t100_message~t100key-msgno
                                 i_type = 'W'
                                 i_var1 = me->if_t100_dyn_msg~msgv1
                                 i_var2 = me->if_t100_dyn_msg~msgv2
                                 i_var3 = me->if_t100_dyn_msg~msgv3
                                 i_var4 = me->if_t100_dyn_msg~msgv4 ).

  endmethod.
  method as_behavior_message.

    r_behavior_msg = new zcl_behavior_msg( i_id = me->if_t100_message~t100key-msgid
                                           i_number = me->if_t100_message~t100key-msgno
                                           i_type = me->if_t100_dyn_msg~msgty
                                           i_var1 = me->if_t100_dyn_msg~msgv1
                                           i_var2 = me->if_t100_dyn_msg~msgv2
                                           i_var3 = me->if_t100_dyn_msg~msgv3
                                           i_var4 = me->if_t100_dyn_msg~msgv4 ).

  endmethod.

endclass.

