--使用select into 为变量赋值
declare   
avg_sal number(8,2);
begin 
  dbms_output.put_line('avg_sal is: '||avg_sal);
  select avg(sal) into avg_sal from emp;
    dbms_output.put_line('avg_sal is: '||avg_sal);
end;
/
--if then 语句
declare
  var_num  number;
  var_name emp.ename%type := '&ename';
begin
  select count(*) into var_num from emp where ename = var_name;
  if var_num >= 1 then
    dbms_output.put_line('there exists: ' || var_name);
  end if;
end;
/
select * from emp;
/
--if-then-else 语句
declare
  var_num  number;
  var_name emp.ename%type := '&ename';
begin
  select count(*) into var_num from emp where ename = var_name;
  if var_num >= 1 then
    dbms_output.put_line('there exists: ' || var_name);
    else
      dbms_output.put_line('the '||var_name||' does not  exists! ');
  end if;
end;
/
--elsif
create or replace procedure plus(sales number) as
  bonus number := 0;
begin
  if sales > 5000 then
    bonus := 1500;
  elsif sales > 3500 then
    bonus := 500;
  else
    bonus := 100;
  end if;
  dbms_output.put_line('Sal = ' || sales || ' , bonus = ' || bonus || '.');
end plus;
/
begin
  plus(5000);
  plus(1000);
  end;
/
---嵌套elsif  
declare
  var_num  number;
  var_name emp.ename%type := '&ename';
begin
  select count(*) into var_num from emp where ename = var_name;
  if var_num >= 1 then
    dbms_output.put_line('there exists: ' || var_name);
    if var_name='SMITH' then
    dbms_output.put_line('SMITH is found');
    else
    dbms_output.put_line('Where is SMITH?');
    end if;
    else
      dbms_output.put_line('the '||var_name||' does not  exists! ');
  end if;
end;
/
--搜索式case语句
declare
  v_num number := &var_num;
begin
  if v_num >= 0 and v_num < 101 then
    case
      when v_num >= 90 then
        dbms_output.put_line('exellent');
      when v_num >= 70 then
        dbms_output.put_line('good');
      when v_num >= 60 then
        dbms_output.put_line('so bad!');
      else
        dbms_output.put_line('so so bad!');
    end case;
  else
    dbms_output.put_line('no such mark');
  end if;
end;
/
--loop 循环
declare
  var_num number := 0;
begin
  loop
    dbms_output.put_line('var_num is: ' || to_char(var_num));
    var_num := var_num + 2;
    exit when var_num > 12;
  end loop;
  dbms_output.put_line('last car_num is ' || to_char(var_num));
end;

--while 循环
declare
  var_num number := 0;
begin
  while var_num < 12 loop
    dbms_output.put_line('var_num is: ' || to_char(var_num));
    var_num := var_num + 2;
  end loop;
  dbms_output.put_line('last car_num is ' || to_char(var_num));
end;
/
--在循环体中嵌入if条件语句
declare
  var_num number := 0;
begin
  while var_num < 12 loop
    dbms_output.put_line('var_num is: ' || to_char(var_num));
    if var_num = 8 then
      exit;
    end if;
    var_num := var_num + 2;
  end loop;
  dbms_output.put_line('last car_num is ' || to_char(var_num));
end;
/
--使用exit when 语句结束循环
declare
  var_num number := 0;
begin
  while var_num < 12 loop
    dbms_output.put_line('var_num is: ' || to_char(var_num));
    exit when var_num = 8;
    var_num := var_num + 2;
  end loop;
  dbms_output.put_line('last car_num is ' || to_char(var_num));
end;
/
--使用for循环
begin
  for i in 1 .. 5 loop
    dbms_output.put_line(to_char(i));
  end loop;
end;
/
--使用游标for循环
begin
  for i in (select ename, sal, deptno from emp where sal > 2500) loop
    dbms_output.put_line(i.ename || ' salary is:' || i.sal || ' and in ' ||
                         i.deptno);
  end loop;
end;
/
--continue 语句
declare
  var_num number := 10;
begin
  loop
    var_num := var_num - 1;
    if var_num > 5 then
      dbms_output.put_line('var_num is: ' || to_char(var_num) ||
                           ' in continue...');
      continue;
    end if;
    if var_num = 0 then
      dbms_output.put_line('end... ');
      exit;
    end if;
    dbms_output.put_line('var_num is ' || to_char(var_num));
  end loop;
end;
/
--continue when 语句
declare
  var_num number := 10;
