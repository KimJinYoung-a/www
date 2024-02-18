<%
	Dim vNowMenu
	SELECT CASE GetFileName()
		Case "mileage" 	: vNowMenu = "2"
		Case "gift" 	: vNowMenu = "3"
		Case "get" 		: vNowMenu = "4"
		Case "daily" : vNowMenu = "5"
	Case Else vNowMenu = "0"
	END SELECT
%>
<script type="text/javascript">
function jsDownCoupon(stype,idx){
<% IF IsUserLoginOK THEN %>
var frm;
	frm = document.frmC;
	frm.action = "/shoppingtoday/couponshop_process.asp";
	frm.stype.value = stype;	
	frm.idx.value = idx;	
	frm.submit();
<%ELSE%>
	if(confirm("로그인하시겠습니까?")) {
		parent.location="/login/loginpage.asp?backpath=/event/2015openevent/";
	}
<%END IF%>
}
</script>
<div class="honeyHead">
	<div class="hgroup">
		<a href="/event/2015openevent/">
			<h2><img src="http://webimage.10x10.co.kr/eventIMG/2015/60829/tit_april_honey_sub.png" alt="당신의 꿀맛같은 쇼핑을 위해! 사월의 꿀 맛" /></h2>
			<p>이벤트 기간은 4월 13일부터 4월 24일까지 12일동안 진행됩니다.</p>
		</a>
	</div>
	<ul>
		<li class="nav1"><a href="" onclick="jsDownCoupon('prd,prd,prd,prd','10144,10147,10148,10149'); return false;"><span></span>꿀맛쿠폰 모두 다운받기</a></li>
		<li class="nav2"><a href="mileage.asp"<%=CHKIIF(vNowMenu="2"," class='on'","")%>><span></span>삼시세번 마일리지</a></li>
		<li class="nav3"><a href="gift.asp"<%=CHKIIF(vNowMenu="3"," class='on'","")%>><span></span>덤&amp;무민 사은이벤트</a></li>
		<li class="nav4"><a href="get.asp"<%=CHKIIF(vNowMenu="4"," class='on'","")%>><span></span>쫄깃한 득템! 텐바이텐 핫 딜</a></li>
		<li class="nav5"><a href="daily.asp"<%=CHKIIF(vNowMenu="5"," class='on'","")%>><span></span>일상다반사 꿀맛 스티커</a> <em class="hTag"><img src="http://webimage.10x10.co.kr/eventIMG/2015/60829/ico_apply_02.png" alt="" /></em></li>
	</ul>
</div>
<form name="frmC" method="get" action="/shoppingtoday/couponshop_process.asp" style="margin:0px;">
<input type="hidden" name="stype" value="">
<input type="hidden" name="idx" value="">
</form>
<%
Function GetFileName()
	On Error Resume Next
	Dim vUrl			'/소스 경로저장 변수
	Dim FullFilename		'파일이름
	Dim strName			'확장자를 제외한 파일이름

	vUrl = Request.ServerVariables("SCRIPT_NAME")
	FullFilename = mid(vUrl,instrrev(vUrl,"/")+1)
	strName = Mid(FullFilename, 1, Instr(FullFilename, ".") - 1)

	GetFileName = strName
	on Error Goto 0
End Function
%>