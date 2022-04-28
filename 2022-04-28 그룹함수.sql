----------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------
-- �׷��Լ�
-- ��׷�(���̺� ��ü, ��ȸ�� �� ��ü, ���� ���� ������ �ִ� �ೢ�� �׷������� �� ������ �׷��)�� ���ؼ� ����� �ϳ� ��ȯ�ϴ� �Լ�
-- ��׷��� GROUP BY�� ���� ���� ���� ���� �� �ִ�. GROUP BY���� �÷��� �Ǵ� ǥ������ ����� �� �ִ�.
-- GROUP BY ǥ������ ��� ǥ������ ���� ���� �ೢ�� �׷����� ���´�.
-- GROUP BY ���� ����� �÷��� �Ǵ� ǥ���ĸ� SELECT���� �׷��Լ��� ����� �� �ִ�.
-- HAVING �������� ���ǽĿ� �׷��Լ��� ����� �� �ֱ� ������ �׷��Լ� �������� ����ؼ� ���ǽ��� ������ �� �ִ�.
-- �̴� GROUP BY�� ���� SELECT �������� ���� ���ǽ��̴�. (GROUP BY�� ���� ���͸�)
----------------------------------------------------------------------------------------------------------------------------
-- ��׷��� '���̺� ��ü�� ���' : ��׷��� �ϳ��̹Ƿ� ��ȸ����� �� �� ��ȸ�ȴ�.
SELECT COUNT(*)
FROM EMPLOYEES;

SELECT SUM(SALARY)
FROM EMPLOYEES;

-- ��׷��� '��ȸ�� �� ��ü�� ���' : ��׷��� �ϳ��̹Ƿ� ��ȸ����� �� �� ��ȸ�ȴ�.
SELECT COUNT(*)
FROM EMPLOYEES
WHERE SALARY < 10000;

SELECT AVG(SALARY)
FROM EMPLOYEES
WHERE SALARY < 10000;

-- Ư�� �Ӽ��� ���Ͽ� ���� ���� ������ �ִ� �ೢ�� �׷����� �ϴ� ��� : ��׷��� ���� ���̹Ƿ� ��ȸ����� ���� �� ��ȸ�ȴ�.
-- GROUP BY �� ��׷��� ������. ���� ���� ��׷��� �����Ѵ�.
SELECT COUNT(*)
FROM EMPLOYEES
GROUP BY JOB_ID; -- GROUP BY�� �������� ��׷츶�� �׷��Լ��� ����ȴ�.

SELECT COUNT(*)
FROM EMPLOYEES
GROUP BY DEPARTMENT_ID;

-- ��׷��� �����ϱ� ���ؼ� GROUP BY ���� ����ߴ� �÷��� Ȥ�� ǥ���ĸ� SELECT������ �׷��Լ��� ���� ����� �� �ִ�.
-- GROUP BY ������ ������� ���� �÷����� SELECT ���� ����� �� ����.

-- ������ �� �μ������� ��ȸ�ϱ�
SELECT LOCATION_ID, COUNT(*)
FROM DEPARTMENTS
GROUP BY LOCATION_ID;

-- �ҼӺμ��� �ִ� �����鿡 ���Ͽ� �ҼӺμ� �� ������ ��ȸ�ϱ�
SELECT DEPARTMENT_ID, COUNT(*)
FROM EMPLOYEES
WHERE DEPARTMENT_ID IS NOT NULL
GROUP BY DEPARTMENT_ID
ORDER BY DEPARTMENT_ID;

-- �Ի�⵵ �� ����� ��ȸ�ϱ�
-- ǥ������ ����� �� �ִ�. ǥ������ ������� ���� �ೢ�� ���´�.
SELECT TO_CHAR(HIRE_DATE, 'YYYY') HIRED_YEAR, COUNT(*) CNT
FROM EMPLOYEES
GROUP BY TO_CHAR(HIRE_DATE, 'YYYY')
ORDER BY HIRED_YEAR;

-- �޿���޺� ����� ��ȸ�ϱ�
-- ������̺�� �޿�������̺��� �����ϰ�, �޿�������̺��� ����� ���� �ೢ�� ��׷��� ����
SELECT S.GRADE, COUNT(*) GRADE_CNT
FROM EMPLOYEES E, SALARY_GRADE S
WHERE E.SALARY >= S.MIN_SALARY AND E.SALARY <= S.MAX_SALARY
GROUP BY S.GRADE
ORDER BY S.GRADE;

-- ���� ���� �ϸ� �����Ͱ� �����ϴ� ��츸 ������ �� �ִ�. (�ش� ����� �������� �ʴ� ����� Ȯ�� �Ұ��ϴ�)
-- �Ʒ��� ���� �ϸ� �����Ͱ� �������� �ʴ� ��޵� �Բ� ������ �� �ִ�.

-- ������ �ۼ��� SELECT���� �������� ������ ���̺� X�� �����ϰ�, SALARY, GRADE�� �����ϱ� 
--SELECT Y.GRADE, NVL(X.GRADE_CNT, 0) CNT -- X.GRADE_CNT ���� NULL�� ��� 0���� ��ȯ�Ѵ�.
--FROM X, SALARY_GRADE Y
--WHERE X.GRADE (+) = Y.GRADE -- X.GRADE�� S.GRADE�� A��ް� ������ ���� �����Ƿ� (+) �Ͽ� �������ν����ش�.
--ORDER BY Y.GRADE ASC;

