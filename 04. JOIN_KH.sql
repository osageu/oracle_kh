/*
    < JOIN >
    두 개 이상의 테이블에서 데이터를 조회하고자 할 때 사용되는 구문
    조회 결과는 하나의 결과물 (RESULT SET)로 나옴
    
    관계형 데이터베이스는 최소한의 데이터로 각각의 테이블에 담고 있음 (중복 최소화)
    --> 즉, 관계형 데이터베이스에서 SQL문을 이용한 테이블간 "관계"를 맺는 방법
    
    무작정 데이터를 가져오는게 아닌 테이블간 연결고리로 관계가 맺어진 데이터를 매칭시켜 조회해야 함
        
*/

-- 1. 등가 조인 (EQUAL JOIN) / 내부 조인 (INNER JOIN)
-- 연결시키는 Column이 일치하는 행들만 조인되서 조회 (일치안하면 조회X)
-- 1.1 오라클 구문 : FROM 절에 조회하고자 하는 테이블들 나열 (, 구분자로), WHERE 절에 매칭시킬 Column (연결고리)에 대한 조건 제시
SELECT EMP_ID, EMP_NAME, DEPT_CODE, DEPT_TITLE
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE = DEPT_ID;

SELECT EMP_NAME, EMPLOYEE.JOB_CODE ,JOB_NAME
FROM EMPLOYEE, JOB
WHERE EMPLOYEE.JOB_CODE = JOB.JOB_CODE;

-- 별칭 이용
SELECT EMP_NAME, E.JOB_CODE ,JOB_NAME
FROM EMPLOYEE E, JOB J
WHERE E.JOB_CODE = J.JOB_CODE;

-- 1.2 ANSI 구문 : FROM 절에 기준이 되는 테이블을 하나 제시한 후 JOIN 절에서 같이 조회하고자 하는 테이블 기술 후 매칭시킬 Column에 대한 조건 제시
-- 1) 연결할 두 Column이 다른 경우 (EMPLOYEE : DEPT_CODE / DEPARTMENT : DEPT_ID) --> ON
SELECT EMP_ID, EMP_NAME, DEPT_TITLE
FROM DEPARTMENT
JOIN EMPLOYEE ON DEPT_CODE = DEPT_ID
ORDER BY 3;

-- 2) 연결할 두 Column이 같은 경우 (EMPLOYEE : JOB_CODE / DEPARTEMNT : JOB_CODE) --> USING
SELECT EMP_ID, EMP_NAME, JOB_CODE, JOB_NAME
FROM EMPLOYEE
JOIN JOB USING (JOB_CODE)
ORDER BY 3;

SELECT EMP_ID, EMP_NAME, E.JOB_CODE, JOB_NAME
FROM EMPLOYEE E
JOIN JOB  J ON (E.JOB_CODE = J.JOB_CODE)
ORDER BY 3;

-- 3) NATURAL JOIN
SELECT EMP_ID, EMP_NAME, JOB_CODE, JOB_NAME
FROM EMPLOYEE E
NATURAL JOIN JOB J
ORDER BY 3;

-- Oracle
SELECT EMP_ID, EMP_NAME, JOB_NAME, SALARY
FROM EMPLOYEE E, JOB J
WHERE E.JOB_CODE = J.JOB_CODE
AND E.JOB_CODE = 'J6';

-- ANSI
SELECT EMP_ID, EMP_NAME, JOB_NAME, SALARY
FROM EMPLOYEE
NATURAL JOIN JOB
WHERE JOB_NAME = '대리';

---------------------------------------------------------- <실 습> ---------------------------------------------------------------
SELECT * FROM DEPARTMENT;
SELECT * FROM LOCATION;

-- 부서코드, 부서명, 지역코드, 지역명 조회
-- ORACLE
SELECT DEPT_ID 부서코드, DEPT_TITLE 부서명, LOCAL_CODE 지역코드, LOCAL_NAME 지역명
FROM DEPARTMENT E, LOCATION L
WHERE E.LOCATION_ID = L.LOCAL_CODE;

-- ANSI
SELECT DEPT_ID 부서코드, DEPT_TITLE 부서명, LOCAL_CODE 지역코드, LOCAL_NAME 지역명
FROM DEPARTMENT
JOIN LOCATION ON LOCATION_ID = LOCAL_CODE;

