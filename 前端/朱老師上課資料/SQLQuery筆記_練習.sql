--基本查詢(任意表單)

--模糊查詢(Userinfo表單 Like %)

--查詢null的方法(Userinfo表單 isnull())

--範圍查詢(Bill表單_兩種 <>=/between)

--查詢結果排序(Bill 最大&最小排序 order by (dsec))

--算比數(count())

--表單關聯性(join 串聯Userinfo House Phone)
--要用外部連結才能正確抓出有null的數據(left join or right join)

--交叉連結(相乘兩張表)

--帳單群組運算(SUM總和 group by)(從Bill表單串聯House表單 找到電話對應地址跟金額總和)

--剔除重複(distinct)

--新增欄位別名(as '自訂名稱')(從bill表單 列出表單有tel欄位跟fee總和並幫該欄位命名)

--帳單總和最大的(top 1)

--找極端值?????

--子查詢

--無中生有 union ALL 產生比假資料 不影響原本資料表
select Tel,sum(fee) as '總和'
from Bill
group by Tel

select *  
  from ( 
	select MAX(總和) as max_sum
	  from (
	    select Tel,sum(fee) as '總和'
        from Bill
        group by Tel
		) as x
	) as a,(
	   select Tel,sum(fee) as '總和'
       from Bill
       group by Tel
	   ) as b
	where a.max_sum = b.總和

