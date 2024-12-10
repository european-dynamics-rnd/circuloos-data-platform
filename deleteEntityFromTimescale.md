When a entity from the Orion-LD is deleted, the data remaining on the Timescale DB and Mintaka can return them. So we need to delete them from the database

# Select

SELECT * 
FROM public."attributes"
WHERE entityid = 'urn:ngsi-ld:circuloos:demo_1:ieq-001';
SELECT *
FROM public."entities"
WHERE id= 'urn:ngsi-ld:circuloos:demo_1:ieq-001' ;

# Select with between timestamps

SELECT * 
FROM public."attributes"
WHERE entityid = 'urn:ngsi-ld:circuloos:demo_1:ieq-001' 
  AND observedat BETWEEN '2024-01-11 10:10:00' AND '2024-01-11 10:20:00'; 

# Deletes 


DELETE FROM public."attributes"
WHERE entityid = 'urn:ngsi-ld:circuloos:demo_1:ieq-001';
DELETE FROM public."entities"
WHERE id= 'urn:ngsi-ld:circuloos:demo_1:ieq-001' ;
