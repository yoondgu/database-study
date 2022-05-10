-- ��� ������ ���̵�, �̸�, �μ���ȣ, �μ����� ��ȸ�ϱ�(�μ����̵� NULL�� ��������)
SELECT E.EMPLOYEE_ID, E.FIRST_NAME, E.DEPARTMENT_ID, DEPARTMENT_NAME
FROM EMPLOYEES E, DEPARTMENTS D
WHERE E.DEPARTMENT_ID IS NOT NULL
AND E.DEPARTMENT_ID = D.DEPARTMENT_ID
ORDER BY EMPLOYEE_ID;

-- Ŀ�̼��� �޴� �������� ���̵�, �̸�, �μ���ȣ, �μ���, �޿������ ��ȸ�ϱ�
SELECT E.EMPLOYEE_ID, E.FIRST_NAME, E.DEPARTMENT_ID, D.DEPARTMENT_NAME, S.GRADE
FROM EMPLOYEES E, DEPARTMENTS D, SALARY_GRADE S
WHERE E.COMMISSION_PCT IS NOT NULL
AND E.DEPARTMENT_ID = D.DEPARTMENT_ID
AND E.SALARY >= S.MIN_SALARY AND E.SALARY <= S.MAX_SALARY
ORDER BY E.EMPLOYEE_ID;

-- ��� ������ �������̵�, �̸�, �� ������ ����̸�, �ҼӺμ��̸�, �ҼӺμ� ������ �̸� ��ȸ�ϱ�
--                 E1     E1          E2         D               D = E3
-- * EMPLOYEES�� MANAGER�� ������ ���, DEPARTMENTS�� MANAGER�� �μ��� �����ڷ� �ƿ� �ٸ� �ǹ��̴�.
SELECT E.EMPLOYEE_ID EMP_ID, E.FIRST_NAME EMP_NAME, EM.FIRST_NAME EMP_M_NAME, D.DEPARTMENT_NAME DEPT_NAME, DM.FIRST_NAME DEPT_M_NAME
FROM EMPLOYEES E, EMPLOYEES EM, EMPLOYEES DM, DEPARTMENTS D
WHERE E.MANAGER_ID = EM.EMPLOYEE_ID
AND E.DEPARTMENT_ID = D.DEPARTMENT_ID (+) -- �ҼӺμ��� ���� ��쿡 ���� ��������
AND D.MANAGER_ID = DM.EMPLOYEE_ID (+)
ORDER BY E.EMPLOYEE_ID;
-- * ������ �ּ��ΰ�? ���������� ����̸�, �μ��̸�, �������̸� �÷��� ���� ���� ����. ��� �� ���̺�� ���εǾ�� �Ѵ�. �ּ��ε�.

-- 80�� �μ��� ��ձ޿�, �����޿�, �ְ�޿��� ��ȸ�ϱ�
SELECT TRUNC(AVG(SALARY)), MIN(SALARY), MAX(SALARY) 
FROM EMPLOYEES
WHERE DEPARTMENT_ID = 80;

-- �� �μ��� �����޿��� �ְ�޿�, �� �� ������ ���̸� ��ȸ�ϱ�
SELECT MIN(SALARY) MIN_SAL, MAX(SALARY) MAX_SAL, MAX(SALARY) - MIN(SALARY) GAP_SAL
FROM EMPLOYEES
WHERE DEPARTMENT_ID IS NOT NULL -- ������ ������ DEPARTMENT�� NULL�� ��츦 �׷����� ���� ����Ѵ�.
GROUP BY DEPARTMENT_ID
ORDER BY DEPARTMENT_ID;

-- 100�� �������� �����ϴ� ������ ������� ��ȸ�ϱ�
SELECT COUNT(*)     -- ��׷쿡�� ��� ���� ������ ��ȯ�Ѵ�.
FROM EMPLOYEES
WHERE MANAGER_ID = 100; -- ���⼭ ��׷��� �� ��ü�̴�.

-- �μ��� �ְ�޿��� ��ȸ���� �� �ְ�޿��� 15000�� �Ѵ� �μ��� ���̵�� �ְ�޿��� ��ȸ�ϱ�
-- * �ְ�޿� 15000 �̻��� �׷��Լ� �������� ���� ���������̴�. (WITH�Լ��� WHERE���� �������� �� ����.)
SELECT DEPARTMENT_ID, MAX(SALARY)
FROM EMPLOYEES
WHERE DEPARTMENT_ID IS NOT NULL
GROUP BY DEPARTMENT_ID
HAVING MAX(SALARY) > 15000;

