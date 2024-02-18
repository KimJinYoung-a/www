<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'####################################################
' Description : 100원 마일리지 Bridge Page
' History : 2019-07-24 원승현
'####################################################
%>
<!-- #INCLUDE Virtual="/lib/util/commlib.asp" -->
<!-- #include Virtual="/lib/chkDevice.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/event/lib/event_etc_function.asp" -->
<%

dim eCode
IF application("Svr_Info") = "Dev" THEN
	eCode = "90354"
Else
	eCode = "96320"
End If
%>
<%
'============== 모바일 접근시 모바일 페이지 이동(referer가 10x10이면 이동안함) ============
if InStr(request.ServerVariables("HTTP_REFERER"),"10x10.co.kr")<1 then
	if Not(Request("mfg")="pc" or session("mfg")="pc") then
		if Not(flgDevice="W" or flgDevice="D" or flgDevice="T") then
			dim mRdSite: mRdSite = requestCheckVar(request("rdsite"),32)
			Response.Redirect "http://m.10x10.co.kr/event/eventmain.asp?eventid=" & eCode & chkIIF(mRdSite<>"","?rdsite=" & mRdSite,"") & chkIIF(gaparam<>"","&gaparam=" & gaparam,"")
			REsponse.End
		end if
	end if
end if
%>
<%
'공유관련
'// 쇼셜서비스로 글보내기 
Dim strPageTitle, strPageDesc, strPageUrl, strHeaderAddMetaTag, strPageImage, strPageKeyword
Dim strRecoPickMeta		'RecoPick환경변수
Dim vTitle, vLink, vPre, vImg, vIsEnd, vState, vNowTime, vCouponMaxCount
Dim snpTitle, snpLink, snpPre, snpTag, snpTag2, snpImg
snpTitle	= Server.URLEncode("[마일리지 이벤트] 텐바이텐 100마일리지")
snpLink		= Server.URLEncode("http://www.10x10.co.kr/event/eventmain.asp?eventid=" & eCode)
snpPre		= Server.URLEncode("10x10 이벤트")
snpImg		= Server.URLEncode("http://webimage.10x10.co.kr/fixevent/event/2019/95967/m/img_kakao.jpg")

'// Facebook 오픈그래프 메타태그 작성
strPageTitle = "[마일리지 이벤트]"
strPageKeyword = "이벤트"
strPageDesc = "[마일리지 이벤트] 매일매일 100 마일리지를 드리는 이벤트! 이벤트 신청하고 마일리지를 받아보세요."
strPageUrl = "http://www.10x10.co.kr/event/eventmain.asp?eventid=" & eCode
strPageImage = "http://webimage.10x10.co.kr/fixevent/event/2019/95967/m/img_kakao.jpg"
%>
<style type="text/css">
.sns-share {position:relative;}
.sns-share .sns {display:inline-block; position:absolute; top:0; left:653px; width:100px; height:100%; text-indent:-999em;}
.sns-share .sns.tw {left:770px;}

.noti {position:relative; padding:40px 0 40px 420px; background-color:#561d9c;}
.noti h3 {position:absolute; top:50%; left:245px; margin-top:-10px;}
.noti ul {font-size:14px; line-height:21px; color:#fff; font-family:'Roboto','Noto Sans KR','malgun Gothic','맑은고딕'; text-align:left;}
.noti ul li {padding:5px 0 5px 7px; text-indent:-7px; word-break:keep-all;}
</style>
<script>
$(function(){

});
</script>
<script type="text/javascript">
function snschk(snsnum) {
	if(snsnum == "tw") {
		popSNSPost('tw','<%=snpTitle%>','<%=snpLink%>','<%=snpPre%>','<%=snpTag2%>');		
	}else if(snsnum=="fb"){
		popSNSPost('fb','<%=snpTitle%>','<%=snpLink%>','','');		
	}else if(snsnum=="pt"){
		pinit('<%=snpLink%>','<%=snpImg%>');
	}
}
</script>
    <%' 96320 마일리지이벤트(브릿지) %>
    <div class="evt96320">
        <h2><img src="//webimage.10x10.co.kr/fixevent/event/2019/96219/tit_mileage.png" alt="마일리지 이벤트" /></h2>
        <div class="how-to1"><img src="//webimage.10x10.co.kr/fixevent/event/2019/96219/txt_how_to_1_v3.png" alt="이벤트 참여 방법 텐바이텐 앱 다운받기, 앱에서 알림허용하기, 이벤트페이지에서 push 신청하기" /></div>

        <%' sns공유 %>
        <div class="sns-share">
            <img src="//webimage.10x10.co.kr/fixevent/event/2019/96219/img_sns.png" alt="친구에게도 100마일리지 이벤트를 알려주세요!" />
            <a href="" onclick="snschk('fb');return false;" target="_blank" class="sns fb">페이스북 공유</a>
            <a href="" onclick="snschk('tw');return false;" target="_blank" class="sns tw">트위터 공유</a>
        </div>
        <%'// sns공유 %>

        <div class="noti">
            <h3><img src="//webimage.10x10.co.kr/fixevent/event/2019/96219/tit_noti.png" alt="이벤트 유의사항" /></h3>
            <ul>
                <li>- ID 당 하루에 1번씩 100 마일리지를 받을 수 있습니다</li>
                <li>- 이벤트 신청이 되지 않는 경우 이벤트 신청이 되지 않는 경우 &#60;푸시 수신 설정 방법&#62;을 꼭 확인해주세요.<br> 푸시 수신 동의는 APP에서 확인할 수 있습니다.</li>
                <li>- 도중에 푸시 수신을 해지하는 경우 알림을 받으실 수 없습니다.</li>
                <li>- 이벤트 PUSH 알림은 신청한 다음 날부터 발송됩니다.</li>
                <li>- 이벤트는 7월 31일까지만 진행됩니다.</li>
            </ul>
        </div>
    </div>
    <%' // 96320 마일리지이벤트(브릿지) %>
<!-- #include virtual="/lib/db/dbclose.asp" -->