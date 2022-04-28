----------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------
-- 포괄조인 (Outer 조인)
-- 테이블을 조인했을 때 연결되는 행이 없는 정보도 조인에 참여할 수 있게 하는 조인
-- 행이 부족한 쪽에 (+)를 붙인다.
-- (+)기호는 연결되는 상대 행이 없는 행도 조인에 참여할 수 있도록 상대 테이블에 NULL행을 추가한다.
----------------------------------------------------------------------------------------------------------------------------
-- 부서아이디, 부서명, 부서관리자 아이디, 부서관리자 이름을 조회하기
-- 등가조인(D.MANAGER_ID = E.EMPLOYEE_ID)에서 MANAGER_ID가 NULL인 행들도 조인하기 위하여,
-- NULL이라서 어디에도 연결할 수 없던 상대 테이블의 속성값들(EMPLOYEE_ID)을 NULL로 한 행을 가상의 조회결과에 추가해서 합치는 것이다.
SELECT D.DEPARTMENT_ID, D.DEPARTMENT_NAME, D.MANAGER_ID, E.FIRST_NAME MANAGER_NAME
FROM DEPARTMENTS D, EMPLOYEES E
WHERE D.MANAGER_ID = E.EMPLOYEE_ID(+)
ORDER BY D.DEPARTMENT_ID;

-- 직종아이디가 'SA_REP'이고 급여를 5000 이상 7000 이하로 받는 직원의 아이디, 이름, 급여, 소속부서명을 조회하기
SELECT E.EMPLOYEE_ID, E.FIRST_NAME, E.SALARY, D.DEPARTMENT_ID, D.DEPARTMENT_NAME
FROM EMPLOYEES E, DEPARTMENTS D
WHERE E.JOB_ID = 'SA_REP'
AND E.SALARY >= 5000 AND E.SALARY <= 7000
AND E.DEPARTMENT_ID = D.DEPARTMENT_ID (+) -- D.DEPARTMENT_ID 쪽에 조인할 행이 없을 때 (+)를 붙인다.
                                          -- E에서 D.DEPARTMENT_ID를 외래키로 갖는데, 값 대신 NULL인 경우도 포괄하려고 D에서 (+)를 붙인다.
ORDER BY E.EMPLOYEE_ID;

-- 직종아이디가 'SA_REP'이고 급여를 5000 이상 7000 이하로 받는 직원의 아이디, 이름, 급여, 소속부서명,부서 소재지 주소를 조회하기
SELECT E.EMPLOYEE_ID, E.FIRST_NAME, E.SALARY, D.DEPARTMENT_NAME, L.STREET_ADDRESS
FROM EMPLOYEES E, DEPARTMENTS D, LOCATIONS L
WHERE E.JOB_ID = 'SA_REP'
AND E.SALARY >= 5000 AND E.SALARY <= 7000
AND E.DEPARTMENT_ID = D.DEPARTMENT_ID (+)
AND D.LOCATION_ID = L.LOCATION_ID (+)
ORDER BY E.EMPLOYEE_ID;