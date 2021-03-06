---------------------------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- 테이블 생성하기

-- CREATE TABLE 테이블명 (
--      컬럼명 데이터타입(사이즈),                              : NULL값이 허용되는 컬럼
--      컬럼명 데이터타입(사이즈) NOT NULL,                     : NULL값이 허용되지 않는 컬럼
--      컬럼명 데이터타입(사이즈) DEFAULT 기본값,                : DEFAULT는 컬럼의 기본값을 지정 
--                                                             행을 추가할 때 값이 지정되지 않으면 지정된 기본 값이 해당 컬럼의 값이 지정된다.
--                                                             행을 추가할 때 값을 지정하면 그 값이 컬럼의 값이 된다.
--      컬럼명 데이터타입(사이즈) 제약조건                       : 컬럼에 제약조건을 지정한다. 제약조건에 위배되는 값은 저장되지 않는다.
--      컬럼명 데이터타입(사이즈) CONSTRAINT 제약조건별칭 제약조건 : 컬럼에 제약조건과 제약조건 별칭을 지정한다.
--                                                             제약조건 별칭을 지정해두면 추가/변경/삭제 작업시 오류가 발생 시
--                                                             오류메시지에 제약조건의 별칭이 표시되기 떄문에 빠른 오류 원인 파악 가능.
--                                                             제약조건별칭은 테이블명_컬럼명_제약조건(30자 이하)으로 작성
---------------------------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- 일련번호를 발행하는 객체 생성하기
-- CREATE SEQUENCE 시퀀스명;

-- CREATE SEQUENCE 시퀀스명
--  INCREMENT BY 1      : 일련번호를 발행할 때마다 1씩 증가시킨다.
--  START WITH 1001     : 일련번호의 시작값을 1001로 한다. 기본값은 1이다.
--  NOCACHE;            : 일련번호를 미리 생성해 두지 않게 한다. 기본값은 CACHE 20이다.
--                        CACHE는 발행 전에 미리 생성해서 바로 주는 것으로 실행효율이 높다.
--                        그러나 DB 재접속시 21번부터 번호를 발행함(중요하지는 않음. 고유한 일련값이면 되기 때문에)

-- 시퀀스 객체의 내장함수
--      NEXTVAL : 시퀀스에서 새로운 일련번호를 발행받는다.
--      CURRVAL : 시퀀스에서 현재 일련번호를 조회한다. 현재 세션에서 CURRVAL은 반드시 NEXTVAL이 실행된 후에만 사용할 수 있다.

-- INSERT문에서 시퀀스의 일련번호를 발행받아서 저장하기
-- INSERT INTO SAMPLE_PRODUCTS (PRODUCT_NO, PRODUCT_NAME, ...)
-- VALUES (시퀀스명.NEXTVAL, '애플워치 7', ...)

---------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- 샘플 테이블 생성하기
CREATE TABLE SAMPLE_PRODUCTS (
    PRODUCT_NO              NUMBER(6)       CONSTRAINT SAMPLE_PRODUCTS_NO_PK PRIMARY KEY,
    PRODUCT_NAME            VARCHAR2(255)   NOT NULL,
    PRODUCT_COMPANY         VARCHAR2(255)   NOT NULL,
    PRODUCT_PRICE           NUMBER(10)      NOT NULL,
    PRODUCT_DISCOUNT_PRICE  NUMBER(10),
    PRODUCT_STOCK           NUMBER(6)       NOT NULL,
    PRODUCT_STATUS          VARCHAR2(100)   DEFAULT '판매중',
    PRODUCT_CREATED_DATE    DATE            DEFAULT SYSDATE
    );
    
-- * DATE 타입은 사이즈를 지정할 필요가 없다.
-- * SYSDATE는 시스템의 현재 날짜와 시간정보를 제공하는 오라클의 내장함수다.
-- * 도구 - 환경설정 - 데이터베이스:NLS 에서 날짜 형식을 수정할 수 있다.

---------------------------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- 테이블에 새로운 행 추가하기
-- * INSERT INTO ~ VALUES 명령어를 사용해서 테이블에 새로운 행을 추가할 수 있다.

-- 추가되는 행의 모든 컬럼에 값을 지정해서 새로운 행을 추가하기

-- INSERT INTO 테이블명 (컬럼명, 컬럼명, 컬럼명, 컬럼명, 컬럼명, 컬럼명, ..., 컬럼명)
-- VALUES              (값,    값,     값,    값,    값,     값,    ..., 값);

-- * VALUES 절에서 지정하는 값의 순서가 테이블의 컬럼순서와 일치하고, 모든 컬럼에 빠짐없이 값을 지정하는 경우
--   INSERT INTO 절에서 컬럼명을 생략할 수 있다.
-- * 이 방법은 절대 사용하지 않는다. 컬럼명을 쓰지 않으면 추후 파악이 어려워 유지보수 시 부적절하다.
-- INSERT INTO 테이블명
-- VALUES (값, 값, 값, 값, 값, 값, ..., 값);

-- 행의 특정 컬럼에만 값을 지정해서 새로운 행을 추가하기
-- * 제외된 컬럼의 값은 DEFAULT값이 지정되어 있으면 그 값이, 지정되어 있지 않으면 자동으로 NULL이 된다.
-- * 행의 특정 컬럼에만 값을 지정해서 새로운 행을 추가할 때는 INSERT INTO 절에서 컬럼명을 생략할 수 없다.
-- * 컬럼명은 테이블의 순서와 일치하게 작성할 필요가 없고, INSERT INTO 절에서 컬럼명과 정의하는 값이 서로 순서가 대응되기만 하면 된다.
-- INSERT INTO 테이블명 (컬럼명, 컬럼명, 컬럼명)
-- VALUES              (값,    값,     값)
-- * 위에서 제시한 컬럼 3개를 제외한 나머지 컬럼들은 NULL이나 해당 컬럼의 DEFAULT값이 저장된다.
---------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- SAMPLE PRODUCTS 테이블에 새 상품정보 저장하기
INSERT INTO SAMPLE_PRODUCTS
(PRODUCT_NO, PRODUCT_NAME, PRODUCT_COMPANY, PRODUCT_PRICE, PRODUCT_DISCOUNT_PRICE, PRODUCT_STOCK)
VALUES
(1000, '애플워치 SE', '애플', 350000, NULL, 10);

-- 상품번호로 사용할 일련번호를 발행해주는 시퀀스 객체 생성하기
CREATE SEQUENCE PRODUCTS_SEQ
INCREMENT BY 1 START WITH 1001 NOCACHE;

-- 시퀀스에서 발행받은 일련번호로 상품번호를 지정하고, 새 상품정보 저장하기
INSERT INTO SAMPLE_PRODUCTS
(PRODUCT_NO, PRODUCT_NAME, PRODUCT_COMPANY, PRODUCT_PRICE, PRODUCT_STOCK)
VALUES
(PRODUCTS_SEQ.NEXTVAL, '갤럭시 S22', '삼성', 1500000, 5);

-- NOT NULL 제약조건이 지정된 컬럼의 값을 누락시키고 새 상품정보를 저장하기 : 오류 발생, 별도 제약조건 지정 없이도 오류 내용 출력됨
INSERT INTO SAMPLE_PRODUCTS
(PRODUCT_NO, PRODUCT_NAME, PRODUCT_COMPANY, PRODUCT_PRICE)
VALUES
(PRODUCTS_SEQ.NEXTVAL, '갤럭시 S22', '삼성', 1500000);
---------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- 테이블에 새로운 행을 추가할 때 체크할 내용
-- 1. 컬럼명을 체크하자
-- 2. 데이터타입을 체크하자
-- 3. NOT NULL 허용여부를 체크하자. NULL이 허용되지 않는 컬럼은 반드시 값을 지정해야 한다.
-- 4. 컬럼별 제약조건을 체크하자. 각 제약조건에 맞는 값을 지정해야 한다.
-- 5. INSERT문 작성시 컬럼명을 반드시 작성하자.
-- 6. 컬럼의 개수와 값의 개수가 일치하는지 체크하자.
-- 7. NULL이 허용되지 않는 컬럼이 누락되었는지 체크하자.
-- 8. PRIMARY KEY로 설정된 컬럼의 값으로 사용되는 시퀀스가 있는지 체크하자. 없을 경우 CREATE SEQUENCE로 만든다.
----------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- * 데이터 추가, 변경, 삭제 내용은 커밋하기 전까지는 DBMS의 메모리에만 반영되어있는 것이다.
-- * 커밋은 오류 발생시 롤백되어 변경 내용을 모두 되돌리므로 완전히 변경되거나 변경되지 않은 상태이다.
----------------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- 데이터 변경하기
-- UPDATE 명령어로 데이터를 변경하기

-- WHERE절이 없으면 테이블의 모든 행에서 지정된 컬럼의 값을 새로운 값으로 변경한다.
-- * WHERE절 없는 UPDATE문을 실행할 경우는 거의 없다.
-- UPDATE 테이블명
-- SET
--  컬럼명 = 값,
--  컬럼명 = 값,
--  컬럼명 = 값;

-- WHERE절이 있으면 조건식이 TRUE로 판정되는 행에서만 지정된 컬럼의 값을 새로운 값으로 변경한다.

-- UPDATE 테이블명
-- SET
--  컬럼명 = 값,
--  컬럼명 = 값,
--  컬럼명 = 값
-- WHERE 조건식;
----------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- SAMPLE_PRODUCTS 테이블의 모든 상품 재고를 100개로 변경하기
UPDATE SAMPLE_PRODUCTS
SET
    PRODUCT_STOCK = 100;
    
-- SAMPLE_PRODUCTS 테이블의 모든 상품 재고를 10개로 변경하고, 상품의 할인가격을 상품가격에서 15% 할인된 가격으로 변경한다.
UPDATE SAMPLE_PRODUCTS
SET
    PRODUCT_STOCK = 10,
    PRODUCT_DISCOUNT_PRICE = PRODUCT_PRICE * 0.85;
    
-- '삼성'에서 제조한 상품의 재고량을 5개로 변경하기
UPDATE SAMPLE_PRODUCTS
SET
    PRODUCT_STOCK = 5
WHERE PRODUCT_COMPANY = '삼성';

-- 1031번 상품의 상품명과 가격, 할인가격, 재고량을 변경하기
-- 상품명 : '갤럭시 S22 Ultra', 가격: 1900000, 할인가격: 1700000, 재고량: 20
UPDATE SAMPLE_PRODUCTS
SET
    PRODUCT_NAME = '갤럭시 S22 Ultra',
    PRODUCT_PRICE = 1900000,
    PRODUCT_DISCOUNT_PRICE = 1700000,
    PRODUCT_STOCK = 20
WHERE PRODUCT_NO = 1052;
----------------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- 데이터 삭제하기 (행 단위를 뜻함. 특정 컬럼의 값을 지우는 것은 UPDATE에서 NULL을 대입하면 된다.)
-- DELETE 명령어로 데이터 삭제하기

-- 테이블에 저장된 모든 행 삭제하기
-- * WHERE절 없이 DELETE문을 실행하면 테이블의 모든 행이 삭제되기 때문에, WHERE절 없이 사용되는 경우는 드물다.
-- DELETE FROM 테이블명;

-- WHERE절의 조건식이 TRUE로 판정되는 행만 삭제하기
-- * WHERE절의 조건식이 TRUE로 판정되는 행만 삭제하기
-- DELETE FROM 테이블명
-- WHERE 조건식;
----------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- * INSERT, UPDATE, DELETE 시에는 제약조건을 잘 체크해야 한다.
-- 아래 구문들은 문법적으로는 틀린 게 없지만 무결성 제약조건을 위배하기 때문에 오류가 발생한다.

DELETE FROM DEPARTMENTS
WHERE DEPARTMENT_ID = 10;

UPDATE EMPLOYEES
SET 
    DEPARTMENT_ID = 1000
WHERE EMPLOYEE_ID = 100;
----------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- 상품명이 '갤럭시 S22'이고 상품번호가 1060번이 아닌 상품 삭제하기
DELETE FROM SAMPLE_PRODUCTS
WHERE
    PRODUCT_NAME = '갤럭시 S22'
    AND PRODUCT_NO != 1060;
    
-- COMMIT을 실행해서 작업내용을 데이터베이스에 반영시킨다.
COMMIT;
