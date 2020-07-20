-- 하나의 PL-SQL BLOCK

SET SERVEROUTPUT ON;

BEGIN
DBMS_OUTPUT.PUT_LINE('HELLO ORACLE'); 
END;
/
--> 환경변수 켜줘야 함 (OFF --> ON)

------------------------------------------------------------------------------------------------------------------------
-- 1. DECLARE 선언부
-- : 변수 및 상수 선언해 놓는 공간 (초기화도 가능)
-- : 일반타입변수, 레퍼런스타입변수, ROW타입변수

-- 1-1) 일반타입변수 선언 및 초기화
DECLARE
    EID NUMBER;
    ENAME VARCHAR2(30);
    PI CONSTANT NUMBER := 3.14;
BEGIN
    EID := 888;
    ENAME := '배장남';
    
    DBMS_OUTPUT.PUT_LINE('EID : ' || EID);
    DBMS_OUTPUT.PUT_LINE('ENAME : ' || ENAME);
    DBMS_OUTPUT.PUT_LINE('PI : ' || PI);
END;
/
    
-- 1-2) 레퍼런스타입변수 선언 및 초기화
DECLARE 
    EID EMPLOYEE.EMP_ID%TYPE;
    ENAME EMPLOYEE.EMP_NAME%TYPE;    
    SAL EMPLOYEE.SALARY%TYPE;
BEGIN
    SELECT EMP_ID, EMP_NAME, SALARY
    INTO EID, ENAME, SAL
    FROM EMPLOYEE
    WHERE EMP_NAME = '&NAME'; --> '&'는 대체변수를 입력하기 위한 창이 뜨게 해주는 구문
    DBMS_OUTPUT.PUT_LINE('EID : ' || EID);
    DBMS_OUTPUT.PUT_LINE('ENAME : ' || ENAME);
    DBMS_OUTPUT.PUT_LINE('SAL : ' || SAL);
END;
 /

-- <실습> --
-- 레퍼런스타입변수로 EID, ENAME, JCODE, DTITLE, SAL을 선언하고
-- 각 자료형은 각각 EMP_ID, EMP_NAME, JOB_CODE, DEPT_TITLE, SALARY 컬럼 참조
-- 사용자가 입력한 사원명과 일치하는 사원을 조회
DECLARE 
    EID EMPLOYEE.EMP_ID%TYPE;
    ENAME EMPLOYEE.EMP_NAME%TYPE;
    JCODE EMPLOYEE.JOB_CODE%TYPE;
    DTITLE DEPARTMENT.DEPT_TITLE%TYPE;
    SAL EMPLOYEE.SALARY%TYPE;
BEGIN
    SELECT EMP_ID, EMP_NAME, JOB_CODE, DEPT_TITLE, SALARY
    INTO EID, ENAME, JCODE, DTITLE, SAL
    FROM EMPLOYEE E, DEPARTMENT D
    WHERE E.DEPT_CODE = D.DEPT_ID
    AND EMP_ID = &사번;
    
    DBMS_OUTPUT.PUT_LINE('사번 : ' || EID);
    DBMS_OUTPUT.PUT_LINE('이름 : ' || ENAME);
    DBMS_OUTPUT.PUT_LINE('직급 : ' || JCODE);
    DBMS_OUTPUT.PUT_LINE('부서 : ' || DTITLE);
    DBMS_OUTPUT.PUT_LINE('급여 : ' || SAL);
END;
/

-- 1-3) 한 행에 대한 타입 변수 선언
DECLARE
    E EMPLOYEE%ROWTYPE;
BEGIN
    SELECT * INTO E FROM EMPLOYEE WHERE EMP_NAME = '&사원명';
    DBMS_OUTPUT.PUT_LINE('사번 : ' || E.EMP_ID);
    DBMS_OUTPUT.PUT_LINE('이름 : ' || E.EMP_NAME);
    DBMS_OUTPUT.PUT_LINE('주민번호 : ' || E.EMP_NO);
    DBMS_OUTPUT.PUT_LINE('급여 : ' || E.SALARY);
END;
/

------------------------------------------------------------------------------------------------------------------------
-- 2. BEGIN 실행부
-- 2-1) 조건문
-- 단일 IF
DECLARE
    EID EMPLOYEE.EMP_ID%TYPE;
    ENAME EMPLOYEE.EMP_NAME%TYPE;
    SALARY EMPLOYEE.SALARY%TYPE;
    BONUS EMPLOYEE.BONUS%TYPE;
BEGIN
    SELECT EMP_ID, EMP_NAME, SALARY, NVL(BONUS, 0)
    INTO EID, ENAME, SALARY, BONUS
    FROM EMPLOYEE
    WHERE EMP_ID = &사번;
    
    DBMS_OUTPUT.PUT_LINE('사번 : ' || EID);
    DBMS_OUTPUT.PUT_LINE('이름 : ' || ENAME);
    DBMS_OUTPUT.PUT_LINE('급여 : ' || SALARY || '원');
    
    IF (BONUS = 0)
        THEN DBMS_OUTPUT.PUT_LINE('보너스를 받지 않는 사원입니당'); 
        ELSE DBMS_OUTPUT.PUT_LINE('보너스 : ' || BONUS*100 || '%');
    END IF;
END;
/