-- �������� �����ϴ� �������� ��ȸ�ϰ�, �������� �������� �����ؼ� ��ȸ�ϱ�
SELECT JOB_ID, COUNT(*)
FROM EMPLOYEES
GROUP BY JOB_ID
ORDER BY COUNT(*);

-- first_name�� 'Neena'�� �������� ���� ���� �޿��� �޴� ������ ���̵�, �̸�, �޿��� ��ȸ�ϱ�
SELECT EMPLOYEE_ID, FIRST_NAME, SALARY
FROM EMPLOYEES
WHERE SALARY > (SELECT SALARY
                FROM EMPLOYEES
                WHERE FIRST_NAME = 'Neena')
ORDER BY EMPLOYEE_ID;

-- 200�� ������ ���� �μ����� �ٹ��ϴ� ������ ���̵�, �̸�, �޿��� ��ȸ�ϱ�
SELECT EMPLOYEE_ID, FIRST_NAME, SALARY
FROM EMPLOYEES
WHERE DEPARTMENT_ID = (SELECT DEPARTMENT_ID
                       FROM EMPLOYEES
                       WHERE EMPLOYEE_ID = 200)
ORDER BY EMPLOYEE_ID;

-- ������ ��ձ޿��� ������� �� ��ձ޿��� ���� ���� ������ ��ձ޿��� ��ȸ�ϱ�
WITH AVERAGES
AS (SELECT JOB_ID, AVG(SALARY) AVG
      FROM EMPLOYEES
      GROUP BY JOB_ID)
SELECT JOB_ID, AVG
FROM AVERAGES
WHERE AVG = (SELECT MIN(AVG)
            FROM AVERAGES);

-- ������ ��ձ޿��� ������� �� ��ձ޿��� ���� ���� ������ ���̵�, ��������, �� ������ �����޿�, �� ������ �ִ�޿��� ��ȸ�ϱ�
WITH AVERAGES
    AS (SELECT JOB_ID, AVG(SALARY) AVG
       FROM EMPLOYEES
       GROUP BY JOB_ID)
SELECT A.JOB_ID, J.JOB_TITLE, J.MIN_SALARY, J.MAX_SALARY
FROM AVERAGES A, JOBS J
WHERE A.AVG = (SELECT MIN(AVG)
            FROM AVERAGES)
AND A.JOB_ID = J.JOB_ID;

-- �޿��� ��ü ������ ��ձ޿����� ���� �޴� ������ ���̵�, �̸�, �޿��� ��ȸ�ϱ�
SELECT EMPLOYEE_ID, FIRST_NAME, SALARY
FROM EMPLOYEES
WHERE SALARY > (SELECT AVG(SALARY)
                FROM EMPLOYEES)
ORDER BY EMPLOYEE_ID;

--  'Neena'�� ���� �ؿ� �Ի��� ������ ���̵�, �̸�, �Ի����� ��ȸ�ϱ�
SELECT EMPLOYEE_ID, FIRST_NAME, HIRE_DATE
FROM EMPLOYEES
WHERE TO_CHAR(HIRE_DATE, 'YYYY') = (SELECT TO_CHAR(HIRE_DATE, 'YYYY')
                                    FROM EMPLOYEES
                                    WHERE FIRST_NAME = 'Neena')
ORDER BY EMPLOYEE_ID;

-- �μ��� ��ձ޿��� ������� �� Ismael�� �ٹ��ϴ� �μ��� ��ձ޿����� �޿��� ���� �޴� �μ��� ���̵�� ��ձ޿��� ��ȸ�ϱ�
WITH AVERAGES
    AS (SELECT DEPARTMENT_ID, AVG(SALARY) AVG
        FROM EMPLOYEES
        WHERE DEPARTMENT_ID IS NOT NULL
        GROUP BY DEPARTMENT_ID)
SELECT A.DEPARTMENT_ID, TRUNC(A.AVG) AVERAGE
FROM AVERAGES A, AVERAGES I, EMPLOYEES E
WHERE E.FIRST_NAME = 'Ismael'
AND E.DEPARTMENT_ID = I.DEPARTMENT_ID
AND A.AVG > I.AVG;

