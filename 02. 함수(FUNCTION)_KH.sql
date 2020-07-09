/*
    < 함수 (FUNCTION) >
    제시한 Column을 읽어서 계산한 결과를 반환
    
    > 단일행 함수 : N개의 값을 읽어서 N개의 결과를 리턴
    > 그룹 함수 : N개의 값을 읽어서 1개의 결과를 리턴
    
    ※ SELECT 절에 두 함수를 함께 사용 불가!
    ※ 함수를 기술할 수 있는 위치 : SELECT, WHERE, ORDER BY
    
*/

------------------------------------------------ < 단일행 함수 > -----------------------------------------------

---------------------------------------------- < 문자 관련 함수 > ----------------------------------------------
/*
    1. < LENGTH / LENGTHB >
    
    LENGTH ( Column | '문자' ) : 글자 개수 반환 (NUMBER)
    LENGTHB ( Column | '문자' ) : 글자의 byte 수 반환 (NUMBER)
    
    한글은 3 byte
    영어, 숫자, 특수문자 : 1 byte
    
*/

SELECT LENGTH ('오라클'), LENGTHB ('오라클')
FROM DUAL;

SELECT EMAIL, LENGTH (EMAIL), LENGTHB (EMAIL), 
          EMP_NAME, LENGTH (EMP_NAME), LENGTHB (EMP_NAME)
FROM EMPLOYEE;

/*
    2. < INSTR >
    지정한 위치부터 지정한 숫자번 째로 나타내는 문자의 시작 위치 반환
    
    INSTR ( Column | '문자', '문자', [ 찾을 위치의 시작값, 순번] ) --> 결과값 NUMBER
    찾을 위치의 시작값
    1 : 앞에서부터 찾아서 앞에서 몇 번째인지
    -1 : 앞에서부터 찾아서 뒤에서 몇 번째인지
*/

SELECT INSTR ('AABAACAABBAA', 'B', 1, 3)
FROM DUAL;

SELECT INSTR ('AABAACAABBCAA', 'B', -1, 3)
FROM DUAL;

SELECT EMAIL, INSTR(EMAIL, '@') "@위치", INSTR (EMAIL, 's', 1, 2) "두번째 s 위치"
FROM EMPLOYEE;

/*
    3. < SUBSTR >
    문자열에서 지정한 위치부터 지정한 개수 만큼의 문자열을 추출해서 반환
    
    SUBSTR ( STRING, POSITION, [LENGTH] ) --> 결과값 CHARACTER
    STRING : 문자타입 Column 또는 '문자'
    POSITION : 문자열을 잘라낼 위치
    LENGTH : 추출할 문자 개수 (생략 시 끝까지)
*/

SELECT SUBSTR ( 'SHOW ME THE MONEY', 7)
FROM DUAL;

SELECT SUBSTR ( 'SHOW ME THE MONEY', 6, 2) 
FROM DUAL;

SELECT SUBSTR ( 'SHOW ME THE MONEY', 1, 6) 
FROM DUAL;

SELECT SUBSTR ( 'SHOW ME THE MONEY', -8, 3) 
FROM DUAL;

SELECT EMP_NO 주민번호, SUBSTR (EMP_NO, 8,1) 성별
FROM EMPLOYEE;

SELECT EMP_NAME, '남자' 성별
FROM EMPLOYEE
-- WHERE SUBSTR (EMP_NO, 8, 1) = '1';
WHERE EMP_NO LIKE '_______1%';

SELECT EMP_NAME, EMAIL, SUBSTR (EMAIL, 1, INSTR(EMAIL, '@')-1) 아이디
FROM EMPLOYEE;

/*
    4. < LPAD / RPAD >
    문자에 대해 통일감있게 보여주고자 할 때 사용
    
    LPAD/RPAD ( STRING, 최종적으로 반환할 문자의 길이 (byte), [ ] )
    제시한 문자열에 임의의 문자를 왼쪽 또는 오른쪽에 덧붙여 최종 N길이만큼의 문자열을 반환 --> 결과값 CHARACTER
    덧붙이고자 하는 문자 생략 시 공백처리
*/

