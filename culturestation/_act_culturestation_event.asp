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
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/lib/inc_const.asp" -->
<!-- #include virtual="/lib/classes/culturestation/_culturestation_class.asp" -->
<%
	'// 이벤트 목록 접수
	dim oevent , i, chkBig, bnrImg
	dim page, etype, sortMtd, mylist
	page = getNumeric(requestCheckVar(request("page"),5))
	etype = getNumeric(requestCheckVar(request("etype"),1))
	sortMtd = requestCheckVar(request("sort"),3)
	mylist = requestCheckVar(request("mylist"),1)
	if page="" then page=2
'	if etype="" then etype="0"
	if sortMtd="" then sortMtd="new"
	set oevent = new cevent_list
	oevent.FCurrPage = page
	oevent.FPageSize = 20		'한페이지 18개
	oevent.frectevt_type = etype
	oevent.frectSrotMtd = sortMtd
	If mylist="Y" Then
	oevent.frectUserid = GetEncLoginUserID()
	End If
	oevent.fevent_list()

	'// 이벤트 목록 출력
	if oevent.FResultCount>0 then
		for i=0 to oevent.FResultCount-1
%>
					<div class="conts<%=chkIIF(oevent.FItemList(i).fevt_type="0"," feel"," read")%>" onClick="location.href='culturestation_event.asp?evt_code=<%=oevent.FItemList(i).fevt_code%>'"> <!-- for dev msg // 느껴봐(영화,연극,뮤지컬)일 경우 feel / 읽어봐(도서)일 경우 read -->
						<div class="info">
							<div class="thumbnail"><img src="<%=oevent.FItemList(i).fimage_barner2%>" alt="" /></div>
							<div class="des">
								<div class="inner">
									<p class="category"><span><%=chkIIF(oevent.FItemList(i).fevt_type="0","느껴봐","읽어봐")%></span></p>
									<p class="tit"><%=oevent.FItemList(i).fevt_name%></p> <!--for dev msg // 2줄 이상은 말줄임표 -->
									<p class="present"><%=oevent.FItemList(i).fevt_comment%></p>
									<p class="date"><%=formatDate(oevent.FItemList(i).fstartdate,"0000.00.00") & " ~ " & formatDate(oevent.FItemList(i).fenddate,"0000.00.00")%></p>
									<a href="culturestation_event.asp?evt_code=<%=oevent.FItemList(i).fevt_code%>" class="enter">참여하기</a>
								</div>
							</div>
						</div>
						<div class="summary">
							<span class="label<%=chkIIF(oevent.FItemList(i).fevt_kind="3"," musical","")%>"><%=oevent.FItemList(i).GetKindName%></span><!-- for dev msg // 뮤지컬 일 경우 musical -->
							<span class="present"><%=oevent.FItemList(i).fevt_comment%></span>
							<span class="numCmt"><%=chkIIF(oevent.FItemList(i).fdcount>999,"999+",oevent.FItemList(i).fdcount)%></span>
						</div>
					</div>
<%
		next
	end if
%>
<% If 20*page >= oevent.FTotalCount Then %>
<input type="hidden" id="more" value="Y">
<% End If %>
<%
	set oevent = Nothing
%>
<!-- #include virtual="/lib/db/dbclose.asp" -->