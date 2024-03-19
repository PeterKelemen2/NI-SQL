CREATE OR REPLACE PACKAGE ZOKWU1_ESEN_gyak_pkb
IS 
    PROCEDURE order_item_description(p_out_errbuff     OUT VARCHAR2,
                                    p_out_retcode     OUT NUMBER,
                                    p_in_order_number IN NUMBER);
    PROCEDURE log(log_msg VARCHAR2, fun_proc VARCHAR2);
END ZOKWU1_ESEN_gyak_pkb;