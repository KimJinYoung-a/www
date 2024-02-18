<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.charset = "UTF-8" %>
<%
'###########################################################
' Description : 서촌도감01 - 오프투얼론
' History : 2021.02.10 정태훈 생성
'###########################################################
%>
<!-- #include Virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/inc_const.asp" -->
<!-- #include Virtual="/lib/chkDevice.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/event/lib/event_etc_function.asp" -->
<!-- #include virtual="/lib/util/DBcacheLib.asp" -->
<!-- #include virtual="/lib/classes/enjoy/eventApplyCls.asp" -->
<!-- #include virtual="/lib/util/pageformlib.asp" -->
<!-- #include virtual="/lib/classes/item/itemInfoCls.asp" -->
<!-- #include virtual="/lib/classes/item/CategoryPrdCls.asp" -->
<%
dim oItem
dim currentDate, eventStartDate, eventEndDate
	currentDate =  now()
'	currenttime = #11/10/2017 09:00:00#

dim eCode
IF application("Svr_Info") = "Dev" THEN
	eCode   =  104316
Else
	eCode   =  109208
End If

dim userid, commentcount, i
	userid = GetEncLoginUserID()
dim cEComment ,blnFull, cdl, com_egCode, bidx, blnBlogURL, strBlogURL
dim iCTotCnt, arrCList,intCLoop, pagereload
dim iCPageSize, iCCurrpage, isMyComm
dim iCStartPage, iCEndPage, iCTotalPage, iCx,iCPerCnt
	iCCurrpage	= requestCheckVar(Request("iCC"),10)	'현재 페이지 번호
	cdl			= requestCheckVar(Request("cdl"),3)
	blnFull		= requestCheckVar(Request("blnF"),10)
	blnBlogURL	= requestCheckVar(Request("blnB"),10)
	isMyComm	= requestCheckVar(request("isMC"),1)
	pagereload	= requestCheckVar(request("pagereload"),2)

IF blnFull = "" THEN blnFull = True
IF blnBlogURL = "" THEN blnBlogURL = False

IF iCCurrpage = "" THEN
	iCCurrpage = 1
END IF
IF iCTotCnt = "" THEN
	iCTotCnt = -1
END IF

iCPerCnt = 10		'보여지는 페이지 간격
'한 페이지의 보여지는 열의 수
if blnFull then
	iCPageSize = 6		'풀단이면 15개			'/수기이벤트 둘다 강제 12고정
else
	iCPageSize = 6		'메뉴가 있으면 10개			'/수기이벤트 둘다 강제 12고정
end if

'데이터 가져오기
set cEComment = new ClsEvtComment
	cEComment.FECode 		= eCode
	cEComment.FComGroupCode	= com_egCode
	cEComment.FEBidx    	= bidx
	cEComment.FCPage 		= iCCurrpage	'현재페이지
	cEComment.FPSize 		= iCPageSize	'페이지 사이즈
	if isMyComm="Y" then cEComment.FUserID = userid
	cEComment.FTotCnt 		= iCTotCnt  '전체 레코드 수
	
	arrCList = cEComment.fnGetComment		'리스트 가져오기
	iCTotCnt = cEComment.FTotCnt '리스트 총 갯수
set cEComment = nothing

iCTotalPage 	=  Int(iCTotCnt/iCPageSize)	'전체 페이지 수
IF (iCTotCnt MOD iCPageSize) > 0 THEN	iCTotalPage = iCTotalPage + 1

