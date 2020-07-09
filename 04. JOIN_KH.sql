/*
    < JOIN >
    �� �� �̻��� ���̺��� �����͸� ��ȸ�ϰ��� �� �� ���Ǵ� ����
    ��ȸ ����� �ϳ��� ����� (RESULT SET)�� ����
    
    ������ �����ͺ��̽��� �ּ����� �����ͷ� ������ ���̺� ��� ���� (�ߺ� �ּ�ȭ)
    --> ��, ������ �����ͺ��̽����� SQL���� �̿��� ���̺� "����"�� �δ� ���
    
    ������ �����͸� �������°� �ƴ� ���̺� ������� ���谡 �ξ��� �����͸� ��Ī���� ��ȸ�ؾ� ��
        
*/

-- 1. � ���� (EQUAL JOIN) / ���� ���� (INNER JOIN)
-- �����Ű�� Column�� ��ġ�ϴ� ��鸸 ���εǼ� ��ȸ (��ġ���ϸ� ��ȸX)
-- 1.1 ����Ŭ ���� : FROM ���� ��ȸ�ϰ��� �ϴ� ���̺�� ���� (, �����ڷ�), WHERE ���� ��Ī��ų Column (�����)�� ���� ���� ����
SELECT EMP_ID, EMP_NAME, DEPT_CODE, DEPT_TITLE
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE = DEPT_ID;

SELECT EMP_NAME, EMPLOYEE.JOB_CODE ,JOB_NAME
FROM EMPLOYEE, JOB
WHERE EMPLOYEE.JOB_CODE = JOB.JOB_CODE;

-- ��Ī �̿�
SELECT EMP_NAME, E.JOB_CODE ,JOB_NAME
FROM EMPLOYEE E, JOB J
WHERE E.JOB_CODE = J.JOB_CODE;

-- 1.2 ANSI ���� : FROM ���� ������ �Ǵ� ���̺��� �ϳ� ������ �� JOIN ������ ���� ��ȸ�ϰ��� �ϴ� ���̺� ��� �� ��Ī��ų Column�� ���� ���� ����
-- 1) ������ �� Column�� �ٸ� ��� (EMPLOYEE : DEPT_CODE / DEPARTMENT : DEPT_ID) --> ON
SELECT EMP_ID, EMP_NAME, DEPT_TITLE
FROM DEPARTMENT
JOIN EMPLOYEE ON DEPT_CODE = DEPT_ID
ORDER BY 3;

-- 2) ������ �� Column�� ���� ��� (EMPLOYEE : JOB_CODE / DEPARTEMNT : JOB_CODE) --> USING
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
WHERE JOB_NAME = '�븮';

---------------------------------------------------------- <�� ��> ---------------------------------------------------------------
SELECT * FROM DEPARTMENT;
SELECT * FROM LOCATION;

-- �μ��ڵ�, �μ���, �����ڵ�, ������ ��ȸ
-- ORACLE
SELECT DEPT_ID �μ��ڵ�, DEPT_TITLE �μ���, LOCAL_CODE �����ڵ�, LOCAL_NAME ������
FROM DEPARTMENT E, LOCATION L
WHERE E.LOCATION_ID = L.LOCAL_CODE;

-- ANSI
SELECT DEPT_ID �μ��ڵ�, DEPT_TITLE �μ���, LOCAL_CODE �����ڵ�, LOCAL_NAME ������
FROM DEPARTMENT
JOIN LOCATION ON LOCATION_ID = LOCAL_CODE;

-- ���ʽ��� �޴� ������� ���, �����, ���ʽ�, �μ��� ��ȸ
-- ORACLE
SELECT EMP_ID ���, EMP_NAME �̸�, BONUS ���ʽ�, DEPT_TITLE �μ���
FROM EMPLOYEE E, DEPARTMENT D
WHERE E.DEPT_CODE = D.DEPT_ID
AND BONUS IS NOT NULL;

-- ANSI
SELECT EMP_ID ���, EMP_NAME �̸�, BONUS ���ʽ�, DEPT_TITLE �μ���
FROM EMPLOYEE E
JOIN DEPARTMENT D ON E.DEPT_CODE = D.DEPT_ID
WHERE BONUS IS NOT NULL; 

-- �λ�����ΰ� �ƴ� ������� �����, �޿� ��ȸ
-- ORACLE
SELECT EMP_NAME �����, SALARY �޿�, DEPT_TITLE
FROM EMPLOYEE E, DEPARTMENT D
WHERE E.DEPT_CODE = D.DEPT_ID
AND DEPT_TITLE <> '�λ������';

-- ANSI
SELECT EMP_NAME �����, SALARY �޿�, DEPT_TITLE
FROM EMPLOYEE 
JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
WHERE DEPT_TITLE ^= '�λ������';

-- ���, �����, �μ���, ���޸�
-- ORACLE
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, JOB_NAME
FROM EMPLOYEE E, DEPARTMENT D, JOB J
WHERE DEPT_CODE = DEPT_ID AND E.JOB_CODE = J.JOB_CODE;

-- ANSI
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, JOB_NAME
FROM EMPLOYEE E
JOIN DEPARTMENT D ON D.DEPT_ID = E.DEPT_CODE
JOIN JOB J USING(JOB_CODE); 

------------------------------------------------------------ <�ǽ�> -------------------------------------------------------------------------

