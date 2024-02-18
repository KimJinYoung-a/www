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
' Discription : pc_main_popup_banner // cache DB경유
' History : 2019-03-13 원승현 생성
'#######################################################
Dim intI
Dim sqlStr , rsMem , arrList, poscode
Dim gaParam : gaParam = "gaparam=main_popupbanner" '//GA 체크 변수

'//DB 시간 타이머 00시부터 00시 5분 사이에는 DB 캐쉬 1분에 한번 읽기
Dim cTime , dummyName
If timer > 10 And Cint(timer/60) < 6 Then
	cTime = 60*1
	dummyName = "MBMPB_"&Cint(timer/60)
Else
	cTime = 60*1
	dummyName = "MBEMPB"
End If

'// 메인 팝업 배너(poscode)
poscode = "736"

sqlStr = " SELECT idx " & vbcrlf
sqlStr = sqlStr & "	, poscode, linktype, fixtype " & vbcrlf
sqlStr = sqlStr & "	, posVarname, imageurl, linkurl " & vbcrlf
sqlStr = sqlStr & "	, imagewidth, imageheight, startdate " & vbcrlf
sqlStr = sqlStr & "	, enddate, regdate, reguserid " & vbcrlf
sqlStr = sqlStr & "	, isusing, orderidx, linkText " & vbcrlf
sqlStr = sqlStr & "	, itemDesc, workeruserid, imageurl2 " & vbcrlf
sqlStr = sqlStr & "	, linkText2, linkText3, linkText4 " & vbcrlf
sqlStr = sqlStr & "	, altname, lastupdate, bgcode " & vbcrlf
sqlStr = sqlStr & "	, xbtncolor, maincopy, maincopy2 " & vbcrlf
sqlStr = sqlStr & "	, subcopy, etctag, etctext " & vbcrlf
sqlStr = sqlStr & "	, ecode, bannertype, altname2 " & vbcrlf
sqlStr = sqlStr & "	, bgcode2, linkurl2, evt_code " & vbcrlf
sqlStr = sqlStr & "	, tag_only, targetOS, targetType " & vbcrlf
sqlStr = sqlStr & "	, imageurl3, altname3, linkurl3 " & vbcrlf
sqlStr = sqlStr & "	, categoryOptions " & vbcrlf
sqlStr = sqlStr & " FROM db_sitemaster.dbo.tbl_main_contents " & vbcrlf
sqlStr = sqlStr & " WHERE poscode='"&poscode&"' " & vbcrlf
sqlStr = sqlStr & "	    AND getdate() >= startdate AND getdate() <= enddate " & vbcrlf
sqlStr = sqlStr & "	    AND isusing='Y' " & vbcrlf
sqlStr = sqlStr & " ORDER BY orderidx ASC, idx DESC "

set rsMem = getDBCacheSQL(dbget, rsget, "MAINPOPUPBAN", sqlStr, cTime)
IF Not (rsMem.EOF OR rsMem.BOF) THEN
    arrList = rsMem.GetRows
END IF
rsMem.close

on Error Resume Next
Dim idx, linktype, fixtype, posVarname, imageurl, imagewidth, imageheight, startdate, enddate, regdate, reguserid, isusing, orderidx, linkText, linkurl
Dim itemDesc, workeruserid, imageurl2, linkText2, linkText3, linkText4, altname, lastupdate, bgcode, xbtncolor, maincopy, maincopy2, subcopy, etctag, etctext
Dim ecode, bannertype, altname2, bgcode2, linkurl2, evt_code, tag_only, targetOS, targetType, imageurl3, altname3, linkurl3, categoryOptions
%>

<%
If IsArray(arrList) Then
	'// 한개만 가져오는거라 For 필요 없음.
    'For intI = 0 To ubound(arrlist,2)
        intI = 0
        idx             = arrlist(0, intI)  '// 고유값
        poscode         = arrlist(1, intI)  '// 배너코드
        linktype        = arrlist(2, intI)  '// 링크구분
        fixtype         = arrlist(3, intI)  '// 적용구분
        posVarname      = arrlist(4, intI)  '// 배너변수명
        imageurl        = arrlist(5, intI)  '// 이미지1url
        linkurl         = arrlist(6, intI)  '// 이미지1linkurl
        imagewidth      = arrlist(7, intI)  '// 이미지 가로사이즈
        imageheight     = arrlist(8, intI)  '// 이미지 세로사이즈
        startdate       = arrlist(9, intI)  '// 시작일
        enddate         = arrlist(10, intI) '// 종료일
        regdate         = arrlist(11, intI) '// 등록일
        reguserid       = arrlist(12, intI) '// 등록자아이디
        isusing         = arrlist(13, intI) '// 사용여부
        orderidx        = arrlist(14, intI) '// 정렬순서
        linkText        = arrlist(15, intI) '// 링크텍스트1
        itemDesc        = arrlist(16, intI) '// 작업요청사항
        workeruserid    = arrlist(17, intI) '// 최종작업자
        imageurl2       = arrlist(18, intI) '// 이미지2url
        linkText2       = arrlist(19, intI) '// 링크텍스트2
        linkText3       = arrlist(20, intI) '// 링크텍스트3
        linkText4       = arrlist(21, intI) '// 링크텍스트4
        altname         = arrlist(22, intI) '// 알트명1
        lastupdate      = arrlist(23, intI) '// 최종수정일
        bgcode          = arrlist(24, intI) '// 배경색상코드
        xbtncolor       = arrlist(25, intI) '// 폰트컬러
        maincopy        = arrlist(26, intI) '// 메인카피
        maincopy2       = arrlist(27, intI) '// 메인카피2
        subcopy         = arrlist(28, intI) '// 서브카피
        etctag          = arrlist(29, intI) '// 태그
        etctext         = arrlist(30, intI) '// 기타 텍스트(검색상단마케팅에선 키워드로 사용)
        ecode           = arrlist(31, intI) '// 컬쳐스테이션이벤트id
        bannertype      = arrlist(32, intI) '// 배너타입(갯수)
        altname2        = arrlist(33, intI) '// 알트명2
        bgcode2         = arrlist(34, intI) '// 배경색상코드2
        linkurl2        = arrlist(35, intI) '// 이미지2linkurl2
        evt_code        = arrlist(36, intI) '// 이벤트 코드
        tag_only        = arrlist(37, intI) '// 태그여부
        targetOS        = arrlist(38, intI) '// 노출할 플랫폼
        targetType      = arrlist(39, intI) '// 노출할 유저타겟
        imageurl3       = arrlist(40, intI) '// 이미지3url
        altname3        = arrlist(41, intI) '// 알트명3
        linkurl3        = arrlist(42, intI) '// 링크url3
        categoryOptions = arrlist(43, intI) '// 카테고리 코드(","구분자로 여러개의 카테고리 1뎁스 코드가 들어가 있음)
	'Next

    '// link에 파라미터 있는지 체크
    If instr(linkurl, "?")>0 Then
        linkurl = db2Html(linkurl) & "&" &gaParam
    Else
        linkurl = db2Html(linkurl) & "?" &gaParam
    End If
