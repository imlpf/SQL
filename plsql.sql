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


