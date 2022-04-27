----------------------------------------------------------------------------------------------------------------------------
-- 비등가 조인
-- 이퀄 연산자를 사용하지 않고 조인한다.
-- 주로 구간을 가지고 있는 등급을 판정하여 조회할 때 사용한다.
----------------------------------------------------------------------------------------------------------------------------
CREATE TABLE SALARY_GRADE (
    GRADE CHAR(1) PRIMARY KEY,
    MIN_SALARY NUMBER(8,2),
    MAX_SALARY NUMBER(8,2)
);

INSERT INTO SALARY_GRADE(GRADE, MIN_SALARY, MAX_SALARY) VALUES('A', 25000, 50000);
INSERT INTO SALARY_GRADE(GRADE, MIN_SALARY, MAX_SALARY) VALUES('B', 15000, 24999);
INSERT INTO SALARY_GRADE(GRADE, MIN_SALARY, MAX_SALARY) VALUES('C', 7000, 14999);
INSERT INTO SALARY_GRADE(GRADE, MIN_SALARY, MAX_SALARY) VALUES('D', 3000, 6999);
INSERT INTO SALARY_GRADE(GRADE, MIN_SALARY, MAX_SALARY) VALUES('E', 0, 2999);

COMMIT;

-- 급여가 10000 이상인 직원들의 직원 아이디, 이름, 급여, 급여등급 조회하기
-- 급여에 대한 조회조건이 급여등급과 맞아떨어지지 않는다.
-- 일치하는 값이 아니라, 범위 조건을 만족하는 행들을 조회할 것이다. 이 경우 비등가조인을 활용한다.
-- E                                E      E    E       S
SELECT E.EMPLOYEE_ID, E.FIRST_NAME, E.SALARY, S.GRADE
FROM EMPLOYEES E, SALARY_GRADE S
WHERE E.SALARY >= 10000
AND E.SALARY >= S.MIN_SALARY AND E.SALARY <= S.MAX_SALARY -- 비등가 조인조건
ORDER BY E.EMPLOYEE_ID;

-- 급여 등급이 'C'나 'D' 등급에 속하는 직원들의 아이디, 이름, 급여, 급여등급을 조회하기
SELECT E.EMPLOYEE_ID, E.FIRST_NAME, E.SALARY, S.GRADE
FROM EMPLOYEES E, SALARY_GRADE S
WHERE E.SALARY >= S.MIN_SALARY AND E.SALARY <= S.MAX_SALARY  -- 비등가 조인조건
AND S.GRADE IN ('C', 'D')
ORDER BY E.EMPLOYEE_ID;

-- 부서관리자가 지정된 부서아이디, 부서명, 관리자명, 급여, 급여등급을 조회하기
--                        D       D       E       E       S
SELECT D.DEPARTMENT_ID, D.DEPARTMENT_NAME, E.FIRST_NAME, E.SALARY, S.GRADE
FROM DEPARTMENTS D, EMPLOYEES E, SALARY_GRADE S
WHERE D.MANAGER_ID IS NOT NULL -- 이 경우에는 쓰지 않아도 조회결과는 같지만, 조인에 참여하는 행 개수 자체를 줄여준다.
AND D.MANAGER_ID = E.EMPLOYEE_ID -- 관리자명을 알 수 있는 등가 조인조건 (D, E)
AND  E.SALARY >= S.MIN_SALARY AND E.SALARY <= S.MAX_SALARY -- 관리자의 급여등급을 알 수 있는 비등가 조인조건 (E, S)
ORDER BY D.DEPARTMENT_ID;


-- 직종 아이디, 직종 최저급여, 직종최저급여의 등급, 직종 최고급여, 직종 최고급여의 등급 ***(같은 테이블 여러 개 사용하기)
--      J           J               S1               J               S2
-- 급여 등급테이블이 2개 필요하다. (최저급여, 최고급여와 조인할 때 사용할 각각 테이블 2개.)
SELECT J.JOB_ID, J.MIN_SALARY, S1.GRADE MIN_GRADE, J.MAX_SALARY, S2.GRADE MAX_GRADE
FROM JOBS J, SALARY_GRADE S1, SALARY_GRADE S2
WHERE (J.MIN_SALARY >= S1.MIN_SALARY AND J.MIN_SALARY <= S1.MAX_SALARY)
AND (J.MAX_SALARY >= S2.MIN_SALARY AND J.MAX_SALARY <= S2.MAX_SALARY)
ORDER BY J.JOB_ID;
