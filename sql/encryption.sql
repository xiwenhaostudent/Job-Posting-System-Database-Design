/* TDE Column Level encryption in SQL Server
	Similar to other Database vendors 

Hierarchy
MASTER KEY
	CERTIFICATE
		ENCRYPTION KEYS (SYMMETRIC/ASYMEMETRIC)*/

--Modify the employee table by adding two columns username and Password columns

alter table dbo.account add [encryped]  varbinary(400)

--Create a master key for the database. 
create MASTER KEY
ENCRYPTION BY PASSWORD = 'JOBSEEKING';
-- drop master key 

-- very that master key exists
SELECT name KeyName,
  symmetric_key_id KeyID,
  key_length KeyLength,
  algorithm_desc KeyAlgorithm
FROM sys.symmetric_keys;

go
--Create a self signed certificate and name it EmpPass
CREATE CERTIFICATE EmpPass  
   WITH SUBJECT = 'Employee Sample Password';  
GO  

-- drop CERTIFICATE EmpPass  

--Create a symmetric key  with AES 256 algorithm using the certificate
-- as encryption/decryption method

CREATE SYMMETRIC KEY EmpPass_SM 
    WITH ALGORITHM = AES_256  
    ENCRYPTION BY CERTIFICATE EmpPass;  
GO  
--drop SYMMETRIC KEY EmpPass_SM 

--Now we are ready to encrypt the password and also decrypt

-- Open the symmetric key with which to encrypt the data.  
OPEN SYMMETRIC KEY EmpPass_SM  
   DECRYPTION BY CERTIFICATE EmpPass;  

-- Encrypt the value in column Password  with symmetric  key, and default everyone with
-- a password of Pass1234  
UPDATE dbo.account set [encryped] = EncryptByKey(Key_GUID('EmpPass_SM'),  convert(varbinary, account.[password])  ) 
GO  

select * from dbo.account