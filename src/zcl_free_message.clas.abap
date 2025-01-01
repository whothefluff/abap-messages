"! <p class="shorttext synchronized" lang="EN">Free Message</p>
"!
"! <p>Inherits from {@link ZCL_MESSAGE}</p>
"!
"! Specialization {@link ZCL_TEXT_SYMBOL_MESSAGE} is easier to use
"! for messages that come from a text-pool
class zcl_free_message definition
                       public
                       inheriting from zcl_message
                       create public.

  public section.

    "! <p class="shorttext synchronized" lang="EN">Creates a message with a free text</p>
    "!
    "! @parameter i_text | <p class="shorttext synchronized" lang="EN">Text up to 200 characters</p>
    "! @parameter i_type | <p class="shorttext synchronized" lang="EN">Type</p>
    "! @parameter i_exc_if_data_loss | <p class="shorttext synchronized" lang="EN">Toggle exception for text overflow</p>
    "! @raising cx_sy_conversion_data_loss | <p class="shorttext synchronized" lang="EN">Thrown when text doesn't fit (if toggled)</p>
    methods constructor
              importing
                i_text type string
                i_type type ref to zif_message_type default zcl_message_type_fty=>unspecified
                i_exc_if_data_loss type xsdboolean default abap_false
              raising
                cx_sy_conversion_data_loss.

  protected section.

endclass.
class zcl_free_message implementation.

  method constructor.

    types: begin of free_text_as_t100_message,
             part1 type zcl_message=>t_variables-msgv1,
             part2 type zcl_message=>t_variables-msgv2,
             part3 type zcl_message=>t_variables-msgv3,
             part4 type zcl_message=>t_variables-msgv4,
           end of free_text_as_t100_message.

    final(free_text_as_t100_message) = cond free_text_as_t100_message( when not ( strlen( i_text ) gt 200
                                                                                  and i_exc_if_data_loss eq abap_true )
                                                                       then i_text
                                                                       else throw cx_sy_conversion_data_loss( value = i_text ) ).

    super->constructor( i_id = 'ZMSG'
                        i_number = 001
                        i_type = i_type
                        i_var1 = free_text_as_t100_message-part1
                        i_var2 = free_text_as_t100_message-part2
                        i_var3 = free_text_as_t100_message-part3
                        i_var4 = free_text_as_t100_message-part4 ).

  endmethod.

endclass.
