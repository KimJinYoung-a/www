<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<%
Response.AddHeader "Cache-Control","no-cache"
Response.AddHeader "Expires","0"
Response.AddHeader "Pragma","no-cache"
response.charset = "utf-8"
Session.Codepage = 65001
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #INCLUDE Virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/inc_const.asp" -->
<!-- #INCLUDE Virtual="/lib/chkDevice.asp" -->
<!-- #include virtual="/lib/util/DBcacheLib.asp" -->
<%
'#######################################################
' Discription : PC_Header_Upper // cache DB경유
' History : 2016-04-27 이종화 생성
'#######################################################
Dim poscode , intI ,intJ
Dim sqlStr , rsMem , arrList
Dim CtrlDate : CtrlDate = now()
Dim limitcnt : limitcnt = 0 '//최대 배너 갯수
Dim gaParam : gaParam = "&gaparam=main_mkt_" '//GA 체크 변수
poscode = 706

'//DB 시간 타이머 00시부터 00시 5분 사이에는 DB 캐쉬 1분에 한번 읽기
Dim cTime , dummyName
If timer > 10 And Cint(timer/60) < 6 Then
	cTime = 60*1
	dummyName = "WBIMG_"&Cint(timer/60)
Else
	cTime = 60*5
	dummyName = "WBIMG"
End If

IF poscode = "" THEN
	Call Alert_Return("잘못된 접근입니다.")
	response.End
END IF

Dim topcnt : topcnt = 1

sqlStr = "select top "& topcnt &" imageurl , linkurl , startdate ,  enddate , altname , bgcode , xbtncolor, imageurl2, bannertype, altname2, bgcode2, linkurl2 , imageurl3 , linkurl3 , altname3 from [db_sitemaster].[dbo].tbl_main_contents"
sqlStr = sqlStr & " where poscode = "& poscode &""
sqlStr = sqlStr & " and isusing = 'Y' and isnull(imageurl,'') <> '' "
sqlStr = sqlStr & " and startdate <= getdate() "
sqlStr = sqlStr & " and enddate >= getdate() "
sqlStr = sqlStr & " order by orderidx asc , idx desc , poscode asc   "

'Response.write sqlStr &"<br/>"

set rsMem = getDBCacheSQL(dbget, rsget, dummyName, sqlStr, cTime)
IF Not (rsMem.EOF OR rsMem.BOF) THEN
	arrList = rsMem.GetRows
END IF
rsMem.close

on Error Resume Next
If IsArray(arrList) Then
%>
<%
	Dim img , link , startdate ,  enddate , altname , bgcode , idname , xbtncolor , alink
	Dim amplitudemktval, img2, bannertype, altname2, bgcode2, link2, alink2 , img3 , link3 , alink3 , altname3
	idname = "btn"&Replace(Date(),"-","")
	For intI = 0 To ubound(arrlist,2)
		If CDate(CtrlDate) >= CDate(arrlist(2,intI)) AND CDate(CtrlDate) <= CDate(arrlist(3,intI)) Then

		img				= staticImgUrl & "/main/" + db2Html(arrlist(0,intI))
		link			= db2Html(arrlist(1,intI))
		startdate		= arrlist(2,intI)
		enddate			= arrlist(3,intI)
		altname			= db2Html(arrlist(4,intI))
		bgcode			= db2Html(arrlist(5,intI))
		xbtncolor		= arrlist(6,intI)

		img2			= staticImgUrl & "/main2/" + db2Html(arrlist(7,intI))
		bannertype		= arrlist(8,intI)
		altname2		= db2Html(arrlist(9,intI))
		bgcode2			= db2Html(arrlist(10,intI))
		link2			= db2Html(arrlist(11,intI))

		img3			= staticImgUrl & "/main3/" + db2Html(arrlist(12,intI))
		link3			= db2Html(arrlist(13,intI))
		altname3		= db2Html(arrlist(14,intI))

		alink = link & gaparamchk(link,gaParam) & "1"
		alink2 = link2 & gaparamchk(link2,gaParam) & "2"
		alink3 = link3 & gaparamchk(link3,gaParam) & "3"
