-- 한 줄 주석
/*
여러 줄 주석
*/

-- 사용자계정 생성하는 구문 (관리자 계정만이 할 수 있는 역할)
-- [표현법] CREATE USER (계정명) IDENTIFIED BY (비밀번호);
CREATE USER KH IDENTIFIED BY KH;

-- 사용자 계정에게 최소한의 권한 (데이터관리, 접속) 부여
--[표현법] GRANT RIGHT1, RIGHT2, .... TO 계정명;
GRANT RESOURCE, CONNECT TO KH;
