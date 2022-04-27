----------------------------------------------------------------------------------------------------------------------------
-- ����
-- 2�� �̻��� ���̺��� �����ؼ� �����͸� ��ȸ�ϴ� ��
-- FROM���� ������ ���̺���� �����Ѵ�.
-- WHERE���� ���������� �����Ѵ�.
-- * ���������� �ּ� ���� = ������ ���̺� �� - 1 

-- SELECT ���̺�1.�÷���, ���̺�1.�÷���, ���̺�2.�÷���, ���̺�2.�÷���
-- FROM ���̺�1, ���̺�2
-- WHERE ���̺�1.�÷��� = ���̺�2.�÷���;

-- SELECT ��Ī1.�÷���, ��Ī1.�÷���, ��Ī2.�÷���, ��Ī2.�÷���
-- FROM ���̺�1 ��Ī1, ���̺�2 ��Ī2
-- WHERE ��Ī1.�÷��� = ��Ī2.�÷���;

-- SELECT ��Ī1.�÷���, ��Ī1.�÷���, ��Ī2.�÷���, ��Ī2.�÷���, ��Ī3.�÷���
-- FROM ���̺�1 ��Ī1, ���̺�2 ��Ī2, ���̺�3 ��Ī3
-- WHERE ��Ī1.�÷��� = ��Ī2.�÷���
-- AND ��Ī1.�÷��� = ��Ī3.�÷���;


-- SELECT ��Ī1.�÷���, ��Ī1.�÷���, ��Ī2.�÷���, ��Ī2.�÷���, ��Ī3.�÷���
-- FROM ���̺�1 ��Ī1, ���̺�2 ��Ī2, ���̺�3 ��Ī3
-- WHERE ��Ī1.�÷��� = ��Ī2.�÷���
-- AND ��Ī1.�÷��� = ��Ī3.�÷���;

-- SELECT ��Ī1.�÷���, ��Ī1.�÷���, ��Ī2.�÷���, ��Ī2.�÷���, ��Ī3.�÷���
-- FROM ���̺�1 ��Ī1, ���̺�2 ��Ī2, ���̺�3 ��Ī3
-- WHERE ��Ī1.�÷��� = ��Ī2.�÷���
-- AND ��Ī2.�÷��� = ��Ī3.�÷���;

----------------------------------------------------------------------------------------------------------------------------

-- �����
-- �����ϴ� ���̺��� Ư�� �÷����� ���� ���� �ͳ��� �����ؼ� ���ϴ� �����͸� ��ȸ�ϴ� ��

-- �������̵�, �����̸�, �ҼӺμ����̵�, �ҼӺμ��� ��ȸ�ϱ�
-- ��� ���̺��� �Ӽ����� �����غ���
-- EMPLOYEES, EMPLOYEES, EMPLOYEES,
--                      DEPARTMENTS, DEPARTMENTS
--                      �ҼӺμ����̵� ���� ��츦 ���������� ����
SELECT E.EMPLOYEE_ID, E.FIRST_NAME, E.DEPARTMENT_ID, D.DEPARTMENT_NAME
FROM EMPLOYEES E, DEPARTMENTS D --����
WHERE E.DEPARTMENT_ID = D.DEPARTMENT_ID --��������
ORDER BY E.EMPLOYEE_ID; 

-- �޿��� 10000 �̻� �޴� ������ ���̵�, �̸�, �������̵�, ��������, �����޿�, �ְ�޿�, �޿��� ��ȸ�ϱ�
--                      EMPLOYEES  EMPLOYEES  EMPLOYEES
--                                            JOBS     JOBS   JOBS   JOBS   EMPLOYEES  
SELECT E.EMPLOYEE_ID, E.FIRST_NAME, E.JOB_ID, J.JOB_TITLE, J.MAX_SALARY, J.MIN_SALARY, E.SALARY
FROM EMPLOYEES E, JOBS J    
WHERE E.SALARY >= 10000 -- �˻�����
AND E.JOB_ID = J.JOB_ID -- ��������
ORDER BY E.EMPLOYEE_ID;

-- �޿��� 10000 �̻� �޴� ������ ���̵�, �̸�, �޿�, �ҼӺμ����� ��ȸ�ϱ�
-- �������̺��� DEPARTMENT_ID�� �ش� ������ �Ҽӵ� �μ��� ���̵��.
-- �������̺��� DEPARTMENT_ID�� �μ����̺��� DEPARTMENT_ID�� ���� ���� ������ �ִ� �ೢ�� �����ϸ�(�����ϸ�)
-- �ش� ������ ������ �� ������ �Ҽӵ� �μ������� ����ȴ�.
-- ���ε� �࿡�� ��������, �μ������� ���� �����Ƿ�, �࿡�� �ʿ��� �÷��� ��ȸ�Ѵ�.
SELECT E.EMPLOYEE_ID, E.FIRST_NAME, E.SALARY, D.DEPARTMENT_NAME
FROM EMPLOYEES E, DEPARTMENTS D
WHERE E.SALARY >= 10000 -- �˻�����
AND E.DEPARTMENT_ID = D.DEPARTMENT_ID
ORDER BY E.EMPLOYEE_ID; -- ��������

-- �μ� �������� ���̵� NULL�� �ƴ� �μ��� �μ����̵�, �μ���, �����ھ��̵�, ������ �̸��� ��ȸ�ϱ�
-- �μ����̺��� MANAGER_ID�� �ش� �μ��� �������� ���̵��.
-- �μ����̺��� MANAGER_ID�� �������̺��� EMPLOYEE_ID�� ���� ���� ������ �ִ� �ೢ�� �����ϸ�(�����ϸ�)
-- �ش� �μ��� ������ �μ��� �������� ������ ������ ����ȴ�.
-- ���ε� �࿡�� ��������, �μ������� ���� �����Ƿ�, �࿡�� �ʿ��� �÷��� ��ȸ�Ѵ�.
SELECT DEPT.DEPARTMENT_ID, DEPT.DEPARTMENT_NAME, DEPT.MANAGER_ID, EMP.FIRST_NAME
FROM DEPARTMENTS DEPT, EMPLOYEES EMP
WHERE DEPT.MANAGER_ID IS NOT NULL -- �˻�����
AND DEPT.MANAGER_ID = EMP.EMPLOYEE_ID -- ��������
ORDER BY DEPT.DEPARTMENT_ID;

-- �μ� ���̵�, �μ���, �μ� ������ ���ø�, �μ� ������ �ּ� ��ȸ�ϱ�
-- DEPARTMENT  DEPARTMENTS   LOCATIONS  LOCATIONS
-- �μ����̺��� �μ����� ������ ������ ����Ǿ� �ִ�.
-- �μ����̺�� ���������̺��� LOCATION_ID�� ���� ���� ������ �ִ� �ೢ�� �����ϸ�
-- �μ������� �� �μ��� ��ġ�� ������ ������ ������ �ϳ��� ������ ����ȴ�.
-- ����� �࿡�� �ʿ��� ������ ��ȸ�Ѵ�.
SELECT DEPT.DEPARTMENT_ID, DEPT.DEPARTMENT_NAME, LOC.CITY, LOC.STREET_ADDRESS
FROM DEPARTMENTS DEPT, LOCATIONS LOC -- ��������
WHERE DEPT.LOCATION_ID = LOC.LOCATION_ID;