%>
	<% If linkurl <> "" And imageurl <> "" Then %>
		<style>
		#mask {background-color:#000; background-color:rgba(0,0,0,.75); background-image:none;}
		.front-bnr {position:fixed; left:50%; top:50%; z-index:99999; -webkit-transform:translate(-50%,-50%); transform:translate(-50%,-50%); display:none}
		.front-bnr p a {display:block;}
		.front-bnr img {vertical-align:top;}
		.front-bnr button {position:absolute; bottom:-45px; height:45px; background-color:transparent; background-repeat:no-repeat; outline:0;}
		.front-bnr .btn-anymore {left:0; padding-left:35px; font-family:'AppleSDGothicNeo-Regular'; font-size:15px; color:#fff; background-image:url(//webimage.10x10.co.kr/fixevent/event/2018/baroquick/btn_today_close.png); background-position:2px 50%; background-size:23px;}
		.front-bnr .btn-close {right:-7px; width:45px; text-indent:-999em; background-image:url(//webimage.10x10.co.kr/fixevent/event/2018/baroquick/btn_close.png); background-position:50% 50%; background-size:25px;}
		</style>
		<script>
			$(function(){
				var maskW = $(document).width();
				var maskH = $(document).height();
				$('#mask').css({'width':maskW,'height':maskH});		

				mainPopup();
				$('#mask').click(function(){
					$(".front-bnr").hide();
					$('#mask').hide();
				});		
			})
			function mainPopup(){//팝업띄우기		
				var popCookie = getPopupCookie("todayPopupCookie");	
				var tempCookie = getPopupCookie("tempPopupCookie");		
				if(tempCookie){
					return false;
				}
				if(!popCookie){			
					$(".front-bnr").show();
					$('#boxes').show();
					$('#mask').show();						
				}
			}
			function mainPopUpClose(){
				$(".front-bnr").hide();		
				$('#mask').hide();	
			}
			function mainPopUpCloseJustToday(){	//오늘 그만보기
				setPopupCookie("todayPopupCookie", "done", 1)
				$(".front-bnr").hide();
				$('#mask').hide();
			}	
			// 쿠키 가져오기
			function getPopupCookie( name ) {
				var nameOfCookie = name + "=";
				var x = 0;
				while ( x <= document.cookie.length )
				{
					var y = (x+nameOfCookie.length);
					if ( document.cookie.substring( x, y ) == nameOfCookie ) {
						if ( (endOfCookie=document.cookie.indexOf( ";", y )) == -1 )
							endOfCookie = document.cookie.length;
						return unescape( document.cookie.substring( y, endOfCookie ) );
					}
					x = document.cookie.indexOf( " ", x ) + 1;
					if ( x == 0 )
						break;
				}
				return "";
			}	
			function setTempPopupCookie( name, value, expiredays ) {
				var todayDate = new Date();
				todayDate.setTime(todayDate.getTime() + 1*2000);
				document.cookie = name + "=" + escape( value ) + "; path=/; expires=" + todayDate.toGMTString() + ";"
			}
			function setPopupCookie( name, value, expiredays ) {
				var todayDate = new Date();
				todayDate.setDate( todayDate.getDate() + expiredays );
				document.cookie = name + "=" + escape( value ) + "; path=/; expires=" + todayDate.toGMTString() + ";"
			}	
		</script>

		<div class="front-bnr">
			<p><a href="<%=linkurl%>" onclick="fnAmplitudeEventMultiPropertiesAction('click_mainlayerpopup','type|linkurl','click|<%=linkurl%>');"><img src="<%=staticImgUrl & "/main/" + db2Html(imageurl)%>" alt="<%=altname%>" /></a></p>
			<div class="btn-group">
				<button type="button" class="btn-anymore" onclick="mainPopUpCloseJustToday();fnAmplitudeEventMultiPropertiesAction('click_mainlayerpopup','type|linkurl','neverview|<%=linkurl%>');">다시보지 않기</button>
				<button type="button" class="btn-close" onclick="mainPopUpClose();fnAmplitudeEventMultiPropertiesAction('click_mainlayerpopup','type|linkurl','close|<%=linkurl%>');">닫기</button>
			</div>
		</div>
	<% End If %>
<% End If %>
<% on Error Goto 0 %>
<!-- #include virtual="/lib/db/dbclose.asp" -->