begin
  loop
    var_num := var_num - 1;
    dbms_output.put_line('var_num is: ' || to_char(var_num) ||
                         '  in continue...');
    continue when var_num > 5;
    if var_num = 0 then
      dbms_output.put_line('end... ');
      exit;
    end if;
    dbms_output.put_line('var_num is ' || to_char(var_num) ||
                         ' out continue');
  end loop;
end;
/
--应用null语句
declare
  var_name emp.ename%type;
  var_empno emp.empno%type:=&empno;
begin
  select ename,empno into var_name,var_empno from emp where empno =var_empno;
  if  var_name='SMITH' then 
    dbms_output.put_line('find data');
     dbms_output.put_line('var_name:  '||var_name);
     dbms_output.put_line('var_empno:  '||var_empno);
else 
  null;
  end if;
end;
/
--在存储过程中创建游标
create or replace procedure cursortest is
  var_ename varchar2(20);
  var_job   varchar2(9);
  var_sal   number(7, 2);
  cursor cselectemp is
    select ename, job, sal from emp;
begin
  open cselectemp;
  loop
    fetch cselectemp
      into var_ename, var_job, var_sal;
    exit when cselectemp%notfound;
    dbms_output.put_line('var_ename is' || var_ename || ' var_job is' ||
                         var_job || var_job || ' var_sal is' || var_sal);
  end loop;
  close cselectemp;
end;
/
begin
  cursortest;
end;
/
--隐式游标 没有声明的游标
create or replace procedure hidencursortest is
  jobnumber number;
  cursor cselectemp is
    select ename, job, sal from emp;
begin
  select count(distinct(job)) into jobnumber from emp;
  dbms_output.put_line('there are ' || jobnumber || ' different jobs');
  dbms_output.put_line('hiden cursor rowcount is  ' || SQL%rowcount);
  for emp_record in cselectemp loop
    dbms_output.put_line('var_ename is' || emp_record.ename ||
                         ' var_job is' || emp_record.job || ' var_sal is' ||
                         emp_record.sal);
  end loop;
end;
/
begin
  hidencursortest;
end;
/
--sql%notfound属性
declare
  var_sum    number;
  var_deotno emp.deptno%type := &deptno;
begin
  select count(*) into var_sum from emp where deptno = var_deotno;
  if sql%notfound then
    dbms_output.put_line('No date found');
  else
    dbms_output.put_line('sum is: ' || var_sum);
  end if;
end;
/
--通过异常处理no_data_found
declare
  var_ename  emp.ename%type;
  var_empno emp.empno%type := &empno;
begin
  select ename into var_ename from emp where empno = var_empno;
  exception
    when no_data_found then 
    dbms_output.put_line('No date found');
end;
/
--for游标不需要声明变量，也不需要显示打开游标关闭游标，都是自动执行的

--游标表达式
select deptno,dname,loc,cursor(select empno,ename,sal from emp where deptno=d.deptno)
from dept d;
select * from dept;
select * from emp;
/
--使用嵌套游标
declare
  type var_cur_type is ref cursor;
  var_cur   var_cur_type;
  var_dname dept.dname%type;
  var_ename emp.ename%type;
  cursor cur is
    select dname,
           cursor (select e.ename from emp e where e.deptno = d.deptno)
      from dept d
     where dname like 'R%';
begin
  open cur;
  loop
    fetch cur
      into var_dname, var_cur;
    exit when cur%notfound;
    dbms_output.put_line('dept_name: ' || var_dname);
    loop
      fetch var_cur
        into var_ename;
      exit when var_cur%notfound;
      dbms_output.put_line('emp_name: ' || var_ename);
    end loop;
  end loop;
  close cur;
end;
/
--使用嵌套查询实现嵌套游标功能
select ename from emp where deptno in (select deptno from dept where dname like 'R%')

/*动态游标，即ref游标，它是一个记录的集合，oracle允许在不同的程序单元之间传递游标引用。
可以在存储过程中定义ref游标，这样就可以在需要的时候使用该游标，从而不必在需要游标的时候都显式定义。
若要使用ref游标，首先需要声明它为一个type，然后再创建一个实例*/
CREATE OR REPLACE PROCEDURE refcursortest IS
  TYPE ty_emprefcur IS REF CURSOR; --声明ref游标为一个type
  empcursor ty_emprefcur; --创建该类型的一个实例
  rec_emp   emp%rowtype;
  rec_sal   emp.sal%TYPE;
  rec_job   emp.JOB%TYPE;
