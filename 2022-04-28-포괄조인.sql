----------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------
-- �������� (Outer ����)
-- ���̺��� �������� �� ����Ǵ� ���� ���� ������ ���ο� ������ �� �ְ� �ϴ� ����
-- ���� ������ �ʿ� (+)�� ���δ�.
-- (+)��ȣ�� ����Ǵ� ��� ���� ���� �൵ ���ο� ������ �� �ֵ��� ��� ���̺� NULL���� �߰��Ѵ�.
----------------------------------------------------------------------------------------------------------------------------
-- �μ����̵�, �μ���, �μ������� ���̵�, �μ������� �̸��� ��ȸ�ϱ�
-- �����(D.MANAGER_ID = E.EMPLOYEE_ID)���� MANAGER_ID�� NULL�� ��鵵 �����ϱ� ���Ͽ�,
-- NULL�̶� ��𿡵� ������ �� ���� ��� ���̺��� �Ӽ�����(EMPLOYEE_ID)�� NULL�� �� ���� ������ ��ȸ����� �߰��ؼ� ��ġ�� ���̴�.
SELECT D.DEPARTMENT_ID, D.DEPARTMENT_NAME, D.MANAGER_ID, E.FIRST_NAME MANAGER_NAME
FROM DEPARTMENTS D, EMPLOYEES E
WHERE D.MANAGER_ID = E.EMPLOYEE_ID(+)
ORDER BY D.DEPARTMENT_ID;

-- �������̵� 'SA_REP'�̰� �޿��� 5000 �̻� 7000 ���Ϸ� �޴� ������ ���̵�, �̸�, �޿�, �ҼӺμ����� ��ȸ�ϱ�
SELECT E.EMPLOYEE_ID, E.FIRST_NAME, E.SALARY, D.DEPARTMENT_ID, D.DEPARTMENT_NAME
FROM EMPLOYEES E, DEPARTMENTS D
WHERE E.JOB_ID = 'SA_REP'
AND E.SALARY >= 5000 AND E.SALARY <= 7000
AND E.DEPARTMENT_ID = D.DEPARTMENT_ID (+) -- D.DEPARTMENT_ID �ʿ� ������ ���� ���� �� (+)�� ���δ�.
                                          -- E���� D.DEPARTMENT_ID�� �ܷ�Ű�� ���µ�, �� ��� NULL�� ��쵵 �����Ϸ��� D���� (+)�� ���δ�.
ORDER BY E.EMPLOYEE_ID;

-- �������̵� 'SA_REP'�̰� �޿��� 5000 �̻� 7000 ���Ϸ� �޴� ������ ���̵�, �̸�, �޿�, �ҼӺμ���,�μ� ������ �ּҸ� ��ȸ�ϱ�
SELECT E.EMPLOYEE_ID, E.FIRST_NAME, E.SALARY, D.DEPARTMENT_NAME, L.STREET_ADDRESS
FROM EMPLOYEES E, DEPARTMENTS D, LOCATIONS L
WHERE E.JOB_ID = 'SA_REP'
AND E.SALARY >= 5000 AND E.SALARY <= 7000
AND E.DEPARTMENT_ID = D.DEPARTMENT_ID (+)
AND D.LOCATION_ID = L.LOCATION_ID (+)
ORDER BY E.EMPLOYEE_ID;