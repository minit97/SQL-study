 /************************************************
         서브쿼리 실습 - 가장 높은 sal을 받는 직원 정보
 *************************************************/

-- 가장 높은 sal을 받는 직원정보
select * from hr.emp where sal = (select max(sal) from hr.emp);

-- 조인
select a.* 
from hr.emp a
	join (select max(sal) as sal from hr.emp) b
on a.sal = b.sal;

-- Analytic SQL
select * from
(
select *,
	row_number() over (order by sal desc) as rnum
from hr.emp
) a where rnum = 1;


/************************************************
     서브쿼리 실습 - 부서별로 가장 높은 sal을 받는 직원 정보
 *************************************************/
-- 부서별로 가장 높은 sal을 받는 직원 상세 정보. 비상관 서브쿼리
select * from hr.emp where (deptno, sal) in (select deptno, max(sal) as sal from hr.emp group by deptno) order by empno;

-- 상관서브쿼리 
select * from hr.emp a
where sal = (select max(sal) as sal from hr.emp x 
             where x.deptno = a.deptno)
order by empno;

-- Analytic SQL
select * from
(
select *,
	row_number() over (partition by deptno order by sal desc) as rnum
from hr.emp
) a where rnum = 1 
order by empno;