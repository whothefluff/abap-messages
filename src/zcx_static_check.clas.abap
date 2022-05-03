"! <p class="shorttext synchronized" lang="EN">Excs. with Static Check of RAISING Clause with t100 message</p>
class zcx_static_check definition
                       public
                       inheriting from cx_static_check
                       create public.

  public section.

    Interfaces: if_t100_dyn_msg.

    "! <p class="shorttext synchronized" lang="EN"></p>
    "!
    "! @parameter i_textid | <p class="shorttext synchronized" lang="EN"></p>
    "! @parameter i_previous | <p class="shorttext synchronized" lang="EN"></p>
    methods constructor
              importing
                !i_textid like if_t100_message=>t100key optional
                !i_previous like previous optional
                preferred parameter i_textid.

    "! <p class="shorttext synchronized" lang="EN">Create exception with object or dynamic t100 message</p>
    "!
    "! @parameter i_t100_msg | <p class="shorttext synchronized" lang="EN"></p>
    "! @parameter i_previous | <p class="shorttext synchronized" lang="EN"></p>
    "! @parameter r_exception | <p class="shorttext synchronized" lang="EN"></p>
    class-methods from_t100_msg
                    importing
                      i_t100_msg type ref to if_t100_dyn_msg
                      i_previous like previous optional
                    returning
                      value(r_exception) type ref to zcx_static_check.

endclass.
class zcx_static_check implementation.

  method constructor ##ADT_SUPPRESS_GENERATION.

    super->constructor( previous = i_previous ).

    me->textid = value #( ).

    me->if_t100_message~t100key = cond #( when i_textid is not initial
                                          then i_textid
                                          else if_t100_message=>default_textid ).

  endmethod.
  method from_t100_msg.

    data(exc) = new zcx_static_check( ).

    exc->if_t100_dyn_msg~msgv1 = i_t100_msg->msgv1.

    exc->if_t100_dyn_msg~msgv2 = i_t100_msg->msgv2.

    exc->if_t100_dyn_msg~msgv3 = i_t100_msg->msgv3.

    exc->if_t100_dyn_msg~msgv4 = i_t100_msg->msgv4.

    exc->if_t100_dyn_msg~msgty = 'E'.

    exc->if_t100_message~t100key = i_t100_msg->if_t100_message~t100key.

    r_exception = exc.

  endmethod.

endclass.