-- ���� ���̺��� �޿��� �������� �޿� ����� ��ȸ���� ��, �޿���޺� �������� ��ȸ�ϱ�
SELECT Y.GRADE, NVL(GRADE_CNT,0)
FROM (SELECT S.GRADE, COUNT(*) GRADE_CNT
      FROM EMPLOYEES E, SALARY_GRADE S
      WHERE E.SALARY >= S.MIN_SALARY AND E.SALARY <= S.MAX_SALARY
      GROUP BY S.GRADE) X, SALARY_GRADE Y
WHERE X.GRADE (+) = Y.GRADE
ORDER BY Y.GRADE;

-- �������� �ٹ��ϴ� �μ��� ���絵�ÿ� �� ���ÿ��� �ٹ��ϴ� �������� ��ȸ�ϱ�
SELECT L.CITY, COUNT(*) CITY_CNT
FROM EMPLOYEES E, DEPARTMENTS D, LOCATIONS L
WHERE E.DEPARTMENT_ID = D.DEPARTMENT_ID
AND D.LOCATION_ID = L.LOCATION_ID
GROUP BY L.CITY 
ORDER BY L.CITY;

-- ���� ���� ������ �Ի��� �ؿ� �� �ؿ� �Ի��� �������� ��ȸ�ϱ�
WITH COUNTS
    AS (SELECT TO_CHAR(HIRE_DATE, 'YYYY') HIRE_YEAR, COUNT(*) CNT
        FROM EMPLOYEES
        GROUP BY TO_CHAR(HIRE_DATE, 'YYYY'))
SELECT HIRE_YEAR, CNT
FROM COUNTS
WHERE CNT = (SELECT MIN(CNT)
            FROM COUNTS);

-- �����ں� �������� ��ȸ���� �� �������� 10���� �Ѵ� ������ ���̵�� �������� ��ȸ�ϱ�
SELECT MANAGER_ID, COUNT(*) EMP_CNT
FROM EMPLOYEES
WHERE MANAGER_ID IS NOT NULL
GROUP BY MANAGER_ID
HAVING COUNT(*) > 10
ORDER BY MANAGER_ID;

-- �μ��� ��ձ޿��� ��ȸ���� �� �� �μ��� ��ձ޿����� ���� �޿��� ���� ������ �̸�, �޿�, �μ����� ��ȸ�ϱ� (�μ�������� �����ϱ�)
SELECT E.FIRST_NAME, E.SALARY, E.DEPARTMENT_ID
FROM (SELECT DEPARTMENT_ID, TRUNC(AVG(SALARY)) AVG
      FROM EMPLOYEES
      WHERE DEPARTMENT_ID IS NOT NULL
      GROUP BY DEPARTMENT_ID) A, EMPLOYEES E
WHERE E.DEPARTMENT_ID = A.DEPARTMENT_ID
AND E.SALARY < A.AVG
ORDER BY E.DEPARTMENT_ID;

-- employees ���̺��� �������� ��� �������̵� ��ȸ�ϱ�
SELECT DISTINCT JOB_ID
FROM EMPLOYEES
ORDER BY JOB_ID;

-- �޿��� 12,000�޷� �̻� �޴� ������ �̸��� �޿��� ��ȸ�ϱ�
SELECT EMPLOYEE_ID, SALARY
FROM EMPLOYEES
WHERE SALARY >= 12000
ORDER BY EMPLOYEE_ID;

-- ������ȣ�� 176�� ������ ���̵�� �̸� ������ ��ȸ�ϱ�
SELECT EMPLOYEE_ID, FIRST_NAME, JOB_ID
FROM EMPLOYEES
WHERE EMPLOYEE_ID = 176;

-- �޿��� 12,000�޷� �̻� 15,000�޷� ���� �޴� �������� ���� ���̵�� �̸��� �޿��� ��ȸ�ϱ�
SELECT EMPLOYEE_ID, FIRST_NAME, SALARY
FROM EMPLOYEES
WHERE SALARY BETWEEN 12000 AND 15000
ORDER BY EMPLOYEE_ID;

-- 2005�� 1�� 1�Ϻ��� 2000�� 6�� 30�� ���̿� �Ի��� ������ ���̵�, �̸�, �������̵�, �Ի����� ��ȸ�ϱ�
SELECT EMPLOYEE_ID, FIRST_NAME, JOB_ID, HIRE_DATE
FROM EMPLOYEES
WHERE HIRE_DATE BETWEEN '2000-06-30' AND '2005-01-01'  
ORDER BY HIRE_DATE;

