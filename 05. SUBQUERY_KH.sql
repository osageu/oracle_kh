/*
    < SUBQUERY >
    �ϳ��� SQL�� �ȿ� ���Ե� �� �ٸ� SQL��

*/

-- ���� �������� ����1
-- ���ö ����� ���� �μ����� ��ȸ
SELECT DEPT_CODE
FROM EMPLOYEE
WHERE EMP_NAME = '���ö';

SELECT EMP_NAME
FROM EMPLOYEE
WHERE DEPT_CODE = 'D9';

-- ��ġ��
SELECT EMP_NAME
FROM EMPLOYEE
WHERE DEPT_CODE = (SELECT DEPT_CODE
                    FROM EMPLOYEE
                    WHERE EMP_NAME = '���ö');

-- ���� �������� ����2
-- �� ������ ��� �޿����� �� ���� �޿��� �ް� �ִ� ���� ��ȸ
SELECT AVG(SALARY)
FROM EMPLOYEE;

SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY >= 3047663;

SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY >= (SELECT AVG(SALARY)
                FROM EMPLOYEE);

/*
    < SUBQUERY ���� >
    ���������� ������ ������� �� �� �� ���̳Ŀ� ���� �з���
    
    1. ������ �������� : ���������� ��ȸ ��� ���� ������ 1���� ��� 
    2. ������ �������� : ���������� ��ȸ ��� ���� ����� ���� ���� ���
    3. ���߿� �������� : ���������� ��ȸ ��� ���� 1�������� Column�� ���� ���� ���
    4. ������ ���߿� �������� : ���������� ��ȸ ������� ���� �� ���� ���� 

*/

-- 1. ������ ��������
-- 1) �� ������ ��� �޿����� �޿��� ���� �޴� �������� �̸�, �����ڵ�, �޿� ��ȸ
SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY <= (SELECT AVG(SALARY) FROM EMPLOYEE)
ORDER BY 3;

-- 2) ���� �޿��� �޴� ������ ���, �̸�, �����ڵ�, �޿�, �Ի��� ��ȸ
SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY, HIRE_DATE
FROM EMPLOYEE
WHERE SALARY = (SELECT MIN(SALARY) FROM EMPLOYEE);

-- 3) ���ö ����� �޿����� ���� �޴� ����� ���, �̸�, �μ��ڵ�, �����ڵ�, �޿� ��ȸ
SELECT EMP_ID, EMP_NAME, DEPT_CODE, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY > (SELECT SALARY FROM EMPLOYEE WHERE EMP_NAME = '���ö');

-- * ���������� WHERE, SELECT, FROM, HAVING ��� �پ��� ������ ��� ����
-- 4) �μ��� �޿����� ���� ū �μ��� �μ��ڵ�, �޿��� ��ȸ
SELECT DEPT_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE 
HAVING SUM(SALARY) = (SELECT MAX(SUM(SALARY)) FROM EMPLOYEE GROUP BY DEPT_CODE);

-- 5) ������ ����� �����ִ� �μ����� ��ȸ (��, �������� ����)
SELECT EMP_NAME, PHONE, DEPT_TITLE, JOB_NAME
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
JOIN JOB USING (JOB_CODE)
WHERE DEPT_CODE = (SELECT DEPT_CODE FROM EMPLOYEE WHERE EMP_NAME = '������')
AND EMP_NAME != '������';


-- 2. ������ ��������
-- IN / NOT IN (SUBQUERY) : ���� ���� ����� �߿��� �� ���� ��ġ�ϴ� ���� �ִٸ� Ȥ�� ���ٸ� �̶�� �ǹ�
-- > ANY / < ANY (SUBQUERY) : ���� ���� ����� �� �� ���� Ŭ ���(���� ���� ������ ũ��?), ���� ���(���� ū ������ �۳�?)��� �ǹ�
-- > ALL / < ALL (SUBQUERY) : ���� ���� ������� ��� ������ ū ���(���� ū ������ ũ��?), ���� ���(���� ���� ������ �۳�?)��� �ǹ�    
-- 1.1) �� �μ��� �ְ�޿��� �޴� ������ �̸�, �����ڵ�, �μ��ڵ�, �޿� ��ȸ
SELECT EMP_NAME, DEPT_CODE, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY IN (SELECT MAX(SALARY) FROM EMPLOYEE GROUP BY DEPT_CODE);

