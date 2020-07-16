/*
    < �Լ� (FUNCTION) >
    ������ Column�� �о ����� ����� ��ȯ
    
    > ������ �Լ� : N���� ���� �о N���� ����� ����
    > �׷� �Լ� : N���� ���� �о 1���� ����� ����
    
    �� SELECT ���� �� �Լ��� �Բ� ��� �Ұ�!
    �� �Լ��� ����� �� �ִ� ��ġ : SELECT, WHERE, ORDER BY
    
*/

------------------------------------------------ < ������ �Լ� > -----------------------------------------------

---------------------------------------------- < ���� ���� �Լ� > ----------------------------------------------
/*
    1. < LENGTH / LENGTHB >
    
    LENGTH ( Column | '����' ) : ���� ���� ��ȯ (NUMBER)
    LENGTHB ( Column | '����' ) : ������ byte �� ��ȯ (NUMBER)
    
    �ѱ��� 3 byte
    ����, ����, Ư������ : 1 byte
    
*/

SELECT LENGTH ('����Ŭ'), LENGTHB ('����Ŭ')
FROM DUAL;

SELECT EMAIL, LENGTH (EMAIL), LENGTHB (EMAIL), 
          EMP_NAME, LENGTH (EMP_NAME), LENGTHB (EMP_NAME)
FROM EMPLOYEE;

/*
    2. < INSTR >
    ������ ��ġ���� ������ ���ڹ� °�� ��Ÿ���� ������ ���� ��ġ ��ȯ
    
    INSTR ( Column | '����', '����', [ ã�� ��ġ�� ���۰�, ����] ) --> ����� NUMBER
    ã�� ��ġ�� ���۰�
    1 : �տ������� ã�Ƽ� �տ��� �� ��°����
    -1 : �տ������� ã�Ƽ� �ڿ��� �� ��°����
*/

SELECT INSTR ('AABAACAABBAA', 'B', 1, 3)
FROM DUAL;

SELECT INSTR ('AABAACAABBCAA', 'B', -1, 3)
FROM DUAL;

SELECT EMAIL, INSTR(EMAIL, '@') "@��ġ", INSTR (EMAIL, 's', 1, 2) "�ι�° s ��ġ"
FROM EMPLOYEE;

/*
    3. < SUBSTR >
    ���ڿ����� ������ ��ġ���� ������ ���� ��ŭ�� ���ڿ��� �����ؼ� ��ȯ
    
    SUBSTR ( STRING, POSITION, [LENGTH] ) --> ����� CHARACTER
    STRING : ����Ÿ�� Column �Ǵ� '����'
    POSITION : ���ڿ��� �߶� ��ġ
    LENGTH : ������ ���� ���� (���� �� ������)
*/

SELECT SUBSTR ( 'SHOW ME THE MONEY', 7)
FROM DUAL;

SELECT SUBSTR ( 'SHOW ME THE MONEY', 6, 2) 
FROM DUAL;

SELECT SUBSTR ( 'SHOW ME THE MONEY', 1, 6) 
FROM DUAL;

SELECT SUBSTR ( 'SHOW ME THE MONEY', -8, 3) 
FROM DUAL;

SELECT EMP_NO �ֹι�ȣ, SUBSTR (EMP_NO, 8,1) ����
FROM EMPLOYEE;

SELECT EMP_NAME, '����' ����
FROM EMPLOYEE
-- WHERE SUBSTR (EMP_NO, 8, 1) = '1';
WHERE EMP_NO LIKE '_______1%';

SELECT EMP_NAME, EMAIL, SUBSTR (EMAIL, 1, INSTR(EMAIL, '@')-1) ���̵�
FROM EMPLOYEE;

/*
    4. < LPAD / RPAD >
    ���ڿ� ���� ���ϰ��ְ� �����ְ��� �� �� ���
    
    LPAD/RPAD ( STRING, ���������� ��ȯ�� ������ ���� (byte), [ ] )
    ������ ���ڿ��� ������ ���ڸ� ���� �Ǵ� �����ʿ� ���ٿ� ���� N���̸�ŭ�� ���ڿ��� ��ȯ --> ����� CHARACTER
    �����̰��� �ϴ� ���� ���� �� ����ó��
*/

