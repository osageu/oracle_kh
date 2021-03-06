-- TRIGGER
-- EMPLOYEE 테이블에 새로운 행이 INSERT될 때 자동으로 메세지 출력하는 트리거
CREATE OR REPLACE TRIGGER TRG_01
AFTER INSERT ON EMPLOYEE
BEGIN 
    DBMS_OUTPUT.PUT_LINE('신입사원 추가요~');
END;
/

INSERT INTO EMPLOYEE
VALUES(300, '길성춘', '111111-2222222', 'GIL@NAVER.COM', '01011112222'
        , 'D2', 'J7', 2000000, 0.3, NULL, SYSDATE, NULL, DEFAULT);

INSERT INTO EMPLOYEE
VALUES(301, '길춘향', '111111-2222222', 'GIL@NAVER.COM', '01011112222'
        , 'D3', 'J6', 2000000, 0.3, NULL, SYSDATE, NULL, DEFAULT);


-- 상품 입출고 관련 예시
-- 1. 상품에 대한 데이터 보관할 테이블 (TB_PRODUCT)
CREATE TABLE TB_PRODUCT(
    PCODE NUMBER PRIMARY KEY,
    PANME VARCHAR2(30),
    BRAND VARCHAR2(30),
    PRICE NUMBER,
    STOCK NUMBER DEFAULT 0
);

CREATE SEQUENCE SEQ_PCODE;

INSERT INTO TB_PRODUCT
VALUES (SEQ_PCODE.NEXTVAL, '갤럭시10', '삼성', 1300000, DEFAULT);
INSERT INTO TB_PRODUCT
VALUES (SEQ_PCODE.NEXTVAL, '아이폰11PRO', '애플', 1000000, DEFAULT);
INSERT INTO TB_PRODUCT
VALUES (SEQ_PCODE.NEXTVAL, '대륙폰', '샤우미', 600000, DEFAULT);

-- 2. 상품 입출고 상세 이력 테이블 (TB_PRODETAIL)
CREATE TABLE TB_PRODETAIL(
    DCODE NUMBER PRIMARY KEY,
    PCODE NUMBER,
    PDATE DATE,
    AMOUNT NUMBER,
    STATUS VARCHAR2(10),
    CHECK (STATUS IN ('입고', '출고')),
    FOREIGN KEY (PCODE) REFERENCES TB_PRODUCT
);

CREATE SEQUENCE SEQ_DCODE;

INSERT INTO TB_PRODETAIL
VALUES (SEQ_DCODE.NEXTVAL, 1, SYSDATE, 10, '입고');
UPDATE TB_PRODUCT
SET STOCK = STOCK + 10
WHERE PCODE = 1;

INSERT INTO TB_PRODETAIL
VALUES (SEQ_DCODE.NEXTVAL, 2, SYSDATE, 20, '입고');
UPDATE TB_PRODUCT
SET STOCK = STOCK + 20
WHERE PCODE = 2;

INSERT INTO TB_PRODETAIL
VALUES (SEQ_DCODE.NEXTVAL, 3, SYSDATE, 5, '입고');
UPDATE TB_PRODUCT
SET STOCK = STOCK + 5
WHERE PCODE = 3;

INSERT INTO TB_PRODETAIL
VALUES (SEQ_DCODE.NEXTVAL, 2, SYSDATE, 5, '출고');
UPDATE TB_PRODUCT
SET STOCK = STOCK - 5
WHERE PCODE = 2;

-- 3. TRIGGER
CREATE OR REPLACE TRIGGER TRG_02
AFTER INSERT ON TB_PRODETAIL
FOR EACH ROW
BEGIN

    IF :NEW.STATUS = '입고'
        THEN UPDATE TB_PRODUCT
             SET STOCK = STOCK + :NEW.AMOUNT
             WHERE PCODE = :NEW.PCODE;
    ELSIF :NEW.STATUS = '출고'
        THEN UPDATE TB_PRODUCT
             SET STOCK = STOCK - :NEW.AMOUNT
             WHERE PCODE = :NEW.PCODE;
    END IF;
    
END;
/

SELECT * FROM TB_PRODUCT;
SELECT * FROM TB_PRODETAIL;

INSERT INTO TB_PRODETAIL
VALUES(SEQ_DCODE.NEXTVAL, 1, SYSDATE, 5, '출고');
INSERT INTO TB_PRODETAIL
VALUES(SEQ_DCODE.NEXTVAL, 2, SYSDATE, 100, '입고');
INSERT INTO TB_PRODETAIL
VALUES(SEQ_DCODE.NEXTVAL, 3, SYSDATE, 200, '입고');











