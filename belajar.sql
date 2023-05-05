-- 1.menampilkan semua table di dalam db classicmodels --
show tables

-- 2.querying data --
select employeeNumber, lastName, firstName, email  
from employees;

-- 3.sorting --
select customerNumber,
count(orderNumber),
status 
from orders 
group by customerNumber
order by customerNumber asc;

-- 4.filtering --
SELECT * FROM Customers 
where (CustomerName LIKE 'S%'
OR CustomerName LIKE 'A%'
OR CustomerName LIKE 'W%')
AND Country='USA'
ORDER BY CustomerName desc;

-- 5.inner join --
select * from orders 
inner join customers 
using (customerNumber)
where status = 'shipped'
group by customerName
order by customerNumber desc;

-- 5.inner join_2 --
SELECT
employeeNumber,
firstName,
lastName,
e.officeCode ,
city,
phone,
addressLine1
from employees e
INNER JOIN offices d ON d.officeCode = e.officeCode
ORDER by firstName asc;


-- 6.agregate --
select customerNumber,
avg(amount) 
from payments 
where customerNumber > 150
group by customerNumber;

-- 7.cursor --
CREATE or replace PROCEDURE get_customer_info(
in in_customernumber int )
BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE vcustomername VARCHAR(255);
    DECLARE vphone VARCHAR(255);
    DECLARE vaddressline1 VARCHAR(255);
    DECLARE vcity VARCHAR(255);
    DECLARE vcountry VARCHAR(255);
    DECLARE cur CURSOR FOR SELECT customerName, phone, addressline1, city, country FROM customers where customerNumber = in_customernumber;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    OPEN cur;

    read_loop: LOOP
        FETCH cur INTO vcustomername, vphone, vaddressline1, vcity, vcountry;
        IF done THEN
            LEAVE read_loop;
        END IF;
        
        SELECT vcustomername, vphone, vaddressline1, vcity, vcountry;
    END LOOP;

    CLOSE cur;
end


-- pemanggil cursor
CALL get_customer_info(114);



-- 8.create table --
create table pelanggan (
no_pelanggan VARCHAR(100),
nama VARCHAR(300),
alamat varchar(500)
);

-- 9.truncate table --
truncate table tmp_employees

-- 10.drop table --
drop table tmp_employees

-- 11.add column --
alter table pelanggan 
add email varchar (300)

-- 12.modify column --
alter table pelanggan 
modify no_pelanggan varchar(150)

-- 13.insert table --
insert into pelanggan 
values ('P1','sayyidah','bogor','say@gmail.com')
insert into pelanggan 
values ('P2','fathimah','depok','fat1@gmail.com')
insert into pelanggan 
values ('P3','safa','jakarta','safa@gmail.com')

-- 14.update --
update pelanggan
set nama = 'safana'
where no_pelanggan = 'P3';

-- 15.delete --
delete from pelanggan 
where no_pelanggan = 'P2';

-- 16.where_clause --
select * from customers 
where creditLimit < 60000
order by customerName asc;

-- 17.left join dan alias --
select e.firstName nama_karyawan
,e.jobTitle
,e.officeCode
,o.phone
,o.city
,o.country
from employees e 
left join offices o 
on e.officeCode = o.officeCode
left join customers c 
on o.officeCode = c.customerNumber; 

-- 18.temporary table --
create table tmp_employees as
select * from employees e 

-- 19.alias, text operation, numeric operation, 
select customerName pelanggan,
upper(contactFirstName) ,
lower(contactLastName),
city,
creditLimit,
max(salesRepEmployeeNumber)
from customers 
where creditLimit <= 50000
and city like '%a_';

-- 20.single row function --
select orderNumber,
productCode,
avg(priceEach),
count(*) quantityOrdered 
from orderdetails;

-- 21.index --
create index idx_status
on orders(status);
--
select * from orders 
where status = 'shipped'

-- drop index --
drop index idx_jobTitle 
on employees;