-- 20��ŭ�� ���� �� EMAIL���� ������ �����ϰ� ������ �������� ä��ڴ�.
SELECT EMP_NAME || '���� �ֹι�ȣ�� ' || RPAD (SUBSTR(EMP_NO, 1, (INSTR (EMP_NO, '-')+1)), LENGTH (EMP_NO), '*') || '�Դϴ�' �ֹι�ȣ
FROM EMPLOYEE;

/*
    5. < LTRIM / RTRIM >
    ���ڿ��� ���� Ȥ�� �����ʿ��� �����ϰ��� �ϴ� ���ڵ��� ã�Ƽ� ������ �������� ��ȯ
    
    LTRIM / RTRIM (STRING, [�����ϰ��� �ϴ� ����]) --> ����� CHARACTER
    
*/

SELECT LTRIM ('       KH') FROM DUAL;
SELECT LTRIM ('1012345', '0') FROM DUAL;
SELECT LTRIM ('123KH123123', '123') FROM DUAL;
SELECT LTRIM ('ACABACCKH', 'ABC') FROM DUAL;
SELECT LTRIM ('5782KH123', '01234KH5689') FROM DUAL;
SELECT RTRIM ('K   H      ', ' ') FROM DUAL;
SELECT RTRIM ('0012300456000', '0') FROM DUAL;

/*
    6. < TRIM >
    ���ڿ��� ��/��/���ʿ� �ִ� ������ ���ڸ� ������ �������� ��ȯ

*/

-- �⺻������ ���ʿ� �ִ� ���� ����
SELECT TRIM ('    K  H    ') FROM DUAL;
SELECT TRIM ('Z' FROM 'ZZZKHZEZ') FROM DUAL;
SELECT TRIM (BOTH 'Z' FROM 'ZZZKHZEZ') FROM DUAL;

-- �տ�������
SELECT TRIM (LEADING 'Z' FROM 'ZZZKHZEZ') FROM DUAL;

-- �ڿ�������
SELECT TRIM (TRAILING 'Z' FROM 'ZZZKHZEZ') FROM DUAL;

/*
    7. < LOWER / UPPER / INITCAP >
    �ҹ��ڷ� / �빮�ڷ� / ù ���ڸ� �빮�ڷ�
    
    LOWER / UPPER / INITCAP (STRING) --> ����� (CHARACTER)

*/

SELECT LOWER ('Welcome To My World!') FROM DUAL;
SELECT UPPER ('Welcome To My World!') FROM DUAL;
SELECT INITCAP ('welcome to My world!') FROM DUAL;

/*
    8. < CONCAT >
    ���ڿ� �� �� ���޹޾Ƽ� �ϳ��� ��ģ �� ��� ��ȯ 
    
    CONCAT (STRING, STRING) --> ����� (CHARACTER)
    
*/

SELECT CONCAT ('�����ٶ�', 'ABCD') FROM DUAL;
SELECT RPAD ('�����ٶ�', 15, 'ABCD') FROM DUAL;
SELECT '�����ٶ�' || 'ABCD' FROM DUAL;

/*
    9. < REPLACE >
    ���� ġȯ
    
    REPLACE (STRING, STR1, STR2) --> ����� (CHARACTER)

*/

SELECT REPLACE ('����� ������ ���ﵿ', ' ', 'A') FROM DUAL;
SELECT EMP_NAME, REPLACE (EMAIL, 'kh.or.kr', 'gmail.com')
FROM EMPLOYEE;


---------------------------------------------- < ���� ���� �Լ� > ----------------------------------------------
/*
    1. < ABS >
    ����
    
    ABS (NUMBER) --> NUMBER

*/

SELECT ABS (-3.141) FROM DUAL;

/*
    2. < MOD >
    ������
    
    MOD (NUMBER, NUMBER) --> NUMBER
    
*/

SELECT MOD (10, 3) FROM DUAL;
SELECT MOD (-10, 3) FROM DUAL;
SELECT MOD (10.9, 3) FROM DUAL;
SELECT MOD (-10.9, 3) FROM DUAL;

/*
    3. < ROUND >
    �ݿø�
    
    ROUND (NUMBER, [��ġ]) 

*/

SELECT ROUND (123.456) FROM DUAL;
SELECT ROUND (123.4567, 2) FROM DUAL;
SELECT ROUND (-123.4523, 3) FROM DUAL;
SELECT ROUND (1234.3423, -2) FROM DUAL;

/*
    4. < CEIL > 
    �ø�

    CEIL (NUMBER)
    
*/

