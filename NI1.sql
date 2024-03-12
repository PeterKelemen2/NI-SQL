CREATE TABLE zokwu1_oe_order_lines_all
AS SELECT * FROM apps.or_order_lines_all
WHERE 1 = 1;

CREATE TABLE zokwu1_log_tbl (
    log_id NUMBER,
    log_date DATE,
    calling_fun_proc VARCHAR2(2000),
    log_msg VARCHAR2 (3000)
);

CREATE SEQUENCE zokwu1_log
    START WITH 1
    INCREMENT BY 1
    NOCACHE
    NOCYCLE;

@C:\Users\student\Desktop\zokwu1_gyak.pks;

@C:\Users\student\Desktop\zokwu1_gyak.pkb;

EXECUTE zokwu1_gyak.log('Text', 'Ez egy teszt');

SELECT * FROM zokwu1_log_tbl logtable;

EXECUTE zokwu1_gyak.delete_by_id(1);

EXECUTE zokwu1_gyak.DELETE_LOG_TABLE;