--�򥻬d��(���N���)

--�ҽk�d��(Userinfo��� Like %)

--�d��null����k(Userinfo��� isnull())

--�d��d��(Bill���_��� <>=/between)

--�d�ߵ��G�Ƨ�(Bill �̤j&�̤p�Ƨ� order by (dsec))

--����(count())

--������p��(join ���pUserinfo House Phone)
--�n�Υ~���s���~�ॿ�T��X��null���ƾ�(left join or right join)

--��e�s��(�ۭ���i��)

--�b��s�չB��(SUM�`�M group by)(�qBill�����pHouse��� ���q�ܹ����a�}����B�`�M)

--�簣����(distinct)

--�s�W���O�W(as '�ۭq�W��')(�qbill��� �C�X��榳tel����fee�`�M���������R�W)

--�b���`�M�̤j��(top 1)

--�䷥�ݭ�?????

--�l�d��

--�L���ͦ� union ALL ���ͤ񰲸�� ���v�T�쥻��ƪ�
select Tel,sum(fee) as '�`�M'
from Bill
group by Tel

select *  
  from ( 
	select MAX(�`�M) as max_sum
	  from (
	    select Tel,sum(fee) as '�`�M'
        from Bill
        group by Tel
		) as x
	) as a,(
	   select Tel,sum(fee) as '�`�M'
       from Bill
       group by Tel
	   ) as b
	where a.max_sum = b.�`�M

