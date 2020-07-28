DROP TABLE MEMBER;
CREATE TABLE MEMBER(
    USER_NO NUMBER PRIMARY KEY,
    USER_ID VARCHAR2(15) NOT NULL UNIQUE,
    USER_PW VARCHAR2(20) NOT NULL,
    USER_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(1) CHECK (GENDER IN ('M', 'F')),
    AGE NUMBER,
    EMAIL VARCHAR2(30),
    PHONE CHAR(11),
    ADDRESS VARCHAR2(100),
    HOBBY VARCHAR2(50),
    ENROLLDATE DATE DEFAULT SYSDATE
);

CREATE SEQUENCE SEQ_USER_NO;
DROP SEQUENCE SEQ_USER_NO;
DROP TABLE MEMBER;
INSERT INTO MEMBER
VALUES (SEQ_USER_NO.NEXTVAL, 'ADMIN', '1234', '홍길동', 'M', 45, 'ADMIN@NAVER.COM', '01011111111', 'GANGNAM', 'SLEEP', '2020/06/21');
INSERT INTO MEMBER
VALUES (SEQ_USER_NO.NEXTVAL, 'USER01', 'PASS01', '여자임', 'F', 20, 'USER01@NAVER.COM', '01022222222', 'HOEGI', 'FLOWER', '2020/07/01');

------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- 사용자가 회원가입 요청 시 실행해야 되는 sql문 (Statement)
INSERT INTO MEMBER
VALUES (SEQ_USER_NO.NEXTVAL, '???', '???', '???', '?', ?, '???', '???', '???', '???', '????/??/??');

-- 사용자가 회원가입 요청 시 실행해야 되는 sql문 (PreparedStatement)
INSERT INTO MEMBER
VALUES (SEQ_USER_NO.NEXTVAL, ?, ?, ?, ?, ?, ?, ?, ?, ?, SYSDATE);

-- 사용자가 전체 회원 조회 요청 시 실행해야되는 sql문
SELECT *
FROM MEMBER;

ALTER TABLE MEMBER ADD DEL_FLAG CHAR(1) DEFAULT 'N';
SELECT * FROM MEMBER WHERE USER_ID = 'user02' AND USER_PW = 'pass02' AND DEL_FLAG = 'N';

-----------------------------------------------------------------------------------------------------------------------------------------















