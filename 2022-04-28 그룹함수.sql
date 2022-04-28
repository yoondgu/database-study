----------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------
-- 그룹함수
-- 행그룹(테이블 전체, 조회된 행 전체, 같은 값을 가지고 있는 행끼리 그룹핑했을 때 각각의 그룹들)에 대해서 결과를 하나 반환하는 함수
-- 행그룹은 GROUP BY를 통해 여러 개로 나눌 수 있다. GROUP BY에는 컬럼명 또는 표현식을 사용할 수 있다.
-- GROUP BY 표현식의 경우 표현식의 값이 같은 행끼리 그룹으로 묶는다.
-- GROUP BY 절에 사용한 컬럼명 또는 표현식만 SELECT절에 그룹함수와 사용할 수 있다.
-- HAVING 절에서는 조건식에 그룹함수를 사용할 수 있기 때문에 그룹함수 적용결과를 사용해서 조건식을 정의할 수 있다.
-- 이는 GROUP BY에 의한 SELECT 실행결과에 대한 조건식이다. (GROUP BY에 대한 필터링)
----------------------------------------------------------------------------------------------------------------------------
-- 행그룹이 '테이블 전체인 경우' : 행그룹이 하나이므로 조회결과가 한 행 조회된다.
SELECT COUNT(*)
FROM EMPLOYEES;

SELECT SUM(SALARY)
FROM EMPLOYEES;

-- 행그룹이 '조회된 행 전체인 경우' : 행그룹이 하나이므로 조회결과가 한 행 조회된다.
SELECT COUNT(*)
FROM EMPLOYEES
WHERE SALARY < 10000;

SELECT AVG(SALARY)
FROM EMPLOYEES
WHERE SALARY < 10000;

-- 특정 속성에 대하여 같은 값을 가지고 있는 행끼리 그룹핑을 하는 경우 : 행그룹이 여러 개이므로 조회결과가 여러 개 조회된다.
-- GROUP BY 는 행그룹을 나눈다. 여러 개의 행그룹을 생성한다.
SELECT COUNT(*)
FROM EMPLOYEES
GROUP BY JOB_ID; -- GROUP BY로 나누어진 행그룹마다 그룹함수가 실행된다.

SELECT COUNT(*)
FROM EMPLOYEES
GROUP BY DEPARTMENT_ID;

-- 행그룹을 생성하기 위해서 GROUP BY 절에 사용했던 컬럼명 혹은 표현식만 SELECT절에서 그룹함수와 같이 사용할 수 있다.
-- GROUP BY 절에서 사용하지 않은 컬럼명은 SELECT 절에 사용할 수 없다.

-- 소재지 별 부서갯수를 조회하기
SELECT LOCATION_ID, COUNT(*)
FROM DEPARTMENTS
GROUP BY LOCATION_ID;

-- 소속부서가 있는 직원들에 대하여 소속부서 별 직원수 조회하기
SELECT DEPARTMENT_ID, COUNT(*)
FROM EMPLOYEES
WHERE DEPARTMENT_ID IS NOT NULL
GROUP BY DEPARTMENT_ID
ORDER BY DEPARTMENT_ID;

-- 입사년도 별 사원수 조회하기
-- 표현식을 사용할 수 있다. 표현식의 결과값이 같은 행끼리 묶는다.
SELECT TO_CHAR(HIRE_DATE, 'YYYY') HIRED_YEAR, COUNT(*) CNT
FROM EMPLOYEES
GROUP BY TO_CHAR(HIRE_DATE, 'YYYY')
ORDER BY HIRED_YEAR;

-- 급여등급별 사원수 조회하기
-- 사원테이블과 급여등급테이블을 조인하고, 급여등급테이블의 등급이 같은 행끼리 행그룹을 생성
SELECT S.GRADE, COUNT(*) GRADE_CNT
FROM EMPLOYEES E, SALARY_GRADE S
WHERE E.SALARY >= S.MIN_SALARY AND E.SALARY <= S.MAX_SALARY
GROUP BY S.GRADE
ORDER BY S.GRADE;

-- 위와 같이 하면 데이터가 존재하는 경우만 집계할 수 있다. (해당 사원이 존재하지 않는 등급은 확인 불가하다)
-- 아래와 같이 하면 데이터가 존재하지 않는 등급도 함께 집계할 수 있다.

-- 위에서 작성한 SELECT문의 실행결과를 가상의 테이블 X로 간주하고, SALARY, GRADE와 조인하기 
--SELECT Y.GRADE, NVL(X.GRADE_CNT, 0) CNT -- X.GRADE_CNT 값이 NULL인 경우 0으로 반환한다.
--FROM X, SALARY_GRADE Y
--WHERE X.GRADE (+) = Y.GRADE -- X.GRADE에 S.GRADE의 A등급과 연결할 행이 없으므로 (+) 하여 포괄조인시켜준다.
--ORDER BY Y.GRADE ASC;

