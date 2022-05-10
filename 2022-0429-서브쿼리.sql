----------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------
-- 서브쿼리
----------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------
-- 단일행 서브쿼리
----------------------------------------------------------------------------------------------------------------------------
-- 80번 부서의 평균급여를 조회하기
SELECT AVG(SALARY)      -- 평균 급여 : 8955.8
FROM EMPLOYEES
WHERE DEPARTMENT_ID = 80;

-- 80번 부서에서 근무하는 직원 중에서 부서의 평균급여보다 적은 급여를 받은 사원의 아이디, 이름, 급여를 조회하기
SELECT EMPLOYEE_ID, FIRST_NAME, SALARY
FROM EMPLOYEES E
WHERE DEPARTMENT_ID = 80
AND SALARY < 8955.8;        -- 부서의 평균급여를 알아야 조건식을 계산할 수 있다. 서브쿼리는 두번의 과정을 한번으로 줄여준다.

SELECT EMPLOYEE_ID, FIRST_NAME, SALARY
FROM EMPLOYEES E
WHERE DEPARTMENT_ID = 80
AND SALARY < (SELECT AVG(SALARY)
              FROM EMPLOYEES
              WHERE DEPARTMENT_ID = 80);
              
-- 부서명이 'IT'인 부서에 근무중인 직원의 아이디, 이름, 급여를 조회하기
SELECT EMPLOYEE_ID, FIRST_NAME, SALARY
FROM EMPLOYEES
WHERE DEPARTMENT_ID = (SELECT DEPARTMENT_ID             -- EMPLOYEES테이블에서는 ID로 부서를 조회하므로 서브쿼리에서 'IT'부서의 ID를 조회한다.
                        FROM DEPARTMENTS
                        WHERE DEPARTMENT_NAME = 'IT');
                        
-- 조인으로 풀어도 조회 결과는 같다.
SELECT E.EMPLOYEE_ID, E.FIRST_NAME, E.SALARY
FROM EMPLOYEES E, DEPARTMENTS D
WHERE E.DEPARTMENT_ID = D.DEPARTMENT_ID
AND D.DEPARTMENT_NAME = 'IT'; 

----------------------------------------------------------------------------------------------------------------------------
-- 다중행 서브쿼리
----------------------------------------------------------------------------------------------------------------------------
-- 부서 관리자가 지정되어 있고, 소재지 아이디가 1700번인 부서에서 근무중인 사원의 아이디, 이름을 조회하기
SELECT EMPLOYEE_ID, FIRST_NAME
FROM EMPLOYEES
WHERE DEPARTMENT_ID IN (SELECT DEPARTMENT_ID        -- 서브쿼리의 결과가 여러 행이기 때문에 =연산자를 사용할 수 없다. IN을 사용한다.
                      FROM DEPARTMENTS
                      WHERE MANAGER_ID IS NOT NULL
                      AND LOCATION_ID = 1700)
ORDER BY EMPLOYEE_ID;

-- 조인으로 풀어도 조회 결과는 같다.
SELECT E.EMPLOYEE_ID, E.FIRST_NAME
FROM EMPLOYEES E, DEPARTMENTS D
WHERE E.DEPARTMENT_ID = D.DEPARTMENT_ID
AND D.LOCATION_ID = 1700
ORDER BY EMPLOYEE_ID;

-- 'Seattle'에서 근무중인 직원의 아이디, 이름 조회하기
-- * 서브쿼리는 또 다른 서브쿼리를 내포하고 있다. (지나치게 여러 번 내포되는 서브쿼리는 바람직한 방식은 아니다.)
SELECT EMPLOYEE_ID, FIRST_NAME
FROM EMPLOYEES
WHERE DEPARTMENT_ID IN (SELECT DEPARTMENT_ID                        
                      FROM DEPARTMENTS
                      WHERE MANAGER_ID IS NOT NULL
                      AND LOCATION_ID IN (SELECT LOCATION_ID
                                          FROM LOCATIONS
                                          WHERE CITY = 'Seattle'))
ORDER BY EMPLOYEE_ID;

-- 조인으로 풀어도 조회 결과는 같다.
SELECT E.EMPLOYEE_ID, E.FIRST_NAME
FROM EMPLOYEES E, DEPARTMENTS D, LOCATIONS L
WHERE L.CITY = 'Seattle'
AND L.LOCATION_ID = D.LOCATION_ID
AND D.DEPARTMENT_ID = E.DEPARTMENT_ID;

-- 60번 부서의 모든 직원들의 급여보다 급여를 많이 받은 사원의 아이디, 이름, 급여를 조회하기
SELECT EMPLOYEE_ID, FIRST_NAME, SALARY
FROM EMPLOYEES
WHERE SALARY >ALL (SELECT SALARY            -- 서브쿼리의 결과가 여러 행(9000,6000,4800,4800,4200)이기 때문에 >가 아니라 다중행 연산자인 >ALL 을 쓴다. 
                    FROM EMPLOYEES          -- 서브쿼리의 모든 결과를 대입했을 때 조건식을 만족하는 경우를 조회한다. 즉 가장 큰 비교값보다 큰 값을 조회한다.
                    WHERE DEPARTMENT_ID = 60);
                    