-- 보너스를 받는 사원들의 사번, 사원명, 보너스, 부서명 조회
-- ORACLE
SELECT EMP_ID 사번, EMP_NAME 이름, BONUS 보너스, DEPT_TITLE 부서명
FROM EMPLOYEE E, DEPARTMENT D
WHERE E.DEPT_CODE = D.DEPT_ID
AND BONUS IS NOT NULL;

-- ANSI
SELECT EMP_ID 사번, EMP_NAME 이름, BONUS 보너스, DEPT_TITLE 부서명
FROM EMPLOYEE E
JOIN DEPARTMENT D ON E.DEPT_CODE = D.DEPT_ID
WHERE BONUS IS NOT NULL; 

-- 인사관리부가 아닌 사원들의 사원명, 급여 조회
-- ORACLE
SELECT EMP_NAME 사원명, SALARY 급여, DEPT_TITLE
FROM EMPLOYEE E, DEPARTMENT D
WHERE E.DEPT_CODE = D.DEPT_ID
AND DEPT_TITLE <> '인사관리부';

-- ANSI
SELECT EMP_NAME 사원명, SALARY 급여, DEPT_TITLE
FROM EMPLOYEE 
JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
WHERE DEPT_TITLE ^= '인사관리부';

-- 사번, 사원명, 부서명, 직급명
-- ORACLE
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, JOB_NAME
FROM EMPLOYEE E, DEPARTMENT D, JOB J
WHERE DEPT_CODE = DEPT_ID AND E.JOB_CODE = J.JOB_CODE;

-- ANSI
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, JOB_NAME
FROM EMPLOYEE E
JOIN DEPARTMENT D ON D.DEPT_ID = E.DEPT_CODE
JOIN JOB J USING(JOB_CODE); 

------------------------------------------------------------ <실습> -------------------------------------------------------------------------

-- 2. 포괄 조인 / 외부 조인
-- : 두 테이블 간의 JOIN 시 일치하지 않는 행도 포함시켜서 조회 가능. 단, LEFT / RIGHT를 지정해줘야 함
-- : OUTER JOIN과 비교할 INNER JOIN 구해놓기
-- 1) LEFT [OUTER] JOIN : 두 테이블 중 왼편에 기술된 테이블의 Column을 기준으로 JOIN
-- ORACLE
SELECT EMP_NAME, DEPT_TITLE, SALARY, SALARY*12
FROM EMPLOYEE E, DEPARTMENT D
WHERE DEPT_CODE = DEPT_ID(+);

-- ANSI
SELECT EMP_NAME, DEPT_TITLE, SALARY, SALARY*12
FROM EMPLOYEE
LEFT JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID;
--> 부서코드가 없던 사원 (하동운, 이오리)의 정보도 나옴

-- 2) RIGHT [OUTER] JOIN : 두 테이블 중 오른편에 기술된 테이블의 Column을 기준으로 JOIN
-- ORACLE
SELECT EMP_NAME, DEPT_TITLE, SALARY, SALARY*12
FROM DEPARTMENT D, EMPLOYEE E
WHERE DEPT_CODE(+) = DEPT_ID;

-- ANSI
SELECT EMP_NAME, DEPT_TITLE, SALARY, SALARY*12
FROM EMPLOYEE
RIGHT JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID;

-- 3) FULL [OUTER] JOIN : 두 테이블 모든 정보를 조회
-- ANSI
SELECT EMP_NAME, DEPT_TITLE, SALARY, SALARY*12
FROM EMPLOYEE
FULL JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID;

-- 3. 카타시안 곱 / 교차 조인
-- : 조인되는 모든 테이블의 각 행들이 서로서로 모두 MAPPING된 데이터가 검색됨 (곱집합)
-- : 두 테이블의 행들이 모두 곱해진 행들의 조합이 출력 --> 방대한 데이터 출력 --> 과부하의 위험

-- 사원명, 부서명
-- 1) ORACLE
SELECT EMP_NAME, DEPT_TITLE
FROM EMPLOYEE, DEPARTMENT; -- 23 * 9 = 207

-- 2) ANSI
SELECT EMP_NAME, DEPT_TITLE
FROM EMPLOYEE
CROSS JOIN DEPARTMENT;

