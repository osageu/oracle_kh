CREATE SEQUENCE SEQ_EMPNO
START WITH 300
INCREMENT BY 5
MAXVALUE 310
NOCYCLE
NOCACHE;

SELECT * FROM USER_SEQUENCES;

SELECT SEQ_EMPNO.CURRVAL FROM DUAL;
--> NEXTVAL를 한 번이라도 수행하지 않는 이상 CURRVAL 불가
--> CURRVAL은 사실 마지막으로 성공적으로 수행된 NEXTVAL 값을 저장해서 보여주는 임시값

SELECT SEQ_EMPNO.NEXTVAL FROM DUAL;
SELECT SEQ_EMPNO.CURRVAL FROM DUAL;
SELECT SEQ_EMPNO.NEXTVAL FROM DUAL;
SELECT SEQ_EMPNO.NEXTVAL FROM DUAL;
SELECT SEQ_EMPNO.NEXTVAL FROM DUAL; --> 310 초과해서 ERROR;
SELECT * FROM USER_SEQUENCES; --> LAST_NUMBER가 315로 되어있음

ALTER SEQUENCE SEQ_EMPNO
INCREMENT BY 10
MAXVALUE 400
NOCYCLE
NOCACHE;

SELECT * FROM USER_SEQUENCES;

SELECT SEQ_EMPNO.CURRVAL FROM DUAL;
SELECT SEQ_EMPNO.NEXTVAL FROM DUAL;

DROP SEQUENCE SEQ_EMPNO;

----------------------------------------------------------------------------------------------------------------------------

-- 매 번 새로운 사번이 발생되는 시퀀스 생성
CREATE SEQUENCE SEQ_EID
START WITH 300;

SELECT SEQ_EID FROM DUAL;

INSERT INTO EMPLOYEE
VALUES (SEQ_EID.NEXTVAL, '홍길동', '666666-7777777', 'hong@iei.or.kr', '01041112222','D2','J2', 5000000, 0.1, NULL, SYSDATE, NULL, DEFAULT);

INSERT INTO EMPLOYEE
VALUES (SEQ_EID.NEXTVAL, '공유', '111111-2222222', 'GGG@iei.or.kr', '01041112222','D1','J3', 6000000, NULL, NULL, SYSDATE, NULL, DEFAULT);

SELECT SEQ_EID.CURRVAL FROM DUAL;

UPDATE EMPLOYEE
SET EMP_NAME = '겅유'
WHERE EMP_NAME = '공유';

ROLLBACK;







