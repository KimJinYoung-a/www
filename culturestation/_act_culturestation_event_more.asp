<%@ codepage="65001" language="VBScript" %>
<% Option Explicit %>
<% response.Charset="UTF-8" %>
<% Response.Buffer = True %>

<%
'#######################################################
'	History	:  2013.09.04 허진원 : 생성
'	Description : culturestation 메인 추가 페이지 Ajax
'#######################################################
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/inc_const.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/lib/classes/culturestation/_culturestation_class.asp" -->
<%
	'// 이벤트 목록 접수
	dim moreevent , i, chkBig, bnrImg
	dim page, etype, sortMtd, page2, mylist
	page = getNumeric(requestCheckVar(request("page"),5))
	page2 = getNumeric(requestCheckVar(request("page2"),5))
	etype = getNumeric(requestCheckVar(request("etype"),1))
	sortMtd = requestCheckVar(request("sort"),3)
	mylist = requestCheckVar(request("mylist"),1)
	if page="" then page=2
'	if etype="" then etype="0"
	if sortMtd="" then sortMtd="new"
If etype="" Then
Response.End
End If
	set moreevent = new cevent_list
	moreevent.FCurrPage = page2
	moreevent.FPageSize = 20 '한페이지 16개 (추가 접수는 18개)
	moreevent.frectevt_type = etype
	moreevent.frectSrotMtd = sortMtd
	If mylist="Y" Then
	moreevent.frectUserid = GetEncLoginUserID()
	End If
	moreevent.fevent_list_more()
	'// 이벤트 목록 출력
	if moreevent.FResultCount>0 then
		for i=0 to moreevent.FResultCount-1
%>
					<div class="conts<%=chkIIF(moreevent.FItemList(i).fevt_type="0"," feel"," read")%> end-evt" onClick="location.href='culturestation_event.asp?evt_code=<%=moreevent.FItemList(i).fevt_code%>'"> <!-- for dev msg // 느껴봐(영화,연극,뮤지컬)일 경우 feel / 읽어봐(도서)일 경우 read -->
						<p>종료된 <br/ >이벤트입니다 :)</p>
						<div class="info">
							<div class="thumbnail"><img src="<%=moreevent.FItemList(i).fimage_barner2%>" alt="" /></div>
							<div class="des">
								<div class="inner">
									<p class="category"><span><%=chkIIF(moreevent.FItemList(i).fevt_type="0","느껴봐","읽어봐")%></span></p>
									<p class="tit"><%=moreevent.FItemList(i).fevt_name%></p> <!--for dev msg // 2줄 이상은 말줄임표 -->
									<p class="present"><%=moreevent.FItemList(i).fevt_comment%></p>
									<p class="date"><%=formatDate(moreevent.FItemList(i).fstartdate,"0000.00.00") & " ~ " & formatDate(moreevent.FItemList(i).fenddate,"0000.00.00")%></p>
									<a href="culturestation_event.asp?evt_code=<%=moreevent.FItemList(i).fevt_code%>" class="enter">참여하기</a>
								</div>
							</div>
						</div>
						<div class="summary">
							<span class="label<%=chkIIF(moreevent.FItemList(i).fevt_kind="3"," musical","")%>"><%=moreevent.FItemList(i).GetKindName%></span><!-- for dev msg // 뮤지컬 일 경우 musical -->
							<span class="present"><%=moreevent.FItemList(i).fevt_comment%></span>
							<span class="numCmt"><%=chkIIF(moreevent.FItemList(i).fdcount>999,"999+",moreevent.FItemList(i).fdcount)%></span>
						</div>
					</div>
<%
		next
	end if
%>
<%
set moreevent = Nothing
%>

<!-- #include virtual="/lib/db/dbclose.asp" -->