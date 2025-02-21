DELIMITER //
CREATE PROCEDURE `lead_gen_business`.`Leads_Sites`(IN p_site_id INT, IN p_leads_id INT)
BEGIN
	SELECT 
		*
	FROM 
		lead_gen_business.leads
	WHERE 
		site_id = p_site_id
	AND
		leads_id = p_leads_id;
END //
DELIMITER ;

CALL lead_gen_business.Leads_Sites(6, 7);