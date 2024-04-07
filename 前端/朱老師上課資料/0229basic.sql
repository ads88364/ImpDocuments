--select uid ,cname,2 from UserInfo where cname like'%大%'
--select * from Bill where fee != 500 and hid='2'
/*select * from UserInfo where cname<>'王大明'and cname<>'李大媽' or cname is null

select * from UserInfo where cname not in ('王大明','李大媽')

select * from UserInfo where cname is null

select * ,ISNULL(cname,'')from UserInfo 

select  * from UserInfo where ISNULL(cname,'') not  in ('王大明','李大媽')

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


--有多少電話 no null
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


--房子
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

select u.uid,COUNT(hid)as'房屋數量' from UserInfo u left join Live l on u.uid=l.uid
group by u.uid

--left(cname,2) 從左邊取兩個字  distinct限制重複的
select distinct LEFT(cname,1) from UserInfo where cname is not null and cname<>''

--top 1 是第一筆如果有兩筆相同結果只會顯示第一筆-->不優
select tel ,sum(fee)as '價格'from Bill 
group by Tel
order by tel desc

--子查詢
select max(總和) as max_fee
from
(
select tel ,sum(fee)as '總和'from Bill 
group by Tel
) as x

--兩個和在一起
select * from
(
select max(總和) as max_fee
from
(
select tel ,sum(fee)as '總和'from Bill 
group by Tel
) as x
)
as a ,
(
select tel ,sum(fee)as '總和'from Bill 
group by Tel
)
as b 
where a.max_fee=b.總和



--兩個表和在一起
SELECT * FROM
(
    SELECT tel, SUM(fee) AS 價格
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
WHERE a.價格 = b.max_fee

--不用having用這個子查詢寫法
select * from
(
select tel,sum(fee) as n from Bill group by tel
)as a 
where a.n>1500
--having 用法
select tel ,sum(fee) as n from Bill
group by tel 
having sum(fee)>=1500
order by  tel desc

--union all 後段給前端測試但不會動到資料庫
select * from UserInfo 
union all 
select 'test','David'
union all
select 'test2','Amy'