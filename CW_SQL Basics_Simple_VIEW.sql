/*For this challenge you need to create a VIEW. This VIEW is used by 
a sales store to give out vouches to members who have spent over $1000 
in departments that have brought in more than $10000 total ordered 
by the members id. The VIEW must be called members_approved_for_voucher 
then you must create a SELECT query using the view.
*/
CREATE VIEW members_approved_for_voucher AS
SELECT s.member_id id, m.name, m.email, SUM(p.price) total_spending 
FROM sales s
LEFT JOIN products p ON s.product_id = p.id
LEFT JOIN members m ON s.member_id = m.id
WHERE s.department_id IN (
    SELECT s.department_id
    FROM sales s
    JOIN products p ON s.product_id = p.id
    GROUP BY s.department_id
    HAVING SUM(p.price) > 10000
    )
GROUP BY s.member_id, m.name, m.email
HAVING SUM(p.price) > 1000
ORDER BY s.member_id;

SELECT *
FROM members_approved_for_voucher;