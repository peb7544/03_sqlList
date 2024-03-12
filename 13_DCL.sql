/*
	DCL(Data Control Language) : 데이터를 다루기 위한 권한을 다루는 언어
	
	- 계정에 DB, DB 객체에 대한 접근 권한을 
	  부여(GRANT)하고 회수(REVOKE)하는 언어


	* 권한의 종류
	
	1) 시스템 권한 : DB접속, 객체 생성 권한
	
	CRETAE SESSION   : 데이터베이스 접속 권한
	CREATE TABLE     : 테이블 생성 권한
	CREATE VIEW      : 뷰 생성 권한
	CREATE SEQUENCE  : 시퀀스 생성 권한
	CREATE PROCEDURE : 함수(프로시져) 생성 권한
	CREATE USER      : 사용자(계정) 생성 권한
	DROP USER        : 사용자(계정) 삭제 권한
	DROP ANY TABLE   : 임의 테이블 삭제 권한
	
	
	2) 객체 권한 : 특정 객체를 조작할 수 있는 권한

	  권한 종류                 설정 객체
	    SELECT              TABLE, VIEW, SEQUENCE
	    INSERT              TABLE, VIEW
	    UPDATE              TABLE, VIEW
	    DELETE              TABLE, VIEW
	    ALTER               TABLE, SEQUENCE
	    REFERENCES          TABLE
	    INDEX               TABLE
	    EXECUTE             PROCEDURE

*/


/* USER - 계정(사용자)

* 관리자 계정 : 데이터베이스의 생성과 관리를 담당하는 계정.
                모든 권한과 책임을 가지는 계정.
                ex) sys(최고관리자), system(sys에서 권한 몇개 제외된 관리자)


* 사용자 계정 : 데이터베이스에 대하여 질의, 갱신, 보고서 작성 등의
                작업을 수행할 수 있는 계정으로
                업무에 필요한 최소한의 권한만을 가지는 것을 원칙으로 한다.
                ex) kh_bdh계정(각자 이니셜 계정), workbook 등
*/

-- GREANT RESOURCE, CONNECT TO kh_peb;

-- 롤(role)
-- 다수 사용자와 다양한 권한을 효율적으로 관리하기 위하여
-- 서로 관련된 권한을 그룹화한 개념(권한의 묶음)

SELECT * FROM ROLE_SYS_PRIVS
WHERE ROLE = 'RESOURCE';
-- CREATE 트리거, 시퀀스, 테이블 등 8가지 권한이 부여되어있음

SELECT * FROM ROLE_SYS_PRIVS
WHERE ROLE = 'CONNECT';

-- 1. (SYS)사용자 계정 생성

ALTER SESSION SET "_ORACLE_SCRIPT" = TRUE;
--> 예전 SQL 방식 허용(계정명을 간단히 작성 가능)

-- [작성법]
-- CREATE USER 사용자명 IDENTIFIED BY 비밀번호
CREATE USER peb_sample IDENTIFIED BY sample1234;

-- 2. 새 연결 추가
--> ORA-01045: 사용자 PEB_SAMPLE는 CREATE SESSION 권한을 가지고있지 않음; 로그온이 거절되었습니다
--> 접속 권한(CREATE SESSION)없어서 오류 발생

-- 3. 접속 권한 부여 
-- [권한 부여 작성법]
-- GRANT CREATE SESSION, 권한, 권한... TO 사용자명;
GRANT CREATE SESSION TO peb_sample;

-- 4. 다시 연결 추가 -> 성공

-- 5. (sample) 테이블 생성
CREATE TABLE TB_TEST(
	PK_COL NUMBER PRIMARY KEY,
	CONTENT VARCHAR2(100)
);
