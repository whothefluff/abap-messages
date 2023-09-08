"! <p class="shorttext synchronized" lang="EN">Free message</p>
"! Inherits from {@link ZCL_MESSAGE}.
class zcl_free_message definition
                       public
                       inheriting from zcl_message
                       create public.

  public section.

    "! <p class="shorttext synchronized" lang="EN">Creates a message ID '00' TYPE <em>i_type</em> NUMBER '001'</p>
    "!
    "! @parameter i_text | <p class="shorttext synchronized" lang="EN"></p>
    "! @parameter i_type | <p class="shorttext synchronized" lang="EN"></p>
    methods constructor
              importing
                i_text type string
                i_type type zcl_message=>valid_type default zcl_message=>type-information.

endclass.
class zcl_free_message implementation.

  method constructor.

    types: begin of free_text_as_t100_message,
             part1 like if_t100_dyn_msg=>msgv1,
             part2 like if_t100_dyn_msg=>msgv2,
             part3 like if_t100_dyn_msg=>msgv3,
             part4 like if_t100_dyn_msg=>msgv4,
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
