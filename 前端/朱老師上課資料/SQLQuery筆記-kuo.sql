select  uid,cname,1 from UserInfo
where uid = 'A04'

--模糊查詢
select  uid,cname,1 from UserInfo
where cname like  '%明%'

--範圍
select * from Bill
where fee <> 500

--===================================================================

--查詢條件介紹
--select *from UserInfo
--isnull()可以把字串null處理掉
select *, ISNULL(cname,'') from UserInfo

--會把cname value為null的去除掉 因為null不能運算
--where cname in( '王大明','李大媽')
--where cname not in( '王大明','李大媽')

--等於跟不等於
--where cname = '王大明' or cname='李大媽'
--where cname <> '王大明' and cname <>'李大媽'

--查詢null的方法
--where cname = '' or cname is null
where cname not in( '王大明','李大媽') or cname is null
--===================================================================

select * from Bill
--where fee >= 400 and fee <= 700
--where fee between 400 and 700
--order by tel,dd desc 
--desc由大到小排序

--排序 where 要放在 order by之前

--where fee <= 400 and fee >= 700

--where fee between 400 and 700
--where fee not between 400 and 700

--===================================================================

--算比數
select COUNT(*) from UserInfo


--表單關聯性
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

--沒有用外部連結查詢A04會沒有結果 實際上 Live表單也沒有 A04資料
--left join / Live right join 外部連結表單
--通常都用同方向都是left or right 不要混合使用


/*
from UserInfo,House,Phone,Live
where UserInfo.uid = Live.uid and
      Live.hid = House.hid and
	  House.hid = Phone.hid and
	  UserInfo.uid = 'A01'
*/

--交叉連結 
select *from UserInfo,Live--會讓兩張資料表相乘 要很小心

--帳單群組運算
select Tel ,Sum(fee),address from Bill,House --SUM總和 AVG平均
where Bill.hid = House.hid
group by Tel,address--合併資料表 需要查詢的東西要放在group by後面不包含計算項目


--
select UserInfo.uid,count(hid)
from UserInfo left join Live
on UserInfo.uid = Live.uid
group by UserInfo.uid


--剔除重複  distinct??
select distinct left(cname,1)
from UserInfo
where cname is not null and cname<> ''

--新增欄位別名
select Tel,sum(fee) as '總和' 
from Bill 
group by Tel

select* 
from UserInfo as a,Live as b 
where a.uid = b.uid

--帳單總和最大的
select top 1 Tel,sum(fee) as '總和' 
from Bill 
group by Tel
order by '總和' desc


--找極端值?????
select*
from(
 select max(總和) as max_sum
  from (
    select Tel,sum(fee) AS '總和' 
    from Bill 
    group by Tel
  ) AS x
 ) as a,(
    select Tel,sum(fee) AS '總和' 
    from Bill 
    group by Tel
  ) as b

where a.max_sum = b.總和



--子查詢
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
	having sum(fee) >= 1500 --n 不能放在having後面 運算邏輯是先取得having結果再給n



--無中生有 union ALL 產生比假資料 不影響原本資料表
select * from UserInfo
union ALL
select 'Test','David'
union ALL
select 'Test2','Tom' 
--union 如果 select 一樣的只會存入一筆
--union ALL 如果 select 一樣的只會存入一筆


