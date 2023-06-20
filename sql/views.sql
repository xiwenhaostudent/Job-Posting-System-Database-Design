-- TOP 5 popular positions
go
CREATE VIEW TOP5PopularPositions
AS
SELECT p.*, t.applicantsNumber 
FROM position p JOIN (
SELECT TOP 5 p.positionID, count(p.positionID) AS applicantsNumber
FROM [application] a JOIN position p ON a.positionid = p.positionid
GROUP BY p.positionID
ORDER BY count(p.positionID) DESC
) AS t ON p.positionID = t.positionID



-- TOP 5 popular companies
go
CREATE VIEW TOP5PopularCompanies
AS

SELECT c.*, t.applicantsNumber
FROM company c JOIN 
(SELECT TOP 5 p.companyid, count(p.companyid) AS applicantsNumber
FROM [application] a JOIN position p 
ON a.positionid = p.positionid
GROUP BY p.companyid
ORDER BY count(p.companyid) DESC
) AS t ON c.companyID = t.companyID


-- TOP 5 popular skills
go
CREATE VIEW TOP5PopularSkills
AS
SELECT TOP 5 s.skill, count(s.skill) AS [count] 
FROM personSkills s
GROUP BY s.skill
ORDER BY count(s.skill) DESC

-- TOP 5 popular universities

CREATE VIEW TOP5PopularUniversities
AS
SELECT TOP 5 e.university, count(e.university) AS [count] 
FROM eduBackground e
GROUP BY e.university
ORDER BY count(e.university) DESC


-- TOP 5 popular universities

CREATE VIEW TOP5PopularMajors
AS
SELECT TOP 5 e.major, count(e.major) AS [count] 
FROM eduBackground e
GROUP BY e.major
ORDER BY count(e.major) DESC

-- relationship between grade and company
CREATE VIEW relationship_grade_company
AS

SELECT p.firstName, p.lAStName, e.grade, c.name, f.result
FROM company c
INNER JOIN position po
ON c.companyID = po.companyID
INNER JOIN [application] a
ON po.positionID = a.positionID
INNER JOIN [feedback] f
ON a.applicationID = f.applicationID
INNER JOIN [profile] p
ON a.accountID = p.accountID
INNER JOIN [eduBackground] e
ON p.profileID = e.profileID
WHERE e.grade > 3.5