BEGIN
  OPEN empcursor FOR --使用ref游标
    SELECT * FROM emp;
  fetch empcursor
    INTO rec_emp;
  dbms_output.put_line('ename is  ' || rec_emp.ename);
  CLOSE empcursor;

  OPEN empcursor FOR --使用ref游标
    SELECT sal FROM emp;
  fetch empcursor
    INTO rec_sal;
  dbms_output.put_line('sal is  ' || rec_sal);
  CLOSE empcursor;

  OPEN empcursor FOR --使用ref游标
    SELECT JOB FROM emp;
  fetch empcursor
    INTO rec_job;
  dbms_output.put_line('job is  ' || rec_job);
  CLOSE empcursor;
END;
/
begin
refcursortest;
end;
/
--创建存储过程IncreSal
create or replace procedure IncreSal is
  var_average number;
  cursor cur_emp is
    select ename, sal from emp;
begin
  select avg(sal) into var_average from emp;
  for cursor_emp in cur_emp loop
    update emp set sal = sal * 1.15 where sal < var_average;
    dbms_output.put_line(cursor_emp.ename || ' updated!');
  end loop;
end;
/
begin
IncreSal;
end;
/
select * from emp
--创建带in和out参数的过程
create or replace procedure search_name(var_empno in number,
                                        var_name  out varchar2,
                                        var_sal   out number) as
begin
  select ename, sal
    into var_name, var_sal
    from emp
   where empno = var_empno;
exception
  when others then
    dbms_output.put_line('Error!');
end search_name;
--通过匿名过程调用过程search_name
declare
var_name varchar2(20);
var_sal number(8,2);
begin
  search_name(7839,var_name,var_sal);
  dbms_output.put_line('empno 7839 '||var_name||' salary is :'||var_sal);
  end;
  /
--创建自定义函数area
create or  replace function area(f float) return float is --is 之后可以声明变量，但不是必须的
begin 
return 3.14*(f*f);
end area;
/ --/表示编译该函数
select area(4) from dual;
/

--创建作用于表的函数
create or replace function find(var_empno number) return varchar2 is 
var_sal number;
var_ename varchar2(20);
begin
select ename ,sal into var_ename,var_sal from emp where empno=var_empno;
if var_sal>=4000 then return 'make good sal';
dbms_output.put_line('sal is : '||var_sal ||' name is :'||var_ename);
else return 'bad';
dbms_output.put_line('sal is : '||var_sal ||' name is :'||var_ename);
end if;
end find;
/
select find(7839) from dual

--应用return 语句
create or replace function square(original number) --参数列表
 return number --函数返回数据类型
 as
  original_squared number; --声明变量
begin
  original_squared := original * original;
  return original_squared; --返回数据
end;
/

begin
  dbms_output.put_line(square(170));
end;
/
--创建包含多个return语句的函数
create or replace function fun2(n number) return number is
begin
  if n = 0 then
    return n + 1;
  elsif n = 1 then
    return n * n;
  else
    return n * n * n;
  end if;
end;


begin
  for i in 0 .. 5 loop
    dbms_output.put_line(fun2(i));
  end loop;
end;

--创建复杂函数
create or replace function if_id_exist(var_empno in number) return boolean as
  var_emp_count number;
begin
  select count(*) into var_emp_count from emp where empno = var_empno;
  return 1 = var_emp_count;
exception
  when others then
    return false;
end if_id_exist;

--创建过程insert_emp
create or replace procedure instert_emp(var_empno in number,
                                        var_sal   in number,
                                        var_ename in varchar2) is
  if_id boolean;
begin
  if_id := if_id_exist(var_empno);
  if if_id then
    dbms_output.put_line('emp_id exist');
  else
    insert into emp
      (empno, sal, ename)
    values
      (var_empno, var_sal, var_ename);
  end if;
end;

begin
instert_emp(7839,8000,'Louis');
end;

--处理函数中的异常
--创建函数show_emp
create or replace function show_emp(var_empno emp.empno%type)
  return varchar2 is
  var_ename emp.ename%type;
begin
  select ename into var_ename from emp where empno = var_empno;
  return var_ename;
exception
  when no_data_found then
    return('the ename is not in the emp!');
  when others then
    return('error in running show_ename');
end;

declare
  var_ename emp.ename%type;
begin
  var_ename := show_emp(7839);
  dbms_output.put_line(var_ename);
end;

--创建并使用基于表的记录
declare
  emp_rec emp%rowtype; --调用表的%rowtype属性
begin
  select * into emp_rec from emp where empno = 7839;
  dbms_output.put_line('empno: ' || emp_rec.empno);
  dbms_output.put_line('ename: ' || emp_rec.ename);
end;

