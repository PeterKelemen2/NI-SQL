CREATE OR REPLACE PACKAGE BODY zokwu1_gyak
IS
    PROCEDURE LOG (call_fun_proc VARCHAR2, log_msg VARCHAR2)
    IS
        date_of_log DATE;
    BEGIN
        SELECT SYSDATE
            INTO date_of_log
            FROM dual;

        INSERT INTO zokwu1_log_tbl
            VALUES (
                zokwu1_log.NEXTVAL,
                date_of_log,
                call_fun_proc,
                log_msg
                );
        COMMIT;
        dbms_output.put_line('Log added');
    END;

    PROCEDURE DELETE_BY_ID (id NUMBER)
    IS
    BEGIN
        DELETE FROM zokwu1_log_tbl
            WHERE log_id = id;
        COMMIT;
        dbms_output.put_line('Line deleted');
    END;

    PROCEDURE DELETE_LOG_TABLE
    IS
    BEGIN
        DELETE FROM zokwu1_log_tbl
            WHERE 1 = 1;
    END;

    PROCEDURE LOG_CLEAR
    IS
    BEGIN
        DELETE FROM zokwu1_log_tbl;
        COMMIT;
        EXECUTE IMMEDIATE 'ALTER SEQUENCE zokwu1_log RESTART START WITH 1';
    END;

    PROCEDURE ORDER_ITEM_DESC(
                                    p_out_errbuff OUT VARCHAR2,
                                    p_out_retcode OUT VARCHAR2,
                                    p_in_order_number IN NUMBER
                                    )
    IS
        CURSOR c_orders(p_in_order_number NUMBER)
        IS 
        SELECT oh.order_number order_number,
                ol.inventory_item_id inv_item_id,
                itms_segment1 part_number,
                itms.description description
            FROM apps.oe_order_headers_all oh,
                 apps.oe_order_lines_all ol,
                 apps.mtl_system_items_b itms
            WHERE ol.header_id = oh.header_id
                AND itms.inventory_item_id = ol.inventory_item_id
                AND oh.order_number = p_in_order_number;
    BEGIN
        SELECT oh.header_id
            INTO header_id
            FROM perdos_oe_order_headers_all oh
            WHERE oh.order_number = p_in_order_number;
        
        get_sum := sum_unit_selling_price(header_id);
        dbms_output.put_line('Entered order number is: ' || p_in_order_number);
        dbms_output.put_line('Header id: ' || header_id);
        dbms_output.put_line('The value of the order is: ' || get_sum);
        FOR v_rec IN c_orders(p_in_order_number)
        LOOP 
            dbms_output.put_line('Part number: ' || v_rec.part_number || ' Description: ' || v_rec.description)
        END LOOP;

        EXCEPTION
        WHEN NO_DATA_FOUND THEN
            dbms_output.put_line('There is no such order');
    END;

    FUNCTION sum_unit_selling_price(p_in_header_id NUMBER)
    RETURN NUMBER
    IS 
        sum_price NUMBER;
    BEGIN 
        SELECT SUM(unit_selling_price)
        INTO sum_price
        FROM perdos_oe_order_lines_all
        WHERE header_id = p_in_header_id;

        RETURN sum_price;
    END;

END zokwu1_gyak;