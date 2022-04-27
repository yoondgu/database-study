----------------------------------------------------------------------------------------------------------------------------
-- 숫자 함수
-- ROUND(컬럼 및 표현식), ROUND(컬럼 및 표현식, 자리수) 자리수가 음수일 때는 정수부의 특정 자리까지 반올림한다.
-- 반올림

-- TRUNC(컬럼 및 표현식), TRUNC(컬럼 및 표현식, 자리수)
-- 소숫점 부분을 버림

-- FLOOR(컬럼 및 표현식)
-- 바닥값을 반환

-- CEIL(컬럼 및 표현식)
-- 천정값을 반환
----------------------------------------------------------------------------------------------------------------------------
SELECT  ROUND(1234.123),        -- 일의 자리로 반올림
        ROUND(1234.123, 0),     -- 일의 자리로 반올림
        ROUND(1234.123, 1),     -- 소숫점 첫번째 자리로 반올림
        ROUND(1234.123, 2),     -- 소수점 두번째 자리로 반올림
        ROUND(1234.123, -1),    -- 십의 자리로 반올림
        ROUND(1234.123, -2),    -- 백의 자리로 반올림
        ROUND(1234.123, -3)     -- 천의 자리로 반올림
FROM DUAL;

SELECT  TRUNC(1234.123),        -- 일의 자리까지 남기고 나머지는 버림
        TRUNC(1234.123, 0),     -- 일의 자리까지 남기고 나머지는 버림
        TRUNC(1234.123, 1),     -- 소숫점 첫번째 자리까지 남기고 나머지는 버림
        TRUNC(1234.123, 2),     -- 소수점 두번째 자리까지 남기고 나머지는 버림
        TRUNC(1234.123, -1),    -- 십의 자리까지 남기고 나머지는 전부 0
        TRUNC(1234.123, -2),    -- 백의 자리까지 남기고 나머지는 전부 0
        TRUNC(1234.123, -3)     -- 천의 자리까지 남기고 나머지는 전부 0
FROM DUAL;

SELECT  ROUND(1.2), -- 1    
        ROUND(1.8), -- 2    
        TRUNC(1.2), -- 1
        TRUNC(1.8), -- 1
        FLOOR(1.2), -- 1
        FLOOR(1.8), -- 1
        CEIL(1.2),  -- 2
        CEIL(1.8)   -- 2
FROM DUAL;

SELECT  ROUND(-1.2), -- -1    
        ROUND(-1.8), -- -2    
        TRUNC(-1.2), -- -1
        TRUNC(-1.8), -- -1
        FLOOR(-1.2), -- -2
        FLOOR(-1.8), -- -2
        CEIL(-1.2),  -- -1
        CEIL(-1.8)   -- -1
FROM DUAL;

----------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------
-- 날짜함수
----------------------------------------------------------------------------------------------------------------------------
SELECT  SYSDATE,            -- 시스템의 현재 날짜와 시간정보를 반환 
        ROUND(SYSDATE),     -- 시스템의 현재 날짜와 시간정보를 참조해서 시간이 정오를 지났으면 다음 날짜를 반환한다.
        TRUNC(SYSDATE)      -- 시스템의 현재 날짜와 시간정보를 참조해서 항상 시,분,초를 0으로 지정한 날짜 정보를 반환한다.
FROM DUAL;

SELECT  SYSDATE,
        TRUNC(SYSDATE) - 3, -- 지금 날짜와 시간정보를 기준으로 3일전 날짜를 반환한다.
        TRUNC(SYSDATE) - 7  -- 지금 날짜와 시간정보를 기준으로 7일전 날짜를 반환한다.
FROM DUAL;

-- 오늘을 기준으로 3일 이내에 등록된 새 책정보를 조회하기
SELECT *
FROM SAMPLE_PRODUCTS
WHERE PRODUCT_CREATED_DATE >= TRUNC(SYSDATE) - 3;

-- ADD_MONTHS(컬럼 혹은 표현식, 숫자)
-- 지정된 날짜를 기준으로 지정된 숫자만큼 개월수가 감소/증가된 날짜를 반환한다.
-- 숫자값을 음수로 설정하면 감소된 개월수에 해당되는 날짜가 반환된다.

