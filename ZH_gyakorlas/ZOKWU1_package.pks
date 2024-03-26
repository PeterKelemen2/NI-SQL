CREATE OR REPLACE PACKAGE ZOKWU1_package
IS 
    FUNCTION ZOKWU1_show_reduced_price(line_id NUMBER, kedvezmeny NUMBER) RETURN NUMBER;
    PROCEDURE ZOKWU1_cut_order_selling_price(p_out_errbuff OUT VARCHAR2,
                                            p_out_retcode OUT NUMBER,
                                            p_in_order_number IN NUMBER,
                                            p_in_cut_by IN NUMBER);
END ZOKWU1_package;