-- 위의 SQL은 MAX()함수를 사용해도 같은 결과가 조회된다.
SELECT EMPLOYEE_ID, FIRST_NAME, SALARY
FROM EMPLOYEES
WHERE SALARY > (SELECT MAX(SALARY)          -- 서브쿼리의 결과가 단일행이다.
                FROM EMPLOYEES
                WHERE DEPARTMENT_ID = 60);

-- 60번 부서의 최저 급여보다 급여를 많이 받은 사원의 아이디, 이름, 급여를 조회하기
SELECT EMPLOYEE_ID, FIRST_NAME, SALARY
FROM EMPLOYEES
WHERE SALARY >ANY (SELECT SALARY            -- 서브쿼리의 결과가 여러 행(9000,6000,4800,4800,4200)이기 때문에 >가 아니라 다중행 연산자인 >ANY 을 쓴다. 
                    FROM EMPLOYEES          -- 서브쿼리의 결과를 대입했을 때 하나라도 조건식을 만족하는 경우를 조회한다. 즉 가장 작은 비교값보다 큰 값을 조회한다.
                    WHERE DEPARTMENT_ID = 60);

-- 위의 SQL은 MIN()함수를 사용해도 같은 결과가 조회된다. 
SELECT EMPLOYEE_ID, FIRST_NAME, SALARY
FROM EMPLOYEES
WHERE SALARY > (SELECT MIN(SALARY)          -- 서브쿼리의 결과가 단일행이다.
                FROM EMPLOYEES
                WHERE DEPARTMENT_ID = 60);

----------------------------------------------------------------------------------------------------------------------------
-- 다중열 서브쿼리
----------------------------------------------------------------------------------------------------------------------------
-- 사원번호 177번의 직원과 같은 부서, 같은 직종에 근무하고 있는 직원의 아이디, 이름을 조회하기

-- 177번 직원의 부서, 직종 조회 : 다중열의 결과가 조회된다.
SELECT DEPARTMENT_ID, JOB_ID
FROM EMPLOYEES
WHERE EMPLOYEE_ID = 177;

-- 다중열 서브쿼리로 작성
SELECT EMPLOYEE_ID, FIRST_NAME DEPARTMENT_ID, JOB_ID
FROM EMPLOYEES
WHERE (DEPARTMENT_ID, JOB_ID) IN (SELECT DEPARTMENT_ID, JOB_ID      -- WHERE (컬럼1, 컬럼2) IN (컬럼3, 컬럼4) : 컬럼1=컬럼3 AND 컬럼2=컬럼4
                                  FROM EMPLOYEES
                                  WHERE EMPLOYEE_ID = 177);

-- 위의 다중열 서브쿼리는 조건식을 각각의 서브쿼리로 만들어서 조회해도 된다.
SELECT EMPLOYEE_ID, FIRST_NAME, DEPARTMENT_ID, JOB_ID
FROM EMPLOYEES
WHERE DEPARTMENT_ID = (SELECT DEPARTMENT_ID
                       FROM EMPLOYEES
                       WHERE EMPLOYEE_ID = 177)
AND JOB_ID = (SELECT JOB_ID
              FROM EMPLOYEES
              WHERE EMPLOYEE_ID = 177);
                                  
-- 다중열 서브쿼리로만 조건식을 작성해야 하는 경우***
-- 각 부서 별 최저급여를 조사하고, 그 부서에서 해당 급여를 받는 사원의 아이디, 이름, 급여를 조회하기

-- 각 부서 별 최저급여 조회 : 다중열의 결과가 조회된다. 두 열의 값이 동시에 일치하는 직원의 경우들을 찾아야 한다.
-- 각 행에 담긴 두 열의 값(부서, 최저급여)이 모두 일치하는 EMPLOYEES의 행들을 각각 조회해야 한다.

SELECT DEPARTMENT_ID, MIN(SALARY)
FROM EMPLOYEES
WHERE DEPARTMENT_ID IS NOT NULL
GROUP BY DEPARTMENT_ID;

-- 다중열 서브쿼리로 작성
-- 두 열의 값을 모두 만족하는 한 행을 세트로 해야하므로 다중열 서브쿼리로만 작성할 수 있다.
SELECT EMPLOYEE_ID, FIRST_NAME, SALARY
FROM EMPLOYEES
WHERE (DEPARTMENT_ID, SALARY) IN (SELECT DEPARTMENT_ID, MIN(SALARY)
                                  FROM EMPLOYEES
                                  WHERE DEPARTMENT_ID IS NOT NULL
                                  GROUP BY DEPARTMENT_ID);

