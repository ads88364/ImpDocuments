--select uid ,cname,2 from UserInfo where cname like'%�j%'
--select * from Bill where fee != 500 and hid='2'
/*select * from UserInfo where cname<>'���j��'and cname<>'���j��' or cname is null

select * from UserInfo where cname not in ('���j��','���j��')

select * from UserInfo where cname is null

select * ,ISNULL(cname,'')from UserInfo 

select  * from UserInfo where ISNULL(cname,'') not  in ('���j��','���j��')

select * from Bill where fee>500 order by fee ,dd desc

--select COUNT(*) from bill where fee=700

select * from UserInfo u ,House h,Phone p ,Live l
where u.uid=l.uid 
and l.hid=h.hid 
and h.hid=p.hid
and u.uid='A04'

*/
select  * from  
UserInfo u left join Live l on u.uid =l.uid
left join  House h on l.hid = h.hid 
left join Phone p  on h.hid = p.hid 
 where u.uid ='A01'



select * from Live


--���h�ֹq�� no null
select  cname,COUNT(p.Tel)as tel from UserInfo u ,House h,Phone p ,Live l
where u.uid=l.uid 
and l.hid=h.hid 
and h.hid=p.hid
group by  cname

--include null
select  cname,COUNT(p.Tel)as tel  from  
UserInfo u left join Live l on u.uid =l.uid
left join  House h on l.hid = h.hid 
left join Phone p  on h.hid = p.hid 
group by cname


--�Фl
select cname,COUNT(h.address)as house from UserInfo u ,House h,Phone p ,Live l
where u.uid=l.uid 
and l.hid=h.hid 
and h.hid=p.hid
group by cname

select cname,COUNT(h.address)as house from UserInfo u ,House h,Phone p ,Live l
where u.uid=l.uid 
and l.hid=h.hid 
and h.hid=p.hid
group by cname

select address, tel,sum(fee)as fee from Bill b
left join House h on b.hid =h.hid
group by address ,tel
order by tel

select tel,sum(fee) as fee,address from Bill b ,House h
where b.hid = h.hid 
group by tel,address
order by tel desc

select u.uid,COUNT(hid)as'�Ыμƶq' from UserInfo u left join Live l on u.uid=l.uid
group by u.uid

--left(cname,2) �q�������Ӧr  distinct����ƪ�
select distinct LEFT(cname,1) from UserInfo where cname is not null and cname<>''

--top 1 �O�Ĥ@���p�G���ⵧ�ۦP���G�u�|��ܲĤ@��-->���u
select tel ,sum(fee)as '����'from Bill 
group by Tel
order by tel desc

--�l�d��
select max(�`�M) as max_fee
from
(
select tel ,sum(fee)as '�`�M'from Bill 
group by Tel
) as x

--��өM�b�@�_
select * from
(
select max(�`�M) as max_fee
from
(
select tel ,sum(fee)as '�`�M'from Bill 
group by Tel
) as x
)
as a ,
(
select tel ,sum(fee)as '�`�M'from Bill 
group by Tel
)
as b 
where a.max_fee=b.�`�M



--��Ӫ�M�b�@�_
SELECT * FROM
(
    SELECT tel, SUM(fee) AS ����
    FROM Bill 
    GROUP BY Tel
) AS a,
(
    SELECT MAX(max_fee) AS max_fee
    FROM
    (
        SELECT  tel , SUM(fee) AS max_fee
        FROM Bill 
        GROUP BY Tel
    ) AS x
) AS b
WHERE a.���� = b.max_fee

--����having�γo�Ӥl�d�߼g�k
select * from
(
select tel,sum(fee) as n from Bill group by tel
)as a 
where a.n>1500
--having �Ϊk
select tel ,sum(fee) as n from Bill
group by tel 
having sum(fee)>=1500
order by  tel desc

--union all ��q���e�ݴ��զ����|�ʨ��Ʈw
select * from UserInfo 
union all 
select 'test','David'
union all
select 'test2','Amy'