--创建基于游标的记录
declare
  cursor emp_cur is
    select ename, empno, sal from emp where rownum < 3;
  emp_rec emp_cur%rowtype;--接着声明基于游标的记录
begin
  open emp_cur;
  loop
    fetch emp_cur
      into emp_rec; --向记录填充数据
    exit when emp_cur%notfound;
    dbms_output.put_line('name: ' || emp_rec.ename); --记录的操作
  end loop;
end;

--创建用户自定义记录
declare
  type time_rec_type is record(curr_date date, curr_day varchar2(12), curr_time varchar2(8) not null := '00:00:00');
  time_rec time_rec_type;--如果非空字段声明为not null，此时字段必须赋初值
begin
  select sysdate into time_rec.curr_date from dual;
  time_rec.curr_day  := to_char(time_rec.curr_date, 'Day');
  time_rec.curr_time := to_char(time_rec.curr_date, 'hh24:mi:ss');
  dbms_output.put_line('Date: ' || time_rec.curr_date);
  dbms_output.put_line('Day: ' || time_rec.curr_day);
  dbms_output.put_line('Time: ' || time_rec.curr_time);
end;

--嵌套记录
declare
type rec_type is record(
var_ename emp.ename%type
);
type emp_type is record(
var_name rec_type,
var_sal emp.sal%type
);
emp_rec emp_type;
begin                       --多层调用
  select ename,sal into emp_rec.var_name.var_ename,emp_rec.var_sal from emp where empno=7839;
  dbms_output.put_line('name: '||emp_rec.var_name.var_ename);
  dbms_output.put_line('name: '||emp_rec.var_sal);
end;

--记录集合
declare
  cursor emp_cur is
    select ename, sal from emp where rownum <= 3;
  type emp_type is table of emp_cur%rowtype --定义联合数组类型
  index by binary_integer;
/*加了index by binary_integer;emp_type类型的下标就是自增长的，
emp_type 类型在插入元素时，不需要初始化，不需要每次extend增加一个空间。*/
  emp_tab   emp_type;--定义联合数组
  var_counter integer := 0;
begin
  for i in emp_cur loop--通过loop循环为联合数组填充记录
    var_counter := var_counter + 1;
    emp_tab(var_counter).ename := i.ename;
    emp_tab(var_counter).sal := i.sal;
    dbms_output.put_line('table name is:' || var_counter || emp_tab(var_counter)
                         .ename);
    dbms_output.put_line('table sal is:' || var_counter || emp_tab(var_counter).sal);
  end loop;
end;

--联合数组，也叫索引表，用于储存某个数据类型的数据集合类型，可以通过索引获得联合数据中的数据。
declare
  cursor my_cursor is
    select ename from emp where sal <= 2800;
  type ename_type is table of emp.ename%type --声明联合数组类型
  index by binary_integer;--声明联合数组的索引
  ename_table   ename_type;--声明ename_type的联合数组ename_table
  var_counter integer := 0;
begin
  for ename_rec in my_cursor loop
    var_counter := var_counter + 1;
    ename_table(var_counter) :=ename_rec .ename;
    dbms_output.put_line('ename(' || var_counter ||'):'|| ename_table(var_counter));
  end loop;
end;

--使用嵌套表
declare
  cursor my_cursor is
    select ename from emp where sal <= 2800;
  type ename_type is table of emp.ename%type; --声明嵌套表的元素类型
  ename_table ename_type :=ename_type();--嵌套表必须先初始化才能使用
  var_counter integer := 0;
begin
  for ename_rec in my_cursor loop
    var_counter := var_counter + 1;
    ename_table.extend;--调用extend 方法增加集合的大小
    ename_table(var_counter) :=ename_rec .ename;
    dbms_output.put_line('ename(' || var_counter ||'):'|| ename_table(var_counter));
  end loop;
end;

--包含有效SQL语句的动态SQL语句演示
declare
  sql_states varchar2(5000);
  counter    number:=0;
begin
  sql_states := 'create table pid
                 as select empno,ename from emp where sal<2800';
  execute immediate  sql_states;
  execute immediate 'select count(distinct(empno)) from pid'
  into counter;
  dbms_output.put_line('counter is' || counter);
end;

--包含pl/sql语句块的sql语句
declare
  obj_id    number := 28;
  obj_name  varchar2(20);
  plsql_blk varchar2(200);
begin
  plsql_blk := 'declare var_date date;' || 'begin ' ||
               'select sysdate into var_date from dual;' ||
               'dbms_output.put_line(var_date);' || 'end;';
  execute immediate plsql_blk;
end;
  



select  * from pid;
