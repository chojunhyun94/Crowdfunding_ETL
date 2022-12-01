-- Challenge Bonus queries.
-- 1. (2.5 pts)
-- Retrieve all the number of backer_counts in descending order for each `cf_id` for the "live" campaigns. 
SELECT ca.cf_id,
	ca.backers_count,
	ca.outcome
FROM campaign as ca
WHERE ca.outcome = 'live'
ORDER BY backers_count DESC;
	


-- 2. (2.5 pts)
-- Using the "backers" table confirm the results in the first query.
SELECT  cf_id, COUNT(b.cf_id)
FROM backers AS b
GROUP BY cf_id
ORDER BY COUNT(b.cf_id) DESC;


-- 3. (5 pts)
-- Create a table that has the first and last name, and email address of each contact.
-- and the amount left to reach the goal for all "live" projects in descending order. 
SELECT ca.contact_id,
		co.first_name,
		co.last_name,
		co.email,
		ca.goal - ca.pledged AS "amount_remaining"
INTO live_remaining
FROM campaign AS ca
INNER JOIN contacts AS co
ON (ca.contact_id = co.contact_id)
WHERE ca.outcome = 'live'
ORDER BY amount_remaining DESC;


-- Check the table
SELECT * FROM live_remaining;

-- 4. (5 pts)
-- Create a table, "email_backers_remaining_goal_amount" that contains the email address of each backer in descending order, 
-- and has the first and last name of each backer, the cf_id, company name, description, 
-- end date of the campaign, and the remaining amount of the campaign goal as "Left of Goal". 
SELECT co.email,
	ba.first_name,
	ba.last_name,
	ca.cf_id,
	ca.company_name,
	ca.description,
	ca.end_date,
	ca.goal - ca.pledged AS "remaining_goal_amount"
INTO email_backers_remaining_goal_amount
FROM campaign AS ca
INNER JOIN contacts AS co
ON (co.contact_id = ca.contact_id)
INNER JOIN backers as ba
ON (ca.cf_id = ba.cf_id)
WHERE ca.outcome = 'live'
ORDER BY last_name;


-- Check the table
SELECT * FROM email_backers_remaining_goal_amount

