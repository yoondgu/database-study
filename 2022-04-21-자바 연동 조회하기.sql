-- 데이터 조회하기
-- 아래 두 가지 경우를 꼭 구분해서 조회를 위한 코드를 작성해야 한다.
-- 조회결과가 없거나 한 행만 조회되는 경우
-- * Primary Key로 설정된 컬럼이 조회조건으로 이용되는 경우
-- * Unique로 설정된 컬럼이 조회조건으로 이용되는 경우

-- * 자바에서 한 건(반환타입의 단일한 값 혹은 null) 반환된다.
-- 상품테이블에서 상품번호(Primary key)로 조회하기
-- public Product getProduct(int productNo) { ... }
-- 사원테이블에서 사원아이디(Primary key)로 조회하기
-- public Employee getEmployee(int employeeId) { ... }
-- 직종테이블에서 직종아이디(Primary key)로 조회하기
-- public Job getJob(String jobId) { ... }
-- 사원테이블에서 이메일(Unique)로 조회하기
-- public Employee getEmployeeByEmail(String email) { ... }

-- 조회결과가 없거나 여러 행이 조회되는 경우
-- * Primary key, Unique로 설정된 컬럼이 아닌 다른 컬럼이 조회조건으로 이용되는 경우

-- * 자바에서 여러 건(콜렉션객체) 반환된다.
-- 상품 테이블에서 상품 이름으로 조회하기
-- public List<Product> getProductByName(String name) { ... }
-- 사원 테이블에서 급여로 조회하기
-- public List<Employee> getEmployeeBySalary(double salary) { ... }
-- 사원테이블에서 소속부서아이디로 조회하기
-- public List<Employee> getEmployeeByDepartmentId(int departmentId) { ... }