-- �޿��� 5,000�޷��� 12,000�޷� �����̰�, �μ���ȣ�� 20 �Ǵ� 50�� ������ �̸��� �޿��� ��ȸ�ϱ�
SELECT FIRST_NAME, SALARY
FROM EMPLOYEES
WHERE SALARY BETWEEN 5000 AND 12000
AND DEPARTMENT_ID IN (20, 50)
ORDER BY EMPLOYEE_ID;

-- �����ڰ� ���� ������ �̸��� �������̵� ��ȸ�ϱ�
SELECT FIRST_NAME, JOB_ID
FROM EMPLOYEES
WHERE MANAGER_ID IS NULL;

-- Ŀ�̼��� �޴� ��� ������ �̸��� �޿�, Ŀ�̼��� ��ȸ�ϰ�,  �޿� �� Ŀ�̼��� ������������ �����ؼ� ��ȸ�ϱ�
SELECT FIRST_NAME, SALARY, COMMISSION_PCT
FROM EMPLOYEES
WHERE COMMISSION_PCT IS NOT NULL
ORDER BY SALARY DESC, COMMISSION_PCT DESC;

-- �̸��� 2��° ���ڰ� 'e'�� ��� ������ �̸��� ��ȸ�ϱ�
SELECT FIRST_NAME
FROM EMPLOYEES
WHERE FIRST_NAME LIKE '_e%';

-- �������̵� 'ST_CLERK' �Ǵ� 'SA_REP'�̰� �޿��� 2500, 3500, 7,000 �޴� ��� ������ �̸��� �������̵�, �޿��� ��ȸ�ϱ�
SELECT FIRST_NAME, JOB_ID, SALARY
FROM EMPLOYEES
WHERE JOB_ID IN ('ST_CLERK', 'SA_REP')
AND SALARY IN (2500, 3500, 7000)
ORDER BY EMPLOYEE_ID;

-- ��� ������ �̸��� �Ի���, �ٹ� ���� ���� ����Ͽ� ��ȸ�ϱ�, �ٹ����� ���� ������ �ݿø��ϰ�, �ٹ��������� �������� ������������ �����ϱ�
SELECT FIRST_NAME, HIRE_DATE, TRUNC(MONTHS_BETWEEN(SYSDATE, HIRE_DATE)) WORK_MONTHS
FROM EMPLOYEES
ORDER BY WORK_MONTHS;

-- ������ �̸��� Ŀ�̼��� ��ȸ�ϱ�, Ŀ�̼��� ���� �ʴ� ������ '����'���� ǥ���ϱ�
SELECT FIRST_NAME, NVL(TO_CHAR(COMMISSION_PCT,'0.99'), '����')
FROM EMPLOYEES;

-- ��� ������ �̸�, �μ���ȣ, �μ��̸��� ��ȸ�ϱ�
SELECT E.FIRST_NAME, D.DEPARTMENT_ID, D.DEPARTMENT_NAME
FROM EMPLOYEES E, DEPARTMENTS D
WHERE E.DEPARTMENT_ID = D.DEPARTMENT_ID
ORDER BY E.EMPLOYEE_ID;

-- EMPLOYEES ���̺��� ������ �̸��� �޿��� ǥ���ϰ�, �޿��� ���ؼ� #�� ǥ���ϱ�. '#'�ϳ��� �޿� 1000�� �ش��Ѵ�.
-- ��¿���
-- ȫ�浿 4300 ####
-- ������ 8700 ########
-- ������ 6500 ######
SELECT FIRST_NAME, SALARY, RPAD('#',TRUNC(SALARY/1000),'#') SALARY#
FROM EMPLOYEES
ORDER BY EMPLOYEE_ID;

-- EMPLOYEES ���̺��� 2006�� ��ݱ⿡ �Ի��� �������� �������̵�, �̸�, �Ի���, ������ ����ϱ�. ������ �޿�12 + �޿�Ŀ�̼�*12��.
SELECT EMPLOYEE_ID, FIRST_NAME, HIRE_DATE, TRUNC((SALARY+NVL(COMMISSION_PCT,0))*12) ANNUAL_SAL
FROM EMPLOYEES
WHERE HIRE_DATE BETWEEN '2006-01-01' AND '2006-06-30'
ORDER BY EMPLOYEE_ID;

