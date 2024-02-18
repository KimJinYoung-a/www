<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%Response.Addheader "P3P","policyref='/w3c/p3p.xml', CP='NOI DSP LAW NID PSA ADM OUR IND NAV COM'"%>
<%
Response.AddHeader "Cache-Control","no-cache"
Response.AddHeader "Expires","0"
Response.AddHeader "Pragma","no-cache"
%>
<!-- #include virtual="/lib/inc_const.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/util/tenSessionLib.asp" -->
<%
dim backpath

backpath = request("backpath")

Dim iCookieDomainName : iCookieDomainName = GetCookieDomainName

response.Cookies("tinfo").domain = iCookieDomainName ''"10x10.co.kr"
response.Cookies("tinfo") = ""
response.Cookies("tinfo").Expires = Date - 1

response.Cookies("etc").domain = iCookieDomainName ''"10x10.co.kr"
response.Cookies("etc") = ""
response.Cookies("etc").Expires = Date - 1

response.Cookies("mybadge").domain = iCookieDomainName ''"10x10.co.kr"
response.Cookies("mybadge") = ""
response.Cookies("mybadge").Expires = Date - 1

response.Cookies("myalarm").domain = iCookieDomainName ''"10x10.co.kr"
response.Cookies("myalarm") = ""
response.Cookies("myalarm").Expires = Date - 1

response.Cookies("todayviewitemidlist").domain = iCookieDomainName ''"10x10.co.kr"
response.cookies("todayviewitemidlist") = ""
response.Cookies("todayviewitemidlist").Expires = Date - 1

''2017/05/26
response.Cookies("rdsite").domain = iCookieDomainName ''"10x10.co.kr"
response.cookies("rdsite") = ""
response.Cookies("rdsite").Expires = Date - 1

''2018/08/15
response.Cookies("shoppingbag").domain = iCookieDomainName
response.cookies("shoppingbag") = ""
response.Cookies("shoppingbag").Expires = Date - 1

CALL fnDBSessionExpire()  ''2016/12/28
CALL fnDBSessionExpireV2() ''2018/08/07

session.abandon ''위치변경. 2018/08/10

dim referer
referer = request.ServerVariables("HTTP_REFERER")

'if backpath="" then backpath = referer		'로그아웃시 본래페이지로 돌리지 않음
if backpath="" then backpath = wwwUrl&"/"


%>
<script type="text/javascript" src="https://cdn.branch.io/branch-2.47.1.min.js"></script>
<script>
    if(typeof qg !== "undefined"){
        qg("event", "logout");
    }

	<%'// Branch Init %>
	<% if application("Svr_Info")="staging" Then %>
		branch.init('key_test_ngVvbkkm1cLkcZTfE55Dshaexsgl87iz');
	<% elseIf application("Svr_Info")="Dev" Then %>
		branch.init('key_test_ngVvbkkm1cLkcZTfE55Dshaexsgl87iz');
	<% else %>
		branch.init('key_live_hpOucoij2aQek0GdzW9xFddbvukaW6le');
	<% end if %>
	branch.logout();
</script>
<script type="text/javascript">
// 장바구니알림 삭제
if(typeof(Storage) !== "undefined") {
	sessionStorage.removeItem("cart");
	sessionStorage.removeItem("myalarm");
}

// 페이지 이동
top.location.replace("<%=backpath%>");
</script>