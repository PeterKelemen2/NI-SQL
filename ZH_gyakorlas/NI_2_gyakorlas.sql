-- https://github.com/erpeter96/esen

SELECT * FROM apps.oe_order_headers_all;

-- oe_order_lines_all, oe_order_headers_all, mtl_system_items_b

CREATE TABLE ZOKWU1_oe_order_lines_all
    AS SELECT * FROM apps.oe_order_lines_all
    WHERE 1=1;  

CREATE TABLE ZOKWU1_oe_order_headers_all
    AS SELECT * FROM apps.oe_order_headers_all
    WHERE 1=1;  

CREATE TABLE ZOKWU1_mtl_system_items_b
    AS SELECT * FROM apps.mtl_system_items_b
    WHERE 1=1;  

SELECT * FROM ZOKWU1_oe_order_headers_all;
SELECT * FROM ZOKWU1_oe_order_lines_all;
SELECT * FROM ZOKWU1_mtl_system_items_b;

SELECT unit_selling_price, unit_selling_price*10
FROM ZOKWU1_oe_order_lines_all
    WHERE line_id = 236771;

SELECT ZOKWU1_mtl_system_items_b.segment1
FROM ZOKWU1_mtl_system_items_b;

@'ZOKWU1_package.pks';
@'ZOKWU1_package.pkb';

SELECT ZOKWU1_package.ZOKWU1_show_reduced_price(236771, 10) FROM dual;

SELECT ol.unit_selling_price * 10
        FROM ZOKWU1_oe_order_lines_all ol
        WHERE ol.line_id = :line_id;

EXECUTE ZOKWU1_package.ZOKWU1_cut_order_selling_price(50002, 10);









