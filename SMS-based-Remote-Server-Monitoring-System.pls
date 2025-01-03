-- Declare the package for SMS-based remote server monitoring
CREATE OR REPLACE PACKAGE sms_server_monitor IS
    -- Procedure to monitor servers
    PROCEDURE monitor_servers;
END sms_server_monitor;
/

-- Implement the package body
CREATE OR REPLACE PACKAGE BODY sms_server_monitor IS

    -- Procedure to monitor servers
    PROCEDURE monitor_servers IS
        -- Cursor to fetch the list of servers to monitor
        CURSOR server_list IS
            SELECT server_id, server_name, server_ip
            FROM monitored_servers;

        -- Cursor to fetch the list of users to notify
        CURSOR user_list IS
            SELECT user_id, phone_number
            FROM notification_users;

        -- Variable to hold the server status
        v_server_status VARCHAR2(10);

        -- Variable to store the SMS message
        v_sms_message VARCHAR2(200);

        -- External SMS sending procedure (replace with actual SMS gateway logic)
        PROCEDURE send_sms(p_phone_number IN VARCHAR2, p_message IN VARCHAR2) IS
        BEGIN
            -- Call an external API or procedure to send SMS
            DBMS_OUTPUT.PUT_LINE('Sending SMS to ' || p_phone_number || ': ' || p_message);
        END;

    BEGIN
        -- Loop through each server to check its status
        FOR server_rec IN server_list LOOP
            BEGIN
                -- Simulate server status check (replace with real status check logic)
                SELECT CASE WHEN MOD(DBMS_RANDOM.VALUE(1, 100), 2) = 0 THEN 'DOWN' ELSE 'UP' END
                INTO v_server_status
                FROM DUAL;

                -- Check if the server is down
                IF v_server_status = 'DOWN' THEN
                    -- Prepare the SMS message
                    v_sms_message := 'Alert: Server ' || server_rec.server_name ||
                                     ' (' || server_rec.server_ip || ') is DOWN. Immediate action required.';

                    -- Notify all users in the notification list
                    FOR user_rec IN user_list LOOP
                        -- Call the SMS sending procedure
                        send_sms(user_rec.phone_number, v_sms_message);
                    END LOOP;

                    -- Log the event
                    INSERT INTO server_alert_logs (alert_id, server_id, alert_message, alert_time)
                    VALUES (server_alert_logs_seq.NEXTVAL, server_rec.server_id, v_sms_message, SYSTIMESTAMP);
                    COMMIT;
                END IF;
            EXCEPTION
                WHEN OTHERS THEN
                    -- Handle errors gracefully
                    DBMS_OUTPUT.PUT_LINE('Error checking server ' || server_rec.server_name || ': ' || SQLERRM);
            END;
        END LOOP;
    END monitor_servers;

END sms_server_monitor;
/
