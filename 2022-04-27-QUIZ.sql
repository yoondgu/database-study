----------------------------------------------------------------------------------------------------------------------------
-- ����
----------------------------------------------------------------------------------------------------------------------------
-- �ý����� ���� ��¥�� �ð������� dual ���̺��� �̿��ؼ� ��ȸ�ϱ�
SELECT SYSDATE
FROM DUAL;

-- �ý����� ���� ��¥�� �ð����� �߿��� ��-��-�� ������ dual ���̺��� �̿��ؼ� ��ȸ�ϱ�
SELECT TO_CHAR(SYSDATE,'YYYY-MM-DD')
FROM DUAL;

-- �������� �޿��� 13% �λ����� �� ���� ���̵�, �̸�, �޿�, 13% �λ�� �޿�, �λ�� �޿��� ���� �޿��� ���̸� ��ȸ�ϱ�
-- * ��������� �Ҽ��� ���ϴ� ������.
SELECT EMPLOYEE_ID, FIRST_NAME, SALARY, TRUNC(SALARY*1.13) INCREASED_SAL, TRUNC(SALARY*0.13) DIFFERENCE
FROM EMPLOYEES
ORDER BY EMPLOYEE_ID;

-- 2007�⿡ �Ի��� �������� ���� ���̵�, �̸�, �Ի��� ��ȸ
SELECT EMPLOYEE_ID, FIRST_NAME, HIRE_DATE
FROM EMPLOYEES
WHERE TO_CHAR(HIRE_DATE,'YYYY') = 2007 
ORDER BY EMPLOYEE_ID;
--�Ǵ�
SELECT EMPLOYEE_ID, FIRST_NAME, HIRE_DATE
FROM EMPLOYEES
WHERE HIRE_DATE >= '2007-01-01' AND HIRE_DATE < '2008-01-01';

-- 2005�⿡ �Ի��� ������ �� Ŀ�̼��� �޴� �������� ���� ���̵�, �̸�, �Ի���, �޿�, ������ ��ȸ�ϱ�
-- * ���� = �޿�*12 + �޿�*Ŀ�̼�*12 
-- * ���� ������� ���� �ڸ��� �ݿø��Ѵ�.
SELECT EMPLOYEE_ID, FIRST_NAME,HIRE_DATE, SALARY, ROUND(SALARY*12 + SALARY*COMMISSION_PCT*12,0) ANNUAL_SALARY
FROM EMPLOYEES
WHERE HIRE_DATE >= '2005-01-01' AND HIRE_DATE < '2006-01-01'
AND COMMISSION_PCT IS NOT NULL
ORDER BY EMPLOYEE_ID;


-- case ~ when �� �̿��ؼ� �޿��� �������� �������� ����� ��ȸ�ϱ�
-- �޿��� 20000 �̻�: A, 15000 �̻� : B, 10000 �̻� : C, �� �ܴ� D����̴�.
-- ���� ���̵�, �̸�, �޿�, �޿������ ��ȸ�Ѵ�.
SELECT EMPLOYEE_ID, FIRST_NAME,
        CASE
        WHEN SALARY >= 20000 THEN 'A'
        WHEN SALARY >= 15000 THEN 'B'
        WHEN SALARY >= 10000 THEN 'C'
        ELSE 'D'
        END SALARY_GRADE
FROM EMPLOYEES
ORDER BY EMPLOYEE_ID;

-- 80�� �μ��� �ٹ��ϴ� �������� �������̵�, �̸�, �Ի���, �Ի��� ���� �ٹ��������� ��ȸ�Ѵ�.
-- �ٹ��������� �Ի��Ϸκ��� ���ñ����� ��������. �Ҽ������ϴ� ������.
-- �ٹ��������� �������� �������� �����Ѵ�.
SELECT EMPLOYEE_ID, FIRST_NAME, HIRE_DATE, TRUNC(MONTHS_BETWEEN(SYSDATE, HIRE_DATE)) MONTHS
FROM EMPLOYEES
WHERE DEPARTMENT_ID = 80
ORDER BY MONTHS DESC;

-- 100�� ������ �ڽ��� �Ŵ����� ������ ������ �߿��� Ŀ�̼��� �޴� �������� �������̵�, �̸�, �޿�, Ŀ�̼��� ��ȸ�ϱ�
SELECT EMPLOYEE_ID, FIRST_NAME, SALARY, COMMISSION_PCT
FROM EMPLOYEES
WHERE MANAGER_ID = 100
AND COMMISSION_PCT IS NOT NULL;

-- 100�� ������ �ڽ��� �Ŵ����� ������ ������ ���� ��ȸ�ϱ�
SELECT COUNT(*)
FROM EMPLOYEES
WHERE MANAGER_ID = 100;

-- 50�� �μ��� �ٹ��ϴ� �������� ���̵�, �̸�, �������̵�, ���������޿�, �����ְ�޿�, �����߰��޿�, �ش� ������ �޿��� �߰��޿��� ���� ��ȸ�ϱ�
-- �����߰��޿��� (�����ְ�޿�+���������޿�)/2 ��.
-- �޿����� �ڽ��� �޿����� �����߰��޿��� �� ���̴�.
SELECT E.EMPLOYEE_ID, E.FIRST_NAME, E.JOB_ID, J.MIN_SALARY, J.MAX_SALARY, E.SALARY,
        (J.MIN_SALARY+J.MAX_SALARY)/2 MED_SALARY,
        (J.MIN_SALARY+J.MAX_SALARY)/2 - E.SALARY DIFFERENCE
FROM EMPLOYEES E, JOBS J
WHERE E.DEPARTMENT_ID = 50
AND E.JOB_ID = J.JOB_ID
ORDER BY J.MAX_SALARY;