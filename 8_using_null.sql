-- 1. List the teachers who have NULL for their department.
SELECT name
FROM teacher
WHERE dept IS NULL;

-- 2. Note the INNER JOIN misses the teachers with no department and the departments with no teacher.
SELECT
    teacher.name as teacher
  , dept.name as dept
FROM teacher
JOIN dept
  ON (teacher.dept=dept.id);

-- 3. Use a different JOIN so that all teachers are listed.
SELECT
    t.name
  , d.name as dept
FROM teacher AS t
LEFT JOIN dept AS d
  ON t.dept = d.id;

-- 4. Use a different JOIN so that all departments are listed.
SELECT
    t.name
  , d.name
FROM dept AS d
LEFT JOIN teacher AS t
  ON t.dept = d.id;

-- 5. Use COALESCE to print the mobile number. Use the number '07986 444 2266' if there is no number given. Show teacher name and mobile number or '07986 444 2266'
SELECT
    name
  , COALESCE(mobile, '07986 444 2266')
FROM teacher;

-- 6. Use the COALESCE function and a LEFT JOIN to print the teacher name and department name. Use the string 'None' where there is no department.
SELECT
    t.name
  , COALESCE(d.name, 'None') as dept
FROM teacher AS t
LEFT JOIN dept AS d
ON d.id = t.dept;

-- 7. Use COUNT to show the number of teachers and the number of mobile phones.
SELECT
    COUNT(name) AS num_teachers
  , COUNT(mobile) AS num_mobiles
 FROM teacher;

-- 8. Use COUNT and GROUP BY dept.name to show each department and the number of staff. Use a RIGHT JOIN to ensure that the Engineering department is listed.
SELECT
    d.name
  , COUNT(t.name) AS num_teachers
FROM dept AS d
LEFT JOIN teacher AS t
  ON d.id = t.dept
GROUP BY d.name;

-- 9. Use CASE to show the name of each teacher followed by 'Sci' if the teacher is in dept 1 or 2 and 'Art' otherwise.
SELECT
    name
  , (CASE WHEN dept IN (1,2) THEN 'Sci'
    ELSE 'Art' END) AS dept_type
FROM teacher;

-- 10. Use CASE to show the name of each teacher followed by 'Sci' if the teacher is in dept 1 or 2, show 'Art' if the teacher's dept is 3 and 'None' otherwise.
SELECT
    name
  , (CASE WHEN dept IN (1,2) THEN 'Sci'
    WHEN dept = 3 THEN 'Art'
    ELSE 'None' END) AS dept_type
FROM teacher;
