-- find all active application of a position

CREATE PROCEDURE positionApplication
@positionID INT
AS
BEGIN
SELECT * 
FROM [application] a
WHERE a.positionID = 10 AND a.[status] <> 'reject'
END


-- find all applicants of a position who hAS the specific skill

CREATE PROCEDURE positionSkillsApplicants
@positionID INT,
@skillName VARCHAR(50)
AS
BEGIN
SELECT a.* 
FROM [profile] p JOIN [application] a 
ON p.accountID = a.accountID 
JOIN position pos 
ON a.positionID = pos.positionID
JOIN personSkills ps
ON ps.profileID = p.profileID
WHERE  pos.positionID = @positionID
and ps.skill = @skillname
END

-- find all positions which contains a key word ORDER BY posted date
CREATE PROCEDURE findPositions
@keyword VARCHAR(100),
@employmentType VARCHAR(20)
AS
BEGIN
	
	SELECT p.*
	FROM position p
	WHERE p.title LIKE '%' + @keyword + '%' and p.employmentType = @employmentType
	ORDER BY p.publishTime DESC
END

-- find all applicants of a position who has work experience
CREATE PROCEDURE findExpdApplicants
@positionID INT
AS
BEGIN
	SELECT a.*
	FROM [application] a 
	WHERE a.positionID = @positionID AND a.[status] <> 'reject' AND a.accountID IN 
		(SELECT p.accountID 
		FROM [profile] p JOIN [experience] e 
		ON p.profileID = e.profileID)
END

-- find all applicants of a position who's work begin date early than a certain date 

CREATE PROCEDURE findAvailApplicants
@positionID INT,
@BEGINDate Datetime
AS
BEGIN
	SELECT a.*
	FROM [application] a 
	WHERE a.positionID = @positionID AND a.[status] <> 'reject' AND a.workBeginDate <= @BEGINDate
END

--find company name bASed on the account id

alter PROCEDURE find_companyid1
@accountid INT,
@companyname VARCHAR(100) OUTPUT
AS
BEGIN
SELECT @companyname = c.[name] 
FROM company c JOIN position po ON c.companyID = po.companyID
	JOIN [application] a ON po.positionID = a.positionID 
	JOIN [profile] p ON a.accountID = p.accountID 
WHERE @accountid = p.profileID
END

--find the grade and degree by name

CREATE PROCEDURE application_experience
@firstname VARCHAR(20),
@lAStname VARCHAR(20),
@grade VARCHAR(20) OUTPUT,
@degree VARCHAR(50) OUTPUT
AS
BEGIN
SELECT @grade = e.grade, @degree = e.degree 
FROM [profile] p JOIN eduBackground e ON p.profileID = e.profileID
WHERE @firstname = p.firstName AND @lAStname = p.lAStName
END

--find the application status by name

CREATE PROCEDURE firstname_lastname_feedbackresult
@firstname VARCHAR(20),
@lAStname VARCHAR(20),
@feedback VARCHAR(20) OUTPUT
AS
BEGIN
SELECT @feedback = f.result 
FROM [profile] p JOIN [application] a ON p.accountID = a.accountID JOIN feedback f ON a.applicationID = f.applicationID
WHERE @firstname = p.firstName AND @lAStname = p.lAStName
END

--find the position by account id

CREATE PROCEDURE accountid_position
@accountid INT,
@position VARCHAR(100) OUTPUT
AS
BEGIN
SELECT @position = p.title 
FROM account a JOIN company c 
	ON a.accountID = c.accountID 
	JOIN position p 
	ON c.companyID = p.companyID
END