--������ ���̺� X �ڸ��� �� SELECT���� �ۼ��Ѵ�.
SELECT Y.GRADE, NVL(X.GRADE_CNT,0) CNT
FROM    (SELECT S.GRADE, COUNT(*) GRADE_CNT
        FROM EMPLOYEES E, SALARY_GRADE S
        WHERE E.SALARY >= S.MIN_SALARY AND E.SALARY <= S.MAX_SALARY
        GROUP BY S.GRADE
        ORDER BY S.GRADE) X, SALARY_GRADE Y
WHERE X.GRADE (+) = Y.GRADE
ORDER BY Y.GRADE ASC;

-- �Ի�⵵�� ������� ��ȸ���� �� �Ի��� ������� 20�� �̻����� �Ի��� �ؿ� �� �ؿ� �Ի��� ������� ��ȸ�ϱ�
SELECT TO_CHAR(HIRE_DATE,'YYYY') YEAR, COUNT(*) HIRED_CNT
FROM EMPLOYEES
GROUP BY TO_CHAR(HIRE_DATE,'YYYY')
HAVING COUNT(*) >= 20
ORDER BY YEAR;

-- �μ���, ������ ������� ��ȸ�ϱ�
-- * �μ����� ���� �׷��� ��, ���� �μ� ������ �������� �ٽ� �׷����ؼ� ������ ������� ��ȸ�Ѵ�.
SELECT DEPARTMENT_ID, JOB_ID, COUNT(*)
FROM EMPLOYEES
WHERE DEPARTMENT_ID IN (50, 80)
GROUP BY DEPARTMENT_ID, JOB_ID -- DEPARTMENT_ID�� �׷����ϰ�, �� �ȿ��� �ٽ� JOB_ID�� �׷����Ѵ�.
ORDER BY DEPARTMENT_ID ASC, JOB_ID ASC;

-- �μ���, ������ ������� ��ȸ�ϱ� - ROLLUP()�Լ��� �μ��� �Ұ�, ��ü �հ踦 ��ȸ�ϱ�
-- * �μ����� ���� �׷��� ��, ���� �μ� ������ �������� �ٽ� �׷����ؼ� ������ �����, �μ��� �����, ��ü ������� ��ȸ�Ѵ�.
SELECT DEPARTMENT_ID, JOB_ID, COUNT(*)
FROM EMPLOYEES
WHERE DEPARTMENT_ID IN (50, 80)
GROUP BY ROLLUP(DEPARTMENT_ID, JOB_ID) -- �κ���(ū �׷캰), ��ü�� ���� �����ش�.
ORDER BY DEPARTMENT_ID ASC, JOB_ID ASC;

--null �μ���, ������ ������� ��ȸ�ϱ� - GROUPING SETS()�Լ��� �μ���, ������ �׷��Լ��� �� ������ ��ȸ�ϱ�
-- * ��ü�� ���Ͽ� �μ����� ������� ��ȸ�ϰ�, �� ��ü�� ���Ͽ� �������� ������� ��ȸ�Ѵ�.
SELECT DEPARTMENT_ID, JOB_ID, COUNT(*)
FROM EMPLOYEES
WHERE DEPARTMENT_ID IN (50, 80)
GROUP BY GROUPING SETS(DEPARTMENT_ID, JOB_ID) -- �μ��� �հ�, ������ �հ踦 ���� �����ش�.
ORDER BY DEPARTMENT_ID ASC, JOB_ID ASC;

------------------------------

-- �μ��� �޿� �Ѿ�, �޿� ����� ��ȸ�ϱ�
-- �μ����̵�, �μ��޿� �Ѿ�, �μ��޿� ���
SELECT E.DEPARTMENT_ID, SUM(E.SALARY) TOTAL, TRUNC(AVG(E.SALARY)) AVERAGE
FROM EMPLOYEES E, DEPARTMENTS D
WHERE E.DEPARTMENT_ID IS NOT NULL
AND E.DEPARTMENT_ID = D.DEPARTMENT_ID
GROUP BY E.DEPARTMENT_ID
ORDER BY E.DEPARTMENT_ID;

-- �μ��� �޿� �Ѿ�, �޿� ����� �μ���� �Բ� ��ȸ�ϱ�
-- �μ����̵�, �μ���, �μ��޿� �Ѿ�, �μ��޿� ���
SELECT E.DEPARTMENT_ID, D.DEPARTMENT_NAME, SUM(E.SALARY) DEPT_TOTAL_SALARY, TRUNC(AVG(E.SALARY)) DEPT_AVG_SALARY
FROM EMPLOYEES E, DEPARTMENTS D
WHERE E.DEPARTMENT_ID IS NOT NULL
AND E.DEPARTMENT_ID = D.DEPARTMENT_ID
GROUP BY E.DEPARTMENT_ID, D.DEPARTMENT_NAME -- D.DEPARTMENT_NAME�� GROUP BY ���� �����־�� SELECT������ ���� �� �ִ�.
-- �� ��쿡�� D.DEPARTMENT_NAME���� �ұ׷��� ���� �ұ׷��� ��� �ϳ��� ���̴�. 
ORDER BY E.DEPARTMENT_ID;