-- 20만큼의 길이 중 EMAIL값은 오른쪽 정렬하고 공백을 왼쪽으로 채우겠다.
SELECT EMP_NAME || '님의 주민번호는 ' || RPAD (SUBSTR(EMP_NO, 1, (INSTR (EMP_NO, '-')+1)), LENGTH (EMP_NO), '*') || '입니다' 주민번호
FROM EMPLOYEE;

/*
    5. < LTRIM / RTRIM >
    문자열의 왼쪽 혹은 오른쪽에서 제거하고자 하는 문자들을 찾아서 제거한 나머지를 반환
    
    LTRIM / RTRIM (STRING, [제거하고자 하는 문자]) --> 결과값 CHARACTER
    
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
    문자열의 앞/뒤/양쪽에 있는 지정한 문자를 제거한 나머지를 반환

*/

-- 기본적으로 양쪽에 있는 문자 제거
SELECT TRIM ('    K  H    ') FROM DUAL;
SELECT TRIM ('Z' FROM 'ZZZKHZEZ') FROM DUAL;
SELECT TRIM (BOTH 'Z' FROM 'ZZZKHZEZ') FROM DUAL;

-- 앞에서부터
SELECT TRIM (LEADING 'Z' FROM 'ZZZKHZEZ') FROM DUAL;

-- 뒤에서부터
SELECT TRIM (TRAILING 'Z' FROM 'ZZZKHZEZ') FROM DUAL;

/*
    7. < LOWER / UPPER / INITCAP >
    소문자로 / 대문자로 / 첫 글자만 대문자로
    
    LOWER / UPPER / INITCAP (STRING) --> 결과값 (CHARACTER)

*/

SELECT LOWER ('Welcome To My World!') FROM DUAL;
SELECT UPPER ('Welcome To My World!') FROM DUAL;
SELECT INITCAP ('welcome to My world!') FROM DUAL;

/*
    8. < CONCAT >
    문자열 두 개 전달받아서 하나로 합친 후 결과 반환 
    
    CONCAT (STRING, STRING) --> 결과값 (CHARACTER)
    
*/

SELECT CONCAT ('가나다라', 'ABCD') FROM DUAL;
SELECT RPAD ('가나다라', 15, 'ABCD') FROM DUAL;
SELECT '가나다라' || 'ABCD' FROM DUAL;

/*
    9. < REPLACE >
    문자 치환
    
    REPLACE (STRING, STR1, STR2) --> 결과값 (CHARACTER)

*/

SELECT REPLACE ('서울시 강남구 역삼동', ' ', 'A') FROM DUAL;
SELECT EMP_NAME, REPLACE (EMAIL, 'kh.or.kr', 'gmail.com')
FROM EMPLOYEE;


---------------------------------------------- < 숫자 관련 함수 > ----------------------------------------------
/*
    1. < ABS >
    절댓값
    
    ABS (NUMBER) --> NUMBER

*/

SELECT ABS (-3.141) FROM DUAL;

/*
    2. < MOD >
    나머지
    
    MOD (NUMBER, NUMBER) --> NUMBER
    
*/

SELECT MOD (10, 3) FROM DUAL;
SELECT MOD (-10, 3) FROM DUAL;
SELECT MOD (10.9, 3) FROM DUAL;
SELECT MOD (-10.9, 3) FROM DUAL;

/*
    3. < ROUND >
    반올림
    
    ROUND (NUMBER, [위치]) 

*/

SELECT ROUND (123.456) FROM DUAL;
SELECT ROUND (123.4567, 2) FROM DUAL;
SELECT ROUND (-123.4523, 3) FROM DUAL;
SELECT ROUND (1234.3423, -2) FROM DUAL;

