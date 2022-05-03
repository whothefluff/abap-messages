"! <p class="shorttext synchronized" lang="EN">Free message</p>
"! Inherits from {@link zcl_msg}.
class zcl_free_msg definition
                   public
                   inheriting from zcl_msg
                   create public.

  public section.

    "! <p class="shorttext synchronized" lang="EN">Create a message ID '00' TYPE <em>i_type</em> NUMBER '001'</p>
    "!
    "! @parameter i_text | <p class="shorttext synchronized" lang="EN"></p>
    "! @parameter i_type | <p class="shorttext synchronized" lang="EN"></p>
    methods constructor
              importing
                i_text type string
                i_type like if_t100_dyn_msg=>msgty default 'I'.

endclass.
class zcl_free_msg implementation.

  method constructor.

    types: begin of free_text_as_t100_message,
             part1 like me->if_t100_dyn_msg~msgv1,
             part2 like me->if_t100_dyn_msg~msgv2,
             part3 like me->if_t100_dyn_msg~msgv3,
             part4 like me->if_t100_dyn_msg~msgv4,
           end of free_text_as_t100_message.

    data(free_text_as_t100_message) = conv free_text_as_t100_message( i_text ).

    super->constructor( i_id = '00'
                        i_number = '001'
                        i_type = i_type
                        i_var1 = free_text_as_t100_message-part1
                        i_var2 = free_text_as_t100_message-part2
                        i_var3 = free_text_as_t100_message-part3
                        i_var4 = free_text_as_t100_message-part4 ).

  endmethod.

endclass.

