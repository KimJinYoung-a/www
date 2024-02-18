<%
'###########################################################
' Description :  브랜드스트리트
' History : 2013.08.29 한용민 생성
'###########################################################
%>
<%
dim mainidx, ointerview, ointerview_comment, ii, interviewpage
	mainidx = getNumeric(requestcheckvar(request("mainidx"),10))
	interviewpage = getNumeric(requestcheckvar(request("interviewpage"),10))

if interviewpage="" then interviewpage=1
if interview_cnt="" then interview_cnt=0
	
if interview_yn="Y" then

set ointerview = new cinterview
	ointerview.FRectDesignerId= makerid
	ointerview.frectidx= mainidx
	
	if makerid<>"" then	
		ointerview.finterviewsub_list
	end if
%>
<% if ointerview.FTotalCount>0 then %>
	<div class="wFix">
		<h4 class="line"><img src="http://fiximage.10x10.co.kr/web2013/brand/tit_interview.gif" alt="INTERVIEW" /></h4>
		<div class="interviewList">
			<% For ii=0 To ointerview.FTotalCount -1 %>
			<div class="interviewCont">
				<img src="<%=ointerview.FItemList(ii).fdetailimg%>" alt="NEWEST DESIGNER!" usemap="#interviewmap1"/>
				<%=ointerview.FItemList(ii).fdetailimglink%>
			</div>
			<% Next %>
			<button type="button" class="prevBtn">Prev</button>
			<button type="button" class="nextBtn">Next</button>
		</div>
	</div>
<% end if %>
<%
set ointerview = nothing
end if
%>