-- 80���μ��� �Ҽӵ� ������ �̸��� �������̵�, ��������, �μ��̸��� ��ȸ�ϱ�
SELECT E.FIRST_NAME, E.JOB_ID, J.JOB_TITLE, D.DEPARTMENT_NAME
FROM EMPLOYEES E, JOBS J, DEPARTMENTS D
WHERE E.DEPARTMENT_ID = 80
AND E.JOB_ID = J.JOB_ID
AND E.DEPARTMENT_ID = D.DEPARTMENT_ID
ORDER BY EMPLOYEE_ID;

-- Ŀ�̼��� �޴� ��� ������ �̸��� �������̵�, ��������, �μ��̸�, �μ������� ���ø��� ��ȸ�ϱ�
SELECT E.FIRST_NAME, J.JOB_ID, J.JOB_TITLE, D.DEPARTMENT_NAME, L.CITY 
FROM EMPLOYEES E, JOBS J, DEPARTMENTS D, LOCATIONS L
WHERE COMMISSION_PCT IS NOT NULL
AND E.JOB_ID = J.JOB_ID
AND E.DEPARTMENT_ID = D.DEPARTMENT_ID
AND D.LOCATION_ID = L.LOCATION_ID
ORDER BY EMPLOYEE_ID;

-- 'Europe'�� �������� �ΰ� �ִ� ��� �μ����̵�� �μ��̸��� ��ȸ�ϱ�
SELECT D.DEPARTMENT_ID, D.DEPARTMENT_NAME
FROM DEPARTMENTS D, LOCATIONS L, COUNTRIES C, REGIONS R
WHERE R.REGION_NAME = 'Europe'
AND C.REGION_ID = R.REGION_ID
AND L.COUNTRY_ID = C.COUNTRY_ID
AND D.LOCATION_ID = L.LOCATION_ID;

-- ������ �̸��� �ҼӺμ���, �޿�, �޿� ����� ��ȸ�ϱ�
SELECT E.FIRST_NAME, D.DEPARTMENT_NAME, E.SALARY, S.GRADE
FROM EMPLOYEES E, DEPARTMENTS D, SALARY_GRADE S
WHERE E.DEPARTMENT_ID = D.DEPARTMENT_ID (+)
AND E.SALARY BETWEEN S.MIN_SALARY AND S.MAX_SALARY
ORDER BY DEPARTMENT_NAME;

-- ������ �̸��� �ҼӺμ���, �ҼӺμ��� �����ڸ��� ��ȸ�ϱ�, �ҼӺμ��� ���� ������ �ҼӺμ��� '����', �����ڸ� '����'���� ǥ���ϱ�
SELECT EMP.FIRST_NAME, NVL(D.DEPARTMENT_NAME, '����') DEPT_NAME, NVL(MNG.FIRST_NAME, '����') DEPT_MNG_NAME
FROM EMPLOYEES EMP, EMPLOYEES MNG, DEPARTMENTS D
WHERE EMP.DEPARTMENT_ID = D.DEPARTMENT_ID (+)
AND D.MANAGER_ID = MNG.EMPLOYEE_ID (+)
ORDER BY EMP.FIRST_NAME;

-- ��� ������ �޿� �ְ��, �޿� ������, �޿� �Ѿ�, �޿� ��վ��� ��ȸ�ϱ�
SELECT MAX(SALARY), MIN(SALARY), SUM(SALARY), TRUNC(AVG(SALARY))
FROM EMPLOYEES;

-- ������ �޿� �ְ��, �޿� ������, �޿� �Ѿ�, �޿� ��վ��� ��ȸ�ϱ�
SELECT JOB_ID, MAX(SALARY), MIN(SALARY), SUM(SALARY), TRUNC(AVG(SALARY))
FROM EMPLOYEES
GROUP BY JOB_ID
ORDER BY JOB_ID;

-- �� ������ �������� ��ȸ�ؼ� ���� �������� ���� ���� 3���� ��ȸ�ϱ�, �������̵�� ������ ǥ���ϱ�
SELECT JOB_ID, CNT
FROM (SELECT JOB_ID, COUNT(*) CNT
      FROM EMPLOYEES
      GROUP BY JOB_ID
      ORDER BY CNT DESC)
WHERE ROWNUM IN (1,2,3)
ORDER BY ROWNUM;

