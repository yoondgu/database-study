-- SELECT 구문
-- 테이블의 데이터를 조회할 때 사용하는 명령어다.

-- 테이블의 모든 행을 조회하기
-- SELECT *                         -- 모든 컬럼을 조회
-- FROM 테이블명;

-- SELECT 컬럼명, 컬럼명, 컬럼명       -- 지정한 컬럼의 값만 조회
-- FROM 테이블명;

-- 직종(JOBS) 테이블의 모든 행과 모든 컬럼 조회하기
SELECT *
FROM JOBS;

-- 부서테이블(DEPARTMENTS)의 모든 행과 컬럼 모든 조회하기
SELECT *
FROM DEPARTMENTS;

-- 소재지테이블(LOCATIONS)의 모든 행과 모든 컬럼 조회하기
SELECT *
FROM LOCATIONS;

-- 사원테이블(EMPLOYEES)에서 모든 행의 사원아이디, 사원이름(FIRST_NAME), 직종아이디, 급여를 조회하기
SELECT EMPLOYEE_ID, FIRST_NAME, JOB_ID, SALARY      -- 각 컬럼명은 ","로 구분하고, 맨 마지막 컬럼 뒤에는 ","를 생략한다.
FROM EMPLOYEES;

-- 직종테이블(JOBS)에서 모든 행의 직종아이디, 직종최저급여, 직종최고급여를 조회하기
SELECT JOB_ID, MIN_SALARY, MAX_SALARY 
FROM JOBS;

-- 소재지테이블(LOCATIONS)에서 모든 행의 소재지아이디, 주소, 도시명을 조회하기
SELECT LOCATION_ID, STREET_ADDRESS, CITY
FROM LOCATIONS;

-- 부서테이블(DEPARTMENTS)에서 모든 행의 부서아이디, 부서이름을 조회하기
SELECT DEPARTMENT_ID, DEPARTMENT_NAME       -- SELECT절
FROM DEPARTMENTS;                           -- FROM절

---------------------------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- SELECT 절에서 사칙연산 수행하기
-- * 사칙연산세 사용되는 컬럼은 데이터타입이 NUMBER타입이어야 한다. (예외사항 제외)
-- * 사칙연산은 조회된 모든 행에 대해서 수행된다.

-- SELECT 컬럼+컬럼, 컬럼-컬럼, 컬럼*컬럼, 컬럼/컬럼
-- FROM 테이블명;

-- SELECT 컬럼+숫자, 컬럼-숫자, 컬럼*숫자, 컬럼/숫자
-- FROM 테이블명;
---------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- SELECT절의 컬럼명에 별칭 붙이기
-- * 별칭은 컬럼명을 의미있는 이름으로 표현할 때, 복잡한 연산식에 이름을 붙여 표현할 때 사용한다.
-- * 테이블의 이름은 그대로 있고, 조회된 컬럼명만 별칭으로 보여주는 것이다.
-- * AS는 생략 가능하다.

-- SELECT 컬럼명 AS 별칭, 컬럼명 AS 별칭
-- FROM 테이블명;

-- SELECT 컬럼명 별칭, 컬럼명 별칭, 컬럼명
-- FROM 테이블명;
---------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- 직종 테이블에서 모든 행의 직종아이디, 직종최고급여, 직종최저급여, 최고급여와 최저급여의 차이를 조회하기
-- 최고급여와 최저급여의 차이는 별칭을 SALARY_GAP으로 한다.
SELECT JOB_ID, MAX_SALARY, MIN_SALARY, MAX_SALARY - MIN_SALARY AS SALARY_GAP
FROM JOBS;

SELECT JOB_ID, MAX_SALARY, MIN_SALARY, MAX_SALARY - MIN_SALARY SALARY_GAP
FROM JOBS;

-- 사원테이블에서 모든 행의 사원아이디, 이름, 급여, 연봉을 조회하기
-- 연봉은 급여*12 한 값이다. 연봉의 별칭은 ANNUAL_SALARY로 한다.
SELECT EMPLOYEE_ID, FIRST_NAME, SALARY, SALARY*12 AS ANNUAL_SALARY
FROM EMPLOYEES;

-- 사원테이블에서 모든 행의 사원아이디, 이름, 급여, 10%인상된 급여를 조회하기
-- 인상된 급여의 별칭은 INCREASED_SALARY로 한다.
SELECT EMPLOYEE_ID, FIRST_NAME, SALARY, SALARY*1.1 INCREASED_SALARY
FROM EMPLOYEES;