/*
    4. < CEIL > 
    올림

    CEIL (NUMBER)
    
*/

SELECT CEIL (123.52) FROM DUAL;

/*
    5. < FLOOR >
    버림
    
    FLOOR (NUMBER)

*/

SELECT FLOOR (123.9999) FROM DUAL;

/*
    6. < TRUNC >
    버림
    
    TRUNC (NUMBER, [위치])

*/

SELECT TRUNC (123.456) FROM DUAL;
SELECT TRUNC (123.456, 2) FROM DUAL;


---------------------------------------------- < 날짜 관련 함수 > ----------------------------------------------
/*
    1. < SYSDATE >
    컴퓨터의 시스템 날짜

*/

SELECT SYSDATE FROM DUAL;

/*
    2. < MONTHS_BETWEEN >
    두 개의 날짜 사이의 개월 수
    
    MONTHS_BETWEEN (DATE1, DATE2) --> NUMBER
    DATE1 - DATE2
    
*/

SELECT MONTHS_BETWEEN ('20/07/07', '19/05/08') FROM DUAL;
SELECT EMP_NAME, HIRE_DATE, FLOOR (MONTHS_BETWEEN (SYSDATE, HIRE_DATE)) || '개월 차' 근속월수
FROM EMPLOYEE;

/*
    3. < ADD_MONTHS >
    특정 날짜에 개월 수 추가

    ADD_MONTHS (DATE, NUMBER) --> DATE
    
*/

SELECT ADD_MONTHS ('19/05/08', 5) FROM DUAL;
SELECT EMP_NAME, HIRE_DATE, ADD_MONTHS (HIRE_DATE, 6) "입사월 이후 6개월"
FROM EMPLOYEE;

/*
    4. < NEXT_DAY >
    특정 날짜에서 구하려는 요일의 가장 가까운 날짜를 반환
    
    NEXT_DAY (DATE, 요일[문자|숫자]) --> DATE

*/

SELECT SYSDATE, NEXT_DAY (SYSDATE, 5) FROM DUAL;
SELECT SYSDATE, NEXT_DAY (SYSDATE, '목') FROM DUAL;
SELECT SYSDATE, NEXT_DAY (SYSDATE, 'FRI') FROM DUAL;

-- 언어 변경
ALTER SESSION SET NLS_LANGUAGE = KOREAN;

/*
    5. < LAST_DAY >
    해당 월의 마지막 날짜를 구해서 반환
    
    LAST_DAY (DATE) --> DATE

*/

SELECT LAST_DAY ('21/02/01') FROM DUAL;
SELECT EMP_NAME, HIRE_DATE, LAST_DAY (HIRE_DATE)
FROM EMPLOYEE;

/*
    6. < EXTRACT >
    특정 날짜로부터 연 / 월 / 일 추출

    EXTRACT (YEAR/MONTH/DATE FROM DATE) --> NUMBER
    
*/

SELECT EXTRACT (MONTH FROM SYSDATE) FROM DUAL;
SELECT TRIM (1 FROM 11112119) FROM DUAL;
SELECT EMP_NAME, 
          EXTRACT (YEAR FROM HIRE_DATE) 입사년도,
          EXTRACT (MONTH FROM HIRE_DATE) 입사월,
          EXTRACT (DAY FROM HIRE_DATE) 입사일
FROM EMPLOYEE
ORDER BY 입사년도, 입사월, 입사일;

-- 날짜 포맷 변경
SELECT SYSDATE FROM DUAL;
ALTER SESSION SET NLS_DATE_FORMAT = 'YY/MM/DD';


---------------------------------------------- < 형변환 관련 함수 > ----------------------------------------------
/*
    1. < TO_CHAR >
    숫자 / 날짜 --> 문자
    
    TO_CHAR (NUMBER | DATE, [FORMAT]) --> CHARACTER
    
*/

