--ʹ��select into Ϊ������ֵ
declare   
avg_sal number(8,2);
begin 
  dbms_output.put_line('avg_sal is: '||avg_sal);
  select avg(sal) into avg_sal from emp;
    dbms_output.put_line('avg_sal is: '||avg_sal);
end;
/
--if then ���
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
--if-then-else ���
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
---Ƕ��elsif  
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
--����ʽcase���
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
--loop ѭ��
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

--while ѭ��
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
--��ѭ������Ƕ��if�������
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
--ʹ��exit when ������ѭ��
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
--ʹ��forѭ��
begin
  for i in 1 .. 5 loop
    dbms_output.put_line(to_char(i));
  end loop;
end;
/
--ʹ���α�forѭ��
begin
  for i in (select ename, sal, deptno from emp where sal > 2500) loop
    dbms_output.put_line(i.ename || ' salary is:' || i.sal || ' and in ' ||
                         i.deptno);
  end loop;
end;
/
--continue ���
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
--continue when ���
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
--Ӧ��null���
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
--�ڴ洢�����д����α�
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
--��ʽ�α� û���������α�
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
--sql%notfound����
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
--ͨ���쳣����no_data_found
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
--for�α겻��Ҫ����������Ҳ����Ҫ��ʾ���α�ر��α꣬�����Զ�ִ�е�

--�α���ʽ
select deptno,dname,loc,cursor(select empno,ename,sal from emp where deptno=d.deptno)
from dept d;
select * from dept;
select * from emp;
/
--ʹ��Ƕ���α�
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
--ʹ��Ƕ�ײ�ѯʵ��Ƕ���α깦��
select ename from emp where deptno in (select deptno from dept where dname like 'R%')

/*��̬�α꣬��ref�α꣬����һ����¼�ļ��ϣ�oracle�����ڲ�ͬ�ĳ���Ԫ֮�䴫���α����á�
�����ڴ洢�����ж���ref�α꣬�����Ϳ�������Ҫ��ʱ��ʹ�ø��α꣬�Ӷ���������Ҫ�α��ʱ����ʽ���塣
��Ҫʹ��ref�α꣬������Ҫ������Ϊһ��type��Ȼ���ٴ���һ��ʵ��*/
CREATE OR REPLACE PROCEDURE refcursortest IS
  TYPE ty_emprefcur IS REF CURSOR; --����ref�α�Ϊһ��type
  empcursor ty_emprefcur; --���������͵�һ��ʵ��
  rec_emp   emp%rowtype;
  rec_sal   emp.sal%TYPE;
  rec_job   emp.JOB%TYPE;
BEGIN
  OPEN empcursor FOR --ʹ��ref�α�
    SELECT * FROM emp;
  fetch empcursor
    INTO rec_emp;
  dbms_output.put_line('ename is  ' || rec_emp.ename);
  CLOSE empcursor;

  OPEN empcursor FOR --ʹ��ref�α�
    SELECT sal FROM emp;
  fetch empcursor
    INTO rec_sal;
  dbms_output.put_line('sal is  ' || rec_sal);
  CLOSE empcursor;

  OPEN empcursor FOR --ʹ��ref�α�
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
--�����洢����IncreSal
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
--������in��out�����Ĺ���
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
--ͨ���������̵��ù���search_name
declare
var_name varchar2(20);
var_sal number(8,2);
begin
  search_name(7839,var_name,var_sal);
  dbms_output.put_line('empno 7839 '||var_name||' salary is :'||var_sal);
  end;
  /
--�����Զ��庯��area
create or  replace function area(f float) return float is --is ֮��������������������Ǳ����
begin 
return 3.14*(f*f);
end area;
/ --/��ʾ����ú���
select area(4) from dual;
/

--���������ڱ�ĺ���
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

--Ӧ��return ���
create or replace function square(original number) --�����б�
 return number --����������������
 as
  original_squared number; --��������
begin
  original_squared := original * original;
  return original_squared; --��������
end;
/

begin
  dbms_output.put_line(square(170));
end;
/
--�����������return���ĺ���
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

--�������Ӻ���
create or replace function if_id_exist(var_empno in number) return boolean as
  var_emp_count number;
begin
  select count(*) into var_emp_count from emp where empno = var_empno;
  return 1 = var_emp_count;
exception
  when others then
    return false;
end if_id_exist;

--��������insert_emp
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

--�������е��쳣
--��������show_emp
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