-- 1.2) ����� �ش��ϴ� ������ ���� ���, �̸�, �μ��ڵ�, ����(���/���) ��ȸ
SELECT EMP_ID, EMP_NAME, DEPT_CODE, '���' ����
FROM EMPLOYEE
WHERE EMP_ID IN (SELECT DISTINCT MANAGER_ID FROM EMPLOYEE WHERE MANAGER_ID IS NOT NULL);

-- 1.3) �λ�� ��ȸ    
SELECT EMP_ID, EMP_NAME, DEPT_CODE, '�λ��' ����
FROM EMPLOYEE
WHERE EMP_ID NOT IN (SELECT DISTINCT MANAGER_ID FROM EMPLOYEE WHERE MANAGER_ID IS NOT NULL);

-- 1.4) ��ü ��ȸ 
SELECT EMP_ID, EMP_NAME, DEPT_CODE, '���' ����
FROM EMPLOYEE
WHERE EMP_ID IN (SELECT DISTINCT MANAGER_ID FROM EMPLOYEE WHERE MANAGER_ID IS NOT NULL)
UNION
SELECT EMP_ID, EMP_NAME, DEPT_CODE, '�λ��' ����
FROM EMPLOYEE
WHERE EMP_ID NOT IN (SELECT DISTINCT MANAGER_ID FROM EMPLOYEE WHERE MANAGER_ID IS NOT NULL);

SELECT EMP_ID, EMP_NAME, DEPT_CODE, CASE WHEN EMP_ID IN (SELECT DISTINCT MANAGER_ID FROM EMPLOYEE WHERE MANAGER_ID IS NOT NULL)
                                        THEN '���'
                                        ELSE '���'
                                        END ����
FROM EMPLOYEE;

-- 2.1) �븮 �����ӿ��� �ұ��ϰ� ���� ���޵��� �ּ� �޿����� ���� �޴� ���� ��ȸ
SELECT EMP_ID, EMP_NAME, JOB_NAME, SALARY
FROM EMPLOYEE E, JOB J
WHERE E.JOB_CODE = J.JOB_CODE
AND SALARY > (SELECT MIN(SALARY) FROM EMPLOYEE JOIN JOB USING (JOB_CODE) WHERE JOB_NAME = '����')
AND JOB_NAME = '�븮'
ORDER BY 4;

SELECT EMP_ID, EMP_NAME, JOB_NAME, SALARY
FROM EMPLOYEE E, JOB J
WHERE E.JOB_CODE = J.JOB_CODE
AND SALARY > ANY (SELECT SALARY FROM EMPLOYEE JOIN JOB USING (JOB_CODE) WHERE JOB_NAME = '����')
AND JOB_NAME = '�븮'
ORDER BY 4;

-- 2.2) ���� ���������� ���� ������ �ִ� �޿����� �� ���� �޴� ����
SELECT EMP_ID, EMP_NAME, JOB_NAME, SALARY
FROM EMPLOYEE
JOIN JOB USING (JOB_CODE)
WHERE JOB_NAME = '����'
AND SALARY > ALL (SELECT SALARY FROM EMPLOYEE JOIN JOB USING (JOB_CODE) WHERE JOB_NAME = '����');

-- 3. ���߿� ��������
-- 3.1) ������ ����� ���� �μ��ڵ�, ���� �����ڵ忡 �ش��ϴ� ��� ��ȸ
-- ������  
SELECT EMP_NAME, DEPT_CODE, JOB_CODE, HIRE_DATE
FROM EMPLOYEE
WHERE DEPT_CODE = (SELECT DEPT_CODE FROM EMPLOYEE WHERE EMP_NAME = '������')
AND JOB_CODE = (SELECT JOB_CODE FROM EMPLOYEE WHERE EMP_NAME = '������');

