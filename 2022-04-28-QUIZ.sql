-- 커미션을 받는 모든 직원의 아이디, 이름, 직종아이디, 소속부서명을 조회하기
SELECT E.EMPLOYEE_ID, E.FIRST_NAME, E.JOB_ID, D.DEPARTMENT_NAME
FROM EMPLOYEES E, DEPARTMENTS D
WHERE E.COMMISSION_PCT IS NOT NULL
AND E.DEPARTMENT_ID = D.DEPARTMENT_ID (+);

-- 30, 60, 90번 부서에 소속된 직원들 중에서 100관리자에게 보고하는 직원의 아이디, 이름, 소속부서명을 조회하기
SELECT E.EMPLOYEE_ID, E.FIRST_NAME, D.DEPARTMENT_NAME
FROM EMPLOYEES E, DEPARTMENTS D
WHERE E.DEPARTMENT_ID IN (30, 60, 90)
AND E.MANAGER_ID = 100
AND E.DEPARTMENT_ID = D.DEPARTMENT_ID;

-- 2006년에 입사한 직원들의 월별 입사자 수를 조회하기
SELECT TO_CHAR(HIRE_DATE, 'MM') MONTH, COUNT(*) HIRED_CNT
FROM EMPLOYEES
WHERE TO_CHAR(HIRE_DATE, 'YYYY') = '2006'
GROUP BY TO_CHAR(HIRE_DATE,'MM');

-- 모든 직원들의 아이디, 이름, 입사일, 입사일 기준 근무 개월수, 개월수별 보너스를 조회하기
-- 근무개월수 기준 3개월마다 보너스를 1000달러씩 지급한다.
SELECT EMPLOYEE_ID, FIRST_NAME, HIRE_DATE,
        TRUNC(MONTHS_BETWEEN(SYSDATE, HIRE_DATE)) MONTHS,
        TRUNC(TRUNC(MONTHS_BETWEEN(SYSDATE, HIRE_DATE))/3)*1000 BONUS
FROM EMPLOYEES;

-- 50번 부서에 근무중인 직원들의 아이디, 이름, 급여, 급여 등급과 보너스를 조회하기
-- 보너스는 A등급: 급여의 10%, B등급: 급여의 15%, C등급: 급여의 20%, D등급: 급여의 30%, E등급: 급여의 50%를 지급한다.
SELECT E.EMPLOYEE_ID, E.FIRST_NAME, E.SALARY, S.GRADE,
        E.SALARY*DECODE(S.GRADE, 'A', 0.1, 'B', 0.15, 'C', 0.2, 'D', 0.3, 'E', 0.5) BONUS
FROM EMPLOYEES E, SALARY_GRADE S
WHERE E.DEPARTMENT_ID = 50
AND E.SALARY >= S.MIN_SALARY AND E.SALARY <= S.MAX_SALARY;

-- 'Europe' 에 소재지를 두고 있는 부서의 아이디, 부서명, 소재지 도시를 조회하기
SELECT D.DEPARTMENT_ID, D.DEPARTMENT_NAME, L.CITY
FROM DEPARTMENTS D, LOCATIONS L, COUNTRIES C, REGIONS R
WHERE R.REGION_NAME = 'Europe'
AND R.REGION_ID = C.REGION_ID
AND C.COUNTRY_ID = L.COUNTRY_ID
AND L.LOCATION_ID = D.LOCATION_ID;

-- 관리자별 사원수를 집계했을 때, 관리하는 사원수가 5명 이상인 관리자의 아이디, 이름, 사원수를 조회하기
SELECT EMP.MANAGER_ID, MNG.FIRST_NAME, COUNT(*) EMP_CNT
FROM EMPLOYEES EMP, EMPLOYEES MNG
WHERE EMP.MANAGER_ID IS NOT NULL
AND EMP.MANAGER_ID = MNG.EMPLOYEE_ID
GROUP BY EMP.MANAGER_ID, MNG.FIRST_NAME
HAVING COUNT(*) >= 5;

-- 'ST_CLERK'근무하다가 다른 직종으로 변경한 직원의 아이디, 이름, 변경전 근무했던 부서명, 현재 직종아이디, 현재 근무중인 부서명을 조회하기
-- JOB_HISTORY 이용하세요
SELECT E.EMPLOYEE_ID, E.FIRST_NAME, PV_D.DEPARTMENT_NAME PREVIOUS_DEPT, E.JOB_ID, CU_D.DEPARTMENT_NAME CURRENT_DEPT
FROM EMPLOYEES E, JOB_HISTORY JH, DEPARTMENTS CU_D, DEPARTMENTS PV_D
WHERE JH.JOB_ID = 'ST_CLERK'
AND E.EMPLOYEE_ID = JH.EMPLOYEE_ID
AND E.DEPARTMENT_ID = CU_D.DEPARTMENT_ID
AND JH.DEPARTMENT_ID = PV_D.DEPARTMENT_ID;

-- 부서별 평균급여를 조회했을 때 평균급여가 10000이상인 부서의 아이디, 부서명, 부서의 평균급여를 조회하기
SELECT E.DEPARTMENT_ID, D.DEPARTMENT_NAME, TRUNC(AVG(E.SALARY)) DEPT_SAL_AVG
FROM EMPLOYEES E, DEPARTMENTS D
WHERE E.DEPARTMENT_ID = D.DEPARTMENT_ID
GROUP BY E.DEPARTMENT_ID, D.DEPARTMENT_NAME
HAVING TRUNC(AVG(E.SALARY)) >= 10000;


-- 직원들이 현재 근무중인 부서의 소재도시별 사원수를 조회하기
SELECT L.CITY, COUNT(*)
FROM EMPLOYEES E, DEPARTMENTS D, LOCATIONS L
WHERE E.DEPARTMENT_ID = D.DEPARTMENT_ID
AND D.LOCATION_ID = L.LOCATION_ID
GROUP BY L.CITY;