SELECT  ADD_MONTHS(SYSDATE, 1),     -- 1개월 후 
        ADD_MONTHS(SYSDATE, 2),     -- 2개월 후
        ADD_MONTHS(SYSDATE, 3),     -- 3개월 후
        ADD_MONTHS(SYSDATE, -1),    -- 1개월 전
        ADD_MONTHS(SYSDATE, -2),    -- 2개월 전
        ADD_MONTHS(SYSDATE, -3)     -- 3개월 전
FROM DUAL;

-- MONTHS_BETWEEN(컬럼 혹은 표현식, 컬럼 혹은 표현식)
-- 두 날짜사이의 개월 수를 반환한다.

SELECT EMPLOYEE_ID, FIRST_NAME, HIRE_DATE, TRUNC(MONTHS_BETWEEN(SYSDATE, HIRE_DATE)) MONTHS
FROM EMPLOYEES
WHERE DEPARTMENT_ID = 60;

-- 날짜관련 연산
-- 날짜 + 숫자 : 숫자만큼 이후 날짜를 반환한다.
-- 날짜 - 숫자 : 숫자만큼 이전 날짜를 반환한다.
-- 날짜 - 날짜 : 두 날짜사이의 일수를 반환한다.
-- 날짜 + 날짜 : 오류, 날짜와 날짜를 더하는 연산은 지원하지 않는다.

SELECT  SYSDATE + 3,
        SYSDATE - 3,
        TRUNC(SYSDATE) - TO_DATE('1973-04-11')
FROM DUAL;

SELECT  TRUNC(SYSDATE) + 1/24,      -- 1시간 후 
        TRUNC(SYSDATE) + 12/24,     -- 12시간 후
        TRUNC(SYSDATE) + 23/24      -- 23시간 후
FROM DUAL;

----------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------
-- 변환 함수

-- 문자 -> 숫자 : TO_NUMBER('문자', '패턴') 특정패턴으로 구성된 숫자형식의 문자를 숫자로 변환
-- 숫자 -> 문자 : TO_CHAR(숫자, '패턴')

-- 문자 -> 날짜 : TO_DATE('문자', '패턴') 특정패턴으로 구성된 날짜형식의 문자를 날짜로 변환
-- 날짜 -> 문자 : TO_CHAR(날짜, '패턴')
----------------------------------------------------------------------------------------------------------------------------

-- 묵시적 변환 : 연산자나 연산대상이 되는 컬럼의 타입 등을 고려해서 문자를 숫자나 날짜로 자동으로 변환하는 것 
-- 숫자로만 이루어진 문자이거나, 날짜 표기 형식의 문자일 경우에 가능하다.
SELECT '123' + '123'
FROM DUAL;

SELECT * FROM EMPLOYEES
WHERE SALARY > '15000'; -- 묵시적 변환

-- 명시적 변환 : 변환함수를 사용해서 문자를 숫자나 날짜로 변환하는 것
-- 필요할 경우 패턴을 알려주어야 변환 가능하다.
SELECT TO_NUMBER('123') + TO_NUMBER('123')
FROM DUAL;

SELECT TO_NUMBER('1,234', '9,999') + TO_NUMBER('1,234', '9,999')
FROM DUAL;

SELECT *
FROM EMPLOYEES
WHERE SALARY > TO_NUMBER('15,000', '99,999'); -- 명시적 변환

-- SQL에서 숫자를 원하는 형식의 문자로 변환해서 조회하는 것은 권장하지 않는다.
-- 테이블에 저장된 값은 가공 없이 자바 애플리케이션에게 제공하고, 자바 애플리케이션의 표현 계층에서 다양한 형식으로 표현하도록 할 것

-- 문자를 날짜로 변환하기

-- 날짜도 묵시적 변환이 가능하다.
SELECT EMPLOYEE_ID, FIRST_NAME, HIRE_DATE
FROM EMPLOYEES
WHERE HIRE_DATE >= '2005/01/01'; -- 입사일이 2005년 1월 1일 0시 0분 0초 이후인 사원 조회

SELECT EMPLOYEE_ID, FIRST_NAME, HIRE_DATE
FROM EMPLOYEES
WHERE HIRE_DATE >= '2005-01-01'; -- 입사일이 2005년 1월 1일 0시 0분 0초 이후인 사원 조회

