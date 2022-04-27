----------------------------------------------------------------------------------------------------------------------------
-- 등가 조인
-- 속성의 값이 같은 행끼리 연결한다.
----------------------------------------------------------------------------------------------------------------------------

-- 200번 직원이 부서 관리자로 지정된 부서에 소속된 사원들의 아이디, 이름, 직종을 조회하기
-- 같은 행에 조회할 속성들이 아니더라도, 서로 다른 테이블의 정보를 통해 정보를 조회할 경우에도 조인을 사용한다.
-- 200번 직원이 부서 관리자로 지정된 부서는 10번 부서다. 즉 10번 부서에 소속된 사원들의 정보를 조회하라는 뜻이다.
-- DEPARTMENTS의 DEPARTMENT_ID가 10번인 행과 EMPLOYEES 테이블에서 DEPARTMENT_ID가 10번으로 지정된 행을 연결해서 하나의 행으로 만들어야 한다.

SELECT E.EMPLOYEE_ID, E.FIRST_NAME, E.JOB_ID
FROM DEPARTMENTS D, EMPLOYEES E
WHERE D.MANAGER_ID = 200
AND D.DEPARTMENT_ID = E.DEPARTMENT_ID;

-- 100번 직원이 부서관리자로 지정된 부서의 아이디, 부서이름, 관리자의 이름을 조회하기
--             DEPARTMENTS(MANAGER_ID)  DEPARTMENTS DEPARTMENTS EMPLOYEES
-- 100번 직원이 부서관리자로 지정된 부서는 90번 부서
SELECT D.DEPARTMENT_ID, D.DEPARTMENT_NAME, E.FIRST_NAME
FROM DEPARTMENTS D, EMPLOYEES E
WHERE D.MANAGER_ID = 100
AND D.MANAGER_ID = E.EMPLOYEE_ID;

-- 부서테이블에서 부서관리자가 지정된 부서의 부서아이디, 부서이름, 관리자 이름을 조회하기
SELECT D.DEPARTMENT_ID, D.DEPARTMENT_NAME, E.FIRST_NAME
FROM DEPARTMENTS D, EMPLOYEES E
WHERE D.MANAGER_ID IS NOT NULL
AND D.MANAGER_ID = E.EMPLOYEE_ID
-- EMPLOYEE_ID는 PK이므로 NULL일 수가 없으므로 IS NOT NULL 조건을 작성하지 않아도 조회결과는 같다.
-- 그러나 아예 NULL인 값은 조인에 참여하지 않도록 해주는 것이 좋다.
ORDER BY D.DEPARTMENT_ID;

-- 급여를 10000 이상 받는 직원의 아이디, 이름, 직종제목, 급여, 소속부서명을 조회하기
SELECT E.EMPLOYEE_ID, E.FIRST_NAME, J.JOB_TITLE, E.SALARY, D.DEPARTMENT_NAME
FROM EMPLOYEES E, JOBS J, DEPARTMENTS D
WHERE E.SALARY >= 10000
AND E.JOB_ID = J.JOB_ID
AND E.DEPARTMENT_ID = D.DEPARTMENT_ID
ORDER BY E.EMPLOYEE_ID;

-----------복습하기-----------

-- 급여를 10000 이상 받는 직원의 아이디, 이름, 직종제목, 근무지 도시명을 조회하기
--                              E     E     J       L
SELECT E.EMPLOYEE_ID, E.FIRST_NAME, J.JOB_TITLE, L.CITY
FROM EMPLOYEES E, JOBS J, DEPARTMENTS D, LOCATIONS L
WHERE E.SALARY >= 10000
AND E.JOB_ID = J.JOB_ID
AND E.DEPARTMENT_ID = D.DEPARTMENT_ID
AND D.LOCATION_ID = L.LOCATION_ID
ORDER BY E.EMPLOYEE_ID ASC;