Function fnDisplayPaging_New2(strCurrentPage, intTotalRecord, intRecordPerPage, intBlockPerPage, strJsFuncName)
	'변수 선언
	Dim intCurrentPage, strCurrentPath, vPageBody
	Dim intStartBlock, intEndBlock, intTotalPage
	Dim strParamName, intLoop

	'현재 페이지 설정
	intCurrentPage = strCurrentPage		'현재 페이지 값

	'해당페이지에 표시되는 시작페이지와 마지막페이지 설정
	intStartBlock = Int((intCurrentPage - 1) / intBlockPerPage) * intBlockPerPage + 1
	intEndBlock = Int((intCurrentPage - 1) / intBlockPerPage) * intBlockPerPage + intBlockPerPage

	'총 페이지 수 설정
	intTotalPage =   int((intTotalRecord-1)/intRecordPerPage) +1
	''eastone 추가
	if (intTotalPage<1) then intTotalPage=1

	vPageBody = ""
	strJsFuncName = trim(strJsFuncName)

	vPageBody = vPageBody & "<ul class=""pagination-wrap"">" & vbCrLf

	'## 이전 페이지
	If intStartBlock > 1 Then
	    vPageBody = vPageBody & "<li class=""prev""><a href=""#"" onclick=""" & strJsFuncName & "(" & intStartBlock-1 & ");return false;""><img src=""//webimage.10x10.co.kr/fixevent/event/2021/109208/icon_left.png"" alt=""left arrow""></a></li>" & vbCrLf
	Else
        vPageBody = vPageBody & "<li class=""prev""><a href=""#"" onclick=""return false;""><img src=""//webimage.10x10.co.kr/fixevent/event/2021/109208/icon_left.png"" alt=""left arrow""></a></li>" & vbCrLf
	End If

	'## 현재 페이지
	If intTotalPage > 1 Then
		For intLoop = intStartBlock To intEndBlock
			If intLoop > intTotalPage Then Exit For
			If Int(intLoop) = Int(intCurrentPage) Then
				vPageBody = vPageBody & "<li><a href=""#"" onclick=""" & strJsFuncName & "(" & intLoop & ");return false;"">" & intLoop & "</a></li>" & vbCrLf
			Else
				vPageBody = vPageBody & "<li><a href=""#"" onclick=""" & strJsFuncName & "(" & intLoop & ");return false;"">" & intLoop & "</a></li>" & vbCrLf
			End If
		Next
	Else
		vPageBody = vPageBody & "<li><a href=""#"" onclick=""" & strJsFuncName & "(1);return false;"">1</a></li>" & vbCrLf
	End If

	'## 다음 페이지
	If Int(intEndBlock) < Int(intTotalPage) Then	'####### 다음페이지
        vPageBody = vPageBody & "<li class=""next""><a href=""#"" onclick=""" & strJsFuncName & "(" & intEndBlock+1 & ");return false;""><img src=""//webimage.10x10.co.kr/fixevent/event/2021/109208/icon_right.png"" alt=""right arrow""></a></li>" & vbCrLf
	Else
        vPageBody = vPageBody & "<li class=""next""><a href=""#"" onclick=""return false;""><img src=""//webimage.10x10.co.kr/fixevent/event/2021/109208/icon_right.png"" alt=""right arrow""></a></li>" & vbCrLf
	End If



	vPageBody = vPageBody & "</ul>" & vbCrLf

	fnDisplayPaging_New2 = vPageBody
End Function
%>
                        <div class="comment-list-wrap">
                    <% IF isArray(arrCList) THEN %>
                        <% For intCLoop = 0 To UBound(arrCList,2) %>
                            <div class="event-comment-area">
                                <% if ((GetLoginUserID = arrCList(2,intCLoop)) or (GetLoginUserID = "10x10")) and ( arrCList(2,intCLoop)<>"") then %>
                                <button type="button" class="comment-close" onclick="fndelComment(<%=arrCList(0,intCLoop)%>)"><img src="//webimage.10x10.co.kr/fixevent/event/2021/109208/icon_close02.png" alt="삭제"></button>
                                <% End If %>
                                <p class="num">NO. <%=iCTotCnt-intCLoop-(iCPageSize*(iCCurrpage-1))%></p>
                                <div class="img">
                                    <img src="//webimage.10x10.co.kr/fixevent/event/2021/109208/item_charcter0<%=arrCList(3,intCLoop)%>.png" alt="charcter" class="character-01">
                                </div>
                                <p class="id"><span><%=printUserId(arrCList(2,intCLoop),2,"*")%></span>님</p>
                                <div class="txt"><%=ReplaceBracket(db2html(arrCList(1,intCLoop)))%></div>
                            </div>
                        <% next %>
                    <% End If %>
                        </div>
                        <div>
                        <%= fnDisplayPaging_New2(iCCurrpage,iCTotCnt,iCPageSize,iCPerCnt,"jsGoComPage") %>
                        </div>
<!-- #include virtual="/lib/db/dbclose.asp" -->