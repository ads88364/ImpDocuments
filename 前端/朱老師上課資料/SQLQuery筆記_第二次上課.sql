--��°���d�� select �|���ͤ@�Ӹ�ƪ�� �i�H��create view �ӫإ߷s��ƪ� �ΨӫO�@��Ʀw����
--�~���H���u��d�� select * from vw_users �åB��ƬO��Ū��

--�R�����
--drop view vw_users 
--create view vw_users as

select a.uid, cname ,address
from UserInfo as a ,Live as b, House as c
where a.uid = b.uid and b.hid = c.hid

--�s�W/�ק�/�R�� �ۤv��

--��� => ����Ʋ��ʦ��_�쪺����
begin transaction
    delete from UserInfo
	delete from House

    --rollback �T�{������Ѵ_��
    --commit �T�{������\

select * from bill


--Pivot �V �ϯ��ഫ
select * from(
    select year(dd) as y ,month(dd)/4+1 as m, fee from Bill
) as tmp
pivot (
    sum(fee)
	for m in ([1],[2],[3],[4])
) as pvt
where y = 2019

--�s�W�@����ƶi�h
--insert into Bill(Tel,fee,hid,dd) values

--�m��pivot �n�����D��ƺ��� Y�b�~��]�w
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

--��Ƹ�0 union all�Ϊk
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


--��u�Ĥ@���W�� �p�G��ƪ�S����u ���ɱϤ�k
select sid, value into new_table from (
    --�H�U�O�H�ϥ��W�ƪ���
    select 'A01' as sid, '�ƾ�,���z,�ƾ�' as courses
    union all
    select 'A02' as sid, '�ƾ�,�ƾ�' as courses
) as a cross apply string_split(courses, ',') as tmp
    --�w�r�I�����ɤ��r��


--ASP.Net Core ������X�@�qjson�榡��� �i�H���e�ݤ��ݳ��i�H�� 
app.MapGet("/", (HttpResponse response, DB db) =>
{
    FormattableString sql = $@"

	    ----�u�n��o�q----
        select * from (
            select 'A01' as sid, '���j��' as cname, 'hw1' as hw, 1 as 'ok'
            union all
            select 'A01' as sid, '���j��' as cname, 'hw2' as hw, 1 as 'ok'
            union all
            select 'A01' as sid, '���p��' as cname, 'hw3' as hw, 1 as 'ok'
            union all
            select 'A02' as sid, '���p�f' as cname, 'hw1' as hw, 1 as 'ok'
            union all
            select 'A02' as sid, '���p�f' as cname, 'hw3' as hw, 1 as 'ok'
        ) as tmp
        pivot (
            sum(ok)
            for hw in ([hw1], [hw2], [hw3])
        ) as pvt
		----�u�n��o�q----

        for json path, include_null_values
    ";
 
    response.Headers.ContentType = "application/json";
    var records = db.Database.SqlQuery<string>(sql).ToArray();
    return records[0];
});


--�e��ݤ��� �s�W�e�� josn���
insert into UserInfo (uid, cname)
select * from openjson(N'{
        "uid": "Z01",
        "cname": "Tom"
}')
 with (
    uid nvarchar(50) '$.uid',
    cname nvarchar(50) '$.cname'
)

--���ͤ@��id ���e��ݥi�H�ϥ�
select *,newid() as id from UserInfo

--�ɶ����
--format�X�ӬO�r�� year�X�ӬO�r��
select concat('���إ���',year(getdate())-1911, format(getdate(), '�褸yyyy�~M��d��'))

select *, concat('���إ���',year(getdate())-1911, format(getdate(), '�褸yyyy�~M��d��')) as cdate
from Bill


--�ʶ��ɹs�U��fn => ��'1'���a��N�n
select right(concat('000','1'),3)