--가상의 테이블 X 자리에 위 SELECT문을 작성한다.
SELECT Y.GRADE, NVL(X.GRADE_CNT,0) CNT
FROM    (SELECT S.GRADE, COUNT(*) GRADE_CNT
        FROM EMPLOYEES E, SALARY_GRADE S
        WHERE E.SALARY >= S.MIN_SALARY AND E.SALARY <= S.MAX_SALARY
        GROUP BY S.GRADE
        ORDER BY S.GRADE) X, SALARY_GRADE Y
WHERE X.GRADE (+) = Y.GRADE
ORDER BY Y.GRADE ASC;

-- 입사년도별 사원수를 조회했을 때 입사한 사원수가 20명 이상으로 입사한 해와 그 해에 입사한 사원수를 조회하기
SELECT TO_CHAR(HIRE_DATE,'YYYY') YEAR, COUNT(*) HIRED_CNT
FROM EMPLOYEES
GROUP BY TO_CHAR(HIRE_DATE,'YYYY')
HAVING COUNT(*) >= 20
ORDER BY YEAR;

-- 부서별, 직종별 사원수를 조회하기
-- * 부서별로 먼저 그룹핑 후, 같은 부서 내에서 직종별로 다시 그룹핑해서 직종별 사원수를 조회한다.
SELECT DEPARTMENT_ID, JOB_ID, COUNT(*)
FROM EMPLOYEES
WHERE DEPARTMENT_ID IN (50, 80)
GROUP BY DEPARTMENT_ID, JOB_ID -- DEPARTMENT_ID로 그룹핑하고, 그 안에서 다시 JOB_ID로 그룹핑한다.
ORDER BY DEPARTMENT_ID ASC, JOB_ID ASC;

-- 부서별, 직종별 사원수를 조회하기 - ROLLUP()함수로 부서별 소계, 전체 합계를 조회하기
-- * 부서별로 먼저 그룹핑 후, 같은 부서 내에서 직종별로 다시 그룹핑해서 직종별 사원수, 부서별 사원수, 전체 사원수를 조회한다.
SELECT DEPARTMENT_ID, JOB_ID, COUNT(*)
FROM EMPLOYEES
WHERE DEPARTMENT_ID IN (50, 80)
GROUP BY ROLLUP(DEPARTMENT_ID, JOB_ID) -- 부분합(큰 그룹별), 전체합 행을 보여준다.
ORDER BY DEPARTMENT_ID ASC, JOB_ID ASC;

--null 부서별, 직종별 사원수를 조회하기 - GROUPING SETS()함수로 부서별, 직종별 그룹함수의 각 실행결과 조회하기
-- * 전체에 대하여 부서별로 사원수를 조회하고, 또 전체에 대하여 직종별로 사원수를 조회한다.
SELECT DEPARTMENT_ID, JOB_ID, COUNT(*)
FROM EMPLOYEES
WHERE DEPARTMENT_ID IN (50, 80)
GROUP BY GROUPING SETS(DEPARTMENT_ID, JOB_ID) -- 부서별 합계, 직종별 합계를 각각 보여준다.
ORDER BY DEPARTMENT_ID ASC, JOB_ID ASC;

------------------------------

-- 부서별 급여 총액, 급여 평균을 조회하기
-- 부서아이디, 부서급여 총액, 부서급여 평균
SELECT E.DEPARTMENT_ID, SUM(E.SALARY) TOTAL, TRUNC(AVG(E.SALARY)) AVERAGE
FROM EMPLOYEES E, DEPARTMENTS D
WHERE E.DEPARTMENT_ID IS NOT NULL
AND E.DEPARTMENT_ID = D.DEPARTMENT_ID
GROUP BY E.DEPARTMENT_ID
ORDER BY E.DEPARTMENT_ID;

-- 부서별 급여 총액, 급여 평균을 부서명과 함께 조회하기
-- 부서아이디, 부서명, 부서급여 총액, 부서급여 평균
SELECT E.DEPARTMENT_ID, D.DEPARTMENT_NAME, SUM(E.SALARY) DEPT_TOTAL_SALARY, TRUNC(AVG(E.SALARY)) DEPT_AVG_SALARY
FROM EMPLOYEES E, DEPARTMENTS D
WHERE E.DEPARTMENT_ID IS NOT NULL
AND E.DEPARTMENT_ID = D.DEPARTMENT_ID
GROUP BY E.DEPARTMENT_ID, D.DEPARTMENT_NAME -- D.DEPARTMENT_NAME을 GROUP BY 절에 적어주어야 SELECT절에도 적을 수 있다.
-- 이 경우에는 D.DEPARTMENT_NAME으로 소그룹을 만들어도 소그룹이 모두 하나씩 뿐이다. 
ORDER BY E.DEPARTMENT_ID;

