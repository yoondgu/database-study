-- 직원들 중에서 가장 많은 급여를 받는 직원의 아이디, 이름, 급여, 급여등급을 조회하기
SELECT E.EMPLOYEE_ID, E.FIRST_NAME, E.SALARY, S.GRADE
FROM EMPLOYEES E, SALARY_GRADE S
WHERE E.SALARY >= S.MIN_SALARY AND E.SALARY <= S.MAX_SALARY
AND E.SALARY = (SELECT MAX(SALARY)      -- 그룹함수는 SELECT 서브쿼리문을 통해 값을 반환받아야 한다.
                FROM EMPLOYEES);

-- 50번 부서에서 근무중이고, 50번 부서의 최저 급여를 받는 직원의 아이디, 이름, 급여를 조회하기
SELECT EMPLOYEE_ID, FIRST_NAME, SALARY
FROM EMPLOYEES
WHERE DEPARTMENT_ID = 50
AND SALARY = (SELECT MIN(SALARY) -- 단일행 서브쿼리
             FROM EMPLOYEES
             WHERE DEPARTMENT_ID = 50);

-- 전체 직원들의 평균급여보다 급여를 적게 받는 직원들의 아이디, 이름, 급여를 조회하기
SELECT EMPLOYEE_ID, FIRST_NAME, SALARY
FROM EMPLOYEES
WHERE SALARY < (SELECT AVG(SALARY) -- 단일행 서브쿼리
                FROM EMPLOYEES);
            
-- 자신의 관리자와 같은 해에 입사한 직원들의 아이디, 이름, 입사일을 조회하기

SELECT E.EMPLOYEE_ID, E.FIRST_NAME, E.HIRE_DATE, M.HIRE_DATE
FROM EMPLOYEES E, EMPLOYEES M
WHERE E.MANAGER_ID = M.EMPLOYEE_ID -- 조인조건 적는 것 잊지 말기. 적지 않으면 카디션곱 되어버린다.
AND TO_CHAR(E.HIRE_DATE, 'YYYY') = TO_CHAR(M.HIRE_DATE, 'YYYY');
                                                  
-- 조인 없이 서브쿼리로 작성한다면 아래와 같다.
SELECT EMPLOYEE_ID, FIRST_NAME, HIRE_DATE
FROM EMPLOYEES
WHERE (MANAGER_ID, TO_CHAR(HIRE_DATE,'YYYY')) IN (SELECT MGR.EMPLOYEE_ID, TO_CHAR(MGR.HIRE_DATE,'YYYY')
                                                  FROM EMPLOYEES EMP, EMPLOYEES MGR
                                                  WHERE EMP.MANAGER_ID = MGR.EMPLOYEE_ID);


-- 자신의 관리자와 급여 등급이 같은 직원의 아이디, 이름을 조회하기***
SELECT E.EMPLOYEE_ID, E.FIRST_NAME
FROM EMPLOYEES E, EMPLOYEES M, SALARY_GRADE ES, SALARY_GRADE MS
WHERE E.MANAGER_ID = M.EMPLOYEE_ID
AND E.SALARY >= ES.MIN_SALARY AND E.SALARY <= ES.MAX_SALARY
AND M.SALARY >= MS.MIN_SALARY AND M.SALARY <= MS.MAX_SALARY
AND MS.GRADE = ES.GRADE
ORDER BY E.EMPLOYEE_ID;

-- 서브쿼리로 작성한 경우 : 굳이 쓸 필요가 없어서 별로임, 결국 계속 조인을 쓰게 된다.
SELECT E.EMPLOYEE_ID, E.FIRST_NAME
FROM EMPLOYEES E, SALARY_GRADE S
WHERE E.SALARY >= S.MIN_SALARY AND E.SALARY <= S.MAX_SALARY
AND (E.MANAGER_ID, S.GRADE) IN (SELECT M.EMPLOYEE_ID, S.GRADE                       
                               FROM EMPLOYEES E, EMPLOYEES M, SALARY_GRADE S            -- ***DEPARTMENTS의 MANAGER와 EMPLOYEES의 MANAGER는 아예 의미가 다른 속성이다. 부서의 총 관리자 / 직원의 상사
                               WHERE E.MANAGER_ID = M.EMPLOYEE_ID
                               AND M.SALARY >= S.MIN_SALARY AND M.SALARY <= S.MAX_SALARY);

-- 전체 직원의 평균급여 보다 급여를 많이 받는 직원들의 아이디, 이름, 급여, 급여와 평균 급여 간의 차이를 조회하기

WITH SAL_AVG
AS (SELECT AVG(SALARY) AVG
    FROM EMPLOYEES)   
SELECT EMPLOYEE_ID, FIRST_NAME, SALARY, TRUNC(SALARY - AVG) SAL_GAP -- SELECT절에서도 서브쿼리를 넣을 수는 있지만 행마다 실행되어 비효율적이다.
FROM EMPLOYEES, SAL_AVG
WHERE SALARY > AVG; -- 비등가 조인조건

-- WITH절을 사용하지 않을 경우 (스칼라 서브쿼리 : 비효율적)
SELECT EMPLOYEE_ID, FIRST_NAME, SALARY, TRUNC(SALARY - (SELECT AVG(SALARY) FROM EMPLOYEES)) SAL_GAP -- SELECT절에서도 서브쿼리를 넣을 수는 있지만 행마다 실행되어 비효율적이다.
FROM EMPLOYEES
WHERE SALARY > (SELECT AVG(SALARY)
                FROM EMPLOYEES);

-- 직종이 변경된 직원 중에서 예전에 근무했던 부서와 같은 부서에서 근무하고 있는 직원의 아이디, 이름, 이전 직종아이디, 현 직종아이디, 부서명을 조회하기

SELECT E.EMPLOYEE_ID, E.FIRST_NAME, H.JOB_ID PREV_JOB, E.JOB_ID CURR_JOB, D.DEPARTMENT_NAME -- H에 이력이 여러 번 있는 직원이 있을 경우 여러 행 출력된다.
FROM JOB_HISTORY H, EMPLOYEES E, DEPARTMENTS D
WHERE H.EMPLOYEE_ID = E.EMPLOYEE_ID    -- 조인조건 (H와 E에서 직원아이디가 같은 행끼리 연결)
AND H.DEPARTMENT_ID = E.DEPARTMENT_ID -- 검색조건 (이전 부서아이디와 현재 부서아이디가 동일한 행만 조회)
AND H.DEPARTMENT_ID = D.DEPARTMENT_ID; -- 조인조건 (H와 D에서 부서아이디가 같은 행끼리 연결)