%>
			<script>
			// 창열기
			function openWin(winName){
				if(getCookie(winName) == "done"){
					$(".top-bnrV18").css("display","none");
				}
				else{
					$(".top-bnrV18").css("display","block");
				}
			}

			$(function(){
				$(".top-bnrV18 .close").click(function(){
					$(".top-bnrV18").addClass("fold");
				});
			});

			openWin('<%=idname%>');

			function closeWin(winName, expiredays){
				setCookie(winName,"done",expiredays);
				if(winName=="<%=idname%>"){
					$.ajax({url:"/common/addlog.js?tp=topbnr_banner"});
					$(".top-bnrV18").addClass("fold");
				}
			}

			function setCookie(name, value, expiredays) {
				var todayDate = new Date();
				todayDate = new Date(parseInt(todayDate.getTime() / 86400000) * 86400000 + 54000000);
				if ( todayDate > new Date() )
				{
					expiredays = expiredays - 1;
				}
				todayDate.setDate( todayDate.getDate() + expiredays );
				document.cookie = name + "=" + escape( value ) + "; path=/; expires=" + todayDate.toGMTString() + ";"
			}
			</script>
			<% If bannertype="1" Then %>
			<div class="top-bnrV18" style="background-color:#<%=trim(bgcode)%>;display:<% if request.Cookies(""&idname&"") = "done" Then Response.write "none" %>">
				<a href="<%=alink%>" onclick="fnAmplitudeEventMultiPropertiesAction('click_header_topbanner','indexnumber|link','1|<%=alink%>');"><img src="<%=img%>" alt="<%=altname%>" /></a>
				<button type="button" class="close" onclick="closeWin('<%=idname%>', 1); return false;">
					<img src="http://fiximage.10x10.co.kr/web2017/common/btn_bnr_close_<%=chkiif(xbtncolor,"blck","whit")%>.gif" alt="배너 닫기" />
				</button>
			</div>
			<% Elseif bannertype="2" then %>
			<div class="top-bnrV18" style="background-color:#<%=trim(bgcode)%>;display:<% if request.Cookies(""&idname&"") = "done" Then Response.write "none" %>">
				<div class="inner">
					<a href="<%=alink%>" onclick="fnAmplitudeEventMultiPropertiesAction('click_header_topbanner','indexnumber|link','1|<%=alink%>');"><img src="<%=img%>" alt="<%=altname%>" /></a><a href="<%=alink2%>" onclick="fnAmplitudeEventMultiPropertiesAction('click_header_topbanner','indexnumber|link','2|<%=alink2%>');"><img src="<%=img2%>" alt="<%=altname2%>" /></a>
				</div>
				<div class="bg-right" style="background-color:#<%=trim(bgcode2)%>"></div>
				<button type="button" class="close" onclick="closeWin('<%=idname%>', 1); return false;">
					<img src="http://fiximage.10x10.co.kr/web2017/common/btn_bnr_close_<%=chkiif(xbtncolor,"blck","whit")%>.gif" alt="배너 닫기" />
				</button>
			</div>
			<% Elseif bannertype="3" then %>
			<div class="top-bnrV18" style="background-color:#<%=trim(bgcode)%>;display:<% if request.Cookies(""&idname&"") = "done" Then Response.write "none" %>">
				<div class="inner">
					<a href="<%=alink%>" onclick="fnAmplitudeEventMultiPropertiesAction('click_header_topbanner','indexnumber|link','1|<%=alink%>');"><img src="<%=img%>" alt="<%=altname%>" /></a>
					<a href="<%=alink2%>" onclick="fnAmplitudeEventMultiPropertiesAction('click_header_topbanner','indexnumber|link','2|<%=alink2%>');"><img src="<%=img2%>" alt="<%=altname2%>" /></a>
					<a href="<%=alink3%>" onclick="fnAmplitudeEventMultiPropertiesAction('click_header_topbanner','indexnumber|link','3|<%=alink3%>');"><img src="<%=img3%>" alt="<%=altname3%>" /></a>
					<button type="button" class="close" onclick="closeWin('<%=idname%>', 1); return false;"><img src="http://fiximage.10x10.co.kr/web2017/common/btn_bnr_close_<%=chkiif(xbtncolor,"blck","whit")%>.gif" alt="배너 닫기" /></button>
				</div>
				<div class="bg-right" style="background-color:#<%=trim(bgcode2)%>"></div><%'!-- 우측 컬러 --%>
			</div>
			<% End If %>
<%
		End if
	Next
%>
<%
End If
on Error Goto 0
%>
<!-- #include virtual="/lib/db/dbclose.asp" -->