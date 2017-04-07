 
--创建表单 : 
    在当前用户下创建表单
    create table 表名字(id number(5,2), name varchar2(20 byte));--创建一个表单,里面有两列,第一列是id 是数值型 切共有5位数字,并有两位是小数,三位是整数 ,第二列是name 字符型,能输入20个字节,必须是字节
    
	CREATE TABLE EMP(
	EMPNO NUMBER(4) CONSTRAINT PK_EMP PRIMARY KEY,
	ENAME VARCHAR2(10),
	JOB VARCHAR2(9),
	MGR NUMBER(4),
	HIREDATE DATE,
	SAL NUMBER(7,2),
	COMM NUMBER(7,2),
	DEPTNO NUMBER(2) CONSTRAINT FK_DEPTNO REFERENCES DEPT);
--更改表名字 : 
 
    rename 旧表名 to 新表名;
 

--增 :
 
    --往表里面添加行(内容) : 
        
        insert into 表名(属性1,属性2...)values(值,值...);
		INSERT INTO EMP VALUES(1234,'LPF','CLERK',7902,to_date('01-09-2015','dd-mm-yyyy'),800,NULL,20);
 
    --往表单里添加一个字段 : (添加一个列/属性)
 
        alter table 表名 add ("名字" number(3));
 
    --多个插入 : 
 
        insert into 新表名(字段名) select 列 from 表名 where 行限定条件(不是所有数据,年龄段,某个部门)--
    如 : insert into emp(id) select age from emp where id = 33;--把emp表中 id列值为33,对应的那些age的值,添加到emp表的id列中
 
    --备份表 : 
 
        create table 表名 as select * from 表名;
 
    --模拟中的数据复制 : 
 
        insert into 表1(属性1,属性2...) select * from 表2;--表1后面属性个数是多少,表2就必须是多少,而且数据类型也必须完全相同 , 然后把表2里面列的数据类型的值,添加到和表1中对应列的数据类型相同的那一列的后面(追加行 )
        insert into emp (id) select * from emp2;--表2 里面必须有一个number(5)类型的列,并且也只能写5个数字
        insert into emp (id) select hao from emp2;--hao这个列 必须和id列的数据类型完全相同,然后把hao那一列的数据,在id哪一列的后面,追加
 

--删 :
 
    --删除表 : 
 
        drop table 表名;--删除表
 
    --删除一个表的字段 : (删除一个列/属性)
 
        alter table 表名 drop column 列名;    --强烈建议不要对成熟的系统这么做
 
    --删除行 : 不定条数
    
        delete from 表名 where 行限定条件;
            --限定条件 如 : name那一列为Kay的 全部删除
        delete from emp where name = 'Kay';
 
    --删除表的数据
 
        truncate table 表名;    --相当于删除表和数据然后重建表.
 
--改 :
 
    --更改表名字 : 
        
        rename 旧表名 to 新表名;
 
    --更改字段(列)的类型或者名字 : 
 
        alter table 表名 modify (属性 类型);
            如 : alter table student modify (sex number(1));
 
    --更改列上的值 : 
 
        update 表名 set 列名=列值改变量(+-*/), 字段2,字段3, where 行限定条件;
            如 :  update 表名 set 列名='值' where id='B0002'(限定条件,id为B0002的 都会把前面指定的属性的值更改);
 
