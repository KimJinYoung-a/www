<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #INCLUDE Virtual="/lib/util/commlib.asp" -->
<style type="text/css">
  table tr td{    
    border: 1px solid #444444;
  }
</style>
<%
    dim eCode
    dim couponIdx, result, result1, result2, result3, result4,result5, result6, result7, result8, i, dayofStart
    couponIdx = request("couponidx")
    dayofStart = request ("startdate")

    dim SqlStr, SqlStr1, SqlStr2, SqlStr3, SqlStr4, SqlStr5, SqlStr6, SqlStr7, SqlStr8
    
IF application("Svr_Info") = "Dev" THEN
	eCode = "90247"	
Else
	eCode = "93355"
End If    

SqlStr1 = " select distinct t1.시간, t1.수, t2.쿠폰수 "
SqlStr1 = SqlStr1 & "   from (    "
SqlStr1 = SqlStr1 & " select *    "
SqlStr1 = SqlStr1 & " 	  from (    "
SqlStr1 = SqlStr1 & " 	 select a.시간  "
SqlStr1 = SqlStr1 & " 		 , count(a.수) as 수        "
SqlStr1 = SqlStr1 & " 	FROM (  "
SqlStr1 = SqlStr1 & " 		 SELECT left(CONVERT(VARCHAR, regdate, 120),13) as 시간 "
SqlStr1 = SqlStr1 & " 			  , count(userid) as 수     "
SqlStr1 = SqlStr1 & " 		  FROM [db_item].[dbo].tbl_user_item_coupon     "
SqlStr1 = SqlStr1 & " 		 WHERE 1 = 1        "
SqlStr1 = SqlStr1 & " 		   and itemcouponidx in (40091,40090,40089,40088)           "
SqlStr1 = SqlStr1 & " 		 group by userid, left(CONVERT(VARCHAR, regdate, 120),13)   "
SqlStr1 = SqlStr1 & " 	) AS A  "
SqlStr1 = SqlStr1 & " 	GROUP BY 시간   "
SqlStr1 = SqlStr1 & " ) as a  "
SqlStr1 = SqlStr1 & " )as t1  "
SqlStr1 = SqlStr1 & " ,(  "
SqlStr1 = SqlStr1 & " select *    "
SqlStr1 = SqlStr1 & "   from (    "
SqlStr1 = SqlStr1 & " 	SELECT left(CONVERT(VARCHAR, regdate, 120),13) as 시간  "
SqlStr1 = SqlStr1 & " 		, count(userid) as 쿠폰수   "
SqlStr1 = SqlStr1 & " 	FROM [db_item].[dbo].tbl_user_item_coupon   "
SqlStr1 = SqlStr1 & " 	WHERE 1 = 1     "
SqlStr1 = SqlStr1 & " 	and itemcouponidx in (40091,40090,40089,40088)          "
SqlStr1 = SqlStr1 & " 	group by left(CONVERT(VARCHAR, regdate, 120),13)    "
SqlStr1 = SqlStr1 & " ) as b  "
SqlStr1 = SqlStr1 & " )as t2  "
SqlStr1 = SqlStr1 & " where t1.시간 = t2.시간 "
SqlStr1 = SqlStr1 & " order by t1.시간 asc    "

 '--올해
SqlStr = " select a.일 "
SqlStr = SqlStr & "      , count(a.수) as 수    "
SqlStr = SqlStr & "   from (    "
SqlStr = SqlStr & "	 SELECT datepart(DD,regdate) as 일  "
SqlStr = SqlStr & "		  , count(userid) as 수 "
SqlStr = SqlStr & "	  FROM [db_item].[dbo].tbl_user_item_coupon "
SqlStr = SqlStr & "	 WHERE 1 = 1    "
SqlStr = SqlStr & "	   and itemcouponidx in (40091,40090,40089,40088)       "
SqlStr = SqlStr & "	 group by userid, datepart(DD,regdate)  "
SqlStr = SqlStr & " ) as a  "
SqlStr = SqlStr & " group by 일 "
SqlStr = SqlStr & " order by 일 "

 '--작년
