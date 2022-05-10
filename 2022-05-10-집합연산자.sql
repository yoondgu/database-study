--------------------------------------------------------------------------------------------------------------
-- 집합연산자
--------------------------------------------------------------------------------------------------------------
-- 합집합
-- 급여를 3000 이하로 받는 사원을 조회하기
-- 급여를 15000 이상으로 받는 사원을 조회하기
SELECT EMPLOYEE_ID, FIRST_NAME, SALARY
FROM EMPLOYEES
WHERE SALARY <= 3000
UNION
SELECT EMPLOYEE_ID, FIRST_NAME, SALARY
FROM EMPLOYEES
WHERE SALARY >=15000;

-- 급여등급이 'c'에 해당하는 사원의 아이디, 이름, 급여를 조회하기
-- 근무지가 'Seattle'인 직원의 아이디, 이름, 급여를 조회하기
SELECT E.EMPLOYEE_ID, E.FIRST_NAME, E.SALARY
FROM EMPLOYEES E, SALARY_GRADE S
WHERE E.SALARY >= S.MIN_SALARY AND E.SALARY <= S.MAX_SALARY
AND S.GRADE = 'C'
UNION ALL
SELECT E.EMPLOYEE_ID, E.FIRST_NAME, E.SALARY
FROM EMPLOYEES E, DEPARTMENTS D, LOCATIONS L
WHERE E.DEPARTMENT_ID = D.DEPARTMENT_ID
AND D.LOCATION_ID = L.LOCATION_ID
AND L.CITY = 'Seattle';

-- 교집합
-- 직종이 변경된적이 있는 사원의 아이디를 조회하기
SELECT EMPLOYEE_ID
FROM JOB_HISTORY
INTERSECT
SELECT EMPLOYEE_ID
FROM EMPLOYEES;

-- 이름도 같이 조회하기
SELECT Y.EMPLOYEE_ID, Y.FIRST_NAME
FROM (SELECT EMPLOYEE_ID
    FROM JOB_HISTORY
    INTERSECT
    SELECT EMPLOYEE_ID
    FROM EMPLOYEES) X, EMPLOYEES Y
WHERE X.EMPLOYEE_ID = Y.EMPLOYEE_ID;

-- 차집합
-- 직종이 변경된 적이 없는 사원을 조회하기
SELECT EMPLOYEE_ID
FROM EMPLOYEES
MINUS
SELECT EMPLOYEE_ID
FROM JOB_HISTORY;

--------------------------------------------------------------------------------------------------------------
-- 상호연관 서브쿼리
--------------------------------------------------------------------------------------------------------------
-- 자신이 소속된 부서의 평균급여보다 급여를 적게 받은 직원의 아이디, 이름, 급여를 조회하기 - INLINE VIEW와 JOIN으로 조회
SELECT Y.EMPLOYEE_ID, Y.FIRST_NAME, Y.SALARY
FROM (SELECT DEPARTMENT_ID, AVG(SALARY) AVG_SALARY
     FROM EMPLOYEES
     WHERE DEPARTMENT_ID IS NOT NULL
     GROUP BY DEPARTMENT_ID) X, EMPLOYEES Y
WHERE X.DEPARTMENT_ID = Y.DEPARTMENT_ID
AND X.AVG_SALARY > Y.SALARY;

-- 자신이 소속된 부서의 평균급여보다 급여를 적게 받은 직원의 아이디, 이름, 급여를 조회하기 - WITH와 JOIN으로 조회
WITH DEPT_AVG_SALARY
AS (SELECT DEPARTMENT_ID, AVG(SALARY) AVG_SALARY
     FROM EMPLOYEES
     WHERE DEPARTMENT_ID IS NOT NULL
     GROUP BY DEPARTMENT_ID)
SELECT Y.EMPLOYEE_ID, Y.FIRST_NAME, Y.SALARY
FROM DEPT_AVG_SALARY X, EMPLOYEES Y
WHERE X.DEPARTMENT_ID = Y.DEPARTMENT_ID
AND X.AVG_SALARY > Y.SALARY;

-- 자신이 소속된 부서의 평균급여보다 급여를 적게 받은 직원의 아이디, 이름, 급여를 조회하기 - 상호연관 서브쿼리로 조회
SELECT MAIN.EMPLOYEE_ID, MAIN.FIRST_NAME, MAIN.SALARY
FROM EMPLOYEES MAIN
WHERE MAIN.SALARY < (SELECT AVG(SUB.SALARY)
                    FROM EMPLOYEES SUB
                    WHERE SUB.DEPARTMENT_ID = MAIN.DEPARTMENT_ID); -- 서브쿼리가 메인쿼리의 조회개수만큼 실행된다.

-- 자신의 상사보다 먼저 입사한 사원의 아이디, 이름을 조회하기
SELECT MAIN.EMPLOYEE_ID, MAIN.FIRST_NAME
FROM EMPLOYEES MAIN
WHERE MAIN.HIRE_DATE < (SELECT SUB.HIRE_DATE
                    FROM EMPLOYEES SUB
                    WHERE SUB.EMPLOYEE_ID = MAIN.MANAGER_ID);
                    
-- 부서아이디, 부서명, 부서관리자명을 조회하기 - JOIN
SELECT D.DEPARTMENT_ID, D.DEPARTMENT_NAME, M.FIRST_NAME
FROM DEPARTMENTS D, EMPLOYEES M
WHERE D.MANAGER_ID = M.EMPLOYEE_ID(+)
ORDER BY D.DEPARTMENT_ID;

-- 부서아이디, 부서명, 부서관리자명을 조회하기 - 상호연관 서브쿼리
-- SELECT 절에 사용되는 서브쿼리는 스칼라 서브쿼리라고 한다. 무조건 단일행,단일열이어야 한다
SELECT MAIN.DEPARTMENT_ID, MAIN.DEPARTMENT_NAME,
        (SELECT SUB.FIRST_NAME
        FROM EMPLOYEES SUB
        WHERE SUB.EMPLOYEE_ID = MAIN.MANAGER_ID) MANAGER_NAME 
FROM DEPARTMENTS MAIN
ORDER BY MAIN.DEPARTMENT_ID;
        
-- 조인으로 해결되는 문제는 항상 먼저 조인으로 해결하도록 할 것
        
--------------------------------------------------------------------------------------------------------------
-- 트랜잭션
--------------------------------------------------------------------------------------------------------------
