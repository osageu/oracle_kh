-- �ϳ��� PL-SQL BLOCK

SET SERVEROUTPUT ON;

BEGIN
DBMS_OUTPUT.PUT_LINE('HELLO ORACLE'); 
END;
/
--> ȯ�溯�� ����� �� (OFF --> ON)

------------------------------------------------------------------------------------------------------------------------
-- 1. DECLARE �����
-- : ���� �� ��� ������ ���� ���� (�ʱ�ȭ�� ����)
-- : �Ϲ�Ÿ�Ժ���, ���۷���Ÿ�Ժ���, ROWŸ�Ժ���

-- 1-1) �Ϲ�Ÿ�Ժ��� ���� �� �ʱ�ȭ
DECLARE
    EID NUMBER;
    ENAME VARCHAR2(30);
    PI CONSTANT NUMBER := 3.14;
BEGIN
    EID := 888;
    ENAME := '���峲';
    
    DBMS_OUTPUT.PUT_LINE('EID : ' || EID);
    DBMS_OUTPUT.PUT_LINE('ENAME : ' || ENAME);
    DBMS_OUTPUT.PUT_LINE('PI : ' || PI);
END;
/
    
-- 1-2) ���۷���Ÿ�Ժ��� ���� �� �ʱ�ȭ
DECLARE 
    EID EMPLOYEE.EMP_ID%TYPE;
    ENAME EMPLOYEE.EMP_NAME%TYPE;    
    SAL EMPLOYEE.SALARY%TYPE;
BEGIN
    SELECT EMP_ID, EMP_NAME, SALARY
    INTO EID, ENAME, SAL
    FROM EMPLOYEE
    WHERE EMP_NAME = '&NAME'; --> '&'�� ��ü������ �Է��ϱ� ���� â�� �߰� ���ִ� ����
    DBMS_OUTPUT.PUT_LINE('EID : ' || EID);
    DBMS_OUTPUT.PUT_LINE('ENAME : ' || ENAME);
    DBMS_OUTPUT.PUT_LINE('SAL : ' || SAL);
END;
 /

-- <�ǽ�> --
-- ���۷���Ÿ�Ժ����� EID, ENAME, JCODE, DTITLE, SAL�� �����ϰ�
-- �� �ڷ����� ���� EMP_ID, EMP_NAME, JOB_CODE, DEPT_TITLE, SALARY �÷� ����
-- ����ڰ� �Է��� ������ ��ġ�ϴ� ����� ��ȸ
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
    AND EMP_ID = &���;
    
    DBMS_OUTPUT.PUT_LINE('��� : ' || EID);
    DBMS_OUTPUT.PUT_LINE('�̸� : ' || ENAME);
    DBMS_OUTPUT.PUT_LINE('���� : ' || JCODE);
    DBMS_OUTPUT.PUT_LINE('�μ� : ' || DTITLE);
    DBMS_OUTPUT.PUT_LINE('�޿� : ' || SAL);
END;
/

-- 1-3) �� �࿡ ���� Ÿ�� ���� ����
DECLARE
    E EMPLOYEE%ROWTYPE;
BEGIN
    SELECT * INTO E FROM EMPLOYEE WHERE EMP_NAME = '&�����';
    DBMS_OUTPUT.PUT_LINE('��� : ' || E.EMP_ID);
    DBMS_OUTPUT.PUT_LINE('�̸� : ' || E.EMP_NAME);
    DBMS_OUTPUT.PUT_LINE('�ֹι�ȣ : ' || E.EMP_NO);
    DBMS_OUTPUT.PUT_LINE('�޿� : ' || E.SALARY);
END;
/

------------------------------------------------------------------------------------------------------------------------
-- 2. BEGIN �����
-- 2-1) ���ǹ�
-- ���� IF
DECLARE
    EID EMPLOYEE.EMP_ID%TYPE;
    ENAME EMPLOYEE.EMP_NAME%TYPE;
    SALARY EMPLOYEE.SALARY%TYPE;
    BONUS EMPLOYEE.BONUS%TYPE;
BEGIN
    SELECT EMP_ID, EMP_NAME, SALARY, NVL(BONUS, 0)
    INTO EID, ENAME, SALARY, BONUS
    FROM EMPLOYEE
    WHERE EMP_ID = &���;
    
    DBMS_OUTPUT.PUT_LINE('��� : ' || EID);
    DBMS_OUTPUT.PUT_LINE('�̸� : ' || ENAME);
    DBMS_OUTPUT.PUT_LINE('�޿� : ' || SALARY || '��');
    
    IF (BONUS = 0)
        THEN DBMS_OUTPUT.PUT_LINE('���ʽ��� ���� �ʴ� ����Դϴ�'); 
        ELSE DBMS_OUTPUT.PUT_LINE('���ʽ� : ' || BONUS*100 || '%');
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
    AND EMP_ID = &���;
    
    IF (NCODE = 'KO')
        THEN TEAM := '������';
        ELSE TEAM := '�ؿ���';
    END IF;
    
    DBMS_OUTPUT.PUT_LINE('��� : ' || EID);
    DBMS_OUTPUT.PUT_LINE('�̸� : ' || ENAME);
    DBMS_OUTPUT.PUT_LINE('�μ� : ' || DTITLE);
    DBMS_OUTPUT.PUT_LINE('�Ҽ� : ' || TEAM);
    
END;
/

-- IF ~ ELSIF ~ ELSE
DECLARE 
    SCORE NUMBER;
    GRADE VARCHAR2(1);
BEGIN
    SCORE := &����;
    
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
    WHERE EMP_ID = &���;
    
    IF (SAL >= 5000000)
        THEN GRADE := '���';
    ELSIF (SAL >= 3000000)
        THEN GRADE := '�߱�';
    ELSE GRADE := '�ʱ�';
    END IF;
    
    SELECT SAL_LEVEL
    INTO GRADE
    FROM SAL_GRADE
    WHERE SAL BETWEEN MIN_SAL AND MAX_SAL;
    
    DBMS_OUTPUT.PUT_LINE('�ش� ����� �޿������ ' || GRADE || '�Դϴ�.');
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
    WHERE EMP_ID = &���;

    DNAME := CASE EMP.DEPT_CODE
                          WHEN 'D1' THEN '�λ������'
                          WHEN 'D2' THEN 'ȸ�������'
                          WHEN 'D3' THEN '�����ú�'
                          WHEN 'D4' THEN '����������'
                          WHEN 'D5' THEN '�ؿܿ���1��'
                          WHEN 'D6' THEN '�ؿܿ���2��'
                          WHEN 'D7' THEN '�ؿܿ���3��'
                          WHEN 'D8' THEN '���������'
                          WHEN 'D9' THEN '�ѹ���'
                          END;
    DBMS_OUTPUT.PUT_LINE('��� : ' || EMP.EMP_ID);
    DBMS_OUTPUT.PUT_LINE('�̸� : ' || EMP.EMP_NAME);
    DBMS_OUTPUT.PUT_LINE('�μ� : ' || DNAME);
END;
/


-- 2-2) �ݺ���
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













