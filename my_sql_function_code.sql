##1 CREATE PROCEDURE add_customer(
	    IN c_id INT,
        IN f_name VARCHAR(100),
        IN l_name VARCHAR(150),
        IN addr VARCHAR(150),
        IN p_number INT,
        IN b_info INT,
        IN s_ticket INT,
        IN inv_id INT
)
BEGIN
	INSERT INTO customer(customer_id, first_name, last_name, address, phone_number, billing_info, service_ticket)
	VALUES (f_name, l_name, addr, p_number, b_info, s_ticket, inv_id);

END //
    
SELECT *
FROM customer;

CALL add_customer(01, 'Joshua', 'Lewis', '1515 Gallaway, Columbus Ohio 43205', 6145555555, '4242568658975', 9862);


##2 CREATE PROCEDURE add_service_facility(
        IN c_id INT,
        IN s_total NUMERIC(20,2),
        IN t_cost NUMERIC(25,2)
        IN a_parts VARCHAR(150)
)
BEGIN
    INSERT INTO service_facility(customer_id, sub_total, total_cost, available_parts)
    VALUES (c_id, s_total, t_cost, a_parts);

END //

CALL add_service_facility(01, 6523.00, 7322.12, 'Alternator');

