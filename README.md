# SMS-based-Remote-Server-Monitoring-System.-PL-SQL
SMS-based Remote Server Monitoring System. PL/SQL script for implementing an SMS-based remote server monitoring system. It assumes the use of an external SMS gateway API or stored procedure to send SMS. This code detects server issues by checking server status periodically, and if a server is found to be down, it sends a notification to a predefined list of users.


Code Explanation:

    Package Declaration:
        sms_server_monitor: Contains the monitor_servers procedure.

    Procedure monitor_servers:
        Uses a cursor (server_list) to fetch the list of monitored servers.
        Simulates server status using random logic (replace with actual status-checking mechanism).
        Checks if the server is down and sends an SMS notification to all users in the user_list cursor.

    SMS Sending Logic:
        send_sms is a placeholder procedure simulating SMS sending. Replace it with a stored procedure or API integration for SMS gateways.

    Logging Alerts:
        Inserts the alert details into server_alert_logs for record-keeping.

    Error Handling:
        Captures and logs any errors during the monitoring process.

Database Tables:

    monitored_servers:
        Holds details of servers to be monitored (e.g., server_id, server_name, server_ip).

    notification_users:
        Stores user details (user_id, phone_number) for sending notifications.

    server_alert_logs:
        Records the alerts sent, with fields like alert_id, server_id, alert_message, alert_time.
