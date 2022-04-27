----------------------------------------------------------------------------------------------------------------------------
-- 퀴즈
----------------------------------------------------------------------------------------------------------------------------
-- 시스템의 현재 날짜와 시간정보를 dual 테이블을 이용해서 조회하기
SELECT SYSDATE
FROM DUAL;

-- 시스템의 현재 날짜와 시간정보 중에서 년-월-일 정보만 dual 테이블을 이용해서 조회하기
SELECT TO_CHAR(SYSDATE,'YYYY-MM-DD')
FROM DUAL;

-- 직원들의 급여를 13% 인상했을 때 직원 아이디, 이름, 급여, 13% 인상된 급여, 인상된 급여와 기존 급여의 차이를 조회하기
-- * 계산결과에서 소수점 이하는 버린다.
SELECT EMPLOYEE_ID, FIRST_NAME, SALARY, TRUNC(SALARY*1.13) INCREASED_SAL, TRUNC(SALARY*0.13) DIFFERENCE
FROM EMPLOYEES
ORDER BY EMPLOYEE_ID;

-- 2007년에 입사한 직원들의 직원 아이디, 이름, 입사일 조회
SELECT EMPLOYEE_ID, FIRST_NAME, HIRE_DATE
FROM EMPLOYEES
WHERE TO_CHAR(HIRE_DATE,'YYYY') = 2007 
ORDER BY EMPLOYEE_ID;
--또는
SELECT EMPLOYEE_ID, FIRST_NAME, HIRE_DATE
FROM EMPLOYEES
WHERE HIRE_DATE >= '2007-01-01' AND HIRE_DATE < '2008-01-01';

-- 2005년에 입사한 직원들 중 커미션을 받는 직원들의 직원 아이디, 이름, 입사일, 급여, 연봉을 조회하기
-- * 연봉 = 급여*12 + 급여*커미션*12 
-- * 연봉 계산결과는 일의 자리로 반올림한다.
SELECT EMPLOYEE_ID, FIRST_NAME,HIRE_DATE, SALARY, ROUND(SALARY*12 + SALARY*COMMISSION_PCT*12,0) ANNUAL_SALARY
FROM EMPLOYEES
WHERE HIRE_DATE >= '2005-01-01' AND HIRE_DATE < '2006-01-01'
AND COMMISSION_PCT IS NOT NULL
ORDER BY EMPLOYEE_ID;


-- case ~ when 을 이용해서 급여를 기준으로 직원들의 등급을 조회하기
-- 급여가 20000 이상: A, 15000 이상 : B, 10000 이상 : C, 그 외는 D등급이다.
-- 직원 아이디, 이름, 급여, 급여등급을 조회한다.
SELECT EMPLOYEE_ID, FIRST_NAME,
        CASE
        WHEN SALARY >= 20000 THEN 'A'
        WHEN SALARY >= 15000 THEN 'B'
        WHEN SALARY >= 10000 THEN 'C'
        ELSE 'D'
        END SALARY_GRADE
FROM EMPLOYEES
ORDER BY EMPLOYEE_ID;

-- 80번 부서에 근무하는 직원들의 직원아이디, 이름, 입사일, 입사일 기준 근무개월수를 조회한다.
-- 근무개월수는 입사일로부터 오늘까지의 개월수다. 소숫점이하는 버린다.
-- 근무개월수를 기준으로 내림차순 정렬한다.
SELECT EMPLOYEE_ID, FIRST_NAME, HIRE_DATE, TRUNC(MONTHS_BETWEEN(SYSDATE, HIRE_DATE)) MONTHS
FROM EMPLOYEES
WHERE DEPARTMENT_ID = 80
ORDER BY MONTHS DESC;

-- 100번 직원이 자신의 매니저로 지정된 직원들 중에서 커미션을 받는 직원들의 직원아이디, 이름, 급여, 커미션을 조회하기
SELECT EMPLOYEE_ID, FIRST_NAME, SALARY, COMMISSION_PCT
FROM EMPLOYEES
WHERE MANAGER_ID = 100
AND COMMISSION_PCT IS NOT NULL;

-- 100번 직원이 자신의 매니저로 지정된 직원의 수를 조회하기
SELECT COUNT(*)
FROM EMPLOYEES
WHERE MANAGER_ID = 100;

-- 50번 부서에 근무하는 직원들의 아이디, 이름, 직종아이디, 직종최저급여, 직종최고급여, 직종중간급여, 해당 직원의 급여와 중간급여의 갭을 조회하기
-- 직종중간급여는 (직종최고급여+직종최저급여)/2 다.
-- 급여갭의 자신의 급여에서 직종중간급여를 뺀 값이다.
SELECT E.EMPLOYEE_ID, E.FIRST_NAME, E.JOB_ID, J.MIN_SALARY, J.MAX_SALARY, E.SALARY,
        (J.MIN_SALARY+J.MAX_SALARY)/2 MED_SALARY,
        (J.MIN_SALARY+J.MAX_SALARY)/2 - E.SALARY DIFFERENCE
FROM EMPLOYEES E, JOBS J
WHERE E.DEPARTMENT_ID = 50
AND E.JOB_ID = J.JOB_ID
ORDER BY J.MAX_SALARY;