-- 날짜의 명시적 변환
SELECT EMPLOYEE_ID, FIRST_NAME, HIRE_DATE
FROM EMPLOYEES
WHERE HIRE_DATE >= TO_DATE('2005/01/01', 'YYYY/MM/DD'); -- 입사일이 2005년 1월 1일 0시 0분 0초 이후인 사원 조회

SELECT EMPLOYEE_ID, FIRST_NAME, HIRE_DATE
FROM EMPLOYEES
WHERE HIRE_DATE >= TO_DATE('2005-1-1', 'YYYY.MM.DD'); -- 입사일이 2005년 1월 1일 0시 0분 0초 이후인 사원 조회

-- 시분초 정보가 포함된 묵시적 형변환
SELECT *
FROM SAMPLE_PRODUCTS
WHERE PRODUCT_CREATED_DATE >= '2022/04/21 14:00:00';

-- 시분초 정보가 포함된 명시적 형변환
SELECT TO_DATE('2022/04/26 11:21:30')
FROM DUAL;

SELECT *
FROM SAMPLE_PRODUCTS
WHERE PRODUCT_CREATED_DATE >= TO_DATE('2022/04/21 14:00:00', 'YYYY/MM/DD HH24:MI:SS');

SELECT  TO_DATE('2022/04/21 14:00:00', 'YYYY/MM/DD HH24:MI:SS')
FROM DUAL;

-- 날짜를 특정 형식의 문자로 변환하기
SELECT  TO_CHAR(SYSDATE, 'YYYY'),
        TO_CHAR(SYSDATE, 'MM'),
        TO_CHAR(SYSDATE, 'DD'),
        TO_CHAR(SYSDATE, 'AM'), -- 오전 오후
        TO_CHAR(SYSDATE, 'HH'), -- 12시간제 
        TO_CHAR(SYSDATE, 'HH24'), -- 24시간제 시간
        TO_CHAR(SYSDATE, 'MI'),
        TO_CHAR(SYSDATE, 'SS'),
        TO_CHAR(SYSDATE, 'DAY') -- 요일
FROM DUAL;

-- 2005년에 입사한 직원정보 조회하기
SELECT *
FROM EMPLOYEES
WHERE TO_CHAR(HIRE_DATE, 'YYYY') = '2005';

-- 아래 방법이 더 적절하다. 위의 경우처럼 컬럼값을 가공한 뒤 연산해야 할 경우 쿼리성능이 떨어진다.
SELECT *
FROM EMPLOYEES
WHERE HIRES_DATE >= '2005/01/01' AND HIRE_DATE < '2006/01/01';
        
----------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------
-- 기타 함수
-- NVL(컬럼 혹은 표현식, 값1)
-- 컬럼 혹은 표현식의 값이 NULL이 아니면 컬럼 혹은 표현식의 값이 반환되고,
--                      NULL이면 값1이 반환된다.
-- * 컬럼 혹은 표현식의 값의 타입과 값1의 타입은 일치해야 한다.

-- NVL2(컬럼 혹은 표현식, 값1, 값2)
-- 컬럼 혹은 표현식의 값이 NULL이 아니면 값1이 반환되고,
--                      NULL이면 값2가 반환된다.
-- * 값1, 값2의 타입이 일치해야 한다.

-- DECODE(컬럼 혹은 표현식, 값1, 값 혹은 표현식, 값1, 값 혹은 표현식, 값2, 값 혹은표현식)
-- 컬럼 혹은 표현식의 값이 값1과 일치하면 값1 다음에 있는 값 혹은 표현식의 결과가 반환된다.
--                      값2과 일치하면 값2 다음에 있는 값 혹은 표현식의 결과가 반환된다
--                      값1, 값2와 전부 일치 하지 않으면 NULL이 반환된다.

-- DECODE(컬럼 혹은 표현식, 값1, 값 혹은 표현식, 값1, 값 혹은 표현식, 값2, 값 혹은표현식, 값3)
-- 컬럼 혹은 표현식의 값이 값1과 일치하면 값1 다음에 있는 값 혹은 표현식의 결과가 반환된다.
--                      값2과 일치하면 값2 다음에 있는 값 혹은 표현식의 결과가 반환된다
--                      값1, 값2와 전부 일치 하지 않으면 맨마지막에 있는(값3) 값 혹은 표현식의 결과가 반환된다.

