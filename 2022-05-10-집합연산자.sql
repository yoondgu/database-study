--------------------------------------------------------------------------------------------------------------
-- ���տ�����
--------------------------------------------------------------------------------------------------------------
-- ������
-- �޿��� 3000 ���Ϸ� �޴� ����� ��ȸ�ϱ�
-- �޿��� 15000 �̻����� �޴� ����� ��ȸ�ϱ�
SELECT EMPLOYEE_ID, FIRST_NAME, SALARY
FROM EMPLOYEES
WHERE SALARY <= 3000
UNION
SELECT EMPLOYEE_ID, FIRST_NAME, SALARY
FROM EMPLOYEES
WHERE SALARY >=15000;

-- �޿������ 'c'�� �ش��ϴ� ����� ���̵�, �̸�, �޿��� ��ȸ�ϱ�
-- �ٹ����� 'Seattle'�� ������ ���̵�, �̸�, �޿��� ��ȸ�ϱ�
SELECT E.EMPLOYEE_ID, E.FIRST_NAME, E.SALARY
FROM EMPLOYEES E, SALARY_GRADE S
WHERE E.SALARY >= S.MIN_SALARY AND E.SALARY <= S.MAX_SALARY
AND S.GRADE = 'C'
UNION ALL
SELECT E.EMPLOYEE_ID, E.FIRST_NAME, E.SALARY
FROM EMPLOYEES E, DEPARTMENTS D, LOCATIONS L
WHERE E.DEPARTMENT_ID = D.DEPARTMENT_ID
AND D.LOCATION_ID = L.LOCATION_ID
AND L.CITY = 'Seattle';

-- ������
-- ������ ��������� �ִ� ����� ���̵� ��ȸ�ϱ�
SELECT EMPLOYEE_ID
FROM JOB_HISTORY
INTERSECT
SELECT EMPLOYEE_ID
FROM EMPLOYEES;

-- �̸��� ���� ��ȸ�ϱ�
SELECT Y.EMPLOYEE_ID, Y.FIRST_NAME
FROM (SELECT EMPLOYEE_ID
    FROM JOB_HISTORY
    INTERSECT
    SELECT EMPLOYEE_ID
    FROM EMPLOYEES) X, EMPLOYEES Y
WHERE X.EMPLOYEE_ID = Y.EMPLOYEE_ID;

-- ������
-- ������ ����� ���� ���� ����� ��ȸ�ϱ�
SELECT EMPLOYEE_ID
FROM EMPLOYEES
MINUS
SELECT EMPLOYEE_ID
FROM JOB_HISTORY;

--------------------------------------------------------------------------------------------------------------
-- ��ȣ���� ��������
--------------------------------------------------------------------------------------------------------------
-- �ڽ��� �Ҽӵ� �μ��� ��ձ޿����� �޿��� ���� ���� ������ ���̵�, �̸�, �޿��� ��ȸ�ϱ� - INLINE VIEW�� JOIN���� ��ȸ
SELECT Y.EMPLOYEE_ID, Y.FIRST_NAME, Y.SALARY
FROM (SELECT DEPARTMENT_ID, AVG(SALARY) AVG_SALARY
     FROM EMPLOYEES
     WHERE DEPARTMENT_ID IS NOT NULL
     GROUP BY DEPARTMENT_ID) X, EMPLOYEES Y
WHERE X.DEPARTMENT_ID = Y.DEPARTMENT_ID
AND X.AVG_SALARY > Y.SALARY;

-- �ڽ��� �Ҽӵ� �μ��� ��ձ޿����� �޿��� ���� ���� ������ ���̵�, �̸�, �޿��� ��ȸ�ϱ� - WITH�� JOIN���� ��ȸ
WITH DEPT_AVG_SALARY
AS (SELECT DEPARTMENT_ID, AVG(SALARY) AVG_SALARY
     FROM EMPLOYEES
     WHERE DEPARTMENT_ID IS NOT NULL
     GROUP BY DEPARTMENT_ID)
SELECT Y.EMPLOYEE_ID, Y.FIRST_NAME, Y.SALARY
FROM DEPT_AVG_SALARY X, EMPLOYEES Y
WHERE X.DEPARTMENT_ID = Y.DEPARTMENT_ID
AND X.AVG_SALARY > Y.SALARY;

-- �ڽ��� �Ҽӵ� �μ��� ��ձ޿����� �޿��� ���� ���� ������ ���̵�, �̸�, �޿��� ��ȸ�ϱ� - ��ȣ���� ���������� ��ȸ
SELECT MAIN.EMPLOYEE_ID, MAIN.FIRST_NAME, MAIN.SALARY
FROM EMPLOYEES MAIN
WHERE MAIN.SALARY < (SELECT AVG(SUB.SALARY)
                    FROM EMPLOYEES SUB
                    WHERE SUB.DEPARTMENT_ID = MAIN.DEPARTMENT_ID); -- ���������� ���������� ��ȸ������ŭ ����ȴ�.

-- �ڽ��� ��纸�� ���� �Ի��� ����� ���̵�, �̸��� ��ȸ�ϱ�
SELECT MAIN.EMPLOYEE_ID, MAIN.FIRST_NAME
FROM EMPLOYEES MAIN
WHERE MAIN.HIRE_DATE < (SELECT SUB.HIRE_DATE
                    FROM EMPLOYEES SUB
                    WHERE SUB.EMPLOYEE_ID = MAIN.MANAGER_ID);
                    
-- �μ����̵�, �μ���, �μ������ڸ��� ��ȸ�ϱ� - JOIN
SELECT D.DEPARTMENT_ID, D.DEPARTMENT_NAME, M.FIRST_NAME
FROM DEPARTMENTS D, EMPLOYEES M
WHERE D.MANAGER_ID = M.EMPLOYEE_ID(+)
ORDER BY D.DEPARTMENT_ID;

-- �μ����̵�, �μ���, �μ������ڸ��� ��ȸ�ϱ� - ��ȣ���� ��������
-- SELECT ���� ���Ǵ� ���������� ��Į�� ����������� �Ѵ�. ������ ������,���Ͽ��̾�� �Ѵ�
SELECT MAIN.DEPARTMENT_ID, MAIN.DEPARTMENT_NAME,
        (SELECT SUB.FIRST_NAME
        FROM EMPLOYEES SUB
        WHERE SUB.EMPLOYEE_ID = MAIN.MANAGER_ID) MANAGER_NAME 
FROM DEPARTMENTS MAIN
ORDER BY MAIN.DEPARTMENT_ID;
        
-- �������� �ذ�Ǵ� ������ �׻� ���� �������� �ذ��ϵ��� �� ��
        
--------------------------------------------------------------------------------------------------------------
-- Ʈ�����
--------------------------------------------------------------------------------------------------------------