-- �����ں� �������� ��ȸ�ϱ�, ������ �̸��� �� �����ڰ� �����ϴ� ������ ǥ���ϱ�
SELECT M.FIRST_NAME, COUNT(*) CNT
FROM EMPLOYEES E, EMPLOYEES M
WHERE E.MANAGER_ID IS NOT NULL
AND E.MANAGER_ID = M.EMPLOYEE_ID
GROUP BY M.FIRST_NAME
ORDER BY CNT;

-- �� �μ��� ���� �μ��̸�, ������ �̸�, �Ҽ����� ��, �Ҽ��������� ��� �޿��� ��ȸ�ϱ�
SELECT D.DEPARTMENT_NAME, M.FIRST_NAME MNG_NAME, COUNT(*) EMP_CNT, TRUNC(AVG(E.SALARY)) EMP_SAL_AVG
FROM EMPLOYEES E, DEPARTMENTS D, EMPLOYEES M
WHERE E.DEPARTMENT_ID IS NOT NULL
AND E.DEPARTMENT_ID = D.DEPARTMENT_ID
AND D.MANAGER_ID = M.EMPLOYEE_ID
GROUP BY D.DEPARTMENT_NAME, M.FIRST_NAME
ORDER BY D.DEPARTMENT_NAME;

-- first_name�� 'Steven'�� ������ ���� �μ��� ���� ������ �̸��� �Ի����� ��ȸ�ϱ�
SELECT FIRST_NAME, HIRE_DATE
FROM EMPLOYEES
WHERE DEPARTMENT_ID IN (SELECT DEPARTMENT_ID
                       FROM EMPLOYEES
                       WHERE FIRST_NAME = 'Steven')
ORDER BY HIRE_DATE;

-- �Ҽ� �μ��� ��ձ޿����� ���� �޿��� �޴� ������ ���̵�� �����̸�, �޿�, �� �μ��� ��� �޿��� ��ȸ�ϱ�
SELECT E.EMPLOYEE_ID, E.FIRST_NAME, E.SALARY, A.AVG 
FROM (SELECT DEPARTMENT_ID, TRUNC(AVG(SALARY)) AVG
      FROM EMPLOYEES
      GROUP BY DEPARTMENT_ID) A, EMPLOYEES E
WHERE E.DEPARTMENT_ID IS NOT NULL
AND E.DEPARTMENT_ID = A.DEPARTMENT_ID
AND E.SALARY > A.AVG
ORDER BY E.EMPLOYEE_ID;

-- first_name�� 'Kochhar'�� ������ ������ �޿��� �޴� ��� ������ �̸�, �Ի���, �޿��� ��ȸ�ϱ�, ����� Kochhar�� ���Խ�Ű�� �ʱ�
SELECT E.LAST_NAME, E.HIRE_DATE, E.SALARY
FROM EMPLOYEES E, EMPLOYEES K
WHERE K.LAST_NAME = 'Kochhar'
AND E.LAST_NAME != 'Kochhar'
AND E.SALARY IN K.SALARY;
-- * first_name�� 'Korchhar'�� ������ �������� ����.

-- �Ҽ� �μ��� �Ի����� ������, �� ���� �޿��� �޴� ������ �̸��� �ҼӺμ���, �޿��� ��ȸ�ϱ�
SELECT DISTINCT E1.FIRST_NAME, D.DEPARTMENT_NAME, E1.SALARY
FROM EMPLOYEES E1, EMPLOYEES E2, DEPARTMENTS D
WHERE E1.DEPARTMENT_ID = E2.DEPARTMENT_ID
AND E1.HIRE_DATE > E2.HIRE_DATE
AND E1.SALARY > E2.SALARY
AND D.DEPARTMENT_ID = E1.DEPARTMENT_ID
ORDER BY D.DEPARTMENT_NAME;

-- ������ ���̵�, �����ڸ�, �� �����ڰ� �����ϴ� ������, �� �����ڰ� �Ҽӵ� �μ��� ��ȸ�ϱ�
SELECT M.EMPLOYEE_ID, M.FIRST_NAME, COUNT(*) EMP_CNT, M.DEPARTMENT_ID 
FROM EMPLOYEES M, EMPLOYEES E
WHERE M.EMPLOYEE_ID = E.MANAGER_ID
GROUP BY M.EMPLOYEE_ID, M.FIRST_NAME, M.DEPARTMENT_ID
ORDER BY M.DEPARTMENT_ID, M.EMPLOYEE_ID;