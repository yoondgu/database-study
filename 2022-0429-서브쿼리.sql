----------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------
-- ��������
----------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------
-- ������ ��������
----------------------------------------------------------------------------------------------------------------------------
-- 80�� �μ��� ��ձ޿��� ��ȸ�ϱ�
SELECT AVG(SALARY)      -- ��� �޿� : 8955.8
FROM EMPLOYEES
WHERE DEPARTMENT_ID = 80;

-- 80�� �μ����� �ٹ��ϴ� ���� �߿��� �μ��� ��ձ޿����� ���� �޿��� ���� ����� ���̵�, �̸�, �޿��� ��ȸ�ϱ�
SELECT EMPLOYEE_ID, FIRST_NAME, SALARY
FROM EMPLOYEES E
WHERE DEPARTMENT_ID = 80
AND SALARY < 8955.8;        -- �μ��� ��ձ޿��� �˾ƾ� ���ǽ��� ����� �� �ִ�. ���������� �ι��� ������ �ѹ����� �ٿ��ش�.

SELECT EMPLOYEE_ID, FIRST_NAME, SALARY
FROM EMPLOYEES E
WHERE DEPARTMENT_ID = 80
AND SALARY < (SELECT AVG(SALARY)
              FROM EMPLOYEES
              WHERE DEPARTMENT_ID = 80);
              
-- �μ����� 'IT'�� �μ��� �ٹ����� ������ ���̵�, �̸�, �޿��� ��ȸ�ϱ�
SELECT EMPLOYEE_ID, FIRST_NAME, SALARY
FROM EMPLOYEES
WHERE DEPARTMENT_ID = (SELECT DEPARTMENT_ID             -- EMPLOYEES���̺����� ID�� �μ��� ��ȸ�ϹǷ� ������������ 'IT'�μ��� ID�� ��ȸ�Ѵ�.
                        FROM DEPARTMENTS
                        WHERE DEPARTMENT_NAME = 'IT');
                        
-- �������� Ǯ� ��ȸ ����� ����.
SELECT E.EMPLOYEE_ID, E.FIRST_NAME, E.SALARY
FROM EMPLOYEES E, DEPARTMENTS D
WHERE E.DEPARTMENT_ID = D.DEPARTMENT_ID
AND D.DEPARTMENT_NAME = 'IT'; 

----------------------------------------------------------------------------------------------------------------------------
-- ������ ��������
----------------------------------------------------------------------------------------------------------------------------
-- �μ� �����ڰ� �����Ǿ� �ְ�, ������ ���̵� 1700���� �μ����� �ٹ����� ����� ���̵�, �̸��� ��ȸ�ϱ�
SELECT EMPLOYEE_ID, FIRST_NAME
FROM EMPLOYEES
WHERE DEPARTMENT_ID IN (SELECT DEPARTMENT_ID        -- ���������� ����� ���� ���̱� ������ =�����ڸ� ����� �� ����. IN�� ����Ѵ�.
                      FROM DEPARTMENTS
                      WHERE MANAGER_ID IS NOT NULL
                      AND LOCATION_ID = 1700)
ORDER BY EMPLOYEE_ID;

-- �������� Ǯ� ��ȸ ����� ����.
SELECT E.EMPLOYEE_ID, E.FIRST_NAME
FROM EMPLOYEES E, DEPARTMENTS D
WHERE E.DEPARTMENT_ID = D.DEPARTMENT_ID
AND D.LOCATION_ID = 1700
ORDER BY EMPLOYEE_ID;

-- 'Seattle'���� �ٹ����� ������ ���̵�, �̸� ��ȸ�ϱ�
-- * ���������� �� �ٸ� ���������� �����ϰ� �ִ�. (����ġ�� ���� �� �����Ǵ� ���������� �ٶ����� ����� �ƴϴ�.)
SELECT EMPLOYEE_ID, FIRST_NAME
FROM EMPLOYEES
WHERE DEPARTMENT_ID IN (SELECT DEPARTMENT_ID                        
                      FROM DEPARTMENTS
                      WHERE MANAGER_ID IS NOT NULL
                      AND LOCATION_ID IN (SELECT LOCATION_ID
                                          FROM LOCATIONS
                                          WHERE CITY = 'Seattle'))
