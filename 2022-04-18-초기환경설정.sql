alter session set "_ORACLE_SCRIPT" = true;

-- ������ �������� ����ڸ� ���� ����� 
-- ����ڸ� : hr
-- ��й�ȣ : zxcv1234
create user hr identified by zxcv1234;

-- ������ �������� hr ����ڿ��� ������ �ο��� (�� : ������ ���� �� ���� ��)
-- connect : DBMS�� ������ �� �ִ� ����
-- resource : DBMS���� ���� �ڿ��� ����� �� �ִ� ����(�����ͺ��̽� ��ü ����, ����, ������ ����������.)
-- dba : �����ͺ��̽� ������ ����
grant connect, resource, dba to hr;
-- ����ڸ� 'hr ����'���� db ������ �������� 