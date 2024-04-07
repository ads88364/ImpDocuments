--單純執行查詢 select 會產生一個資料表單 可以用create view 來建立新資料表 用來保護資料安全性
--外部人員只能查詢 select * from vw_users 並且資料是唯讀的

--刪除表單
--drop view vw_users 
--create view vw_users as

select a.uid, cname ,address
from UserInfo as a ,Live as b, House as c
where a.uid = b.uid and b.hid = c.hid

--新增/修改/刪除 自己看

--交易 => 讓資料異動有復原的機制
begin transaction
    delete from UserInfo
	delete from House

    --rollback 確認交易失敗復原
    --commit 確認交易成功

select * from bill


--Pivot – 樞紐轉換
select * from(
    select year(dd) as y ,month(dd)/4+1 as m, fee from Bill
) as tmp
pivot (
    sum(fee)
	for m in ([1],[2],[3],[4])
) as pvt
where y = 2019

--新增一筆資料進去
--insert into Bill(Tel,fee,hid,dd) values

--練習pivot 要先知道資料種類 Y軸才能設定
--select distinct hw from () 

select * from(
select 'A01' as sid, 'hw1' as hw, 1 as 'ok'
union all
select 'A01' as sid, 'hw2' as hw, 1 as 'ok'
union all
select 'A01' as sid, 'hw3' as hw, 1 as 'ok'
union all
select 'A02' as sid, 'hw1' as hw, 1 as 'ok'
union all
select 'A02' as sid, 'hw3' as hw, 1 as 'ok'
) as tmp
pivot(
  sum(ok)
  for hw in([hw1],[hw2],[hw3])
) as pvt

--資料補0 union all用法
select q, sum(sum_fee) from (
    select month(dd) / 4 + 1 as q, sum(fee) as sum_fee from Bill group by month(dd) / 4 + 1
    union all
    select 1, 0
    union all
    select 2, 0
    union all
    select 3, 0
    union all
    select 4, 0
) as a
group by q    


--遵守第一正規化 如果資料表沒有遵守 有補救方法
select sid, value into new_table from (
    --以下是違反正規化的表
    select 'A01' as sid, '化學,物理,數學' as courses
    union all
    select 'A02' as sid, '化學,數學' as courses
) as a cross apply string_split(courses, ',') as tmp
    --已逗點為分界切字串


--ASP.Net Core 直接輸出一段json格式資料 可以給前端戶後端都可以用 
app.MapGet("/", (HttpResponse response, DB db) =>
{
    FormattableString sql = $@"

	    ----只要改這段----
        select * from (
            select 'A01' as sid, '王大明' as cname, 'hw1' as hw, 1 as 'ok'
            union all
            select 'A01' as sid, '王大明' as cname, 'hw2' as hw, 1 as 'ok'
            union all
            select 'A01' as sid, '王小毛' as cname, 'hw3' as hw, 1 as 'ok'
            union all
            select 'A02' as sid, '朱小妹' as cname, 'hw1' as hw, 1 as 'ok'
            union all
            select 'A02' as sid, '朱小妹' as cname, 'hw3' as hw, 1 as 'ok'
        ) as tmp
        pivot (
            sum(ok)
            for hw in ([hw1], [hw2], [hw3])
        ) as pvt
		----只要改這段----

        for json path, include_null_values
    ";
 
    response.Headers.ContentType = "application/json";
    var records = db.Database.SqlQuery<string>(sql).ToArray();
    return records[0];
});


--前後端分離 新增前端 josn資料
insert into UserInfo (uid, cname)
select * from openjson(N'{
        "uid": "Z01",
        "cname": "Tom"
}')
 with (
    uid nvarchar(50) '$.uid',
    cname nvarchar(50) '$.cname'
)

--產生一個id 讓前後端可以使用
select *,newid() as id from UserInfo

--時間日期
--format出來是字串 year出來是字串
select concat('中華民國',year(getdate())-1911, format(getdate(), '西元yyyy年M月d日'))

select *, concat('中華民國',year(getdate())-1911, format(getdate(), '西元yyyy年M月d日')) as cdate
from Bill


--缺項補零萬用fn => 改'1'的地方就好
select right(concat('000','1'),3)