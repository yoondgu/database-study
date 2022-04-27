-- �μ����̺��� ��� �μ� ������ ��ȸ�ϱ�
SELECT * FROM DEPARTMENTS;

-- * ���̺��� ��� ������ ��ȸ�Ѵٰ� �ϴ��� �Ʒ��� ���� ��� �÷����� ��Ȯ�ϰ� �������. *�� ���� �� ��!
SELECT DEPARTMENT_ID, DEPARTMENT_NAME, MANAGER_ID, LOCATION_ID
FROM DEPARTMENTS;

-- �μ����̺��� ��ġ���̵� 1700���� �ƴ� �μ� ���� ��ȸ�ϱ�
SELECT DEPARTMENT_ID, DEPARTMENT_NAME, MANAGER_ID, LOCATION_ID
FROM DEPARTMENTS
WHERE LOCATION_ID != 1700; -- ����Ŭ ���������� != ��� <> ���� ���� �� �ִ�.

-- 100����� �����ϴ� �μ����� ��ȸ�ϱ�
SELECT DEPARTMENT_ID, DEPARTMENT_NAME, MANAGER_ID, LOCATION_ID
FROM DEPARTMENTS
WHERE MANAGER_ID = 100;

-- �μ����� 'IT'�� �μ��� ���� ��ȸ�ϱ�
SELECT DEPARTMENT_ID, DEPARTMENT_NAME, MANAGER_ID, LOCATION_ID
FROM DEPARTMENTS
WHERE DEPARTMENT_NAME = 'IT';

-- ��ġ���̵� 1700���� ������ �ּ�, �����ȣ, ���ø�, �����ڵ带 ��ȸ�ϱ�
SELECT STREET_ADDRESS, POSTAL_CODE, CITY, COUNTRY_ID
FROM LOCATIONS
WHERE LOCATION_ID = 1700;

-- �ּұ޿��� 2000�̻� 5000������ ������ �������̵�, ��������, �ּұ޿�, �ִ�޿� ��ȸ�ϱ�
SELECT JOB_ID, JOB_TITLE, MIN_SALARY, MAX_SALARY
FROM JOBS
WHERE MIN_SALARY BETWEEN 2000 AND 5000;

-- �ִ�޿��� 20000�� �ʰ��ϴ� ������ ���̵�, ��������, �ּұ޿�, �ִ�޿� ��ȸ�ϱ�
SELECT JOB_ID, JOB_TITLE, MIN_SALARY, MAX_SALARY
FROM JOBS
WHERE MAX_SALARY > 20000;

-- 100�������� �����ϴ� ����� ���̵�, �̸�, �μ����̵��� ��ȸ�ϱ�
SELECT EMPLOYEE_ID, FIRST_NAME, DEPARTMENT_ID
FROM EMPLOYEES
WHERE MANAGER_ID = 100;

-- 80�� �μ����� �ٹ��ϰ� �޿��� 8000 �̻� �޴� ����� ���̵�, �̸�, �޿�, Ŀ�̼�����Ʈ ��ȸ�ϱ�
SELECT EMPLOYEE_ID, FIRST_NAME, SALARY, COMMISSION_PCT
FROM EMPLOYEES
WHERE DEPARTMENT_ID = 80
AND SALARY >= 8000;

-- ������ SA_REP�̰�, Ŀ�̼�����Ʈ�� 0.25�̻��� ����� ���̵�, �̸�, �޿�, Ŀ�̼�����Ʈ�� ��ȸ�ϱ�
SELECT EMPLOYEE_ID, FIRST_NAME, SALARY, COMMISSION_PCT
FROM EMPLOYEES
WHERE JOB_ID = 'SA_REP' 
AND COMMISSION_PCT >= 0.25;

-- 80�� �μ��� �ٹ��ϰ�, �޿��� 7000�̻��̰�, Ŀ�̼��� �޴� ����� ���̵�, �̸�, �޿�, ������ ��ȸ�ϱ�
-- ���� = (�޿� + �޿�xĿ�̼�)x12��
SELECT EMPLOYEE_ID, FIRST_NAME, SALARY, (SALARY+SALARY*COMMISSION_PCT)*12 ANNUAL_SALARY
FROM EMPLOYEES
WHERE DEPARTMENT_ID = 80
AND SALARY >= 7000
AND COMMISSION_PCT IS NOT NULL;

-- 80�� �μ��� �ٹ��ϰ�, 147�� �������� �����ϴ� ��� �߿��� Ŀ�̼��� 0.1�� ����� ������̵�, �̸�, ����, �޿�, Ŀ�̼�����Ʈ�� ��ȸ�ϱ�
SELECT EMPLOYEE_ID, FIRST_NAME, JOB_ID, SALARY, COMMISSION_PCT
FROM EMPLOYEES
WHERE DEPARTMENT_ID = 80
AND MANAGER_ID = 147
AND COMMISSION_PCT = 0.1;

-- ������� �����ϴ� ������ �ߺ����� ��ȸ�ϱ�
SELECT DISTINCT JOB_ID
FROM EMPLOYEES;

-- ������� �Ҽӵ� �μ����̵� ��� ��ȸ�ϱ�
SELECT DISTINCT DEPARTMENT_ID
FROM EMPLOYEES
WHERE DEPARTMENT_ID IS NOT NULL;