---------------------------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- WHERE절을 이용해서 조회되는 행을 제한하기
-- * WHERE절의 조건식이 TRUE로 판정되는 행만 조회된다.
-- * 조건식의 연산자는 > >= < <= = != IN LIKE 자바와 달리 EQUAL의 의미로 "="을 쓴다.
-- * AND, OR을 사용하면 2개 이상의 조건식을 판정조건으로 사용할 수 있다.
-- 사용예) 평균점수가 90점 이상인 학생정보 조회, 급여를 10000 이상 받는 직원정보 조회, 2022년 1월과 2월달에 입사한 사원정보 조회..

-- SELECT *
-- FROM 테이블명 
-- WHERE 조건식;

-- SELECT *
-- FROM 테이블명
-- WHERE 조건식 AND 조건식;
---------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- 직원테이블에서 급여를 15000 이상 받는 직원의 아이디, 이름, 직종, 급여를 조회하기
SELECT EMPLOYEE_ID, FIRST_NAME, JOB_ID, SALARY
FROM EMPLOYEES
WHERE SALARY >= 15000;

-- 직원테이블에서 직종아이디가 'IT_PROG'인 직원의 아이디, 이름, 입사일을 조회하기
SELECT EMPLOYEE_ID, FIRST_NAME, HIRE_DATE 
FROM EMPLOYEES
WHERE JOB_ID = 'IT_PROG';
-- 잘못된 조건식
-- WHERE JOB_ID = IT_PROG;      JOB_ID컬럼의 값과 IT_PROG 컬럼의 값이 같은 행을 조회하는 조건식이다.
-- WHERE JOB_ID = "IT_PROG";    문자데이터는 'IT_PROG'로 적어야 한다. 이 조건식은 SQL 문법 오류이다.
-- WHERE JOB_ID = 'it_prog';    JOB_ID 컬럼의 값이 'it_prog'인 행을 조회하는 조건식이다.
--                              EMPLOYEES 테이블에는 JOB_ID컬럼의 값이 'it_prog'인 행이 존재하지 않는다.
--                              문법오류는 아니지만 조회결과가 존재하지 않는다.
-- WHERE JOB_ID == 'IT_PROG';   오라클에서 equal 비교 연산자는 = 이다. 문법 오류이다.

-- 직원테이블에서 급여를 10000 이상 받고, 소속부서 아이디가 80인 직원의 직원아이디, 이름, 급여를 조회하기
SELECT EMPLOYEE_ID, FIRST_NAME, SALARY
FROM EMPLOYEES
WHERE SALARY > 10000 AND DEPARTMENT_ID = 80;

-- 직원테이블에서 60번 부서에서 근무하는 직원과 90번 부서에서 근무하는 직원의 아이디, 이름, 직종아이디를 조회하기
SELECT EMPLOYEE_ID, FIRST_NAME, JOB_ID
FROM EMPLOYEES
WHERE DEPARTMENT_ID = 60 OR DEPARTMENT_ID = 90;

SELECT EMPLOYEE_ID, FIRST_NAME, JOB_ID
FROM EMPLOYEES
WHERE DEPARTMENT_ID IN (60, 90);        -- OR로 연결된 =연산은 IN() 으로 적을 수 있다.

-- 직원 테이블에서 급여를 10000 이상 15000 이하로 받는 직원의 아이디, 이름, 급여를 조회하기
SELECT EMPLOYEE_ID, FIRST_NAME, SALARY
FROM EMPLOYEES
WHERE SALARY >= 10000 AND SALARY <= 15000; -- SALARY BETWEEN 10000 AND 15000 도 가능

-- 직원 테이블에서 80번 부서에서 근무하는 직원과 50번 부서에서 근무하는 직원 중 급여를 7000 이하로 받는 직원 조회하기
-- 직원아이디, 이름, 부서아이디, 급여를 조회한다.
SELECT EMPLOYEE_ID, FIRST_NAME, DEPARTMENT_ID, SALARY
FROM EMPLOYEES
WHERE (DEPARTMENT_ID = 80 OR DEPARTMENT_ID = 50) AND SALARY < 7000 ;    -- OR연산과 AND연산이 같이 사용될 때 반드시 OR 연산을 괄호로 묶어주어야 한다. AND가 OR보다 연산 우선순위가 높다.

SELECT EMPLOYEE_ID, FIRST_NAME, DEPARTMENT_ID, SALARY
FROM EMPLOYEES
WHERE DEPARTMENT_ID IN (80, 50) AND SALARY < 7000 ;     -- 그러나 OR연산을 사용하는 경우의 대부분은 IN으로 대체한다.
