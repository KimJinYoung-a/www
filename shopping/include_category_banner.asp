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
' Discription : pc_leftcate_banner // cache DB경유
' History : 2019-02-15 원승현 생성
'#######################################################
Dim intI
Dim sqlStr , rsMem , arrList, poscode, vDisp
Dim gaParam : gaParam = "gaparam=left_cate_banner_" '//GA 체크 변수

'//DB 시간 타이머 00시부터 00시 5분 사이에는 DB 캐쉬 1분에 한번 읽기
Dim cTime , dummyName
If timer > 10 And Cint(timer/60) < 6 Then
	cTime = 60*1
	dummyName = "MBLCBAN_"&Cint(timer/60)
Else
	cTime = 60*1
	dummyName = "MBLCBAN_"
End If

vDisp = request("disp")

'// 좌측 카테고리 메뉴 배너
poscode = "725"

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

set rsMem = getDBCacheSQL(dbget, rsget, "MAINLEFTCATEBAN", sqlStr, cTime)
IF Not (rsMem.EOF OR rsMem.BOF) THEN
    arrList = rsMem.GetRows
END IF
rsMem.close

on Error Resume Next
Dim idx, linktype, fixtype, posVarname, imageurl, imagewidth, imageheight, startdate, enddate, regdate, reguserid, isusing, orderidx, linkText, linkurl
Dim itemDesc, workeruserid, imageurl2, linkText2, linkText3, linkText4, altname, lastupdate, bgcode, xbtncolor, maincopy, maincopy2, subcopy, etctag, etctext
Dim ecode, bannertype, altname2, bgcode2, linkurl2, evt_code, tag_only, targetOS, targetType, imageurl3, altname3, linkurl3, categoryOptions
Dim cateCheckIdx, allCheckIdx, checkIdx
checkIdx = ""
cateCheckIdx = ""
allCheckIdx = ""
%>

<%
If IsArray(baArrList) Then

    '// 카테고리에 맞는 이벤트 배너가 있는지 확인
    If vDisp <> "" Then
        For IntI = 0 To ubound(ArrList,2)
            If instr(ArrList(43, IntI),left(vDisp, 3))>0 Then
                cateCheckIdx = ArrList(0, IntI)
                Exit For
            End If
        Next
    End If

    '// 전체로 등록된 이벤트가 있는지 확인
    If checkIdx = "" Then
        For IntI = 0 To ubound(ArrList,2)
            If ArrList(43, IntI) = "" Then
                allCheckIdx = ArrList(0, IntI)
                Exit For
            End If
        Next
    End If

    '// 둘다 있을경우 가장 상위값 불러옴
    If cateCheckIdx<>"" And allCheckIdx<>"" THen
        checkIdx = ArrList(0, 0)
    Else
        If cateCheckIdx <> "" Then
            checkIdx = cateCheckIdx
        End If

        If allCheckIdx <> "" Then
            checkIdx = allCheckIdx
        End If
    End If
    For intI = 0 To ubound(arrlist,2)
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

        If checkIdx = idx Then
            Exit For
        Else
            linkurl = ""
            imageurl = ""
        End If
	Next

    '// link에 파라미터 있는지 체크
    If instr(linkurl, "?")>0 Then
        linkurl = db2Html(linkurl) & "&" &gaParam & "1"
    Else
        linkurl = db2Html(linkurl) & "?" &gaParam & "1"
    End If
%>
	<% If linkurl <> "" And imageurl <> "" Then %>
		<p class="bnr tMar10"><a href="<%=linkurl%>"><img src="<%=staticImgUrl & "/main/" + db2Html(imageurl)%>" alt="<%=altname%>" /></a></p>
	<% End If %>
<% End If %>
<% on Error Goto 0 %>
<!-- #include virtual="/lib/db/dbclose.asp" -->