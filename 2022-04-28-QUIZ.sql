-- Ŀ�̼��� �޴� ��� ������ ���̵�, �̸�, �������̵�, �ҼӺμ����� ��ȸ�ϱ�
SELECT E.EMPLOYEE_ID, E.FIRST_NAME, E.JOB_ID, D.DEPARTMENT_NAME
FROM EMPLOYEES E, DEPARTMENTS D
WHERE E.COMMISSION_PCT IS NOT NULL
AND E.DEPARTMENT_ID = D.DEPARTMENT_ID (+)
ORDER BY E.EMPLOYEE_ID;

-- 30, 60, 90�� �μ��� �Ҽӵ� ������ �߿��� 100�����ڿ��� �����ϴ� ������ ���̵�, �̸�, �ҼӺμ����� ��ȸ�ϱ�
SELECT E.EMPLOYEE_ID, E.FIRST_NAME, D.DEPARTMENT_NAME
FROM EMPLOYEES E, DEPARTMENTS D
WHERE E.DEPARTMENT_ID IN (30, 60, 90)
AND E.MANAGER_ID = 100
AND E.DEPARTMENT_ID = D.DEPARTMENT_ID
ORDER BY E.EMPLOYEE_ID;

-- 2006�⿡ �Ի��� �������� ���� �Ի��� ���� ��ȸ�ϱ�
SELECT TO_CHAR(HIRE_DATE, 'MM') MONTH, COUNT(*) HIRED_CNT
FROM EMPLOYEES
WHERE HIRE_DATE >= '2006-01-01' AND HIRE_DATE < '2007-01-01' -- TO_CHAR�� ��� ��������� �ϳ��� �� �Լ��� �����ϱ⺸�ٴ�, �� �״�� ���͸��� �� �ֵ��� �Ѵ�.
-- WHERE�������� ���׿��� �Լ� ������ �ϸ� ������ ���� ��������.
GROUP BY TO_CHAR(HIRE_DATE,'MM')
ORDER BY MONTH;

-- ��� �������� ���̵�, �̸�, �Ի���, �Ի��� ���� �ٹ� ������, �������� ���ʽ��� ��ȸ�ϱ�
-- �ٹ������� ���� 3�������� ���ʽ��� 1000�޷��� �����Ѵ�.
SELECT EMPLOYEE_ID, FIRST_NAME, HIRE_DATE,
        TRUNC(MONTHS_BETWEEN(SYSDATE, HIRE_DATE)) MONTHS,
        TRUNC(TRUNC(MONTHS_BETWEEN(SYSDATE, HIRE_DATE))/3)*1000 BONUS
FROM EMPLOYEES
ORDER BY EMPLOYEE_ID;

-- 50�� �μ��� �ٹ����� �������� ���̵�, �̸�, �޿�, �޿� ��ް� ���ʽ��� ��ȸ�ϱ�
-- ���ʽ��� A���: �޿��� 10%, B���: �޿��� 15%, C���: �޿��� 20%, D���: �޿��� 30%, E���: �޿��� 50%�� �����Ѵ�.
SELECT E.EMPLOYEE_ID, E.FIRST_NAME, E.SALARY, S.GRADE,
        E.SALARY*DECODE(S.GRADE, 'A', 0.1, 'B', 0.15, 'C', 0.2, 'D', 0.3, 'E', 0.5) BONUS
FROM EMPLOYEES E, SALARY_GRADE S
WHERE E.DEPARTMENT_ID = 50
AND E.SALARY >= S.MIN_SALARY AND E.SALARY <= S.MAX_SALARY
ORDER BY E.EMPLOYEE_ID;

-- 'Europe' �� �������� �ΰ� �ִ� �μ��� ���̵�, �μ���, ������ ���ø� ��ȸ�ϱ�
SELECT D.DEPARTMENT_ID, D.DEPARTMENT_NAME, L.CITY
FROM DEPARTMENTS D, LOCATIONS L, COUNTRIES C, REGIONS R
WHERE R.REGION_NAME = 'Europe'
AND R.REGION_ID = C.REGION_ID
AND C.COUNTRY_ID = L.COUNTRY_ID
AND L.LOCATION_ID = D.LOCATION_ID
ORDER BY DEPARTMENT_ID;

