select  uid,cname,1 from UserInfo
where uid = 'A04'

--�ҽk�d��
select  uid,cname,1 from UserInfo
where cname like  '%��%'

--�d��
select * from Bill
where fee <> 500

--===================================================================

--�d�߱��󤶲�
--select *from UserInfo
--isnull()�i�H��r��null�B�z��
select *, ISNULL(cname,'') from UserInfo

--�|��cname value��null���h���� �]��null����B��
--where cname in( '���j��','���j��')
--where cname not in( '���j��','���j��')

--����򤣵���
--where cname = '���j��' or cname='���j��'
--where cname <> '���j��' and cname <>'���j��'

--�d��null����k
--where cname = '' or cname is null
where cname not in( '���j��','���j��') or cname is null
--===================================================================

select * from Bill
--where fee >= 400 and fee <= 700
--where fee between 400 and 700
--order by tel,dd desc 
--desc�Ѥj��p�Ƨ�

--�Ƨ� where �n��b order by���e

--where fee <= 400 and fee >= 700

--where fee between 400 and 700
--where fee not between 400 and 700

--===================================================================

--����
select COUNT(*) from UserInfo


--������p��
select * --UserInfo,cname ,address,Tel
select *
--from UserInfo join Live

--from UserInfo left join Live
from Live right join UserInfo
     on UserInfo.uid = Live.uid
	left join House
	 on Live.hid = House.hid
	left join Phone
	 on House.hid = Phone.hid
	 where UserInfo.uid = 'A04'

--�S���Υ~���s���d��A04�|�S�����G ��ڤW Live���]�S�� A04���
--left join / Live right join �~���s�����
--�q�`���ΦP��V���Oleft or right ���n�V�X�ϥ�


/*
from UserInfo,House,Phone,Live
where UserInfo.uid = Live.uid and
      Live.hid = House.hid and
	  House.hid = Phone.hid and
	  UserInfo.uid = 'A01'
*/

--��e�s�� 
select *from UserInfo,Live--�|����i��ƪ�ۭ� �n�ܤp��

--�b��s�չB��
select Tel ,Sum(fee),address from Bill,House --SUM�`�M AVG����
where Bill.hid = House.hid
group by Tel,address--�X�ָ�ƪ� �ݭn�d�ߪ��F��n��bgroup by�᭱���]�t�p�ⶵ��


--
select UserInfo.uid,count(hid)
from UserInfo left join Live
on UserInfo.uid = Live.uid
group by UserInfo.uid


--�簣����  distinct??
select distinct left(cname,1)
from UserInfo
where cname is not null and cname<> ''

--�s�W���O�W
select Tel,sum(fee) as '�`�M' 
from Bill 
group by Tel

select* 
from UserInfo as a,Live as b 
where a.uid = b.uid

--�b���`�M�̤j��
select top 1 Tel,sum(fee) as '�`�M' 
from Bill 
group by Tel
order by '�`�M' desc


--�䷥�ݭ�?????
select*
from(
 select max(�`�M) as max_sum
  from (
    select Tel,sum(fee) AS '�`�M' 
    from Bill 
    group by Tel
  ) AS x
 ) as a,(
    select Tel,sum(fee) AS '�`�M' 
    from Bill 
    group by Tel
  ) as b

where a.max_sum = b.�`�M



--�l�d��
select * from
(
    select Tel,Sum(fee) as n
	from Bill
	group by Tel
) as a
where a.n >= 1500


select Tel,Sum(fee) as n
    from Bill
	group by Tel
	having sum(fee) >= 1500 --n �����bhaving�᭱ �B���޿�O�����ohaving���G�A��n



--�L���ͦ� union ALL ���ͤ񰲸�� ���v�T�쥻��ƪ�
select * from UserInfo
union ALL
select 'Test','David'
union ALL
select 'Test2','Tom' 
--union �p�G select �@�˪��u�|�s�J�@��
--union ALL �p�G select �@�˪��u�|�s�J�@��


