BEGIN
    DBMS_SCHEDULER.CREATE_JOB(
        job_name        => 'SERVER_MONITOR_JOB',
        job_type        => 'PLSQL_BLOCK',
        job_action      => 'BEGIN sms_server_monitor.monitor_servers; END;',
        start_date      => SYSTIMESTAMP,
        repeat_interval => 'FREQ=MINUTELY; INTERVAL=5', -- Run every 5 minutes
        enabled         => TRUE
    );
END;
/