---- NOT IN 예시                                  
--SELECT EMPLOYEE_ID, FIRST_NAME, DEPARTMENT_ID, JOB_ID
--FROM EMPLOYEES
--WHERE (DEPARTMENT_ID, JOB_ID) NOT IN (SELECT DEPARTMENT_ID, JOB_ID   -- WHERE (컬럼1, 컬럼2) NOT IN : (컬럼3, 컬럼4) 컬럼1!=컬럼3 OR 컬럼2!=컬럼4
--                                  FROM EMPLOYEES
--                                  WHERE EMPLOYEE_ID = 177);             
                
----------------------------------------------------------------------------------------------------------------------------
-- 여러 개의 서브쿼리를 사용해서 조회하기
----------------------------------------------------------------------------------------------------------------------------

-- 80번 부서에서 근무하고, 80번 부서의 평균급여보다 급여를 많이 받은 직원이고, 80번 부서의 관리자와 같은 해에 입사한 직원을 조회하기
-- * 복수 개의 조건에 대하여 개별적으로 서브쿼리를 사용할 수 있다.
SELECT EMPLOYEE_ID, FIRST_NAME, SALARY
FROM EMPLOYEES
WHERE DEPARTMENT_ID = 80
AND SALARY > (SELECT AVG(SALARY)
              FROM EMPLOYEES
              WHERE DEPARTMENT_ID = 80)
AND TO_CHAR(HIRE_DATE, 'YYYY') = (SELECT TO_CHAR(E.HIRE_DATE, 'YYYY')
                                 FROM EMPLOYEES E, DEPARTMENTS D
                                 WHERE E.EMPLOYEE_ID = D.MANAGER_ID
                                 AND D.DEPARTMENT_ID = 80);
                                 
----------------------------------------------------------------------------------------------------------------------------
-- HAVING 절에서 서브쿼리를 사용하기
----------------------------------------------------------------------------------------------------------------------------
-- 직종별로 사원수를 조회했을 때 사원수가 10명을 넘는 직종과 사원수를 조회하기
SELECT JOB_ID, COUNT(*)
FROM EMPLOYEES
GROUP BY JOB_ID
HAVING COUNT(*) > 10
ORDER BY JOB_ID;

-- 직종 별로 사원수를 조회했을 때 사원수가 가장 많은 직종을 조회하기
SELECT JOB_ID, COUNT(*) CNT
FROM EMPLOYEES
GROUP BY JOB_ID
HAVING COUNT(*) = (SELECT MAX(COUNT(*)) -- 다중행 함수의 중첩은 SELECT절에서만 허용되므로 MAX(COUNT(*))라고 그대로 쓸 수 없다. 일반적인 용례는 아니다.
                   FROM EMPLOYEES
                   GROUP BY JOB_ID);

----------------------------------------------------------------------------------------------------------------------------
-- WITH 절에서 서브쿼리를 사용하기
-- SQL문에서 여러 번 사용되는 SQL문 혹은 실행결과를 WITH절을 사용하면 가상의 테이블을 생성하고, 그 실행결과를 임시로 저장할 수 있다.

-- WITH 가상테이블별칭
-- AS (SELECT 컬럼명1, 컬럼명2, 표현식 별칭1, 표현식 별칭2
--     FROM 테이블명
--     WHERE 조건식)
-- SELECT 컬럼명1, 컬럼명2, 별칭1, 별칭2
-- FROM 가상테이블별칭
----------------------------------------------------------------------------------------------------------------------------
-- 직종 별로 사원수를 조회했을 때 사원수가 가장 많은 직종을 조회하기
-- 위의 SQL을 WITH절을 사용해서 변경하기
WITH JOB_EMPS   -- SELECT문의 결과를 가상의 테이블로 지정. 여러 가상 테이블을 만들 수 있다.
AS (SELECT JOB_ID, COUNT(*) CNT
    FROM EMPLOYEES
    GROUP BY JOB_ID)
SELECT JOB_ID, CNT
FROM JOB_EMPS
WHERE CNT = (SELECT MAX(CNT)
            FROM JOB_EMPS);

----------------------------------------------------------------------------------------------------------------------------
-- 의사컬럼(Pseudo columns)을 이용해서 조회하기
-- 의사컬럼은 실제 테이블에 저장되어있지 않은 컬럼이다.
-- 의사컬럼은 SQL이 실행되는 동안 사용할 수 있는 컬럼이다.
-- ROWNUM: 의사컬럼 중 하나로, 조회 결과의 각 행에 순서대로 1번부터 시작되는 순번을 붙여주는 컬럼
----------------------------------------------------------------------------------------------------------------------------
-- 직종 별로 사원수를 조회했을 때 사원수가 가장 많은 직종을 조회하기
-- 의사칼럼 ROWNUM의 순번을 이용해서 조회하기. 순번이 1번인 행이 사원수가 가장 많은 직종의 행이다.
SELECT JOB_ID, CNT
FROM (SELECT JOB_ID, COUNT(*) CNT
     FROM EMPLOYEES
     GROUP BY JOB_ID
     ORDER BY CNT DESC) -- 직종 별 사원수를 내림차순으로 정렬한 가상의 테이블
WHERE ROWNUM = 1;       -- 조회결과의 순번 1인 행을 조회 (ROWNUM 컬럼이 있다는 것을 가정)
