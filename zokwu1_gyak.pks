CREATE OR REPLACE PACKAGE zokwu1_gyak
IS 
    PROCEDURE LOG (call_fun_proc VARCHAR2, log_msg VARCHAR2);
    PROCEDURE DELETE_BY_ID (id NUMBER);
    PROCEDURE DELETE_LOG_TABLE;
END zokwu1_gyak;