-- 4. 비등가 조인 / JOIN ON
-- : '='를 사용하지 않는 조인
-- : 지정한 Column 값이 일치하는 경우가 아닌, 값의 "범위"에 포함되는 행들을 연결하는 방식
-- EMPLOYEE의 SAL_LEVEL 지우자!
ALTER TABLE EMPLOYEE DROP COLUMN SAL_LEVEL;
-- 사원명, 급여, 급여등급
-- 1) ORACLE
SELECT EMP_NAME, SALARY, SAL_LEVEL
FROM EMPLOYEE, SAL_GRADE
-- WHERE SALARY >= MIN_SAL AND SALARY <= MAX_SAL;
WHERE SALARY BETWEEN MIN_SAL AND MAX_SAL;

-- 2) ANSI
SELECT EMP_NAME, SALARY, SAL_LEVEL
FROM EMPLOYEE
JOIN SAL_GRADE ON SALARY BETWEEN MIN_SAL AND MAX_SAL;

-- 5 .자체 조인
-- : 같은 테이블을 조인하는 경우
-- 각각의 사원의 사원사번, 사원명, 부서코드, 사수사번, 사수명 조회
-- 1) ORACLE
SELECT E.EMP_ID, E.EMP_NAME, E.DEPT_CODE, E.MANAGER_ID, J.EMP_NAME, J.DEPT_CODE, J.SALARY
FROM EMPLOYEE E, EMPLOYEE J
WHERE E.MANAGER_ID = J.EMP_ID(+);

-- 2) ANSI
SELECT E.EMP_ID 사원사번, E.EMP_NAME 사원명, E.JOB_CODE 사원직급코드,
          M.EMP_ID 사수사번, M.EMP_NAME 사수명, M.JOB_CODE 사수직급코드
FROM EMPLOYEE E
LEFT JOIN EMPLOYEE M ON (E.MANAGER_ID = M.EMP_ID);

-- 6. 다중 조인
-- : N개의 테이블을 조인
-- 사번, 사원명, 부서명, 지역명 조회
-- 1) ORACLE
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, LOCAL_NAME
FROM EMPLOYEE E, DEPARTMENT D, LOCATION L
WHERE DEPT_ID(+) = DEPT_CODE
AND LOCATION_ID = LOCAL_CODE(+);

-- 2) ANSI
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, LOCAL_NAME
FROM EMPLOYEE
LEFT JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
LEFT JOIN LOCATION ON LOCATION_ID = LOCAL_CODE;

------------------------------------------------------ <실습>----------------------------------------------------------
-- 1. 사번, 사원명, 부서명, 지역명, 국가명 조회
-- ORACLE
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, LOCAL_NAME, N.NATIONAL_NAME
FROM EMPLOYEE E, DEPARTMENT D, LOCATION L, NATIONAL N
WHERE DEPT_CODE = DEPT_ID
AND LOCATION_ID = LOCAL_CODE
AND L.NATIONAL_CODE = N.NATIONAL_CODE;

-- ANSI
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, LOCAL_NAME, N.NATIONAL_NAME
FROM EMPLOYEE E
JOIN DEPARTMENT D ON DEPT_CODE = DEPT_ID
JOIN LOCATION L ON LOCATION_ID = LOCAL_CODE
JOIN NATIONAL N ON L.NATIONAL_CODE = N.NATIONAL_CODE;

-- 2. 사번, 사원명, 부서명, 직급명, 지역명, 국가명, 급여등급 조회
-- ORACLE
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, JOB_NAME, LOCAL_NAME, N.NATIONAL_NAME, SAL_LEVEL
FROM EMPLOYEE E, DEPARTMENT D, LOCATION L, NATIONAL N, JOB J, SAL_GRADE S
WHERE DEPT_CODE = DEPT_ID
AND LOCATION_ID = LOCAL_CODE
AND L.NATIONAL_CODE = N.NATIONAL_CODE
AND J.JOB_CODE = E.JOB_CODE
AND SALARY BETWEEN MIN_SAL AND MAX_SAL;

-- ANSI
SELECT EMP_ID 사번, 
        EMP_NAME 사원명,
        DEPT_TITLE 부서명,
        JOB_NAME 직급명, 
        LOCAL_NAME 지역명,
        N.NATIONAL_NAME 국가명, 
        SAL_LEVEL 급여등급
FROM EMPLOYEE E
JOIN DEPARTMENT D ON DEPT_CODE = DEPT_ID
JOIN LOCATION L ON LOCATION_ID = LOCAL_CODE
JOIN NATIONAL N ON L.NATIONAL_CODE = N.NATIONAL_CODE
JOIN JOB J ON E.JOB_CODE = J.JOB_CODE
JOIN SAL_GRADE ON SALARY BETWEEN MIN_SAL AND MAX_SAL;










































