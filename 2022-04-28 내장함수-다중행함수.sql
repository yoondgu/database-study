----------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------
-- 다중행 함수
-- 행그룹(테이블의 모든 행 혹은  조회된 모든 행, 특정 컬럼의 값이 같은 것끼리 그룹핑된 것)

-- MIN(컬럼 혹은 표현식) : 행그룹에서 지정된 컬럼의 최소값을 반환한다. (NULL은 무시)

-- MAX(컬럼 혹은 표현식) : 행그룹에서 지정된 컬럼의 최대값을 반환한다. (NULL은 무시)

-- SUM(컬럼 혹은 표현식) : 행그룹에서 지정된 컬럼의 합계를 반환한다. (NULL은 무시)

-- AVG(컬럼 혹은 표현식) : 행그룹에서 지정된 컬럼의 평균값을 반환한다. (NULL은 무시)

-- COUNT(컬럼 혹은 표현식) : 행그룹에서 지정된 컬럼의 값이 NULL이 아닌 행의 개수를 반환한다.

-- COUNT(*) : 행그룹에서 모든 행의 개수를 반환한다.

----------------------------------------------------------------------------------------------------------------------------
-- 직원들이 받는 최고급여를 조회하기
SELECT MAX(SALARY)
FROM EMPLOYEES;

-- 직원들이 받는 최고급여와 그 급여를 받는 직원의 아이디, 이름도 같이 조회하기
-- 서브쿼리를 사용해서 조회할 수 있다.
-- 서브쿼리는 쿼리문 안에 포함된 쿼리문이다.
-- 서브쿼리의 실행결과는 WHERE절의 조건식에 사용된다.
-- (현재 배운 내용으로는 SELECT에서 그룹함수와 단행함수를 같이 사용할 수 없음. 결과 값의 개수가 서로 다르다.)
SELECT EMPLOYEE_ID, FIRST_NAME, SALARY
FROM EMPLOYEES
WHERE SALARY = (SELECT MAX(SALARY)
                FROM EMPLOYEES);
                
-- 80번 부서에 근무중인 사원의 수 조회하기
SELECT COUNT(*)
FROM EMPLOYEES
WHERE DEPARTMENT_ID = 80;

-- 80번 부서에서 근무중인 사원의 최소급여, 최대급여, 평균급여, 급여총계를 조회하기
SELECT MIN(SALARY), MAX(SALARY), AVG(SALARY), SUM(SALARY)
FROM EMPLOYEES
WHERE DEPARTMENT_ID = 80;
----------------------------------------------------------------------------------------------------------------------------

