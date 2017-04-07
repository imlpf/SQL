--oracle数据类型 : 
    number : 
 
        number(5,2);--一共5位数字,其中有两位是小数;
        number(5);--就是规定有五位数字,没有小数 默认是number(5,0);
    
    char : 
 
        --查询快,但是浪费空间
        char:定长,2000字符(4000字节),字符串char(5);--可以设置5可 但是内容必须是 '内容',用单引号括起来
 
    varchar2 : 
 
        varchar2:变长,4000字符(8000字节);
        varchar2(20 byte);--规定能写20个字符 但是只能是byte类型(字节型),但是内容必须是 '内容',用单引号括起来
 
    clob : 
 
        clob(characterlarge object);--字符型大对象,最大4G
 
    date : 
 
        date;--时间格式,values()赋值的时候,可以用这个更改格式 : to_date('20-2-81','DD-MON-RR');

		
select * from emp;
select empno, ename, job from emp;
select empno 编号, ename 姓名, job 工作 from emp;
select job from emp;
select distinct job from emp;
select distinct empno, job from emp;
说明:因为雇员编号不重复, 所以此时证明所有的列没有重复,所以不能消除掉重复的列.
--查询出雇员的编号, 姓名, 工作, 但是显示的格式:编号是: 7369 的雇员, 姓名是: smith, 工作是: clear
select '编号是: ' || empno || '的雇员, 姓名是: ' || ename || ', 工作是: ' || job from emp;
--求出每个雇员的姓名及年薪
select ename, sal * 12 income from emp;

--条件查询
--求出工资大于 1500 的所有雇员信息
select * from emp where sal > 1500;
--查询每月可以得到奖金的雇员信息
select * from emp where comm is not null;
--查询没有奖金的雇员信息
select * from emp where comm is null;
--查询出基本工资大于 1500 同时可以领取奖金的雇员信息
select * from emp where sal > 1500 and comm is not null;
--查询出基本工资大于 1500 或者可以领取奖金的雇员信息
select * from emp where sal > 1500 or comm is not null;
--查询基本工资大于等于 1500, 但是小于等于 3000 的全部雇员信息
select * from emp where sal >= 1500 and sal <= 3000;
select * from emp where sal between 1500 and 3000;

--查询出在 1981 年雇佣的全部雇员信息(1981 年 1 月 1 日 到 1981 年 12 月 31 日之间的雇佣的雇员)
select * from emp where hiredate between '1-1月-81' and '31-12月-81';
--要求查询出姓名是 smith 的雇员信息
select * from emp where ename = 'SMITH';
--要求查询出雇员是 7369, 7499, 7521 的雇员的具体信息
select * from emp where empno = 7369 or empno = 7499 or empno = 7521;
select * from emp where empno in(7369, 7499, 7521);
--要求查询出雇员不是 7369, 7499, 7521 的雇员的具体信息
select * from emp where empno not in(7369, 7499, 7521);
--要求查询出姓名是 smith, allen, king 的雇员信息
select * from emp where ename in('SMITH', 'ALLEN', 'KING');

-- 模糊查询
--查询出所有雇员姓名中第二个字母包含 "M" 的雇员信息
select * from emp where ename like '_M%';
--查询出雇员姓名中包含字母 M 的雇员信息
select * from emp where ename like '%M%';
--要求查询出在 1981 年雇佣的雇员信息
select * from emp where hiredate like '%81%';
--查询工资中包含 5 的雇员信息
select * from emp where sal like '%5%';
--查询雇员编号不是 7369 的雇员信息
select * from emp where empno != 7369;
select * from emp where empno <> 7369;

--排序
--要求按照工资由低到高排序
select * frm emp order by sal;
select * from emp order by sal asc;
--要求按照工资由高到低排序
select * from emp order by sal desc;
--要求查询出 20 部门的所有雇员信息, 查询的信息按照工资由高到低排序,如果工资相等,则按照雇佣日期由早到晚排序.
select * from emp where deptno = 20 order by sal desc, hiredate asc;

--聚合函数
select count(ename) from emp;
select min(sal) from emp;
select max(sal) from emp;
select sum(sal) from emp;
select avg(sal) from emp;
select sum(sal) from emp where deptno = 20;
select avg(sal) from emp where deptno = 20;
--求出每个部门的雇员数量
select deptno, count(deptno) from emp group by deptno;
select deptno, count(empno) from emp group by deptno;
--求出每个部门的平均工资
select deptno, avg(sal) from emp group by deptno;
--要求显示出平均工资大于 2000 的部门编号和平均工资
select deptno, avg(sal) from emp group by deptno having avg(sal) > 2000;