SqlStr3 = " select a.일 "
SqlStr3 = SqlStr3 & "      , count(a.수) as 수    "
SqlStr3 = SqlStr3 & "   from (    "
SqlStr3 = SqlStr3 & "	 SELECT datepart(DD,regdate) as 일  "
SqlStr3 = SqlStr3 & "		  , count(userid) as 수 "
SqlStr3 = SqlStr3 & "	  FROM [db_item].[dbo].tbl_user_item_coupon "
SqlStr3 = SqlStr3 & "	 WHERE 1 = 1    "
SqlStr3 = SqlStr3 & "	   and itemcouponidx in (13739,13740,13741,13742,13787)       "
SqlStr3 = SqlStr3 & "	 group by userid, datepart(DD,regdate)  "
SqlStr3 = SqlStr3 & " ) as a  "
SqlStr3 = SqlStr3 & " group by 일 "
SqlStr3 = SqlStr3 & " order by 일 "

 '--작년 이시간
SqlStr2 = "  select a.일 "
SqlStr2 = SqlStr2 & "      , count(a.수) as 수    "
SqlStr2 = SqlStr2 & "   from (    "
SqlStr2 = SqlStr2 & "	SELECT datepart(DD,regdate) as 일   "
SqlStr2 = SqlStr2 & "		  , count(userid) as 수 "
SqlStr2 = SqlStr2 & "	  FROM [db_item].[dbo].tbl_user_item_coupon "
SqlStr2 = SqlStr2 & "	 WHERE 1 = 1    "
SqlStr2 = SqlStr2 & "	   and itemcouponidx in (13739,13740,13741,13742,13787)     "
SqlStr2 = SqlStr2 & "	   and datepart(DD,regdate) = " & dayofStart & " "
SqlStr2 = SqlStr2 & "	   and CONVERT(CHAR(12), regdate, 14) < CONVERT(CHAR(12), getdate(), 14)    "
SqlStr2 = SqlStr2 & "	 group by userid, datepart(DD,regdate)  "
SqlStr2 = SqlStr2 & " ) as a  "
SqlStr2 = SqlStr2 & " group by 일 "
SqlStr2 = SqlStr2 & " order by 일 asc "

SqlStr4 = " SELECT A.일 "
SqlStr4 = SqlStr4 & "	 , COUNT(A.수) AS 수    "
SqlStr4 = SqlStr4 & "  FROM (   "
SqlStr4 = SqlStr4 & "	SELECT COUNT(USERID) AS 수  "
SqlStr4 = SqlStr4 & "	    , CONVERT(CHAR(10), regdate, 23) AS 일   "
SqlStr4 = SqlStr4 & "	 FROM DB_EVENT.DBO.tbl_event_subscript  "
SqlStr4 = SqlStr4 & "	WHERE EVT_CODE = " & eCode
SqlStr4 = SqlStr4 & "	  AND SUB_OPT3 = 'DRAW' "
SqlStr4 = SqlStr4 & "	GROUP BY USERID, CONVERT(CHAR(10), regdate, 23)  "
SqlStr4 = SqlStr4 & "  ) AS A   "
SqlStr4 = SqlStr4 & "  GROUP BY 일  "
SqlStr4 = SqlStr4 & "  ORDER BY 일  "

SqlStr5 = "	SELECT CONVERT(CHAR(10), regdate, 23) AS 일 "
SqlStr5 = SqlStr5 & "	     , COUNT(USERID) AS 수  "
SqlStr5 = SqlStr5 & "	 FROM DB_EVENT.DBO.tbl_event_subscript  "
SqlStr5 = SqlStr5 & "	WHERE EVT_CODE = " & eCode
SqlStr5 = SqlStr5 & "	  AND SUB_OPT3 = 'DRAW' "
SqlStr5 = SqlStr5 & "	GROUP BY CONVERT(CHAR(10), regdate, 23)  "
SqlStr5 = SqlStr5 & "	ORDER BY CONVERT(CHAR(10), regdate, 23)  "


