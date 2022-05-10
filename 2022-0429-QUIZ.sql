-- ������ �߿��� ���� ���� �޿��� �޴� ������ ���̵�, �̸�, �޿�, �޿������ ��ȸ�ϱ�
SELECT E.EMPLOYEE_ID, E.FIRST_NAME, E.SALARY, S.GRADE
FROM EMPLOYEES E, SALARY_GRADE S
WHERE E.SALARY >= S.MIN_SALARY AND E.SALARY <= S.MAX_SALARY
AND E.SALARY = (SELECT MAX(SALARY)      -- �׷��Լ��� SELECT ������������ ���� ���� ��ȯ�޾ƾ� �Ѵ�.
                FROM EMPLOYEES);

-- 50�� �μ����� �ٹ����̰�, 50�� �μ��� ���� �޿��� �޴� ������ ���̵�, �̸�, �޿��� ��ȸ�ϱ�
SELECT EMPLOYEE_ID, FIRST_NAME, SALARY
FROM EMPLOYEES
WHERE DEPARTMENT_ID = 50
AND SALARY = (SELECT MIN(SALARY) -- ������ ��������
             FROM EMPLOYEES
             WHERE DEPARTMENT_ID = 50);

-- ��ü �������� ��ձ޿����� �޿��� ���� �޴� �������� ���̵�, �̸�, �޿��� ��ȸ�ϱ�
SELECT EMPLOYEE_ID, FIRST_NAME, SALARY
FROM EMPLOYEES
WHERE SALARY < (SELECT AVG(SALARY) -- ������ ��������
                FROM EMPLOYEES);
            
-- �ڽ��� �����ڿ� ���� �ؿ� �Ի��� �������� ���̵�, �̸�, �Ի����� ��ȸ�ϱ�

SELECT E.EMPLOYEE_ID, E.FIRST_NAME, E.HIRE_DATE, M.HIRE_DATE
FROM EMPLOYEES E, EMPLOYEES M
WHERE E.MANAGER_ID = M.EMPLOYEE_ID -- �������� ���� �� ���� ����. ���� ������ ī��ǰ� �Ǿ������.
AND TO_CHAR(E.HIRE_DATE, 'YYYY') = TO_CHAR(M.HIRE_DATE, 'YYYY');
                                                  
-- ���� ���� ���������� �ۼ��Ѵٸ� �Ʒ��� ����.
SELECT EMPLOYEE_ID, FIRST_NAME, HIRE_DATE
FROM EMPLOYEES
WHERE (MANAGER_ID, TO_CHAR(HIRE_DATE,'YYYY')) IN (SELECT MGR.EMPLOYEE_ID, TO_CHAR(MGR.HIRE_DATE,'YYYY')
                                                  FROM EMPLOYEES EMP, EMPLOYEES MGR
                                                  WHERE EMP.MANAGER_ID = MGR.EMPLOYEE_ID);


-- �ڽ��� �����ڿ� �޿� ����� ���� ������ ���̵�, �̸��� ��ȸ�ϱ�***
SELECT E.EMPLOYEE_ID, E.FIRST_NAME
FROM EMPLOYEES E, EMPLOYEES M, SALARY_GRADE ES, SALARY_GRADE MS
WHERE E.MANAGER_ID = M.EMPLOYEE_ID
AND E.SALARY >= ES.MIN_SALARY AND E.SALARY <= ES.MAX_SALARY
AND M.SALARY >= MS.MIN_SALARY AND M.SALARY <= MS.MAX_SALARY
AND MS.GRADE = ES.GRADE
ORDER BY E.EMPLOYEE_ID;

-- ���������� �ۼ��� ��� : ���� �� �ʿ䰡 ��� ������, �ᱹ ��� ������ ���� �ȴ�.
SELECT E.EMPLOYEE_ID, E.FIRST_NAME
FROM EMPLOYEES E, SALARY_GRADE S
WHERE E.SALARY >= S.MIN_SALARY AND E.SALARY <= S.MAX_SALARY
AND (E.MANAGER_ID, S.GRADE) IN (SELECT M.EMPLOYEE_ID, S.GRADE                       
                               FROM EMPLOYEES E, EMPLOYEES M, SALARY_GRADE S            -- ***DEPARTMENTS�� MANAGER�� EMPLOYEES�� MANAGER�� �ƿ� �ǹ̰� �ٸ� �Ӽ��̴�. �μ��� �� ������ / ������ ���
                               WHERE E.MANAGER_ID = M.EMPLOYEE_ID
                               AND M.SALARY >= S.MIN_SALARY AND M.SALARY <= S.MAX_SALARY);

-- ��ü ������ ��ձ޿� ���� �޿��� ���� �޴� �������� ���̵�, �̸�, �޿�, �޿��� ��� �޿� ���� ���̸� ��ȸ�ϱ�

WITH SAL_AVG
AS (SELECT AVG(SALARY) AVG
    FROM EMPLOYEES)   
SELECT EMPLOYEE_ID, FIRST_NAME, SALARY, TRUNC(SALARY - AVG) SAL_GAP -- SELECT�������� ���������� ���� ���� ������ �ึ�� ����Ǿ� ��ȿ�����̴�.
FROM EMPLOYEES, SAL_AVG
WHERE SALARY > AVG; -- �� ��������

-- WITH���� ������� ���� ��� (��Į�� �������� : ��ȿ����)
SELECT EMPLOYEE_ID, FIRST_NAME, SALARY, TRUNC(SALARY - (SELECT AVG(SALARY) FROM EMPLOYEES)) SAL_GAP -- SELECT�������� ���������� ���� ���� ������ �ึ�� ����Ǿ� ��ȿ�����̴�.
FROM EMPLOYEES
WHERE SALARY > (SELECT AVG(SALARY)
                FROM EMPLOYEES);

-- ������ ����� ���� �߿��� ������ �ٹ��ߴ� �μ��� ���� �μ����� �ٹ��ϰ� �ִ� ������ ���̵�, �̸�, ���� �������̵�, �� �������̵�, �μ����� ��ȸ�ϱ�

SELECT E.EMPLOYEE_ID, E.FIRST_NAME, H.JOB_ID PREV_JOB, E.JOB_ID CURR_JOB, D.DEPARTMENT_NAME -- H�� �̷��� ���� �� �ִ� ������ ���� ��� ���� �� ��µȴ�.
FROM JOB_HISTORY H, EMPLOYEES E, DEPARTMENTS D
WHERE H.EMPLOYEE_ID = E.EMPLOYEE_ID    -- �������� (H�� E���� �������̵� ���� �ೢ�� ����)
AND H.DEPARTMENT_ID = E.DEPARTMENT_ID -- �˻����� (���� �μ����̵�� ���� �μ����̵� ������ �ุ ��ȸ)
AND H.DEPARTMENT_ID = D.DEPARTMENT_ID; -- �������� (H�� D���� �μ����̵� ���� �ೢ�� ����)