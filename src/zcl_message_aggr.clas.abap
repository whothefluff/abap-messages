"! <p class="shorttext synchronized" lang="EN">Message aggregate</p>
"!
"! <p>Contains a collection of messages.</p>
"! <p>Inherits from {@link ZCL_MESSAGE}</p>
class zcl_message_aggr definition
                       public
                       inheriting from zcl_message
                       create public.

  public section.

    types:
           "! <p class="shorttext synchronized" lang="EN">Any messages</p>
           t_list type standard table of ref to zcl_message with empty key.

    class-methods class_constructor.

    "! <p class="shorttext synchronized" lang="EN"></p>
    "!
    "! @parameter i_default | <p class="shorttext synchronized" lang="EN"></p>
    "! @parameter i_list | <p class="shorttext synchronized" lang="EN">Mandatory collection of errors</p>
    methods constructor
              importing
                i_default type ref to if_message optional
                i_list type zcl_message_aggr=>t_list.

    "! <p class="shorttext synchronized" lang="EN">Returns all errors typed as CX_ROOT</p>
    "!
    "! @parameter r_val | <p class="shorttext synchronized" lang="EN"></p>
    methods list
              returning
                value(r_val) type zcl_message_aggr=>t_list.

    "! <p class="shorttext synchronized" lang="EN">Returns the number of errors contained in this object</p>
    "!
    "! @parameter r_val | <p class="shorttext synchronized" lang="EN"></p>
    methods size
              returning
                value(r_val) type i.

    "! <p class="shorttext synchronized" lang="EN">Returns true when the collection of errors is empty</p>
    "!
    "! @parameter r_val | <p class="shorttext synchronized" lang="EN"></p>
    methods is_empty
              returning
                value(r_val) type xsdboolean.

  protected section.

    data _list type zcl_message_aggr=>t_list.

    class-data _type_fty type ref to zcl_message_type_fty.

    class-data _msg_vars_reader type ref to zcl_msg_vars_reader.

    class-data _fallback_for_default_msg type ref to if_message.

endclass.
class zcl_message_aggr implementation.

  method class_constructor.

    _type_fty = new zcl_message_type_fty( ).

    _fallback_for_default_msg = new zcl_message( i_id = 'ZMSG'
                                                 i_number = 002
                                                 i_type = zcl_message_type_fty=>information ).

    _msg_vars_reader = new zcl_msg_vars_reader( new zcl_msg_type_severity_pairs( i_severity_of_default = if_abap_behv_message=>severity-information
                                                                                 i_type_of_default = xco_cp_message=>type->information->value ) ).

  endmethod.
  method constructor.

    final(vars) = _msg_vars_reader->read_basic( i_default ).

    super->constructor( i_id = vars-msgid
                        i_number = vars-msgno
                        i_type = _type_fty->from_old( vars-msgty )
                        i_var1 = vars-msgv1
                        i_var2 = vars-msgv2
                        i_var3 = vars-msgv3
                        i_var4 = vars-msgv4 ).

    _list = i_list.

  endmethod.
  method list.

    return _list.

  endmethod.
  method is_empty.

    return xsdbool( size( ) eq 0 ).

  endmethod.
  method size.

    return lines( list( ) ).

  endmethod.

endclass.
