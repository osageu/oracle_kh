/*
    < DML (DATA MANIPULATION LANGUAGE) >
    추가, 갱신, 제거

*/
-- 1. INSERT : 테이블에 새로운 행을 추가하는 구문 
-- INSERT INTO TABLE_NAME VALUES (값, 값, 값, ... );
-- : 테이블에 모든 컬럼에 대한 값을 INSERT하고자 할 때 사용, 컬럼 순번을 지켜서 VALUES에 값을 나열!!
INSERT INTO EMPLOYEE 
VALUES(900,'장채현','980914-2156477','jang_ch@kh.or.kr','01011112222', 
        'D1', 'J7',4000000,0.2,200,sysdate,null,default);
        
INSERT INTO EMPLOYEE (EMP_ID, EMP_NAME, EMP_NO, DEPT_CODE, JOB_CODE, HIRE_DATE)
VALUES (901, '강람보', '850918-2514655', 'D1', 'J7', sysdate);

CREATE TABLE EMP_01(
    EMP_ID NUMBER,
    EMP_NAME VARCHAR2(30),
    DEPT_TITLE VARCHAR2(20)
);

SELECT EMP_ID, EMP_NAME, DEPT_TITLE
FROM EMPLOYEE E
LEFT JOIN DEPARTMENT D ON (DEPT_CODE = DEPT_ID);

INSERT INTO EMP_01
    SELECT EMP_ID, EMP_NAME, DEPT_TITLE
    FROM EMPLOYEE E
    LEFT JOIN DEPARTMENT D ON (DEPT_CODE = DEPT_ID);

SELECT * FROM EMP_01;

-- 2. INSERT ALL
CREATE TABLE EMP_DEPT
AS SELECT EMP_ID, EMP_NAME, DEPT_CODE, HIRE_DATE FROM EMPLOYEE WHERE 1 != 1;
CREATE TABLE EMP_MANAGER
AS SELECT EMP_ID, EMP_NAME, MANAGER_ID FROM EMPLOYEE WHERE 1 <> 1;

SELECT EMP_ID, EMP_NAME, DEPT_CODE, HIRE_DATE, MANAGER_ID
FROM EMPLOYEE
WHERE DEPT_CODE = 'D1';

-- EMP_DEPT : 부서코드가 D1인 사원의 사번, 이름, 부서코드, 입사일 삽입
-- EMP_MANAGER : 부서코드가 D1인 사원의 사번, 이름, 사수사번 삽입
INSERT ALL
INTO EMP_DEPT VALUES (EMP_ID, EMP_NAME, DEPT_CODE, HIRE_DATE)
INTO EMP_MANAGER VALUES (EMP_ID, EMP_NAME, MANAGER_ID)
    SELECT EMP_ID, EMP_NAME, DEPT_CODE, HIRE_DATE, MANAGER_ID
    FROM EMPLOYEE
    WHERE DEPT_CODE = 'D1';

SELECT * FROM EMP_DEPT;
SELECT * FROM EMP_MANAGER;

CREATE TABLE EMP_OLD
AS SELECT EMP_ID, EMP_NAME, HIRE_DATE, SALARY
    FROM EMPLOYEE
    WHERE 1 = 0;

CREATE TABLE EMP_NEW
AS SELECT EMP_ID, EMP_NAME, HIRE_DATE, SALARY
    FROM EMPLOYEE
    WHERE 1 = 0;

SELECT * FROM EMP_OLD;
SELECT * FROM EMP_NEW;

SELECT EMP_ID, EMP_NAME, HIRE_DATE, SALARY
FROM EMPLOYEE
WHERE EXTRACT (YEAR FROM HIRE_DATE) >= 2000;

INSERT ALL
WHEN HIRE_DATE < '2000-01-01' THEN
    INTO EMP_OLD VALUES (EMP_ID, EMP_NAME, HIRE_DATE, SALARY)
WHEN HIRE_DATE >= '2000-01-01' THEN
    INTO EMP_NEW VALUES (EMP_ID, EMP_NAME, HIRE_DATE, SALARY)
SELECT EMP_ID, EMP_NAME, HIRE_DATE, SALARY
FROM EMPLOYEE;


-- 3. UPDATE
CREATE TABLE DEPT_COPY
AS SELECT * FROM DEPARTMENT;

UPDATE DEPT_COPY 
SET DEPT_TITLE = '전략기획팀' 
WHERE DEPT_ID = 'D9';

CREATE TABLE EMP_SALARY
AS SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY, BONUS FROM EMPLOYEE;

UPDATE EMP_SALARY
SET SALARY = 1000000
WHERE EMP_NAME = '노옹철';

UPDATE EMP_SALARY
SET SALARY = 7000000, BONUS = 0.2
WHERE EMP_NAME = '선동일';

UPDATE EMP_SALARY
SET SALARY = (SELECT SALARY FROM EMP_SALARY WHERE EMP_NAME = '유재식'),
    BONUS = (SELECT BONUS FROM EMP_SALARY WHERE EMP_NAME = '유재식')
WHERE EMP_NAME = '방명수';

UPDATE EMP_SALARY
SET (SALARY, BONUS) = (SELECT SALARY, BONUS FROM EMP_SALARY WHERE EMP_NAME = '유재식')
WHERE EMP_NAME = '방명수';

UPDATE EMP_SALARY
SET (SALARY, BONUS) = (SELECT SALARY, BONUS FROM EMP_SALARY WHERE EMP_NAME = '유재식')
WHERE EMP_NAME IN ('하동운', '전형돈', '정중하', '노옹철');

SELECT EMP_ID
FROM EMP_SALARY S
JOIN DEPARTMENT D ON (DEPT_CODE = DEPT_ID)
JOIN LOCATION L ON (LOCATION_ID = LOCAL_CODE)
WHERE LOCAL_NAME LIKE 'ASIA%';

UPDATE EMP_SALARY
SET BONUS = 0.3
WHERE EMP_ID IN (SELECT EMP_ID
                 FROM EMP_SALARY S
                 JOIN DEPARTMENT D ON (DEPT_CODE = DEPT_ID)
                 JOIN LOCATION L ON (LOCATION_ID = LOCAL_CODE)
                 WHERE LOCAL_NAME LIKE 'ASIA%');

UPDATE EMPLOYEE
SET DEPT_CODE = 'D0'
WHERE EMP_NAME = '노옹철';

UPDATE EMPLOYEE
SET EMP_NAME = NULL;

COMMIT;

-- 4. DELETE & TRUNCATE

DELETE FROM EMPLOYEE;
SELECT * FROM EMPLOYEE;
SELECT * FROM DEPARTMENT;

ROLLBACK;

DELETE FROM EMPLOYEE
WHERE EMP_NAME = '장채현';
DELETE FROM EMPLOYEE
WHERE EMP_NAME = '강람보';
DELETE FROM DEPARTMENT
WHERE DEPT_ID = 'D3';
DELETE FROM DEPARTMENT
WHERE DEPT_ID = 'D1';

SELECT *  FROM EMP_SALARY;
DELETE FROM EMP_SALARY;
ROLLBACK;

TRUNCATE TABLE EMP_SALARY;
ROLLBACK;









