CREATE OR REPLACE PACKAGE BODY ZOKWU1_package
IS
    FUNCTION ZOKWU1_show_reduced_price(line_id NUMBER, kedvezmeny NUMBER)
        RETURN NUMBER
    IS
        reduced_price NUMBER;
    BEGIN
        --dbms_output.put_line(reduced_price || ' ' || line_id || ' ' || kedvezmeny);
        SELECT ol.unit_selling_price * kedvezmeny reduced
            INTO reduced_price
        FROM ZOKWU1_oe_order_lines_all ol
        WHERE ol.line_id = line_id;
        --
        RETURN reduced_price;
    END;

    PROCEDURE ZOKWU1_cut_order_selling_price(p_out_errbuff OUT VARCHAR2,
                                            p_out_retcode OUT NUMBER,
                                            p_in_order_number IN NUMBER,
                                            p_in_cut_by IN NUMBER)
    IS
        CURSOR c_orders(p_in_order_number NUMBER)
        IS
        SELECT oh.header_id header_id,
                itms.segment1 part_number
            FROM ZOKWU1_oe_order_headers_all oh,
                ZOKWU1_oe_order_lines_all ol,
                ZOKWU1_mtl_system_items_b itms
        WHERE ol.header_id = oh.header_id
            AND itms.inventory_item_id = ol.inventory_item_id
            AND itms.organization_id = ol.org_id
            AND oh.order_number = p_in_order_number;
        --
        header NUMBER;
        get_cut_price NUMBER;
    BEGIN
        SELECT oh.header_id
        INTO header
        FROM ZOKWU1_oe_order_headers_all oh
        WHERE oh.order_number = p_in_order_number;
        --
        get_cut_price := ZOKWU1_show_reduced_price(header, p_in_cut_by);
        dbms_output.put_line('header id: ' || header);
        dbms_output.put_line('Reduced price: ' || get_cut_price);
        FOR v_rec IN c_orders(p_in_order_number)
        LOOP
            dbms_output.put_line('Part number: ' || v_rec.part_number);
            fnd_file.put_line(fnd_file.OUTPUT, 'Part number: ' || v_rec.part_number);
            fnd_file.put_line(fnd_file.LOG, 'Part number: ' || v_rec.part_number);
        END LOOP;     
    END;

END ZOKWU1_package;