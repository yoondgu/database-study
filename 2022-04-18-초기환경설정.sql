alter session set "_ORACLE_SCRIPT" = true;

-- 관리자 권한으로 사용자를 새로 등록함 
-- 사용자명 : hr
-- 비밀번호 : zxcv1234
create user hr identified by zxcv1234;

-- 관리자 권한으로 hr 사용자에게 권한을 부여함 (롤 : 권한을 여러 개 묶은 것)
-- connect : DBMS에 접속할 수 있는 권한
-- resource : DBMS에서 여러 자원을 사용할 수 있는 권한(데이터베이스 객체 생성, 변경, 삭제가 가능해진다.)
-- dba : 데이터베이스 관리자 권한
grant connect, resource, dba to hr;
-- 사용자명 'hr 계정'으로 db 접속이 가능해짐 