SELECT CEIL (123.52) FROM DUAL;

/*
    5. < FLOOR >
    ����
    
    FLOOR (NUMBER)

*/

SELECT FLOOR (123.9999) FROM DUAL;

/*
    6. < TRUNC >
    ����
    
    TRUNC (NUMBER, [��ġ])

*/

SELECT TRUNC (123.456) FROM DUAL;
SELECT TRUNC (123.456, 2) FROM DUAL;


---------------------------------------------- < ��¥ ���� �Լ� > ----------------------------------------------
/*
    1. < SYSDATE >
    ��ǻ���� �ý��� ��¥

*/

SELECT SYSDATE FROM DUAL;

/*
    2. < MONTHS_BETWEEN >
    �� ���� ��¥ ������ ���� ��
    
    MONTHS_BETWEEN (DATE1, DATE2) --> NUMBER
    DATE1 - DATE2
    
*/

SELECT MONTHS_BETWEEN ('20/07/07', '19/05/08') FROM DUAL;
SELECT EMP_NAME, HIRE_DATE, FLOOR (MONTHS_BETWEEN (SYSDATE, HIRE_DATE)) || '���� ��' �ټӿ���
FROM EMPLOYEE;

/*
    3. < ADD_MONTHS >
    Ư�� ��¥�� ���� �� �߰�

    ADD_MONTHS (DATE, NUMBER) --> DATE
    
*/

SELECT ADD_MONTHS ('19/05/08', 5) FROM DUAL;
SELECT EMP_NAME, HIRE_DATE, ADD_MONTHS (HIRE_DATE, 6) "�Ի�� ���� 6����"
FROM EMPLOYEE;

/*
    4. < NEXT_DAY >
    Ư�� ��¥���� ���Ϸ��� ������ ���� ����� ��¥�� ��ȯ
    
    NEXT_DAY (DATE, ����[����|����]) --> DATE

*/

SELECT SYSDATE, NEXT_DAY (SYSDATE, 5) FROM DUAL;
SELECT SYSDATE, NEXT_DAY (SYSDATE, '��') FROM DUAL;
SELECT SYSDATE, NEXT_DAY (SYSDATE, 'FRI') FROM DUAL;

-- ��� ����
ALTER SESSION SET NLS_LANGUAGE = KOREAN;

/*
    5. < LAST_DAY >
    �ش� ���� ������ ��¥�� ���ؼ� ��ȯ
    
    LAST_DAY (DATE) --> DATE

*/

SELECT LAST_DAY ('21/02/01') FROM DUAL;
SELECT EMP_NAME, HIRE_DATE, LAST_DAY (HIRE_DATE)
FROM EMPLOYEE;

/*
    6. < EXTRACT >
    Ư�� ��¥�κ��� �� / �� / �� ����

    EXTRACT (YEAR/MONTH/DATE FROM DATE) --> NUMBER
    
*/

SELECT EXTRACT (MONTH FROM SYSDATE) FROM DUAL;
SELECT TRIM (1 FROM 11112119) FROM DUAL;
SELECT EMP_NAME, 
          EXTRACT (YEAR FROM HIRE_DATE) �Ի�⵵,
          EXTRACT (MONTH FROM HIRE_DATE) �Ի��,
          EXTRACT (DAY FROM HIRE_DATE) �Ի���
FROM EMPLOYEE
ORDER BY �Ի�⵵, �Ի��, �Ի���;

-- ��¥ ���� ����
SELECT SYSDATE FROM DUAL;
ALTER SESSION SET NLS_DATE_FORMAT = 'YY/MM/DD';


---------------------------------------------- < ����ȯ ���� �Լ� > ----------------------------------------------
/*
    1. < TO_CHAR >
    ���� / ��¥ --> ����
    
    TO_CHAR (NUMBER | DATE, [FORMAT]) --> CHARACTER
    
*/

-- ����
SELECT TO_CHAR (12345) FROM DUAL;
SELECT TO_CHAR (1234, '99999') FROM DUAL; -- 5ĭ ����, ����������, �� ĭ ����
SELECT TO_CHAR (1234, '00000') FROM DUAL; -- 5ĭ ����, ����������, �� ĭ 0
SELECT TO_CHAR (1234, 'L00000') FROM DUAL; -- ���� ������ ����(LOCAL)�� ȭ�����
SELECT TO_CHAR (1234, '00$000') FROM DUAL;
SELECT TO_CHAR (1234, '99,999L') FROM DUAL;
SELECT EMP_NAME, TO_CHAR (SALARY, 'L999,999,999') ��
FROM EMPLOYEE;

