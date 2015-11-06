--使用select into 为变量赋值
declare   
avg_sal number(8,2);
begin 
  dbms_output.put_line('avg_sal is: '||avg_sal);
  select avg(sal) into avg_sal from emp;
    dbms_output.put_line('avg_sal is: '||avg_sal);
end;
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

select * from emp;

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

begin
  plus(5000);
  plus(1000);
  end;

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

--使用for循环
begin
  for i in 1 .. 5 loop
    dbms_output.put_line(to_char(i));
  end loop;
end;

--使用游标for循环
begin
  for i in (select ename, sal, deptno from emp where sal > 2500) loop
    dbms_output.put_line(i.ename || ' salary is:' || i.sal || ' and in ' ||
                         i.deptno);
  end loop;
end;

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

begin
  cursortest;
end;

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

begin
  hidencursortest;
end;

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

--for游标不需要声明变量，也不需要显示打开游标关闭游标，都是自动执行的

--游标表达式
select deptno,dname,loc,cursor(select empno,ename,sal from emp where deptno=d.deptno)
from dept d;
select * from dept
select * from emp

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

begin
refcursortest;
end;

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

begin
IncreSal;
end;

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
  
--创建自定义函数area
create or  replace function area(f float) return float is --is 之后可以声明变量，但不是必须的
begin 
return 3.14*(f*f);
end area;
/ --/表示编译该函数
select area(4) from dual

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
select find(7839) from dual