-- �����ں� ������� �������� ��, �����ϴ� ������� 5�� �̻��� �������� ���̵�, �̸�, ������� ��ȸ�ϱ�
SELECT MNG.EMPLOYEE_ID, MNG.FIRST_NAME, COUNT(*) EMP_CNT
FROM EMPLOYEES EMP, EMPLOYEES MNG
WHERE EMP.MANAGER_ID IS NOT NULL
AND MNG.EMPLOYEE_ID = EMP.MANAGER_ID
GROUP BY MNG.EMPLOYEE_ID, MNG.FIRST_NAME
HAVING COUNT(*) >= 5
ORDER BY MNG.EMPLOYEE_ID;

-- �������� ������ ���� ���������ε� ����������, �Ϲ������δ� ������������ �������� Ǯ�⸦ ���Ѵ�. �׷��� ���������� �� �����ϰ� �۾��Ǵ� ��쵵 ���� ��.
SELECT M.EMPLOYEE_ID, M.FIRST_NAME,  X.EMP_CNT
FROM (SELECT MANAGER_ID, COUNT(*) EMP_CNT
          FROM EMPLOYEES
          GROUP BY MANAGER_ID
          HAVING COUNT(*) >= 5) X, EMPLOYEES M -- �����ں� ������� ���� �����ϰ�, �ش� �����ڵ鿡 ���� ������������ �����Ѵ�.
WHERE X.MANAGER_ID = M.EMPLOYEE_ID;

-- 'ST_CLERK'�ٹ��ϴٰ� �ٸ� �������� ������ ������ ���̵�, �̸�, ������ �ٹ��ߴ� �μ���, ���� �������̵�, ���� �ٹ����� �μ����� ��ȸ�ϱ�
-- JOB_HISTORY �̿��ϼ���
SELECT E.EMPLOYEE_ID, E.FIRST_NAME, OD.DEPARTMENT_NAME PREVIOUS_DEPT_NAME, E.JOB_ID CURRENT_JOB_ID, CD.DEPARTMENT_NAME CURRENT_DEPT_NAME
FROM EMPLOYEES E, JOB_HISTORY JH, DEPARTMENTS CD, DEPARTMENTS OD
WHERE JH.JOB_ID = 'ST_CLERK'
AND JH.EMPLOYEE_ID =E.EMPLOYEE_ID
AND JH.DEPARTMENT_ID = OD.DEPARTMENT_ID
AND E.DEPARTMENT_ID = CD.DEPARTMENT_ID
ORDER BY EMPLOYEE_ID;

-- �μ��� ��ձ޿��� ��ȸ���� �� ��ձ޿��� 10000�̻��� �μ��� ���̵�, �μ���, �μ��� ��ձ޿��� ��ȸ�ϱ�
SELECT D.DEPARTMENT_ID, D.DEPARTMENT_NAME, TRUNC(AVG(E.SALARY)) SAL_AVG
FROM EMPLOYEES E, DEPARTMENTS D
WHERE E.DEPARTMENT IS NOT NULL -- ���� �ĺ��� ���δ�.
AND E.DEPARTMENT_ID = D.DEPARTMENT_ID
GROUP BY D.DEPARTMENT_ID, D.DEPARTMENT_NAME -- DEPARTMENT_NAME�� ��ȸ�ϱ� ���� GROUP BY�� �ִ´�.
HAVING TRUNC(AVG(E.SALARY)) >= 10000
ORDER BY D.DEPARTMENT_ID;

-- �������� ���� �ٹ����� �μ��� ���絵�ú� ������� ��ȸ�ϱ�
SELECT L.CITY, COUNT(*)
FROM EMPLOYEES E, DEPARTMENTS D, LOCATIONS L
WHERE E.DEPARTMENT_ID = D.DEPARTMENT_ID
AND D.LOCATION_ID = L.LOCATION_ID
GROUP BY L.CITY
ORDER BY L.CITY;