-- ��¥
SELECT TO_CHAR (SYSDATE, 'PM YYYY-MM-DD HH:MI:SS') FROM DUAL;
SELECT TO_CHAR (SYSDATE, 'MONDYYYYY') FROM DUAL;
SELECT TO_CHAR (SYSDATE, 'YYYY-MM-DD DAY, PM HH:MI:SS') FROM DUAL;
SELECT EMP_NAME, TO_CHAR (HIRE_DATE, 'YYYY-MM-DD DAY , HH24:MI:SS')
FROM EMPLOYEE;
SELECT EMP_NAME, TO_CHAR (HIRE_DATE, 'YYYY"��" MM"��" DD"��"') 
FROM EMPLOYEE;

-- ���� ����
-- 'Y' : 20XX
-- 'R' : 50�̻� 19XX, 50���� 20XX
SELECT TO_CHAR (SYSDATE, 'YYYY'),
          TO_CHAR (SYSDATE, 'RRRR'),
          TO_CHAR (SYSDATE, 'YY'),
          TO_CHAR (SYSDATE, 'RR'),
          TO_CHAR (SYSDATE, 'YEAR')
FROM DUAL;

-- �� ����
SELECT TO_CHAR (SYSDATE, 'MM'),
          TO_CHAR (SYSDATE, 'MON'),
          TO_CHAR (SYSDATE, 'MONTH'),
          TO_CHAR (SYSDATE, 'RM')
FROM DUAL;

-- �� ����
SELECT TO_CHAR (SYSDATE, 'DDD'), -- 1�� ���� ��ĥ °
          TO_CHAR (SYSDATE, 'DD'), -- 1�� ���� ��ĥ °
          TO_CHAR (SYSDATE, 'D') -- 1���� ���� ��ĥ °
FROM DUAL;

-- ���� ����
SELECT TO_CHAR (SYSDATE, 'DY'),
          TO_CHAR (SYSDATE, 'DAY')
FROM DUAL;

-- CUSTOMIZED
SELECT TO_CHAR (TO_DATE (200508), 'YYYY"��" MONDD"��" (DY)')
FROM DUAL;

/*
    2. < TO_DATE >
    ���� / ���� --> ��¥
    
    TO_DATE (���� | ����, [����]) --> DATE

*/

SELECT TO_DATE (20100101) FROM DUAL;
SELECT TO_DATE ('20200101') FROM DUAL;
SELECT TO_DATE ('200101') FROM DUAL;
SELECT TO_DATE ('20100101', 'YYYYMMDD') FROM DUAL;
SELECT TO_DATE ('041030 143000', 'YYMMDD HH24MISS') FROM DUAL;
SELECT TO_DATE ('980630', 'RRMMDD') FROM DUAL;
SELECT TO_DATE ('980630', 'YYMMDD') FROM DUAL;
SELECT EMP_ID, EMP_NAME, HIRE_DATE
FROM EMPLOYEE
WHERE HIRE_DATE > TO_DATE ('19980101', 'YYMMDD')
ORDER BY HIRE_DATE;


/*
    3. < TO_NUMBER >
    ���� --> ����
    
    TO_NUMBER (STRING, [FORAMT])

*/

SELECT TO_NUMBER ('') FROM DUAL; 
SELECT '123' + '234' FROM DUAL;
SELECT '123' + '234A' FROM DUAL;
SELECT EMP_NAME
FROM EMPLOYEE
WHERE EMP_ID >= 210;
SELECT '111,111,111' + '3' FROM DUAL;
SELECT TO_NUMBER ('1111,111,11', '9999,999,99') + 3 FROM DUAL;


------------------------------------------------- < ��Ÿ �Լ� > -------------------------------------------------
/*
    1. < NVL >
    NULL�� ��ü
    
    NVL (Column, �ٲ� ��)

*/

SELECT EMP_NAME, (SALARY + SALARY*NVL(BONUS, 0)) * 12
FROM EMPLOYEE;
SELECT EMP_NAME, NVL (DEPT_CODE, 'D0')
FROM EMPLOYEE;

/*
    2. < NVL2 >
    NULL�� ��ü
    
    NVL2 (Column, �ٲ� ��1, �ٲ� ��2) --> Column �����ϸ� ��1, NULL�̸� ��2

*/

