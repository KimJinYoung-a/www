<%@ codepage="65001" language="VBScript" %>
<% Option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/lib/classes/shopping/sp_evaluatesearchercls.asp" -->
<!-- #include virtual="/lib/classes/item/CategoryCls.asp" -->
<!-- #include virtual="/lib/util/pageformlib.asp" -->
<%
    '요 페이지를 사용하는곳(goodsusing.asp, index.asp, incMytentenLnb.asp)
    '####### 적립예상마일리지.
    '### 마케팅 두배이벤트시 그때그때 달라지므로 따로.
    '0 ~ 1 : count(*) AS totalcnt, isNull(SUM(CASE WHEN i.evalcnt > 0 THEN 100 ELSE 200 END),0) AS totalgetmile, 
    '2 ~ 3 : sum(Case When i.evalcnt>0 then 1 else 0 end) AS cnt, sum(Case When i.evalcnt=0 then 1 else 0 end) AS firstcnt

    dim userid
    userid      = getEncLoginUserID
    If IsUserLoginOK Then
        Dim cMil, vMileArr, vMileValue, vIsMileEvent

        If Now() > #02/05/2020 00:00:00# AND Now() < #02/09/2020 23:59:59# Then
            vIsMileEvent = "o"
            vMileValue = 200
        Else
            vIsMileEvent = "x"
            vMileValue = 100
        End If

        Set cMil = New CEvaluateSearcher
        cMil.FRectUserID = Userid
        cMil.FRectMileage = vMileValue
        vMileArr = cMil.getEvaluatedTotalMileCnt
        Set cMil = Nothing
        if vMileArr(0,0) > 0 Then
            response.write vMileArr(0,0)&"||"&FormatNumber(vMileArr(1,0),0)&"||"&vIsMileEvent
        Else
            response.write "Err||EvalEmpty"
        End If
    Else
        response.write "Err||NotLogin"
    End If
%>
<!-- #include virtual="/lib/db/dbclose.asp" -->