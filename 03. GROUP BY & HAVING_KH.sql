/*
    < GROUP BY �� >
    �׷������ ������ �� �ִ� ���� --> ���� ���� ������ �ϳ��� �׷����� ��� ó���� ����
    
*/

SELECT TO_CHAR(SUM(SALARY), '99,999,999')
FROM EMPLOYEE; --> ��ü ��� ����

-- �� �μ��� �� �޿���
SELECT DEPT_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE
ORDER BY DEPT_CODE NULLS FIRST;

-- �� �μ��� �����
SELECT DEPT_CODE, COUNT(*)
FROM EMPLOYEE
GROUP BY DEPT_CODE;

-- �� ���޺� �����
SELECT JOB_CODE, COUNT(*)
FROM EMPLOYEE
GROUP BY JOB_CODE
ORDER BY COUNT(*);

-- �� ���޺� ���ʽ� �޴� �����
SELECT JOB_CODE, COUNT(BONUS)
FROM EMPLOYEE
GROUP BY JOB_CODE
ORDER BY 1;

-- �� ���޺� �޿� ���
SELECT JOB_CODE, TO_CHAR(AVG(SALARY),'9,999,999') ���
FROM EMPLOYEE
GROUP BY JOB_CODE
ORDER BY 1;

-- �� ���޺� �� �����, ���ʽ� �޴� �����, �޿���, ��ձ޿�,  �ְ�޿�, �����޿�
SELECT JOB_CODE, COUNT(*) "�� �����", COUNT(BONUS) "���ʽ� �޴� �����" , 
            TO_CHAR(SUM(SALARY), '99,999,999') "�޿���" , 
            TO_CHAR(AVG(SALARY), '9,999,999') "�޿� ���", 
            TO_CHAR(MAX(SALARY), '9,999,999') "�ְ� �޿�", 
            TO_CHAR(MIN(SALARY),'9,999,999') "���� �޿�"
FROM EMPLOYEE
GROUP BY JOB_CODE
ORDER BY 1;

-- ���� �÷��� �����ؼ� �׷���� ���� ����
SELECT DEPT_CODE, JOB_CODE, COUNT(*), SUM(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE, JOB_CODE
ORDER BY DEPT_CODE;

-----------------------------------------------------------------------------------------------------------------------------------------

/*
    < HAVING �� >
    �׷쿡 ���� ������ ������ �� ����ϴ� ���� (�ַ� �׷��Լ��� ����� ������ �񱳼���)

*/

-- �μ��� ��ձ޿��� 300���� �̻��� �μ��鸸 ��ȸ
SELECT DEPT_CODE, FLOOR(AVG(SALARY))
FROM EMPLOYEE
GROUP BY DEPT_CODE HAVING FLOOR(AVG(SALARY)) >=3000000
ORDER BY 1;

-- �μ��� ���ʽ� �޴� ����� ���� �μ����� ��ȸ
SELECT DEPT_CODE
FROM EMPLOYEE
GROUP BY DEPT_CODE HAVING COUNT(BONUS) = 0;

-----------------------------------------------------------------------------------------------------------------------------------
-- ������ �࿡ ��ü �� �޿��ձ��� ���� ��ȸ
SELECT JOB_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY ROLLUP(JOB_CODE) 
ORDER BY 1;

-- ROLLUP
SELECT DEPT_CODE, JOB_CODE, SAL_LEVEL, SUM(SALARY)
FROM EMPLOYEE
GROUP BY ROLLUP(DEPT_CODE, JOB_CODE, SAL_LEVEL)
ORDER BY 1, 2, 3;

-- CUBE
SELECT DEPT_CODE, JOB_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY CUBE (DEPT_CODE, JOB_CODE)
ORDER BY 1;

-- GROUPING
SELECT DEPT_CODE, JOB_CODE, TO_CHAR(SUM(SALARY), '99,999,999') �޿�, 
        GROUPING(DEPT_CODE) �μ����׷�,
        GROUPING(JOB_CODE) ���޺��׷�
FROM EMPLOYEE
GROUP BY ROLLUP (DEPT_CODE, JOB_CODE)
ORDER BY 1;

SELECT DEPT_CODE, JOB_CODE, TO_CHAR(SUM(SALARY), '99,999,999') �޿�, 
        GROUPING(DEPT_CODE) �μ����׷�,
        GROUPING(JOB_CODE) ���޺��׷�
FROM EMPLOYEE
GROUP BY CUBE (DEPT_CODE, JOB_CODE)
ORDER BY 1;

-- SET OPERATION : ���� ���� QUERY���� ������ �ϳ��� QUERY������ ����� ������

-- 1. UNION
-- EMPLOYEE ���̺��� �μ��ڵ尡 D5�� ��� �Ǵ� �޿��� 300���� �ʰ��� ����� ��ȸ
SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5' OR SALARY > 3000000;

SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5'
UNION
SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY > 3000000;

-- 2. UNION ALL
SELECT EMP_ID, EMP_NAME, DEPT_CODE, BONUS
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5'
UNION ALL
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY > 3000000;

-- 3. INTERSECT 
SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5'
INTERSECT
SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY > 3000000
ORDER BY 1;

-- 4. MINUS
SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5'
MINUS
SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY > 3000000
ORDER BY 1;





























































































