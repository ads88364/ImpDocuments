--時間計算筆記


--小心計算會有小數問題
select dateadd(day,-5, getdate())


--計算年齡 .25因為閏年 可以用地板除法得到整數
select datediff(DAY,'2023/1/1',GETDATE()) / 365.25


--現在星期幾weekday/year/day
select datepart(WEEKDAY, getdate())


--自訂格式
select format(getdate(), '西元yyyy年')
--datepart/format出來資料型態不一樣int/


--時間日期去掉零頭(不能用!!!)
select datetrunc(DAY,getdate())


--世界協調時間(不帶時區資訊的世界協調時間)
select getdate(),GETUTCDATE()
--實務上資料庫存取時間要規定好要不要時區 通常都是不帶時區(前後端自己處理) 才不會亂掉
--SQL server存到資料庫不會把時區資訊存進去 所以會不知道是否UTC 要先講好


--
select q, sum(sum_fee) as value from (
   select q, sum(fee) as sum_fee from (
       select *, datepart(quarter, dd) as q from Bill
   ) as a
   group by q
   union all select 1, 0
   union all select 2, 0
   union all select 3, 0
   union all select 4, 0
) as a
group by q

--Epochtime 定義：距離格林威治時間 1970/1/1 0:0:0 有多少秒--每個系統單位不一樣有毫秒跟秒select DATEDIFF(s,'1970/1/1',getutcdate())select DATEADD(s,1711091659,'1970/1/1') + 8/24.0--------------------------------------------------------------------------drop trigger if exists trigger_userinfo_insertgocreate trigger trigger_userinfo_inserton Userinfofor insert, delete, updateasbegin    --宣告變數declare	declare @uid nvarchar(50)	declare @cname nvarchar(50)	--停止計算影響幾筆	set nocount on	 -- insert into sql command
   if not exists(select * from deleted) and exists(select * from inserted)
   begin
       select @uid = uid, @cname = cname from inserted
       if @cname is NULL
       BEGIN
           set @cname = 'NULL'
       END
       insert into Log (body) values (
           '在 UserInfo 資料表中插入一筆 uid='+@uid+', cname='+@cname+' 的資料'
       )
   end
   -- delete sql command
   if exists(select * from deleted) and not exists(select * from inserted)
   begin
       insert into Log (body) values ('刪除一筆資料')
   end


   -- update sql command
   if exists(select * from deleted) and exists(select * from inserted)
   begin
       insert into Log (body) values ('修改一筆資料')
   end


   -- no change
   if not exists(select * from deleted) and not exists(select * from inserted)
   begin
       set @cname = ''
   end
end

--要執行的insert into UserInfo (uid) values('Z03')select * from UserInfoselect * from Log