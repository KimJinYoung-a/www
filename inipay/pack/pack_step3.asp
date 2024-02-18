<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
Response.AddHeader "Cache-Control","no-cache"
Response.AddHeader "Expires","0"
Response.AddHeader "Pragma","no-cache"
%>
<%
'#######################################################
'	History	:  2015.11.09 한용민 생성
'	Description : 포장 서비스
'#######################################################
%>
<!-- #include virtual="/login/checkBaguniLogin.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/lib/classes/ordercls/shoppingbagDBcls.asp" -->
<!-- #include virtual="/lib/classes/ordercls/pack_cls.asp" -->
<%
dim midx
	midx = getNumeric(requestcheckvar(request("midx"),10))

dim vShoppingBag_checkset
	vShoppingBag_checkset=0

vShoppingBag_checkset = getShoppingBag_checkset("TT")		'실제 장바구니 수량		TT:텐배

dim userid, guestSessionID, i, j, isBaguniUserLoginOK
If IsUserLoginOK() Then
	userid = getEncLoginUserID ''GetLoginUserID
	isBaguniUserLoginOK = true
Else
	userid = GetLoginUserID
	isBaguniUserLoginOK = false
End If
guestSessionID = GetGuestSessionKey

'if not(isBaguniUserLoginOK) then
'	response.write "<script type='text/javascript'>alert('회원전용 서비스 입니다. 로그인을 해주세요.');</script>"
'	dbget.close()	:	response.end
'end if

if midx="" then
	response.write "<script type='text/javascript'>alert('일렬번호가 없습니다.');</script>"
	dbget.close()	:	response.end
end if

'//선물포장 임시 패킹 리스트
dim opackmaster
set opackmaster = new Cpack
	opackmaster.FRectUserID = userid
	opackmaster.FRectSessionID = guestSessionID
	opackmaster.frectmidx = midx
	opackmaster.Getpojangtemp_master()

if opackmaster.FResultCount < 1 then
	response.write "<script type='text/javascript'>alert('해당 선물 포장 내역이 없습니다.');</script>"
	dbget.close()	:	response.end
end if
%>

<!-- #include virtual="/lib/inc/head_SSL.asp" -->

<link rel="stylesheet" type="text/css" href="/lib/css/preVst/popup.css" />
<link rel="stylesheet" type="text/css" href="/lib/css/popupV15.css" />
<script type="text/javascript">

function pojangcomplete(){
    self.close();
}

function gostep1(){
	pojangfrm.mode.value='reset_step1';
	pojangfrm.reload.value='ON';
	pojangfrm.action = "<%= SSLURL %>/inipay/pack/pack_step1.asp";
	pojangfrm.submit();
	return;
}

//마우스 오른쪽 클릭 막음		//2015.12.15 한용민 생성
window.document.oncontextmenu = new Function("return false");
//새창 띄우기 막음		//2015.12.15 한용민 생성
window.document.onkeydown = function(e){    	//Crtl + n 막음
    if(typeof(e) != "undefined"){
        if((e.ctrlKey) && (e.keyCode == 78)) return false;
    }else{
        if((event.ctrlKey) && (event.keyCode == 78)) return false;
    }
}
//드레그 막음		//2015.12.15 한용민 생성
window.document.ondragstart = new Function("return false");

</script>
</head>
<body>
<% '<!-- for dev msg : 팝업 창 사이즈 width=800, height=800 --> %>
<div class="heightgird">

	<div class="popWrap pkgProcessV15a">
		<div class="popHeader">
			<h1><img src="http://fiximage.10x10.co.kr/web2015/common/pkg_pop_tit.png" alt="선물포장" /></h1>

			<% if vShoppingBag_checkset=1 then %>
				<% '<!-- for dev msg : 단품포장 완료의 경우 노출안됩니다. --> %>
				<div class="pkgStepV15a">
					<p class="step1"><span>상품선택</span></p>
					<p class="step2"><span>메시지입력</span></p>
					<p class="step3"><span><strong>포장완료</strong></span></p>
				</div>
			<% end if %>

		</div>
		<div class="popContent">
			<div class="pkgEndV15a">
				<% '<!-- for dev msg : 단품 포장 완료후 노출됩니다.--> %>
				<% if vShoppingBag_checkset=0 then %>
					<p class="fs16"><strong class="cRd0V15">선물포장</strong>이 완료되었습니다.</p>
				<% else %>
					<p class="fs16">
						<strong><%= opackmaster.FItemList(0).Ftitle %></strong><br>선물포장이 완료되었습니다.
					</p>
				<% end if %>
			</div>
		</div>
		<div class="popFooter">
			<% '<!-- for dev msg : 단품 포장 완료후 아래 버튼 하나만 노출됩니다.--> %>
			<% if vShoppingBag_checkset=0 then %>
				<a href="" onclick="pojangcomplete(); return false;"><img src="http://fiximage.10x10.co.kr/web2015/common/btn_pkg_ok2.png" alt="포장 완료" /></a>
			<% else %>
				<a href="" onclick="gostep1(); return false;"><img src="http://fiximage.10x10.co.kr/web2015/common/btn_more_make.png" alt="선물포장 더 만들기" /></a>
				<a href="" onclick="pojangcomplete(); return false;"><img src="http://fiximage.10x10.co.kr/web2015/common/btn_pkg_ok.png" alt="포장 완료" /></a>
			<% end if %>
		</div>
	</div>
</div>
<form name="pojangfrm" method="post" action="" style="margin:0px;">
<input type="hidden" name="mode">
<input type="hidden" name="reload">
</form>
</body>
</html>

<%
set opackmaster=nothing
%>
<!-- #include virtual="/lib/db/dbclose.asp" -->