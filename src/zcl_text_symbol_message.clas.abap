"! <p class="shorttext synchronized" lang="EN">Text symbol message</p>
"! Inherits from {@link ZCL_FREE_MESSAGE}.
class zcl_text_symbol_message definition
                              public
                              inheriting from zcl_free_message
                              create public.

  public section.

    types t_value type rs38m-itex132.

    "! <p class="shorttext synchronized" lang="EN">Creates a message ID '00' TYPE <em>i_type</em> NUMBER '001'</p>
    "!
    "! @parameter i_text_symbol | <p class="shorttext synchronized" lang="EN"></p>
    "! @parameter i_type | <p class="shorttext synchronized" lang="EN"></p>
    methods constructor
              importing
                i_text_symbol type zcl_text_symbol_message=>t_value
                i_type type zcl_message=>valid_type default zcl_message=>type-information
                i_placeholder1 like if_t100_dyn_msg=>msgv1 optional
                i_placeholder2 like if_t100_dyn_msg=>msgv2 optional
                i_placeholder3 like if_t100_dyn_msg=>msgv3 optional
                i_placeholder4 like if_t100_dyn_msg=>msgv4 optional.

endclass.
class zcl_text_symbol_message implementation.

  method constructor.

    super->constructor( i_text = replace( val = replace( val = replace( val = replace( val = i_text_symbol
                                                                                       sub = '&1'
                                                                                       with = i_placeholder1 )
                                                                        sub = '&2'
                                                                        with = i_placeholder2 )
                                                         sub = '&3'
                                                         with = i_placeholder3 )
                                          sub = '&4'
                                          with = i_placeholder4 )
                        i_type = i_type ).

  endmethod.

endclass.
