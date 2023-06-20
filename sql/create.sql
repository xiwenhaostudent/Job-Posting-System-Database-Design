-- CREATE DATABASE JOBSEEKING

use JOBSEEKING
-- Table [account]
CREATE TABLE [account]
(
  [accountID] INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
  [email] VARCHAR(50),
  [password] VARCHAR(500),
  [accountType] VARCHAR(20) CHECK ([accountType] IN ('company', 'individual'))
)
;

CREATE TABLE [address] 
(
  [addressID] INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
  [address] VARCHAR(255),
  [city] VARCHAR(20),
  [state] VARCHAR(20),
  [zipcode] VARCHAR(10),
  [country] VARCHAR(20),
)

-- Table [company]
CREATE TABLE [company]
(
  [companyID] INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
  [name] VARCHAR(255),
  [location] VARCHAR(255),
  [foundYear] VARCHAR(4),
  [industry] VARCHAR(20),
  [description] TEXT,
  [website] VARCHAR(255),
  [logoPath] VARCHAR(255),
  [accountID] INT NOT NULL,
  CONSTRAINT [FK_company_accountID] FOREIGN KEY ([accountID]) REFERENCES [account] ([accountID])
);

-- Table Position

CREATE TABLE [position]
(
  [positionID] INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
  [title] VARCHAR(100),
  [jobDescription] TEXT,
  [employmentType] VARCHAR(20),
  [salary] VARCHAR(50),
  [publishTime] DATETIME DEFAULT CURRENT_TIMESTAMP,
  [companyID] INT NOT NULL,
  CONSTRAINT [FK_position_companyId] FOREIGN KEY ([companyID]) REFERENCES [company] ([companyID])
)
;


-- Table [profile]

CREATE TABLE [profile]
(
  [profileID] INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
  [firstName] VARCHAR(50),
  [lastName] VARCHAR(50),
  [email] VARCHAR(50),
  [phone] VARCHAR(20),
  [addressID] INT,
  [summary] TEXT,
  [portraitPath] VARCHAR(255),
  [accountID] INT NOT NULL,
  CONSTRAINT [FK_profile_addressID] FOREIGN KEY ([addressID]) REFERENCES [address] ([addressID]),
  CONSTRAINT [FK_profile_accountID] FOREIGN KEY ([accountID]) REFERENCES [account] ([accountID])
)
;

-- Table PersonExperience

CREATE TABLE [experience]
(
  [experienceID] INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
  [title] VARCHAR(50),
  [companyName] VARCHAR(20),
  [location] VARCHAR(20),
  [fromDate] DATE,
  [toDate] DATE,
  [description] TEXT,
  [profileID] INT NOT NULL,
  [employmentType] VARCHAR(20),
  CONSTRAINT [FK_experience_profileId] FOREIGN KEY ([profileID]) REFERENCES [profile] ([profileID]) 
)
;

-- Table EducationBackground

CREATE TABLE [eduBackground]
(
  [eduBackgroundID] INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
  [university] VARCHAR(50),
  [degree] VARCHAR(20),
  [major] VARCHAR(50),
  [activity] TEXT,
  [fromYear] VARCHAR(4),
  [toYear] VARCHAR(4),
  [description] TEXT,
  [profileID] INT NOT NULL,
  [grade] VARCHAR(20),
  CONSTRAINT [FK_eduBackground_profileId] FOREIGN KEY ([profileID]) REFERENCES [profile] ([profileID]) 
)
;

-- Table PersonSkills

CREATE TABLE [personSkills]
(
  [profileID] INT NOT NULL,
  [skill] VARCHAR(50) NOT NULL,
  [skillDescription] TEXT,
  PRIMARY KEY ([profileID], [skill]),
  CONSTRAINT [FK_personSkills_profileId] FOREIGN KEY ([profileID]) REFERENCES [profile] ([profileID]) 
)
;


-- Table Application

CREATE TABLE [application]
(
  [applicationID] INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
  [accountID] INT NOT NULL,
  [positionID] INT NOT NULL,
  [firstName] VARCHAR(20),
  [lastName] VARCHAR(20),
  [email] VARCHAR(50),
  [phone] VARCHAR(20),
  [addressID] INT,
  [resumePath] VARCHAR(255),
  [workBeginDate] DATETIME,
  [website] VARCHAR(255),
  [status] VARCHAR(50),
  [applicationTime] DATETIME DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT [FK_application_accountID] FOREIGN KEY ([accountID]) REFERENCES [account] ([accountID]),
  CONSTRAINT [FK_application_positionID] FOREIGN KEY ([positionID]) REFERENCES [position] ([positionID]),
  CONSTRAINT [FK_application_addressID] FOREIGN KEY ([addressID]) REFERENCES [address] ([addressID])
)
;

-- Table Feedback

CREATE TABLE [feedback]
(
  [feedbackID] INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
  [result] VARCHAR(50),
  [InterviewTime] DATETIME,
  [InterviewLocation] VARCHAR(255),
  [comments] TEXT,
  [applicationID] INT NOT NULL,
  [applicationTime] DATETIME DEFAULT CURRENT_TIMESTAMP, 
  CONSTRAINT [FK_feedback_positionID] FOREIGN KEY ([applicationID]) REFERENCES [application] ([applicationID])
)
;

CREATE INDEX [idx_company_name] ON [company] ([name])
CREATE INDEX [idx_profile_firstName] ON [profile] ([firstName])
CREATE INDEX [idx_profile_lastName] ON [profile] ([lastName])
CREATE INDEX [idx_position_title] ON [position] ([title])