--������ʹ�û��ڱ�ļ�¼
declare
  emp_rec emp%rowtype; --���ñ��%rowtype����
begin
  select * into emp_rec from emp where empno = 7839;
  dbms_output.put_line('empno: ' || emp_rec.empno);
  dbms_output.put_line('ename: ' || emp_rec.ename);
end;

--���������α�ļ�¼
declare
  cursor emp_cur is
    select ename, empno, sal from emp where rownum < 3;
  emp_rec emp_cur%rowtype;--�������������α�ļ�¼
begin
  open emp_cur;
  loop
    fetch emp_cur
      into emp_rec; --���¼�������
    exit when emp_cur%notfound;
    dbms_output.put_line('name: ' || emp_rec.ename); --��¼�Ĳ���
  end loop;
end;

--�����û��Զ����¼
declare
  type time_rec_type is record(curr_date date, curr_day varchar2(12), curr_time varchar2(8) not null := '00:00:00');
  time_rec time_rec_type;--����ǿ��ֶ�����Ϊnot null����ʱ�ֶα��븳��ֵ
begin
  select sysdate into time_rec.curr_date from dual;
  time_rec.curr_day  := to_char(time_rec.curr_date, 'Day');
  time_rec.curr_time := to_char(time_rec.curr_date, 'hh24:mi:ss');
  dbms_output.put_line('Date: ' || time_rec.curr_date);
  dbms_output.put_line('Day: ' || time_rec.curr_day);
  dbms_output.put_line('Time: ' || time_rec.curr_time);
end;

--Ƕ�׼�¼
declare
type rec_type is record(
var_ename emp.ename%type
);
type emp_type is record(
var_name rec_type,
var_sal emp.sal%type
);
emp_rec emp_type;
begin                       --������
  select ename,sal into emp_rec.var_name.var_ename,emp_rec.var_sal from emp where empno=7839;
  dbms_output.put_line('name: '||emp_rec.var_name.var_ename);
  dbms_output.put_line('name: '||emp_rec.var_sal);
end;

--��¼����
declare
  cursor emp_cur is
    select ename, sal from emp where rownum <= 3;
  type emp_type is table of emp_cur%rowtype --����������������
  index by binary_integer;
/*����index by binary_integer;emp_type���͵��±�����������ģ�
emp_type �����ڲ���Ԫ��ʱ������Ҫ��ʼ��������Ҫÿ��extend����һ���ռ䡣*/
  emp_tab   emp_type;--������������
  var_counter integer := 0;
begin
  for i in emp_cur loop--ͨ��loopѭ��Ϊ������������¼
    var_counter := var_counter + 1;
    emp_tab(var_counter).ename := i.ename;
    emp_tab(var_counter).sal := i.sal;
    dbms_output.put_line('table name is:' || var_counter || emp_tab(var_counter)
                         .ename);
    dbms_output.put_line('table sal is:' || var_counter || emp_tab(var_counter).sal);
  end loop;
end;

--�������飬Ҳ�����������ڴ���ĳ���������͵����ݼ������ͣ�����ͨ������������������е����ݡ�
declare
  cursor my_cursor is
    select ename from emp where sal <= 2800;
  type ename_type is table of emp.ename%type --����������������
  index by binary_integer;--�����������������
  ename_table   ename_type;--����ename_type����������ename_table
  var_counter integer := 0;
begin
  for ename_rec in my_cursor loop
    var_counter := var_counter + 1;
    ename_table(var_counter) :=ename_rec .ename;
    dbms_output.put_line('ename(' || var_counter ||'):'|| ename_table(var_counter));
  end loop;
end;

--ʹ��Ƕ�ױ�
declare
  cursor my_cursor is
    select ename from emp where sal <= 2800;
  type ename_type is table of emp.ename%type; --����Ƕ�ױ��Ԫ������
  ename_table ename_type :=ename_type();--Ƕ�ױ�����ȳ�ʼ������ʹ��
  var_counter integer := 0;
begin
  for ename_rec in my_cursor loop
    var_counter := var_counter + 1;
    ename_table.extend;--����extend �������Ӽ��ϵĴ�С
    ename_table(var_counter) :=ename_rec .ename;
    dbms_output.put_line('ename(' || var_counter ||'):'|| ename_table(var_counter));
  end loop;
end;

--������ЧSQL���Ķ�̬SQL�����ʾ
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

--����pl/sql�����sql���
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