ORDER BY EMPLOYEE_ID;

-- �������� Ǯ� ��ȸ ����� ����.
SELECT E.EMPLOYEE_ID, E.FIRST_NAME
FROM EMPLOYEES E, DEPARTMENTS D, LOCATIONS L
WHERE L.CITY = 'Seattle'
AND L.LOCATION_ID = D.LOCATION_ID
AND D.DEPARTMENT_ID = E.DEPARTMENT_ID;

-- 60�� �μ��� ��� �������� �޿����� �޿��� ���� ���� ����� ���̵�, �̸�, �޿��� ��ȸ�ϱ�
SELECT EMPLOYEE_ID, FIRST_NAME, SALARY
FROM EMPLOYEES
WHERE SALARY >ALL (SELECT SALARY            -- ���������� ����� ���� ��(9000,6000,4800,4800,4200)�̱� ������ >�� �ƴ϶� ������ �������� >ALL �� ����. 
                    FROM EMPLOYEES          -- ���������� ��� ����� �������� �� ���ǽ��� �����ϴ� ��츦 ��ȸ�Ѵ�. �� ���� ū �񱳰����� ū ���� ��ȸ�Ѵ�.
                    WHERE DEPARTMENT_ID = 60);
                    
-- ���� SQL�� MAX()�Լ��� ����ص� ���� ����� ��ȸ�ȴ�.
SELECT EMPLOYEE_ID, FIRST_NAME, SALARY
FROM EMPLOYEES
WHERE SALARY > (SELECT MAX(SALARY)          -- ���������� ����� �������̴�.
                FROM EMPLOYEES
                WHERE DEPARTMENT_ID = 60);

-- 60�� �μ��� ���� �޿����� �޿��� ���� ���� ����� ���̵�, �̸�, �޿��� ��ȸ�ϱ�
SELECT EMPLOYEE_ID, FIRST_NAME, SALARY
FROM EMPLOYEES
WHERE SALARY >ANY (SELECT SALARY            -- ���������� ����� ���� ��(9000,6000,4800,4800,4200)�̱� ������ >�� �ƴ϶� ������ �������� >ANY �� ����. 
                    FROM EMPLOYEES          -- ���������� ����� �������� �� �ϳ��� ���ǽ��� �����ϴ� ��츦 ��ȸ�Ѵ�. �� ���� ���� �񱳰����� ū ���� ��ȸ�Ѵ�.
                    WHERE DEPARTMENT_ID = 60);

-- ���� SQL�� MIN()�Լ��� ����ص� ���� ����� ��ȸ�ȴ�. 
SELECT EMPLOYEE_ID, FIRST_NAME, SALARY
FROM EMPLOYEES
WHERE SALARY > (SELECT MIN(SALARY)          -- ���������� ����� �������̴�.
                FROM EMPLOYEES
                WHERE DEPARTMENT_ID = 60);

----------------------------------------------------------------------------------------------------------------------------
-- ���߿� ��������
----------------------------------------------------------------------------------------------------------------------------
-- �����ȣ 177���� ������ ���� �μ�, ���� ������ �ٹ��ϰ� �ִ� ������ ���̵�, �̸��� ��ȸ�ϱ�

-- 177�� ������ �μ�, ���� ��ȸ : ���߿��� ����� ��ȸ�ȴ�.
SELECT DEPARTMENT_ID, JOB_ID
FROM EMPLOYEES
WHERE EMPLOYEE_ID = 177;

-- ���߿� ���������� �ۼ�
SELECT EMPLOYEE_ID, FIRST_NAME DEPARTMENT_ID, JOB_ID
FROM EMPLOYEES
WHERE (DEPARTMENT_ID, JOB_ID) IN (SELECT DEPARTMENT_ID, JOB_ID      -- WHERE (�÷�1, �÷�2) IN (�÷�3, �÷�4) : �÷�1=�÷�3 AND �÷�2=�÷�4
                                  FROM EMPLOYEES
                                  WHERE EMPLOYEE_ID = 177);

