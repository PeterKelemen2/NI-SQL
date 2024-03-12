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

END zokwu1_gyak;