-- 숫자
SELECT TO_CHAR (12345) FROM DUAL;
SELECT TO_CHAR (1234, '99999') FROM DUAL; -- 5칸 공간, 오른쪽정렬, 빈 칸 공백
SELECT TO_CHAR (1234, '00000') FROM DUAL; -- 5칸 공간, 오른쪽정렬, 빈 칸 0
SELECT TO_CHAR (1234, 'L00000') FROM DUAL; -- 현재 설정된 나라(LOCAL)의 화폐단위
SELECT TO_CHAR (1234, '00$000') FROM DUAL;
SELECT TO_CHAR (1234, '99,999L') FROM DUAL;
SELECT EMP_NAME, TO_CHAR (SALARY, 'L999,999,999') 돈
FROM EMPLOYEE;

-- 날짜
SELECT TO_CHAR (SYSDATE, 'PM YYYY-MM-DD HH:MI:SS') FROM DUAL;
SELECT TO_CHAR (SYSDATE, 'MONDYYYYY') FROM DUAL;
SELECT TO_CHAR (SYSDATE, 'YYYY-MM-DD DAY, PM HH:MI:SS') FROM DUAL;
SELECT EMP_NAME, TO_CHAR (HIRE_DATE, 'YYYY-MM-DD DAY , HH24:MI:SS')
FROM EMPLOYEE;
SELECT EMP_NAME, TO_CHAR (HIRE_DATE, 'YYYY"년" MM"월" DD"일"') 
FROM EMPLOYEE;

-- 연도 포맷
-- 'Y' : 20XX
-- 'R' : 50이상 19XX, 50이하 20XX
SELECT TO_CHAR (SYSDATE, 'YYYY'),
          TO_CHAR (SYSDATE, 'RRRR'),
          TO_CHAR (SYSDATE, 'YY'),
          TO_CHAR (SYSDATE, 'RR'),
          TO_CHAR (SYSDATE, 'YEAR')
FROM DUAL;

-- 월 포맷
SELECT TO_CHAR (SYSDATE, 'MM'),
          TO_CHAR (SYSDATE, 'MON'),
          TO_CHAR (SYSDATE, 'MONTH'),
          TO_CHAR (SYSDATE, 'RM')
FROM DUAL;

-- 일 포맷
SELECT TO_CHAR (SYSDATE, 'DDD'), -- 1년 기준 며칠 째
          TO_CHAR (SYSDATE, 'DD'), -- 1달 기준 며칠 째
          TO_CHAR (SYSDATE, 'D') -- 1주일 기준 며칠 째
FROM DUAL;

-- 요일 포맷
SELECT TO_CHAR (SYSDATE, 'DY'),
          TO_CHAR (SYSDATE, 'DAY')
FROM DUAL;

-- CUSTOMIZED
SELECT TO_CHAR (TO_DATE (200508), 'YYYY"년" MONDD"일" (DY)')
FROM DUAL;

/*
    2. < TO_DATE >
    숫자 / 문자 --> 날짜
    
    TO_DATE (숫자 | 문자, [포맷]) --> DATE

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
    문자 --> 숫자
    
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


------------------------------------------------- < 기타 함수 > -------------------------------------------------
/*
    1. < NVL >
    NULL을 대체
    
    NVL (Column, 바꿀 값)

*/

SELECT EMP_NAME, (SALARY + SALARY*NVL(BONUS, 0)) * 12
FROM EMPLOYEE;
SELECT EMP_NAME, NVL (DEPT_CODE, 'D0')
FROM EMPLOYEE;

/*
    2. < NVL2 >
    NULL을 대체
    
    NVL2 (Column, 바꿀 값1, 바꿀 값2) --> Column 존재하면 값1, NULL이면 값2

*/

SELECT EMP_NAME, BONUS, NVL2 (BONUS, 1, 0)
FROM EMPLOYEE;

/*
    3. < NULLIF >
    동일하면 NULL, 다르면 비교대상1 반환
    
    NULLIF (비교대상1, 비교대상2)

*/