-- ���� ���߿� ���������� ���ǽ��� ������ ���������� ���� ��ȸ�ص� �ȴ�.
SELECT EMPLOYEE_ID, FIRST_NAME, DEPARTMENT_ID, JOB_ID
FROM EMPLOYEES
WHERE DEPARTMENT_ID = (SELECT DEPARTMENT_ID
                       FROM EMPLOYEES
                       WHERE EMPLOYEE_ID = 177)
AND JOB_ID = (SELECT JOB_ID
              FROM EMPLOYEES
              WHERE EMPLOYEE_ID = 177);
                                  
-- ���߿� ���������θ� ���ǽ��� �ۼ��ؾ� �ϴ� ���***
-- �� �μ� �� �����޿��� �����ϰ�, �� �μ����� �ش� �޿��� �޴� ����� ���̵�, �̸�, �޿��� ��ȸ�ϱ�

-- �� �μ� �� �����޿� ��ȸ : ���߿��� ����� ��ȸ�ȴ�. �� ���� ���� ���ÿ� ��ġ�ϴ� ������ ������ ã�ƾ� �Ѵ�.
-- �� �࿡ ��� �� ���� ��(�μ�, �����޿�)�� ��� ��ġ�ϴ� EMPLOYEES�� ����� ���� ��ȸ�ؾ� �Ѵ�.

SELECT DEPARTMENT_ID, MIN(SALARY)
FROM EMPLOYEES
WHERE DEPARTMENT_ID IS NOT NULL
GROUP BY DEPARTMENT_ID;

-- ���߿� ���������� �ۼ�
-- �� ���� ���� ��� �����ϴ� �� ���� ��Ʈ�� �ؾ��ϹǷ� ���߿� ���������θ� �ۼ��� �� �ִ�.
SELECT EMPLOYEE_ID, FIRST_NAME, SALARY
FROM EMPLOYEES
WHERE (DEPARTMENT_ID, SALARY) IN (SELECT DEPARTMENT_ID, MIN(SALARY)
                                  FROM EMPLOYEES
                                  WHERE DEPARTMENT_ID IS NOT NULL
                                  GROUP BY DEPARTMENT_ID);

---- NOT IN ����                                  
--SELECT EMPLOYEE_ID, FIRST_NAME, DEPARTMENT_ID, JOB_ID
--FROM EMPLOYEES
--WHERE (DEPARTMENT_ID, JOB_ID) NOT IN (SELECT DEPARTMENT_ID, JOB_ID   -- WHERE (�÷�1, �÷�2) NOT IN : (�÷�3, �÷�4) �÷�1!=�÷�3 OR �÷�2!=�÷�4
--                                  FROM EMPLOYEES
--                                  WHERE EMPLOYEE_ID = 177);             
                
----------------------------------------------------------------------------------------------------------------------------
-- ���� ���� ���������� ����ؼ� ��ȸ�ϱ�
----------------------------------------------------------------------------------------------------------------------------

-- 80�� �μ����� �ٹ��ϰ�, 80�� �μ��� ��ձ޿����� �޿��� ���� ���� �����̰�, 80�� �μ��� �����ڿ� ���� �ؿ� �Ի��� ������ ��ȸ�ϱ�
-- * ���� ���� ���ǿ� ���Ͽ� ���������� ���������� ����� �� �ִ�.
SELECT EMPLOYEE_ID, FIRST_NAME, SALARY
FROM EMPLOYEES
WHERE DEPARTMENT_ID = 80
AND SALARY > (SELECT AVG(SALARY)
              FROM EMPLOYEES
              WHERE DEPARTMENT_ID = 80)
