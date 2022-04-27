----------------------------------------------------------------------------------------------------------------------------
-- � ����
-- �Ӽ��� ���� ���� �ೢ�� �����Ѵ�.
----------------------------------------------------------------------------------------------------------------------------

-- 200�� ������ �μ� �����ڷ� ������ �μ��� �Ҽӵ� ������� ���̵�, �̸�, ������ ��ȸ�ϱ�
-- ���� �࿡ ��ȸ�� �Ӽ����� �ƴϴ���, ���� �ٸ� ���̺��� ������ ���� ������ ��ȸ�� ��쿡�� ������ ����Ѵ�.
-- 200�� ������ �μ� �����ڷ� ������ �μ��� 10�� �μ���. �� 10�� �μ��� �Ҽӵ� ������� ������ ��ȸ�϶�� ���̴�.
-- DEPARTMENTS�� DEPARTMENT_ID�� 10���� ��� EMPLOYEES ���̺��� DEPARTMENT_ID�� 10������ ������ ���� �����ؼ� �ϳ��� ������ ������ �Ѵ�.

SELECT E.EMPLOYEE_ID, E.FIRST_NAME, E.JOB_ID
FROM DEPARTMENTS D, EMPLOYEES E
WHERE D.MANAGER_ID = 200
AND D.DEPARTMENT_ID = E.DEPARTMENT_ID;

-- 100�� ������ �μ������ڷ� ������ �μ��� ���̵�, �μ��̸�, �������� �̸��� ��ȸ�ϱ�
--             DEPARTMENTS(MANAGER_ID)  DEPARTMENTS DEPARTMENTS EMPLOYEES
-- 100�� ������ �μ������ڷ� ������ �μ��� 90�� �μ�
SELECT D.DEPARTMENT_ID, D.DEPARTMENT_NAME, E.FIRST_NAME
FROM DEPARTMENTS D, EMPLOYEES E
WHERE D.MANAGER_ID = 100
AND D.MANAGER_ID = E.EMPLOYEE_ID;

-- �μ����̺��� �μ������ڰ� ������ �μ��� �μ����̵�, �μ��̸�, ������ �̸��� ��ȸ�ϱ�
SELECT D.DEPARTMENT_ID, D.DEPARTMENT_NAME, E.FIRST_NAME
FROM DEPARTMENTS D, EMPLOYEES E
WHERE D.MANAGER_ID IS NOT NULL
AND D.MANAGER_ID = E.EMPLOYEE_ID
-- EMPLOYEE_ID�� PK�̹Ƿ� NULL�� ���� �����Ƿ� IS NOT NULL ������ �ۼ����� �ʾƵ� ��ȸ����� ����.
-- �׷��� �ƿ� NULL�� ���� ���ο� �������� �ʵ��� ���ִ� ���� ����.
ORDER BY D.DEPARTMENT_ID;

-- �޿��� 10000 �̻� �޴� ������ ���̵�, �̸�, ��������, �޿�, �ҼӺμ����� ��ȸ�ϱ�
SELECT E.EMPLOYEE_ID, E.FIRST_NAME, J.JOB_TITLE, E.SALARY, D.DEPARTMENT_NAME
FROM EMPLOYEES E, JOBS J, DEPARTMENTS D
WHERE E.SALARY >= 10000
AND E.JOB_ID = J.JOB_ID
AND E.DEPARTMENT_ID = D.DEPARTMENT_ID
ORDER BY E.EMPLOYEE_ID;

-----------�����ϱ�-----------

-- �޿��� 10000 �̻� �޴� ������ ���̵�, �̸�, ��������, �ٹ��� ���ø��� ��ȸ�ϱ�
--                              E     E     J       L
SELECT E.EMPLOYEE_ID, E.FIRST_NAME, J.JOB_TITLE, L.CITY
FROM EMPLOYEES E, JOBS J, DEPARTMENTS D, LOCATIONS L
WHERE E.SALARY >= 10000
AND E.JOB_ID = J.JOB_ID
AND E.DEPARTMENT_ID = D.DEPARTMENT_ID
AND D.LOCATION_ID = L.LOCATION_ID
ORDER BY E.EMPLOYEE_ID ASC;