-- ���߿�
SELECT EMP_NAME, DEPT_CODE, JOB_CODE, HIRE_DATE
FROM EMPLOYEE
WHERE (DEPT_CODE, JOB_CODE) = (SELECT DEPT_CODE, JOB_CODE FROM EMPLOYEE WHERE EMP_NAME = '������');

-- 3.2) �ڳ��� ����� �����ڵ尡 ��ġ�ϸ鼭 ���� ����� ������ �ִ� ��� ��ȸ
SELECT EMP_ID, EMP_NAME, JOB_CODE, MANAGER_ID
FROM EMPLOYEE
WHERE (MANAGER_ID, JOB_CODE) = (SELECT MANAGER_ID, JOB_CODE FROM EMPLOYEE WHERE EMP_NAME = '�ڳ���');

-- 4. ������ ���߿� ��������  
-- 4.1) �� ���޺� ���� �޿��� �޴� ����� ��ȸ
SELECT EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE (JOB_CODE, SALARY) IN (SELECT JOB_CODE, MIN(SALARY) FROM EMPLOYEE GROUP BY JOB_CODE)
ORDER BY 2;

-- 4.2) �� �μ��� ���� �޿��� �޴� ����� ��ȸ
-- IN�� = �񱳶� NULL���� �� ���� ~ �׷��� NVL�� ���� �� �ְ� ������ �� ����־���    
SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE (NVL(DEPT_CODE, 'NO'), SALARY) IN (SELECT NVL(DEPT_CODE, 'NO'), MIN(SALARY) FROM EMPLOYEE GROUP BY NVL(DEPT_CODE, 'NO'))
ORDER BY 2;

-- 5. �ζ��� �� (INLINE - VIEW) : FROM ���� ��������, ���������� ������ ����� ���̺� ��ſ� ���
-- 5.1) ������ 3000���� �ʰ��� ��� ��ȸ
SELECT EMP_ID, EMP_NAME, SALARY*12 ����, DEPT_CODE
FROM EMPLOYEE
WHERE SALARY*12 > 30000000;

SELECT EMP_NAME, ����, DEPT_CODE
FROM (SELECT EMP_ID, EMP_NAME, SALARY*12 ����, DEPT_CODE FROM EMPLOYEE)
WHERE ���� > 30000000;

-- 5.2) TOP-N �м�
-- �� ���� �� �޿��� ���� ���� ���� 5�� ����, �̸�, �޿� ��ȸ
SELECT ROWNUM ����, DEPT_TITLE, E.*
FROM (SELECT * FROM EMPLOYEE ORDER BY SALARY DESC) E
JOIN DEPARTMENT D ON (DEPT_CODE = DEPT_ID)
WHERE ROWNUM <= 5;

-- �� �μ��� ��� �޿��� ���� ���� ���� 3�μ�
SELECT ROWNUM ����, DEPT_CODE, ROUND(��ձ޿�)
FROM (SELECT DEPT_CODE, AVG(SALARY) ��ձ޿� FROM EMPLOYEE GROUP BY DEPT_CODE ORDER BY 2 DESC) E
WHERE ROWNUM <= 3;

-- 5.3) RANK OVER / DENSE_RANK OVER��
-- ����� �޿��� ���� ����� ������ �Űܼ� �����, �޿�, ����
SELECT EMP_NAME, SALARY, /*DENSE_*/RANK() OVER(ORDER BY SALARY DESC) ����
FROM EMPLOYEE;

-- ���� 5�� ��ȸ
SELECT *
FROM (SELECT EMP_NAME, SALARY, RANK() OVER(ORDER BY SALARY DESC) ���� FROM EMPLOYEE) E
WHERE ���� <= 5;