SqlStr6 = " SELECT 시간	 "
SqlStr6 = SqlStr6 & "	 , COUNT(A.수) AS 수 "
SqlStr6 = SqlStr6 & "  FROM ( "
SqlStr6 = SqlStr6 & "	SELECT left(CONVERT(VARCHAR, regdate, 120),13) as 시간 "
SqlStr6 = SqlStr6 & "		 , count(userid) as 수 "
SqlStr6 = SqlStr6 & "	  FROM DB_EVENT.DBO.tbl_event_subscript "
SqlStr6 = SqlStr6 & "	 WHERE EVT_CODE = " & eCode
SqlStr6 = SqlStr6 & "	   AND SUB_OPT3 = 'DRAW' "
SqlStr6 = SqlStr6 & "	 group by userid, left(CONVERT(VARCHAR, regdate, 120),13) "
SqlStr6 = SqlStr6 & "  ) AS A "
SqlStr6 = SqlStr6 & "  GROUP BY 시간 "
SqlStr6 = SqlStr6 & "  ORDER BY 시간 "



SqlStr7 = "	SELECT left(CONVERT(VARCHAR, regdate, 120),13) as 시간 "
SqlStr7 = SqlStr7 & "		 , count(userid) as 수  "
SqlStr7 = SqlStr7 & "	  FROM DB_EVENT.DBO.tbl_event_subscript "
SqlStr7 = SqlStr7 & "	 WHERE EVT_CODE = " & eCode
SqlStr7 = SqlStr7 & "	   AND SUB_OPT3 = 'DRAW'    "
SqlStr7 = SqlStr7 & "	 group by left(CONVERT(VARCHAR, regdate, 120),13)   "
SqlStr7 = SqlStr7 & "	 ORDER BY 시간   "
	 

SqlStr8 = " select 날짜 "
SqlStr8 = SqlStr8 & "		 , count(1) 신규유저    "
SqlStr8 = SqlStr8 & "	from (  "
SqlStr8 = SqlStr8 & "		select left(convert(varchar, a.regdate, 120), 10) as 날짜   "
SqlStr8 = SqlStr8 & "			 , count(1) as 수   "
SqlStr8 = SqlStr8 & "		  from db_event.dbo.tbl_event_subscript as a    "
SqlStr8 = SqlStr8 & "		 inner join db_user.dbo.tbl_user_n b on a.userid = b.userid "
SqlStr8 = SqlStr8 & "		 where evt_code = 93355 "
SqlStr8 = SqlStr8 & "		 AND SUB_OPT3 = 'DRAW' "
SqlStr8 = SqlStr8 & "		   and left(convert(varchar, a.regdate, 120), 10) = left(convert(varchar, b.regdate, 120), 10)  "
SqlStr8 = SqlStr8 & "		 group by a.userid, left(convert(varchar, a.regdate, 120), 10)  "
SqlStr8 = SqlStr8 & "	) as a  "
SqlStr8 = SqlStr8 & "	group by 날짜   "
SqlStr8 = SqlStr8 & "	order by 날짜   "

    'response.write SqlStr &"<br>"
    'response.end
    
    rsget.CursorLocation = adUseClient
    rsget.Open SqlStr, dbget, adOpenForwardOnly, adLockReadOnly
    
    if not rsget.EOF then
        result = rsget.getRows()	
    end if
    rsget.close		

    rsget.CursorLocation = adUseClient
    rsget.Open SqlStr3, dbget, adOpenForwardOnly, adLockReadOnly
    
    if not rsget.EOF then
        result3 = rsget.getRows()	
    end if
    rsget.close	

    rsget.CursorLocation = adUseClient
    rsget.Open SqlStr2, dbget, adOpenForwardOnly, adLockReadOnly
    
    if not rsget.EOF then
        result2 = rsget.getRows()	
    end if
    rsget.close		

    
    rsget.CursorLocation = adUseClient
    rsget.Open SqlStr4, dbget, adOpenForwardOnly, adLockReadOnly
    
    if not rsget.EOF then
        result4 = rsget.getRows()	
    end if
    rsget.close		

    rsget.CursorLocation = adUseClient
    rsget.Open SqlStr5, dbget, adOpenForwardOnly, adLockReadOnly
    
    if not rsget.EOF then
        result5 = rsget.getRows()	
    end if
    rsget.close	

    rsget.CursorLocation = adUseClient
    rsget.Open SqlStr8, dbget, adOpenForwardOnly, adLockReadOnly
    
    if not rsget.EOF then
        result8 = rsget.getRows()	
    end if
    rsget.close	    

    rsget.CursorLocation = adUseClient
    rsget.Open SqlStr6, dbget, adOpenForwardOnly, adLockReadOnly
    
    if not rsget.EOF then
        result6 = rsget.getRows()	
    end if
    rsget.close	


    rsget.CursorLocation = adUseClient
    rsget.Open SqlStr7, dbget, adOpenForwardOnly, adLockReadOnly
    
    if not rsget.EOF then
        result7 = rsget.getRows()	
    end if
    rsget.close

    rsget.CursorLocation = adUseClient
    rsget.Open SqlStr1, dbget, adOpenForwardOnly, adLockReadOnly
    
    if not rsget.EOF then
        result1 = rsget.getRows()	
    end if
    rsget.close	

