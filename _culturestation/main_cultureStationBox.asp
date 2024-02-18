<%@ codepage="65001" language="VBScript" %>
<% Option Explicit %>
<% response.Charset="UTF-8" %>
<%
'#######################################################
'	History	:  2019.03.19 정태훈
'	Description : culturestation 메인 컬처에디터/당첨자 발표 박스
'#######################################################
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/inc_const.asp" -->
<!-- #include virtual="/lib/classes/culturestation/culturestation_class.asp" -->
<!-- #include virtual="/lib/classes/cscenter/BoardNoticecls.asp" -->
<%
dim oCulture , i
	'// 컬쳐 공지사항 목록
	set oCulture = New cBoardNotice
	oCulture.FRectNoticeOrder =7
	oCulture.FPageSize = 6
	oCulture.FCurrPage = 1
	oCulture.FRectNoticetype = "06"		'컬쳐스테이션
	oCulture.getNoticsList
%>
<div class="conts">
	<div class="notice">
		<div class="tit-winner">
			<h3><img src="http://fiximage.10x10.co.kr/web2017/culturestation/tit_winner.png" alt="당첨자 발표" /></h3>
			<p class="more"><a href="/common/news_popup.asp?type=06" onclick="window.open(this.href, 'popNotice', 'width=570, height=855, scrollbars=yes'); return false;" >more &gt;</a></p>
		</div>
		<ul class="notice-list">
		<%
			if oCulture.FresultCount>0 then
				for i=0 to oCulture.FresultCount-1
		%>
			<li<% if i=0 then %> class="new"<% end if %>><a href="/common/news_popup.asp?type=06&idx=<%=oCulture.FItemList(i).Fid%>" onclick="window.open(this.href, 'popNotice', 'width=570, height=855, scrollbars=yes'); return false;"><%=oCulture.FItemList(i).Ftitle%></a></li>
		<%
				next
			end if
		%>
		</ul>
	</div>
	<div class="bnr-thank"><a href="/cscenter/thanks10x10.asp"><img src="http://fiximage.10x10.co.kr/web2017/culturestation/img_bnr_thank.png" alt="" /></a></div>
</div>
<%
	set oCulture = Nothing
%>
<!-- #include virtual="/lib/db/dbclose.asp" -->