AND TO_CHAR(HIRE_DATE, 'YYYY') = (SELECT TO_CHAR(E.HIRE_DATE, 'YYYY')
                                 FROM EMPLOYEES E, DEPARTMENTS D
                                 WHERE E.EMPLOYEE_ID = D.MANAGER_ID
                                 AND D.DEPARTMENT_ID = 80);
                                 
----------------------------------------------------------------------------------------------------------------------------
-- HAVING ������ ���������� ����ϱ�
----------------------------------------------------------------------------------------------------------------------------
-- �������� ������� ��ȸ���� �� ������� 10���� �Ѵ� ������ ������� ��ȸ�ϱ�
SELECT JOB_ID, COUNT(*)
FROM EMPLOYEES
GROUP BY JOB_ID
HAVING COUNT(*) > 10
ORDER BY JOB_ID;

-- ���� ���� ������� ��ȸ���� �� ������� ���� ���� ������ ��ȸ�ϱ�
SELECT JOB_ID, COUNT(*) CNT
FROM EMPLOYEES
GROUP BY JOB_ID
HAVING COUNT(*) = (SELECT MAX(COUNT(*)) -- ������ �Լ��� ��ø�� SELECT�������� ���ǹǷ� MAX(COUNT(*))��� �״�� �� �� ����. �Ϲ����� ��ʴ� �ƴϴ�.
                   FROM EMPLOYEES
                   GROUP BY JOB_ID);

----------------------------------------------------------------------------------------------------------------------------
-- WITH ������ ���������� ����ϱ�
-- SQL������ ���� �� ���Ǵ� SQL�� Ȥ�� �������� WITH���� ����ϸ� ������ ���̺��� �����ϰ�, �� �������� �ӽ÷� ������ �� �ִ�.

-- WITH �������̺�Ī
-- AS (SELECT �÷���1, �÷���2, ǥ���� ��Ī1, ǥ���� ��Ī2
--     FROM ���̺��
--     WHERE ���ǽ�)
-- SELECT �÷���1, �÷���2, ��Ī1, ��Ī2
-- FROM �������̺�Ī
----------------------------------------------------------------------------------------------------------------------------
-- ���� ���� ������� ��ȸ���� �� ������� ���� ���� ������ ��ȸ�ϱ�
-- ���� SQL�� WITH���� ����ؼ� �����ϱ�
WITH JOB_EMPS   -- SELECT���� ����� ������ ���̺�� ����. ���� ���� ���̺��� ���� �� �ִ�.
AS (SELECT JOB_ID, COUNT(*) CNT
    FROM EMPLOYEES
    GROUP BY JOB_ID)
SELECT JOB_ID, CNT
FROM JOB_EMPS
WHERE CNT = (SELECT MAX(CNT)
            FROM JOB_EMPS);

----------------------------------------------------------------------------------------------------------------------------
-- �ǻ��÷�(Pseudo columns)�� �̿��ؼ� ��ȸ�ϱ�
-- �ǻ��÷��� ���� ���̺� ����Ǿ����� ���� �÷��̴�.
-- �ǻ��÷��� SQL�� ����Ǵ� ���� ����� �� �ִ� �÷��̴�.
-- ROWNUM: �ǻ��÷� �� �ϳ���, ��ȸ ����� �� �࿡ ������� 1������ ���۵Ǵ� ������ �ٿ��ִ� �÷�
----------------------------------------------------------------------------------------------------------------------------
-- ���� ���� ������� ��ȸ���� �� ������� ���� ���� ������ ��ȸ�ϱ�
-- �ǻ�Į�� ROWNUM�� ������ �̿��ؼ� ��ȸ�ϱ�. ������ 1���� ���� ������� ���� ���� ������ ���̴�.
SELECT JOB_ID, CNT
FROM (SELECT JOB_ID, COUNT(*) CNT
     FROM EMPLOYEES
     GROUP BY JOB_ID
     ORDER BY CNT DESC) -- ���� �� ������� ������������ ������ ������ ���̺�
WHERE ROWNUM = 1;       -- ��ȸ����� ���� 1�� ���� ��ȸ (ROWNUM �÷��� �ִٴ� ���� ����)