--字符串操作
--将小写字母变为大写字母
select upper('hello') from dual;
--将大写字母变为小写字母
select lower('HELLO WORLD') from dual;
--要求查询出姓名是 smith 的雇员信息
select * from emp where ename = upper('smith');
--使用 initcap() 函数将单词的第一个字母大写
select initcap('hello world') from dual;
--将雇员表中的雇员姓名变为开头字母大写
select initcap(ename) from emp;
--将字符串 "hello" 和 "world" 进行串联
select concat('hello ', 'world') from dual;
--对字符串进行操作的常用字符处理函数
select substr('hello', 1, 3) 截取字符串, length('hello') 字符串的长度, replace('hello', 'l', 'x') 字符串替换 from dual;
select substr('hello', 0, 3) 截取字符串, length('hello') 字符串的长度, replace('hello', 'l', 'x') 字符串替换 from dual;
--显示所有雇员的姓名及姓名的后三个字符
select ename, substr(ename, length(ename) -2) from emp;
select ename, substr(ename, -3, 3) from emp;

--数值操作
--使用数值函数执行四舍五入操作
select round(789.536) from dual;
--要求将 789.536 数值保留两位小数
select round(789.536, 2) from dual;
--要求将 789.536 数值中的整数的十位进行四舍五入进位
select round(789.536, -2) from dual;
--采用 trunc() 函数不会保留任何小数,而且小数点也不会执行四舍五入的操作
select round(789.536, -2) from dual;
--通过 trunc() 也可以指定小数点的保留位数
select trunc(789.536, 2) from dual;
--作用负数表示位数
select trunc(789.536, -2) from dual;
--使用 mod() 函数可以进行取余的操作
select mod(10, 3) from dual;



--日期函数
months_between(): 求出给定日期范围的月数
add_months(): 在指定的日期上加上指定的月数, 求出之后的日期
next_day(): 指定日期的下一个日期
last_day(): 求出给定日期当月的最后一天日期
 
select empno, ename, months_between(sysdate, hiredate) from emp;
select empno, ename, round(months_between(sysdate, hiredate)) from emp;
select sysdate, add_months(sysdate, 4) from dual;
select next_day(sysdate, '星期一') from dual;
select last_day(sysdate) from dual;


--转换函数
to_char(): 转换成字符串
to_number(): 转换成数字
to_date(): 转换成日期
--查询所有雇员的雇员编号, 姓名, 雇佣日期
select empno, 
ename,
to_char(hiredate, 'yyyy') year,
to_char(hiredate, 'mm') months,
to_char(hiredate, 'dd') day
from emp;
select empno, ename, to_char(hiredate, 'yyyy-mm-dd') from emp;
select empno, ename, to_char(hiredate, 'fmyyyy-mm-dd') from emp;
--查询所有雇员的编号, 姓名和工资
select empno, ename, sal from emp;
select empno, ename, to_char(sal, '99,999') from emp;
select empno, ename, to_char(sal, '$99,999') from emp;
select to_number('123') + to_number('123') from dual;
--将一个字符串转换成日期类型
select to_date('2009-01-01', 'yyyy-mm-dd') from dual;
--求出每个雇员的年薪(要求加上奖金)
select empno, ename, sal, comm, (sal + comm) * 12 from emp;
select empno, ename, sal, comm, nvl(comm, 0), (sal + nvl(comm, 0)) * 12 income from emp;
--decode() 函数类似于 if....elsif...else 语句
select decode(1, 1, '内容是 1', 2, '内容是 2', 3, '内容是 3') from dual;
--查询出雇员的编号, 姓名, 雇佣日期及工作, 要求将雇员的工作替换成以下信息:
select empno 雇员编号, 
ename 雇员姓名, 
hiredate 雇佣日期, 
decode(job, 
'CLERK', '业务员', 
'SALESMAN', '销售人员',
'MANAGER', '经理',
'ANALYST', '分析员',
'PRESIDENT', '总裁'
) 职位
from emp;


--笛卡尔积(交差连接)
select * from emp, dept;
--内连接
select * from emp e, dept d where e.deptno = d.deptno;

--左外连接
select empno, ename, d.deptno, dname, loc from emp e, dept d where e.deptno = d.deptno(+);

--右外连接
select empno, ename, d.deptno, dname, loc from emp e, dept d where e.deptno(+) = d.deptno;


--求出每个部门的最低工资的雇员的信息
select * from emp where sal in(select min(sal) from emp group by deptno);
--union 操作符返回两个查询选定的所有不重复的行
select deptno from emp union select deptno from dept;
--union all 操作符合并两个查询选定的所有行，包括重复的行
select deptno from emp union all select deptno from dept;
--intersect 操作符只返回两个查询都有的行
select deptno from emp intersect select deptno from dept;
--minus 操作符只返回由第一个查询选定但是没有被第二个查询选定的行, 也就是在第一个查询结果中排除在第二个查询结果中出现的行
select deptno from dept minus select deptno from emp;