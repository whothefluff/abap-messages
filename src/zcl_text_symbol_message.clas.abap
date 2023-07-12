"! <p class="shorttext synchronized" lang="EN">Text symbol message</p>
"! Inherits from {@link ZCL_FREE_MESSAGE}.
class zcl_text_symbol_message definition
                              public
                              inheriting from zcl_free_message
                              create public.

  public section.

    types t_value type rs38m-itex132.

    "! <p class="shorttext synchronized" lang="EN">Create a message ID '00' TYPE <em>i_type</em> NUMBER '001'</p>
    "!
    "! @parameter i_text_symbol | <p class="shorttext synchronized" lang="EN"></p>
    "! @parameter i_type | <p class="shorttext synchronized" lang="EN"></p>
    methods constructor
              importing
                i_text_symbol type zcl_text_symbol_message=>t_value
                i_type like sy-msgty default zcl_message=>valid_type-information
                i_placeholder1 type sy-msgv1 optional
                i_placeholder2 type sy-msgv2 optional
                i_placeholder3 type sy-msgv3 optional
                i_placeholder4 type sy-msgv4 optional.

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