SELECT EMP_NAME, BONUS, NVL2 (BONUS, 1, 0)
FROM EMPLOYEE;

/*
    3. < NULLIF >
    �����ϸ� NULL, �ٸ��� �񱳴��1 ��ȯ
    
    NULLIF (�񱳴��1, �񱳴��2)

*/

SELECT NULLIF ('12343', '123') FROM DUAL;

/*
    4. < DECODE >
    �������� ��쿡 ������ �� �� �ִ� ��� ����
    
    DECODE ( �񱳴��[Column | ����], {���ǰ�1, �����1}, {���ǰ�2, �����2}, �� , {�����} )
    ���ϰ����ϴ� ���� ���ǰ��� ��ġ�� ��� �׿� �ش��ϴ� ����� ��ȯ
    SWITCH�� ���
    
*/

-- ���, �����, �ֹι�ȣ, ����
SELECT EMP_ID, EMP_NAME, EMP_NO, 
          DECODE (SUBSTR (EMP_NO, 8, 1), '1', '��', '2', '��') ����
FROM EMPLOYEE;

-- ������ �޿� �λ��ؼ� ��ȸ
-- �����ڵ尡 J7�̸� �޿� 10% �λ�
-- J6 15%
-- J5 20%
-- ������ 5%
SELECT EMP_NAME, SALARY �����޿�, 
          TO_CHAR (DECODE (JOB_CODE, 'J7', SALARY*1.1, 
                                                  'J6', SALARY*1.15, 
                                                  'J5', SALARY*1.2, 
                                                  SALARY*1.05), '9,999,999') �޿��λ�
FROM EMPLOYEE;

/*
    5. < CASE WHEN THEN >
    
    CASE WHEN ���ǽ�1 THEN �����1
           WHEN ���ǽ�2 THEN �����2
           ELSE �����
    END
    IF ELSE IF�� ���

*/

SELECT EMP_ID, EMP_NAME, EMP_NO,
          CASE WHEN SUBSTR (EMP_NO, 8, 1) = '1' THEN '��'
                  WHEN SUBSTR (EMP_NO, 8, 1) = '2' THEN '��'
            END ����
FROM EMPLOYEE;

-- �����, �޿�, �޿���� (1,2,3,4���)
-- SALARY > 500 : 1���
-- SALARY > 350 : 2���
-- SALARY > 200 : 3���
-- SALARY <= 200 : 4���

SELECT EMP_NAME �̸� , TO_CHAR(SALARY, '9,999,999') �޿�,
        CASE WHEN SALARY > 5000000 THEN ' 1���'
                WHEN SALARY > 3500000 THEN ' 2���'
                WHEN SALARY > 2000000 THEN ' 3���'
                ELSE ' 4���'
                END �޿����
FROM EMPLOYEE;


---------------------------------------------------------- < �׷� �Լ� > ---------------------------------------------------------
-- 1. SUM (���� Column) : �� �հ�
SELECT TO_CHAR(SUM(SALARY), '99,999,999') �ѱ޿���
FROM EMPLOYEE;

SELECT TO_CHAR(SUM(SALARY), '99,999,999') ���ڱ޿���
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO, 8, 1) = '1';

SELECT TO_CHAR(SUM(SALARY*12), '999,999,999') ������
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5';

-- 2. AVG (���� Column) : �� ���
SELECT TRIM(TO_CHAR(AVG(SALARY), 'L9,999,999')) ��ձ޿�
FROM EMPLOYEE;

-- 3. MIN (Column) : �ּڰ�
SELECT MIN(HIRE_DATE), MIN(EMAIL), MIN(PHONE), MIN(EMP_NAME), MIN(BONUS)
FROM EMPLOYEE;

-- 4. MAX (Column) : �ִ�
SELECT MAX(HIRE_DATE), MAX(EMAIL), MAX(PHONE), MAX(EMP_NAME), MAX(BONUS)
FROM EMPLOYEE;

-- 5. COUNT (* | Column) : �� ���� ��ȯ
SELECT COUNT(*)
FROM EMPLOYEE
WHERE SUBSTR (EMP_NO, 8, 1) = '1';

SELECT COUNT(DEPT_CODE)
FROM EMPLOYEE;

SELECT COUNT(DISTINCT DEPT_CODE)
FROM EMPLOYEE;




