-- Example SQL for using a SELF JOIN to pull hierarchical relationships such as employee and manager
-- Business Case: Pulling employee/manager data with a self join. Create list of all employees with their employee ID, their name, their manager's name, and their manager's email.
-- If they don't have a manager, meaning their manager email is null, fill it with their employee email
-- COALESCE: Used to return the first non-null value in a list.

-- SQL request(s)​​​​​​‌​‌​​‌​‌​​​‌‌‌‌​​‌​​​‌​‌‌ below
SELECT Employee.EmployeeID, Employee.Name AS Employee_Name, Manager.Name AS Manager_Name, COALESCE(Manager.Email, Employee.Email) AS Contact_Email
FROM Employees Employee
LEFT JOIN Employees Manager
ON Employee.ManagerID = Manager.EmployeeID
WHERE Employee.Department = 'Sales';