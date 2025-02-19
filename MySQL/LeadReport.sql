-- 1. What query would you run to get all the sites that client=15 owns?
SELECT 
	s.domain_name AS Website, 
    s.client_id
FROM lead_gen_business.sites s
	WHERE s.client_id = 15
;

-- 2. What query would you run to get total count of domain created for June 2011?
SELECT monthname(s.created_datetime) AS month, count(s.site_id) AS total_count
	FROM lead_gen_business.sites s
    WHERE monthname(s.created_datetime) = 'June'
    AND year(s.created_datetime) = '2011'
;

-- 3. What query would you run to get the total revenue for the date November 19th 2012?
SELECT str_to_date(b.charged_datetime, "%Y-%m-%d") AS date, 
	sum(b.amount) AS revenue
FROM lead_gen_business.billing b
    WHERE str_to_date(b.charged_datetime, "%Y-%m-%d") = '2012-11-19'
;

-- 4. What query would you run to get total revenue earned monthly each year for the client with an id of 1?
SELECT b.client_id, b.amount AS total_revenue, 
	monthname(b.charged_datetime) AS month, 
    year(b.charged_datetime) AS year 
FROM lead_gen_business.billing b
	GROUP BY b.client_id, YEAR(b.charged_datetime), MONTH(b.charged_datetime)
    HAVING b.client_id = 1
;

-- 5. What query would you run to get total revenue of each client every month per year? Order it by client id.
SELECT 
	concat(c.first_name, ' ', c.last_name) AS client_name,  
    b.amount AS total_revenue, monthname(b.charged_datetime) AS month_charged, year(b.charged_datetime) AS year_charged
FROM lead_gen_business.clients c
	JOIN 
		lead_gen_business.billing b
			ON b.client_id  =  c.client_id
		GROUP BY client_name, month_charged, year_charged
        ORDER BY c.client_id, b.charged_datetime
;

-- 6. What query would you run to get which sites generated leads between March 15, 2011 to April 15, 2011? Show how many leads for each site. 
SELECT 
	s.domain_name AS website,
    count(l.leads_id) AS number_of_leads
FROM lead_gen_business.leads l
	JOIN lead_gen_business.sites s
		ON s.site_id = l.site_id
	WHERE str_to_date(l.registered_datetime, "%Y-%m-%d") BETWEEN "2011-03-15" AND "2011-04-15"
	GROUP BY s.site_id
;

-- 7. What query would you run to show all the site owners, the site name(s), and the total number of leads generated from each site for all time?
SELECT 
	concat(c.first_name, ' ', c.last_name) AS client_name,
    s.domain_name,
    count(l.site_id) AS num_leads
FROM 
	lead_gen_business.clients c
JOIN 
	lead_gen_business.sites s
    ON s.client_id = c.client_id
JOIN lead_gen_business.leads l
	ON l.site_id = s.site_id
GROUP BY l.site_id
ORDER BY c.client_id, s.domain_name
;

-- 8. What query would you run to get a list of site owners who had leads, and the total of each for the whole 2012?


-- 9. What query would you run to get a list of site owners and the total # of leads we've generated for each owner per month for the first half of Year 2012?

-- 10. Write a single query that retrieves all the site names that each client owns and its total count. Group the results so that each row shows a new client. (Tip: use GROUP_CONCAT)