-- ������ ��ȸ�ϱ�
-- �Ʒ� �� ���� ��츦 �� �����ؼ� ��ȸ�� ���� �ڵ带 �ۼ��ؾ� �Ѵ�.
-- ��ȸ����� ���ų� �� �ุ ��ȸ�Ǵ� ���
-- * Primary Key�� ������ �÷��� ��ȸ�������� �̿�Ǵ� ���
-- * Unique�� ������ �÷��� ��ȸ�������� �̿�Ǵ� ���

-- * �ڹٿ��� �� ��(��ȯŸ���� ������ �� Ȥ�� null) ��ȯ�ȴ�.
-- ��ǰ���̺��� ��ǰ��ȣ(Primary key)�� ��ȸ�ϱ�
-- public Product getProduct(int productNo) { ... }
-- ������̺��� ������̵�(Primary key)�� ��ȸ�ϱ�
-- public Employee getEmployee(int employeeId) { ... }
-- �������̺��� �������̵�(Primary key)�� ��ȸ�ϱ�
-- public Job getJob(String jobId) { ... }
-- ������̺��� �̸���(Unique)�� ��ȸ�ϱ�
-- public Employee getEmployeeByEmail(String email) { ... }

-- ��ȸ����� ���ų� ���� ���� ��ȸ�Ǵ� ���
-- * Primary key, Unique�� ������ �÷��� �ƴ� �ٸ� �÷��� ��ȸ�������� �̿�Ǵ� ���

-- * �ڹٿ��� ���� ��(�ݷ��ǰ�ü) ��ȯ�ȴ�.
-- ��ǰ ���̺��� ��ǰ �̸����� ��ȸ�ϱ�
-- public List<Product> getProductByName(String name) { ... }
-- ��� ���̺��� �޿��� ��ȸ�ϱ�
-- public List<Employee> getEmployeeBySalary(double salary) { ... }
-- ������̺��� �ҼӺμ����̵�� ��ȸ�ϱ�
-- public List<Employee> getEmployeeByDepartmentId(int departmentId) { ... }