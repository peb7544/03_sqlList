
-- 한줄 주석

/*
 * 범위주석
 * 
 * 
 * */

-- 11G 버전 이전의 문접을 사용 가능하도록 함
ALTER SESSION SET "_ORACLE_SCRIPT" = TRUE;

-- CTRL + ENTER : 선택한 SQL 수행

-- 사용자 계정 생성
CREATE USER board_project IDENTIFIED BY board1234;

-- 사용자 권한 부여
GRANT RESOURCE, CONNECT TO board_project;

-- 객체가 생성될 수 있는 공간 할당량 지정
ALTER USER board_project DEFAULT TABLESPACE SYSTEM QUOTA UNLIMITED ON SYSTEM;


-- 사용자 계정 생성
CREATE USER exam_peb IDENTIFIED BY exam_peb;

-- 사용자 권한 부여
GRANT RESOURCE, CONNECT TO exam_peb;

-- 객체가 생성될 수 있는 공간 할당량 지정
ALTER USER exam_peb DEFAULT TABLESPACE SYSTEM QUOTA UNLIMITED ON SYSTEM;

DROP USER kh_peb CASCADE;

ALTER SESSION SET "_oracle_script"=TRUE;



-- 11G 버전 이전의 문접을 사용 가능하도록 함
ALTER SESSION SET "_ORACLE_SCRIPT" = TRUE;

-- 사용자 계정 생성
CREATE USER kh_peb IDENTIFIED BY kh1234;

-- 사용자 권한 부여
GRANT RESOURCE, CONNECT TO kh_peb;

-- 객체가 생성될 수 있는 공간 할당량 지정
ALTER USER kh_peb DEFAULT TABLESPACE SYSTEM QUOTA UNLIMITED ON SYSTEM;

DROP USER exam_PEB CASCADE;