SELECT NULLIF ('12343', '123') FROM DUAL;

/*
    4. < DECODE >
    여러가지 경우에 선택을 할 수 있는 기능 제공
    
    DECODE ( 비교대상[Column | 계산식], {조건값1, 결과값1}, {조건값2, 결과값2}, … , {결과값} )
    비교하고자하는 값이 조건값과 일치할 경우 그에 해당하는 결과값 반환
    SWITCH랑 비슷
    
*/

-- 사번, 사원명, 주민번호, 성별
SELECT EMP_ID, EMP_NAME, EMP_NO, 
          DECODE (SUBSTR (EMP_NO, 8, 1), '1', '남', '2', '여') 성별
FROM EMPLOYEE;

-- 직원의 급여 인상해서 조회
-- 직급코드가 J7이면 급여 10% 인상
-- J6 15%
-- J5 20%
-- 나머지 5%
SELECT EMP_NAME, SALARY 기존급여, 
          TO_CHAR (DECODE (JOB_CODE, 'J7', SALARY*1.1, 
                                                  'J6', SALARY*1.15, 
                                                  'J5', SALARY*1.2, 
                                                  SALARY*1.05), '9,999,999') 급여인상
FROM EMPLOYEE;

/*
    5. < CASE WHEN THEN >
    
    CASE WHEN 조건식1 THEN 결과값1
           WHEN 조건식2 THEN 결과값2
           ELSE 결과값
    END
    IF ELSE IF와 비슷

*/

SELECT EMP_ID, EMP_NAME, EMP_NO,
          CASE WHEN SUBSTR (EMP_NO, 8, 1) = '1' THEN '남'
                  WHEN SUBSTR (EMP_NO, 8, 1) = '2' THEN '여'
            END 성별
FROM EMPLOYEE;

-- 사원명, 급여, 급여등급 (1,2,3,4등급)
-- SALARY > 500 : 1등급
-- SALARY > 350 : 2등급
-- SALARY > 200 : 3등급
-- SALARY <= 200 : 4등급

SELECT EMP_NAME 이름 , TO_CHAR(SALARY, '9,999,999') 급여,
        CASE WHEN SALARY > 5000000 THEN ' 1등급'
                WHEN SALARY > 3500000 THEN ' 2등급'
                WHEN SALARY > 2000000 THEN ' 3등급'
                ELSE ' 4등급'
                END 급여등급
FROM EMPLOYEE;


---------------------------------------------------------- < 그룹 함수 > ---------------------------------------------------------
-- 1. SUM (숫자 Column) : 총 합계
SELECT TO_CHAR(SUM(SALARY), '99,999,999') 총급여합
FROM EMPLOYEE;

SELECT TO_CHAR(SUM(SALARY), '99,999,999') 남자급여합
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO, 8, 1) = '1';

SELECT TO_CHAR(SUM(SALARY*12), '999,999,999') 연봉합
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5';

-- 2. AVG (숫자 Column) : 총 평균
SELECT TRIM(TO_CHAR(AVG(SALARY), 'L9,999,999')) 평균급여
FROM EMPLOYEE;

-- 3. MIN (Column) : 최솟값
SELECT MIN(HIRE_DATE), MIN(EMAIL), MIN(PHONE), MIN(EMP_NAME), MIN(BONUS)
FROM EMPLOYEE;

-- 4. MAX (Column) : 최댓값
SELECT MAX(HIRE_DATE), MAX(EMAIL), MAX(PHONE), MAX(EMP_NAME), MAX(BONUS)
FROM EMPLOYEE;

-- 5. COUNT (* | Column) : 행 개수 반환
SELECT COUNT(*)
FROM EMPLOYEE
WHERE SUBSTR (EMP_NO, 8, 1) = '1';

SELECT COUNT(DEPT_CODE)
FROM EMPLOYEE;

SELECT COUNT(DISTINCT DEPT_CODE)
FROM EMPLOYEE;




