----------------------------------------------------------------------------------------------------------------------------
-- �� ����
-- ���� �����ڸ� ������� �ʰ� �����Ѵ�.
-- �ַ� ������ ������ �ִ� ����� �����Ͽ� ��ȸ�� �� ����Ѵ�.
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

-- �޿��� 10000 �̻��� �������� ���� ���̵�, �̸�, �޿�, �޿���� ��ȸ�ϱ�
-- �޿��� ���� ��ȸ������ �޿���ް� �¾ƶ������� �ʴ´�.
-- ��ġ�ϴ� ���� �ƴ϶�, ���� ������ �����ϴ� ����� ��ȸ�� ���̴�. �� ��� �������� Ȱ���Ѵ�.
-- E                                E      E    E       S
SELECT E.EMPLOYEE_ID, E.FIRST_NAME, E.SALARY, S.GRADE
FROM EMPLOYEES E, SALARY_GRADE S
WHERE E.SALARY >= 10000
AND E.SALARY >= S.MIN_SALARY AND E.SALARY <= S.MAX_SALARY -- �� ��������
ORDER BY E.EMPLOYEE_ID;

-- �޿� ����� 'C'�� 'D' ��޿� ���ϴ� �������� ���̵�, �̸�, �޿�, �޿������ ��ȸ�ϱ�
SELECT E.EMPLOYEE_ID, E.FIRST_NAME, E.SALARY, S.GRADE
FROM EMPLOYEES E, SALARY_GRADE S
WHERE E.SALARY >= S.MIN_SALARY AND E.SALARY <= S.MAX_SALARY  -- �� ��������
AND S.GRADE IN ('C', 'D')
ORDER BY E.EMPLOYEE_ID;

-- �μ������ڰ� ������ �μ����̵�, �μ���, �����ڸ�, �޿�, �޿������ ��ȸ�ϱ�
--                        D       D       E       E       S
SELECT D.DEPARTMENT_ID, D.DEPARTMENT_NAME, E.FIRST_NAME, E.SALARY, S.GRADE
FROM DEPARTMENTS D, EMPLOYEES E, SALARY_GRADE S
WHERE D.MANAGER_ID IS NOT NULL -- �� ��쿡�� ���� �ʾƵ� ��ȸ����� ������, ���ο� �����ϴ� �� ���� ��ü�� �ٿ��ش�.
AND D.MANAGER_ID = E.EMPLOYEE_ID -- �����ڸ��� �� �� �ִ� � �������� (D, E)
AND  E.SALARY >= S.MIN_SALARY AND E.SALARY <= S.MAX_SALARY -- �������� �޿������ �� �� �ִ� �� �������� (E, S)
ORDER BY D.DEPARTMENT_ID;


-- ���� ���̵�, ���� �����޿�, ���������޿��� ���, ���� �ְ�޿�, ���� �ְ�޿��� ��� ***(���� ���̺� ���� �� ����ϱ�)
--      J           J               S1               J               S2
-- �޿� ������̺��� 2�� �ʿ��ϴ�. (�����޿�, �ְ�޿��� ������ �� ����� ���� ���̺� 2��.)
SELECT J.JOB_ID, J.MIN_SALARY, S1.GRADE MIN_GRADE, J.MAX_SALARY, S2.GRADE MAX_GRADE
FROM JOBS J, SALARY_GRADE S1, SALARY_GRADE S2
WHERE (J.MIN_SALARY >= S1.MIN_SALARY AND J.MIN_SALARY <= S1.MAX_SALARY)
AND (J.MAX_SALARY >= S2.MIN_SALARY AND J.MAX_SALARY <= S2.MAX_SALARY)
ORDER BY J.JOB_ID;