-- IF ~ ELSE 
DECLARE
    EID EMPLOYEE.EMP_ID%TYPE;
    ENAME EMPLOYEE.EMP_NAME%TYPE;
    DTITLE DEPARTMENT.DEPT_TITLE%TYPE;
    NCODE LOCATION.NATIONAL_CODE%TYPE;
    TEAM VARCHAR2(20);
BEGIN
    SELECT EMP_ID, EMP_NAME, DEPT_TITLE, NATIONAL_CODE
    INTO EID, ENAME, DTITLE, NCODE
    FROM EMPLOYEE E, DEPARTMENT D, LOCATION L
    WHERE E.DEPT_CODE = D.DEPT_ID
    AND D.LOCATION_ID = L.LOCAL_CODE
    AND EMP_ID = &사번;
    
    IF (NCODE = 'KO')
        THEN TEAM := '국내팀';
        ELSE TEAM := '해외팀';
    END IF;
    
    DBMS_OUTPUT.PUT_LINE('사번 : ' || EID);
    DBMS_OUTPUT.PUT_LINE('이름 : ' || ENAME);
    DBMS_OUTPUT.PUT_LINE('부서 : ' || DTITLE);
    DBMS_OUTPUT.PUT_LINE('소속 : ' || TEAM);
    
END;
/

-- IF ~ ELSIF ~ ELSE
DECLARE 
    SCORE NUMBER;
    GRADE VARCHAR2(1);
BEGIN
    SCORE := &점수;
    
    IF (SCORE >= 90)
        THEN GRADE := 'A';
    ELSIF (SCORE >= 80)
        THEN GRADE := 'B';
    ELSIF (SCORE >= 70)
        THEN GRADE := 'C';
    ELSIF (SCORE >= 60)
        THEN GRADE := 'D';
    ELSE GRADE := 'F';
    END IF;
    
    DBMS_OUTPUT.PUT_LINE('GRADE : ' || GRADE);
END;
/

DECLARE
    SAL EMPLOYEE.SALARY%TYPE;
    GRADE VARCHAR2(10);
BEGIN
    SELECT SALARY
    INTO SAL
    FROM EMPLOYEE
    WHERE EMP_ID = &사번;
    
    IF (SAL >= 5000000)
        THEN GRADE := '고급';
    ELSIF (SAL >= 3000000)
        THEN GRADE := '중급';
    ELSE GRADE := '초급';
    END IF;
    
    SELECT SAL_LEVEL
    INTO GRADE
    FROM SAL_GRADE
    WHERE SAL BETWEEN MIN_SAL AND MAX_SAL;
    
    DBMS_OUTPUT.PUT_LINE('해당 사원의 급여등급은 ' || GRADE || '입니다.');
END;
/

-- CASE WHEN THEN
DECLARE 
    EMP EMPLOYEE%ROWTYPE;
    DNAME VARCHAR2(30);
BEGIN
    SELECT *
    INTO EMP
    FROM EMPLOYEE
    WHERE EMP_ID = &사번;

    DNAME := CASE EMP.DEPT_CODE
                          WHEN 'D1' THEN '인사관리부'
                          WHEN 'D2' THEN '회계관리부'
                          WHEN 'D3' THEN '마케팅부'
                          WHEN 'D4' THEN '국내영업부'
                          WHEN 'D5' THEN '해외영업1부'
                          WHEN 'D6' THEN '해외영업2부'
                          WHEN 'D7' THEN '해외영업3부'
                          WHEN 'D8' THEN '기술지원부'
                          WHEN 'D9' THEN '총무부'
                          END;
    DBMS_OUTPUT.PUT_LINE('사번 : ' || EMP.EMP_ID);
    DBMS_OUTPUT.PUT_LINE('이름 : ' || EMP.EMP_NAME);
    DBMS_OUTPUT.PUT_LINE('부서 : ' || DNAME);
END;
/


-- 2-2) 반복문
-- BASIC LOOP
DECLARE
    N NUMBER := 1;
BEGIN
    LOOP
        DBMS_OUTPUT.PUT_LINE(N);
        N := N+1;
        EXIT WHEN N > 5;
    END LOOP;
END;
/
        
-- FOR LOOP
DECLARE
    N NUMBER := 1;
BEGIN
    FOR N IN 1..5
    LOOP
        DBMS_OUTPUT.PUT_LINE(N);
    END LOOP;
END;
/

BEGIN
    FOR N IN 1..5
    LOOP
        DBMS_OUTPUT.PUT_LINE(N);
    END LOOP;
END;
/

CREATE TABLE TEST2(
    NUM NUMBER,
    TODAY DATE
);

BEGIN 
    FOR I IN 1..10
    LOOP
        INSERT INTO TEST2
        VALUES (I, SYSDATE+I);
    END LOOP;
END;
/

DECLARE 
    RESULT NUMBER;
BEGIN
    FOR DAN IN 2..9
    LOOP
    
    IF (MOD(DAN,2) = 0)
        THEN
            FOR SU IN 1..9
            LOOP
                RESULT := DAN * SU;
                DBMS_OUTPUT.PUT_LINE(DAN || 'x' || SU || '=' || RESULT);
            END LOOP;
            DBMS_OUTPUT.PUT_LINE('');
    END IF;
    
    END LOOP;
END;
/

------------------------------------------------------------------------------------------------------------------------


------------------------------------------------------------------------------------------------------------------------


------------------------------------------------------------------------------------------------------------------------













