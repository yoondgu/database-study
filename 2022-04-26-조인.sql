----------------------------------------------------------------------------------------------------------------------------
-- 조인
-- 2개 이상의 테이블을 연결해서 데이터를 조회하는 것
-- FROM절에 연결할 테이블들을 지정한다.
-- WHERE절에 조인조건을 정의한다.
-- * 조인조건의 최소 개수 = 연결한 테이블 수 - 1 

-- SELECT 테이블1.컬럼명, 테이블1.컬럼명, 테이블2.컬럼명, 테이블2.컬럼명
-- FROM 테이블1, 테이블2
-- WHERE 테이블1.컬럼명 = 테이블2.컬럼명;

-- SELECT 별칭1.컬럼명, 별칭1.컬럼명, 별칭2.컬럼명, 별칭2.컬럼명
-- FROM 테이블1 별칭1, 테이블2 별칭2
-- WHERE 별칭1.컬럼명 = 별칭2.컬럼명;

-- SELECT 별칭1.컬럼명, 별칭1.컬럼명, 별칭2.컬럼명, 별칭2.컬럼명, 별칭3.컬럼명
-- FROM 테이블1 별칭1, 테이블2 별칭2, 테이블3 별칭3
-- WHERE 별칭1.컬럼명 = 별칭2.컬럼명
-- AND 별칭1.컬럼명 = 별칭3.컬럼명;


-- SELECT 별칭1.컬럼명, 별칭1.컬럼명, 별칭2.컬럼명, 별칭2.컬럼명, 별칭3.컬럼명
-- FROM 테이블1 별칭1, 테이블2 별칭2, 테이블3 별칭3
-- WHERE 별칭1.컬럼명 = 별칭2.컬럼명
-- AND 별칭1.컬럼명 = 별칭3.컬럼명;

-- SELECT 별칭1.컬럼명, 별칭1.컬럼명, 별칭2.컬럼명, 별칭2.컬럼명, 별칭3.컬럼명
-- FROM 테이블1 별칭1, 테이블2 별칭2, 테이블3 별칭3
-- WHERE 별칭1.컬럼명 = 별칭2.컬럼명
-- AND 별칭2.컬럼명 = 별칭3.컬럼명;

----------------------------------------------------------------------------------------------------------------------------

-- 등가조인
-- 조인하는 테이블의 특정 컬럼값이 서로 같은 것끼리 조인해서 원하는 데이터를 조회하는 것

-- 직원아이디, 직원이름, 소속부서아이디, 소속부서명 조회하기
-- 어느 테이블의 속성인지 정리해보면
-- EMPLOYEES, EMPLOYEES, EMPLOYEES,
--                      DEPARTMENTS, DEPARTMENTS
--                      소속부서아이디가 같은 경우를 조인조건을 정의
SELECT E.EMPLOYEE_ID, E.FIRST_NAME, E.DEPARTMENT_ID, D.DEPARTMENT_NAME
FROM EMPLOYEES E, DEPARTMENTS D --조인
WHERE E.DEPARTMENT_ID = D.DEPARTMENT_ID --조인조건
ORDER BY E.EMPLOYEE_ID; 

-- 급여를 10000 이상 받는 직원의 아이디, 이름, 직종아이디, 직종제목, 최저급여, 최고급여, 급여를 조회하기
--                      EMPLOYEES  EMPLOYEES  EMPLOYEES
--                                            JOBS     JOBS   JOBS   JOBS   EMPLOYEES  
SELECT E.EMPLOYEE_ID, E.FIRST_NAME, E.JOB_ID, J.JOB_TITLE, J.MAX_SALARY, J.MIN_SALARY, E.SALARY
FROM EMPLOYEES E, JOBS J    
WHERE E.SALARY >= 10000 -- 검색조건
AND E.JOB_ID = J.JOB_ID -- 조인조건
ORDER BY E.EMPLOYEE_ID;

-- 급여를 10000 이상 받는 직원의 아이디, 이름, 급여, 소속부서명을 조회하기
-- 직원테이블의 DEPARTMENT_ID는 해당 직원이 소속된 부서의 아이디다.
-- 직원테이블의 DEPARTMENT_ID와 부서테이블의 DEPARTMENT_ID가 같은 값을 가지고 있는 행끼리 연결하면(조인하면)
-- 해당 직원의 정보와 그 직원이 소속된 부서정보가 연결된다.
-- 조인된 행에는 직원정보, 부서정보가 같이 있으므로, 행에서 필요한 컬럼을 조회한다.
SELECT E.EMPLOYEE_ID, E.FIRST_NAME, E.SALARY, D.DEPARTMENT_NAME
FROM EMPLOYEES E, DEPARTMENTS D
WHERE E.SALARY >= 10000 -- 검색조건
AND E.DEPARTMENT_ID = D.DEPARTMENT_ID
ORDER BY E.EMPLOYEE_ID; -- 조인조건

-- 부서 관리자의 아이디가 NULL이 아닌 부서의 부서아이디, 부서명, 관리자아이디, 관리자 이름을 조회하기
-- 부서테이블의 MANAGER_ID는 해당 부서의 관리자의 아이디다.
-- 부서테이블의 MANAGER_ID와 직원테이블의 EMPLOYEE_ID가 같은 값을 가지고 있는 행끼리 연결하면(조인하면)
-- 해당 부서의 정보와 부서의 관리자인 직원의 정보가 연결된다.
-- 조인된 행에는 직원정보, 부서정보가 같이 있으므로, 행에서 필요한 컬럼을 조회한다.
SELECT DEPT.DEPARTMENT_ID, DEPT.DEPARTMENT_NAME, DEPT.MANAGER_ID, EMP.FIRST_NAME
FROM DEPARTMENTS DEPT, EMPLOYEES EMP
WHERE DEPT.MANAGER_ID IS NOT NULL -- 검색조건
AND DEPT.MANAGER_ID = EMP.EMPLOYEE_ID -- 조인조건
ORDER BY DEPT.DEPARTMENT_ID;

-- 부서 아이디, 부서명, 부서 소재지 도시명, 부서 소재지 주소 조회하기
-- DEPARTMENT  DEPARTMENTS   LOCATIONS  LOCATIONS
-- 부서테이블에는 부서들의 소재지 정보가 저장되어 있다.
-- 부서테이블과 소재지테이블에서 LOCATION_ID가 같은 값을 가지고 있는 행끼리 연결하면
-- 부서정보와 그 부서가 위치한 지역의 소재지 정보가 하나의 행으로 연결된다.
-- 연결된 행에서 필요한 정보를 조회한다.
SELECT DEPT.DEPARTMENT_ID, DEPT.DEPARTMENT_NAME, LOC.CITY, LOC.STREET_ADDRESS
FROM DEPARTMENTS DEPT, LOCATIONS LOC -- 조인조건
WHERE DEPT.LOCATION_ID = LOC.LOCATION_ID;