-- CASE WHEN THEN ELSE END 표현식 (자바의 if문 같은 것이다.)
-- * END 옆에 별칭을 적을 수 있다.

-- CASE
--  WHEN 조건식1 THEN 표현식1,
--  WHEN 조건식2 THEN 표현식2,
--  ELSE 표현식3
--  END [별칭]

-- CASE 컬럼 혹은 표현식 : DECODE와 같은 내용이다. DECODE는 조건식이 아니고 '값' 기준이다.
--  WHEN 값1 THEN 표현식1
--  WHEN 값2 THEN 표현식2
--  ELSE 표현식3
-- END [별칭]
----------------------------------------------------------------------------------------------------------------------------
-- NULL값 처리
SELECT  NVL(10,1),      -- 10
        NVL(NULL,1)     -- 1
FROM DUAL;

SELECT 1000 + 1000*NVL(0.1, 0),
       1000 + 1000*NVL(NULL, 0) 
FROM DUAL;

-- 급여가 10000이상인 직원의 아이디, 이름, 급여, 연봉을 조회하기
-- 연봉 = 급여*12 + 급여*커미션비율*12 

-- COMMISION_PCT 가 NULL일 경우 해당 연산결과가 아예 NULL로 반환된다.
SELECT EMPLOYEE_ID, FIRST_NAME, SALARY, SALARY*12 + SALARY*commission_pct*12 ANNUAL_SALARY 
FROM EMPLOYEES
WHERE SALARY >= 10000
ORDER BY EMPLOYEE_ID ASC;

-- 계산하려는 항목 중 NULL 값이 존재한다면 이에 대한 처리로 NVL함수를 사용한다. 
SELECT EMPLOYEE_ID, FIRST_NAME, SALARY, SALARY*12 + SALARY*NVL(commission_pct, 0)*12 ANNUAL_SALARY 
FROM EMPLOYEES
WHERE SALARY >= 10000
ORDER BY EMPLOYEE_ID ASC;

-- 급여가 10000 이상인 직원의 아이디, 이름, 급여, 커미션을 조회하기
-- 커미션이 NULL인 경우 '없음'이라고 표시하기
-- 아래의 SQL문은 오류이다. NVL(숫자타입, 문자타입)으로 서로 타입이 다르기 때문이다.
SELECT EMPLOYEE_ID, FIRST_NAME, SALARY, NVL(COMMISION_PCT, '없음')
FROM EMPLOYEES
WHERE SALARY >= 10000;

-- 급여가 10000 이상인 직원의 아이디, 이름, 급여, 커미션을 조회하기
-- 커미션이 NULL이 아니면 '있음', NULL이면 '없음'이라고 표시하기
SELECT EMPLOYEE_ID, FIRST_NAME, SALARY, NVL2(COMMISSION_PCT, '있음', '없음')
FROM EMPLOYEES
WHERE SALARY >= 10000;

-- CASE WHEN
-- 직원들의 급여를 인상해서 조회하기
-- 직원아이디, 이름, 급여, 인상된 급여를 조회한다.
-- 급여가 10000 이상이면 3% 인상
-- 급여가 5000 이상이면 5% 인상
-- 그 외는 10% 인상

SELECT  EMPLOYEE_ID, FIRST_NAME, SALARY, 
    CASE
        WHEN SALARY >= 10000 THEN SALARY*1.03
        WHEN SALARY >= 5000 THEN SALARY*1.05
        ELSE SALARY*1.1
    END INCREASED_SALARY        -- CASE~ END 가 SELECT 구문 내의 하나의 속성값인 것
FROM EMPLOYEES
ORDER BY EMPLOYEE_ID;

-- DECODE
-- 직원 테이블에서 80번 부서에 소속된 사람은 A팀, 50번 부서에 소속된 사람은 B팀, 그 외는 C팀으로 나눠서 조회하기
-- 팀, 부서아이디, 이름을 조회한다.
SELECT DECODE(DEPARTMENT_ID, 80, 'A팀', 50, 'B팀', 'C팀') TEAM, DEPARTMENT_ID, FIRST_NAME
-- 'C팀'을 따로 적지 않았다면 80, 50번 외의 부서 직원들의 TEAM은 NULL이 반환된다.
FROM EMPLOYEES
ORDER BY TEAM ASC;