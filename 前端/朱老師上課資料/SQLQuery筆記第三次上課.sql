--�ɶ��p�ⵧ�O


--�p�߭p��|���p�ư��D
select dateadd(day,-5, getdate())


--�p��~�� .25�]���|�~ �i�H�Φa�O���k�o����
select datediff(DAY,'2023/1/1',GETDATE()) / 365.25


--�{�b�P���Xweekday/year/day
select datepart(WEEKDAY, getdate())


--�ۭq�榡
select format(getdate(), '�褸yyyy�~')
--datepart/format�X�Ӹ�ƫ��A���@��int/


--�ɶ�����h���s�Y(�����!!!)
select datetrunc(DAY,getdate())


--�@�ɨ�ծɶ�(���a�ɰϸ�T���@�ɨ�ծɶ�)
select getdate(),GETUTCDATE()
--��ȤW��Ʈw�s���ɶ��n�W�w�n�n���n�ɰ� �q�`���O���a�ɰ�(�e��ݦۤv�B�z) �~���|�ñ�
--SQL server�s���Ʈw���|��ɰϸ�T�s�i�h �ҥH�|�����D�O�_UTC �n�����n


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

--Epochtime �w�q�G�Z����L�ªv�ɶ� 1970/1/1 0:0:0 ���h�֬�--�C�Өt�γ�줣�@�˦��@����select DATEDIFF(s,'1970/1/1',getutcdate())select DATEADD(s,1711091659,'1970/1/1') + 8/24.0--------------------------------------------------------------------------drop trigger if exists trigger_userinfo_insertgocreate trigger trigger_userinfo_inserton Userinfofor insert, delete, updateasbegin    --�ŧi�ܼ�declare	declare @uid nvarchar(50)	declare @cname nvarchar(50)	--����p��v�T�X��	set nocount on	 -- insert into sql command
   if not exists(select * from deleted) and exists(select * from inserted)
   begin
       select @uid = uid, @cname = cname from inserted
       if @cname is NULL
       BEGIN
           set @cname = 'NULL'
       END
       insert into Log (body) values (
           '�b UserInfo ��ƪ����J�@�� uid='+@uid+', cname='+@cname+' �����'
       )
   end
   -- delete sql command
   if exists(select * from deleted) and not exists(select * from inserted)
   begin
       insert into Log (body) values ('�R���@�����')
   end


   -- update sql command
   if exists(select * from deleted) and exists(select * from inserted)
   begin
       insert into Log (body) values ('�ק�@�����')
   end


   -- no change
   if not exists(select * from deleted) and not exists(select * from inserted)
   begin
       set @cname = ''
   end
end

--�n���檺insert into UserInfo (uid) values('Z03')select * from UserInfoselect * from Log