response.write "<div>====================올해==================================================================================================================</div><br>"
    if isArray(result) then 
        for i=0 to uBound(result,2) 
            response.write "<div>"& result(0,i) &"일 : " & result(1,i) &"명</div><br>"																		
        next 
    end if 
%>
</table>
<% response.write "<div> **시간대별** </div><br>"             %>
<table>
    <tr>
        <td>일자</td>
        <td>발급자 수</td>
        <td>발급 횟수</td>
    </tr>
<%
    if isArray(result1) then 
        for i=0 to uBound(result1,2) 
        %>        
            <tr>
                <td><%=result1(0,i) & ":00"%></td>
                <td><%=result1(1,i)%></td>
                <td><%=result1(2,i)%></td>
            </tr>        
        <%
        next 
    end if 
%>
</table>
<%
response.write "<div>====================작년==================================================================================================================</div><br>"
    if isArray(result3) then 
        for i=0 to uBound(result3,2) 
            response.write "<div>"& result3(0,i) &"일 : " & result3(1,i) &"명</div><br>"																		
        next 
    end if 
response.write "<div>====================작년 4월" & dayofStart & "일 " & time() & "==================================================================================================================</div><br>"    
    if isArray(result2) then 
        for i=0 to uBound(result2,2) 
            response.write "<div>"& result2(0,i) &"일 : " & result2(1,i) &"명</div><br>"																		
        next 
    end if 
response.write "<div>======================100원의기적 참여인원수================================================================================================================</div><br>"        
%>
<table>
    <tr>
        <td>일자</td>
        <td>응모자수</td>
        <td>응모횟수</td>
        <td>신규 응모자 수</td>
    </tr>
<%
    if isArray(result4) then 
        for i=0 to uBound(result4,2) 
        %>        
            <tr>
                <td><%=result4(0,i)%></td>
                <td><%=result4(1,i)%></td>
                <td><%=result5(1,i)%></td>
                <td><%=result8(1,i)%></td>
            </tr>        
        <%
        next 
    end if 
%>
</table>
<% response.write "<div> **시간대별** </div><br>"             %>
<table>
    <tr>
        <td>일자</td>
        <td>응모자수</td>
        <td>응모횟수</td>
    </tr>
<%
    if isArray(result6) then 
        for i=0 to uBound(result6,2) 
        %>        
            <tr>
                <td><%=result6(0,i) & ":00"%></td>
                <td><%=result6(1,i)%></td>
                <td><%=result7(1,i)%></td>
            </tr>        
        <%
        next 
    end if 
%>
</table>
<!-- #include virtual="/lib/db/dbclose.asp" -->