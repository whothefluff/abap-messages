"! <p class="shorttext synchronized" lang="EN">Message</p>
class zcl_message definition
                  public
                  create public.

  public section.

    interfaces: if_abap_behv_message.

    aliases: get_longtext for if_message~get_longtext,
             get_text for if_message~get_text.

    types: begin of enum valid_type structure type,
             error,
             information,
             warning,
             success,
           end of enum valid_type structure type.

    "! <p class="shorttext synchronized" lang="EN">Creates a T100 message</p>
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
                i_id like if_t100_dyn_msg=>if_t100_message~t100key-msgid
                i_number like if_t100_dyn_msg=>if_t100_message~t100key-msgno
                i_type type zcl_message=>valid_type
                i_var1 like if_t100_dyn_msg=>msgv1 optional
                i_var2 like if_t100_dyn_msg=>msgv2 optional
                i_var3 like if_t100_dyn_msg=>msgv3 optional
                i_var4 like if_t100_dyn_msg=>msgv4 optional.

    "! <p class="shorttext synchronized" lang="EN">Sends message</p>
    "!
    "! @parameter r_self | <p class="shorttext synchronized" lang="EN"></p>
    methods send
              returning
                value(r_self) type ref to if_abap_behv_message.

    "! <p class="shorttext synchronized" lang="EN">Sends message and displays it like a specific type</p>
    "!
    "! @parameter i_display_like | <p class="shorttext synchronized" lang="EN"></p>
    "! @parameter r_self | <p class="shorttext synchronized" lang="EN"></p>
    methods send_like
              importing
                i_type type zcl_message=>valid_type
              returning
                value(r_self) type ref to if_abap_behv_message.

    "! <p class="shorttext synchronized" lang="EN">Sends message that displays at the end of the process</p>
    "!
    "! @parameter r_self | <p class="shorttext synchronized" lang="EN"></p>
    methods display
              returning
                value(r_self) type ref to if_abap_behv_message.

    "! <p class="shorttext synchronized" lang="EN">Sends message that displays before continuing the process</p>
    "!
    "! @parameter r_self | <p class="shorttext synchronized" lang="EN"></p>
    methods display_immediately
              returning
                value(r_self) type ref to if_abap_behv_message.

endclass.
class zcl_message implementation.

  method constructor.

    me->if_t100_dyn_msg~msgv1 = i_var1.

    me->if_t100_dyn_msg~msgv2 = i_var2.

    me->if_t100_dyn_msg~msgv3 = i_var3.

    me->if_t100_dyn_msg~msgv4 = i_var4.

    me->if_t100_dyn_msg~msgty = switch #( i_type
                                          when type-error then 'E'
                                          when type-information then 'I'
                                          when type-warning then 'W'
                                          when type-success then 'S' ).

    me->if_t100_message~t100key = value #( msgid = i_id
                                           msgno = i_number
                                           attr1 = 'IF_T100_DYN_MSG~MSGV1'
                                           attr2 = 'IF_T100_DYN_MSG~MSGV2'
                                           attr3 = 'IF_T100_DYN_MSG~MSGV3'
                                           attr4 = 'IF_T100_DYN_MSG~MSGV4' ).

    me->if_abap_behv_message~m_severity = switch #( i_type
                                                    when type-error then if_abap_behv_message=>severity-error
                                                    when type-information then if_abap_behv_message=>severity-information
                                                    when type-warning then if_abap_behv_message=>severity-warning
                                                    when type-success then if_abap_behv_message=>severity-success ).

  endmethod.
  method if_message~get_longtext.

    result = cl_message_helper=>get_longtext_for_message( text = me
                                                          preserve_newlines = preserve_newlines ).

  endmethod.
  method if_message~get_text.

    result = cl_message_helper=>get_text_for_message( me ).

  endmethod.
  method send.

    message me.

  endmethod.
  method send_like.

    message me display like i_type.

  endmethod.
  method display.

    message me type 'S' display like me->if_t100_dyn_msg~msgty.

  endmethod.
  method display_immediately.

    message me type 'I' display like me->if_t100_dyn_msg~msgty.

  endmethod.

endclass.
