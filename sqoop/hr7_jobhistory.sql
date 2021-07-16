use hr_db;

INSERT INTO job_history
         VALUES (102
   , STR_TO_DATE('13-JAN-1993', '%d-%M-%Y')
   , STR_TO_DATE('24-JUL-1998', '%d-%M-%Y')
   , 'IT_PROG'
   , 60);
INSERT INTO job_history
         VALUES (101
   , STR_TO_DATE('21-SEP-1989', '%d-%M-%Y')
   , STR_TO_DATE('27-OCT-1993', '%d-%M-%Y')
   , 'AC_ACCOUNT'
   , 110);
INSERT INTO job_history
         VALUES (101
   , STR_TO_DATE('28-OCT-1993', '%d-%M-%Y')
   , STR_TO_DATE('15-MAR-1997', '%d-%M-%Y')
   , 'AC_MGR'
   , 110);
INSERT INTO job_history
         VALUES (201
   , STR_TO_DATE('17-FEB-1996', '%d-%M-%Y')
   , STR_TO_DATE('19-DEC-1999', '%d-%M-%Y')
   , 'MK_REP'
   , 20);
INSERT INTO job_history
         VALUES (114
   , STR_TO_DATE('24-MAR-1998', '%d-%M-%Y')
   , STR_TO_DATE('31-DEC-1999', '%d-%M-%Y')
   , 'ST_CLERK'
   , 50
   );
INSERT INTO job_history
         VALUES (122
   , STR_TO_DATE('01-JAN-1999', '%d-%M-%Y')
   , STR_TO_DATE('31-DEC-1999', '%d-%M-%Y')
   , 'ST_CLERK'
   , 50
   );
INSERT INTO job_history
         VALUES (200
   , STR_TO_DATE('17-SEP-1987', '%d-%M-%Y')
   , STR_TO_DATE('17-JUN-1993', '%d-%M-%Y')
   , 'AD_ASST'
   , 90
   );
INSERT INTO job_history
         VALUES (176
   , STR_TO_DATE('24-MAR-1998', '%d-%M-%Y')
   , STR_TO_DATE('31-DEC-1998', '%d-%M-%Y')
   , 'SA_REP'
   , 80
   );
INSERT INTO job_history
         VALUES (176
   , STR_TO_DATE('01-JAN-1999', '%d-%M-%Y')
   , STR_TO_DATE('31-DEC-1999', '%d-%M-%Y')
   , 'SA_MAN'
   , 80
   );
INSERT INTO job_history
         VALUES (200
   , STR_TO_DATE('01-JUL-1994', '%d-%M-%Y')
   , STR_TO_DATE('31-DEC-1998', '%d-%M-%Y')
   , 'AC_ACCOUNT'
   , 90
   );

COMMIT;
