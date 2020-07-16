-- FUNCTION 1
SELECT STUDENT_NO 학번, STUDENT_NAME 이름, TO_CHAR(ENTRANCE_DATE, 'YYYY-MM-DD') 입학년도
FROM TB_STUDENT
WHERE DEPARTMENT_NO = 002
ORDER BY 3;

-- FUNCTION 2
SELECT PROFESSOR_NAME, PROFESSOR_SSN
FROM TB_PROFESSOR
WHERE LENGTH(PROFESSOR_NAME) != 3;

-- FUNCTION 3
SELECT PROFESSOR_NAME 교수이름, 120 - SUBSTR(PROFESSOR_SSN, 1, 2) 나이
FROM TB_PROFESSOR
WHERE SUBSTR(PROFESSOR_SSN, 8, 1) = 1
ORDER BY 2;

-- FUNCTION 4 
SELECT SUBSTR(PROFESSOR_NAME, 2, 2) 이름
FROM TB_PROFESSOR;

-- FUNCTION 5 
SELECT STUDENT_NO, STUDENT_NAME
FROM TB_STUDENT
WHERE (EXTRACT(YEAR FROM ENTRANCE_DATE) - EXTRACT(YEAR FROM TO_DATE(SUBSTR(STUDENT_SSN, 1, 6)))) >= 20;

-- FUNCTION 6
SELECT TO_CHAR(TO_DATE(201225), 'DAY') FROM DUAL;

-- FUNCTION 7
SELECT TO_DATE('99/10/11', 'YY/MM/DD'), 
        TO_DATE('49/10/11', 'YY/MM/DD'), 
        TO_DATE('99/10/11', 'RR/MM/DD'),
        TO_DATE('49/10/11', 'RR/MM/DD') FROM DUAL;

-- FUNCTION 8
SELECT STUDENT_NO, STUDENT_NAME
FROM TB_STUDENT
WHERE STUDENT_NO NOT LIKE 'A%';

-- FUNCTION 9
SELECT ROUND(AVG(POINT), 1) 평점
FROM TB_GRADE
WHERE STUDENT_NO = 'A517178';

-- FUNCTION 10
SELECT DEPARTMENT_NO 학과번호, SUM(DEPARTMENT_NO)/DEPARTMENT_NO "학생수(명)"
FROM TB_STUDENT
GROUP BY DEPARTMENT_NO
ORDER BY 1;

-- FUNCTION 11
SELECT COUNT(*)
FROM TB_STUDENT
WHERE COACH_PROFESSOR_NO IS NULL;

-- FUNCTION 12
SELECT SUBSTR(TERM_NO,1,4) 년도, ROUND(AVG(POINT),1) "년도 별 평점"
FROM (SELECT * FROM TB_GRADE WHERE STUDENT_NO = 'A112113')
GROUP BY SUBSTR(TERM_NO,1,4)
ORDER BY 1;

-- FUNCTION 13
SELECT DEPARTMENT_NO 학과코드명, SUM(DECODE(ABSENCE_YN, 'Y', 1, 'N', 0)) "휴학생 수"
FROM TB_STUDENT
GROUP BY DEPARTMENT_NO
ORDER BY 1;

-- FUNCTION 14 
SELECT STUDENT_NAME 동일인물, SUM(EXTRACT(DAY FROM ENTRANCE_DATE)) "동명인 수"
FROM TB_STUDENT
GROUP BY STUDENT_NAME HAVING SUM(EXTRACT(DAY FROM ENTRANCE_DATE)) >= 2;

-- FUNCTION 15
SELECT SUBSTR(TERM_NO,1,4) 년도, SUBSTR(TERM_NO,5,2) 학기, 
CASE WHEN SUBSTR(TERM_NO,1,4) IS NULL THEN ROUND(SUM(POINT)/9,1)
    WHEN COUNT(SUBSTR(TERM_NO,1,4)) >= 3 THEN ROUND(SUM(POINT)/3,1)
    WHEN COUNT(SUBSTR(TERM_NO,1,4)) <= 2 AND SUBSTR(TERM_NO,5,2) IS NOT NULL THEN ROUND(SUM(POINT),1)
    ELSE ROUND(SUM(POINT)/2,1)
    END 평점
FROM (SELECT * FROM TB_GRADE WHERE STUDENT_NO = 'A112113')
GROUP BY ROLLUP (SUBSTR(TERM_NO,1,4), SUBSTR(TERM_NO,5,2))
ORDER BY 1;
-- END