-- 2. ���� ���� / �ܺ� ����
-- : �� ���̺� ���� JOIN �� ��ġ���� �ʴ� �൵ ���Խ��Ѽ� ��ȸ ����. ��, LEFT / RIGHT�� ��������� ��
-- : OUTER JOIN�� ���� INNER JOIN ���س���
-- 1) LEFT [OUTER] JOIN : �� ���̺� �� ���� ����� ���̺��� Column�� �������� JOIN
-- ORACLE
SELECT EMP_NAME, DEPT_TITLE, SALARY, SALARY*12
FROM EMPLOYEE E, DEPARTMENT D
WHERE DEPT_CODE = DEPT_ID(+);

-- ANSI
SELECT EMP_NAME, DEPT_TITLE, SALARY, SALARY*12
FROM EMPLOYEE
LEFT JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID;
--> �μ��ڵ尡 ���� ��� (�ϵ���, �̿���)�� ������ ����

-- 2) RIGHT [OUTER] JOIN : �� ���̺� �� ������ ����� ���̺��� Column�� �������� JOIN
-- ORACLE
SELECT EMP_NAME, DEPT_TITLE, SALARY, SALARY*12
FROM DEPARTMENT D, EMPLOYEE E
WHERE DEPT_CODE(+) = DEPT_ID;

-- ANSI
SELECT EMP_NAME, DEPT_TITLE, SALARY, SALARY*12
FROM EMPLOYEE
RIGHT JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID;

-- 3) FULL [OUTER] JOIN : �� ���̺� ��� ������ ��ȸ
-- ANSI
SELECT EMP_NAME, DEPT_TITLE, SALARY, SALARY*12
FROM EMPLOYEE
FULL JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID;

-- 3. īŸ�þ� �� / ���� ����
-- : ���εǴ� ��� ���̺��� �� ����� ���μ��� ��� MAPPING�� �����Ͱ� �˻��� (������)
-- : �� ���̺��� ����� ��� ������ ����� ������ ��� --> ����� ������ ��� --> �������� ����

-- �����, �μ���
-- 1) ORACLE
SELECT EMP_NAME, DEPT_TITLE
FROM EMPLOYEE, DEPARTMENT; -- 23 * 9 = 207

-- 2) ANSI
SELECT EMP_NAME, DEPT_TITLE
FROM EMPLOYEE
CROSS JOIN DEPARTMENT;

-- 4. �� ���� / JOIN ON
-- : '='�� ������� �ʴ� ����
-- : ������ Column ���� ��ġ�ϴ� ��찡 �ƴ�, ���� "����"�� ���ԵǴ� ����� �����ϴ� ���
-- EMPLOYEE�� SAL_LEVEL ������!
ALTER TABLE EMPLOYEE DROP COLUMN SAL_LEVEL;
-- �����, �޿�, �޿����
-- 1) ORACLE
SELECT EMP_NAME, SALARY, SAL_LEVEL
FROM EMPLOYEE, SAL_GRADE
-- WHERE SALARY >= MIN_SAL AND SALARY <= MAX_SAL;
WHERE SALARY BETWEEN MIN_SAL AND MAX_SAL;

-- 2) ANSI
SELECT EMP_NAME, SALARY, SAL_LEVEL
FROM EMPLOYEE
JOIN SAL_GRADE ON SALARY BETWEEN MIN_SAL AND MAX_SAL;

-- 5 .��ü ����
-- : ���� ���̺��� �����ϴ� ���
-- ������ ����� ������, �����, �μ��ڵ�, ������, ����� ��ȸ
-- 1) ORACLE
SELECT E.EMP_ID, E.EMP_NAME, E.DEPT_CODE, E.MANAGER_ID, J.EMP_NAME, J.DEPT_CODE, J.SALARY
FROM EMPLOYEE E, EMPLOYEE J
WHERE E.MANAGER_ID = J.EMP_ID(+);

-- 2) ANSI
SELECT E.EMP_ID ������, E.EMP_NAME �����, E.JOB_CODE ��������ڵ�,
          M.EMP_ID ������, M.EMP_NAME �����, M.JOB_CODE ��������ڵ�
FROM EMPLOYEE E
LEFT JOIN EMPLOYEE M ON (E.MANAGER_ID = M.EMP_ID);

-- 6. ���� ����
-- : N���� ���̺��� ����
-- ���, �����, �μ���, ������ ��ȸ
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

------------------------------------------------------ <�ǽ�>----------------------------------------------------------
-- 1. ���, �����, �μ���, ������, ������ ��ȸ
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

-- 2. ���, �����, �μ���, ���޸�, ������, ������, �޿���� ��ȸ
-- ORACLE
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, JOB_NAME, LOCAL_NAME, N.NATIONAL_NAME, SAL_LEVEL
FROM EMPLOYEE E, DEPARTMENT D, LOCATION L, NATIONAL N, JOB J, SAL_GRADE S
WHERE DEPT_CODE = DEPT_ID
AND LOCATION_ID = LOCAL_CODE
AND L.NATIONAL_CODE = N.NATIONAL_CODE
AND J.JOB_CODE = E.JOB_CODE
AND SALARY BETWEEN MIN_SAL AND MAX_SAL;

-- ANSI
SELECT EMP_ID ���, 
        EMP_NAME �����,
        DEPT_TITLE �μ���,
        JOB_NAME ���޸�, 
        LOCAL_NAME ������,
        N.NATIONAL_NAME ������, 
        SAL_LEVEL �޿����
FROM EMPLOYEE E
JOIN DEPARTMENT D ON DEPT_CODE = DEPT_ID
JOIN LOCATION L ON LOCATION_ID = LOCAL_CODE
JOIN NATIONAL N ON L.NATIONAL_CODE = N.NATIONAL_CODE
JOIN JOB J ON E.JOB_CODE = J.JOB_CODE
JOIN SAL_GRADE ON SALARY BETWEEN MIN_SAL AND MAX_SAL;










































