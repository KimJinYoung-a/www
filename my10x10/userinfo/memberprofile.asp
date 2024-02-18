<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<%
Response.AddHeader "Cache-Control","no-cache"
Response.AddHeader "Expires","0"
Response.AddHeader "Pragma","no-cache"
response.Charset="UTF-8"
%>
<%
'#######################################################
'	Description : 내 프로필 변경
'	History	:  2014.09.18 한용민 생성
'              2015.03.21 허진원 PC Web Conv.
'	Erc : 팝업 창 사이즈 width=580, height=750
'#######################################################
%>
<!-- #include virtual="/lib/util/tenSessionLib.asp" -->
<!-- #include virtual="/login/checklogin.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/inc/head.asp" -->
<!-- #include virtual="/lib/classes/membercls/sp_userinfocls.asp" -->
<%
dim i, iMyProfileNum

if GetLoginUserICon="" or GetLoginUserICon="0" then
	iMyProfileNum = getDefaultProfileImgNo(GetLoginUserID)
else
	iMyProfileNum = GetLoginUserICon
end if
%>
<link rel="stylesheet" type="text/css" href="/lib/css/preVst/popup.css" />
<link rel="stylesheet" type="text/css" href="/lib/css/popupV15.css" />
<script type="text/javascript">
$(function(){
	// 기본 프로필 이미지 선택
	imgchange('<%= iMyProfileNum %>');

	$("#profileList").append("<div class='smile'><span></span><span></span></div>");
});

function imgchange(imgid){
	var Pbnum = imgid;

	$("#profileList ul li button").removeClass("on");
	$("#img"+Pbnum+" button").addClass("on");
	$("#usericonno").val(Pbnum);
}

function imgreg(){
	var ret = confirm('정보를 수정 하시겠습니까?');
	if (ret){
		var rstStr = $.ajax({
			type: "POST",
			url: "/my10x10/userinfo/memberprofile_process.asp",
			data: "mode=usericonnoreg&usericonno="+$("#usericonno").val(),
			dataType: "text",
			async: false
		}).responseText;

		if (rstStr == "2"){
			alert('로그인을 해주세요.');
			return false;
		}else if (rstStr == "3"){
			alert('프로필 이미지를 선택해 주세요.');
			return false;
		}else if (rstStr == "1"){
			alert('프로필 이미지가 저장 되었습니다.');
			opener.location.reload();
			window.close();
			return false;
		}else{
			alert('오류가 발생했습니다.');
			return false;
		}
	}
}
</script>
</head>
<body>
<div class="heightgird">
	<div class="popWrap">
		<div class="popHeader">
			<h1><img src="http://fiximage.10x10.co.kr/web2015/popup/tit_profile_image.png" alt="프로필 이미지" /></h1>
		</div>
		<div class="popContent">
			<div class="profileV15">
				<ul class="list01">
					<li>원하는 프로필 이미지를 선택해주세요.</li>
					<li>프로필 이미지는 언제든지 변경이 가능합니다.</li>
				</ul>

				<div id="profileList" class="profileList">
					<ul>
					<% for i = 1 to 30 %>
						<li id="img<%= i %>">
							<p>
								<button type="button" onclick="imgchange('<%= i %>');">선택</button>
								<img src="http://fiximage.10x10.co.kr/web2015/common/img_profile_<%= Format00(2,i) %>.png" width="100" height="100" alt="profile Icon #<%=i%>" />
							</p>
						</li>
					<% next %>
					</ul>
				</div>
				<div class="btnArea ct tPad20">
					<input type="hidden" name="usericonno" id="usericonno" value="<%= iMyProfileNum %>">
					<button type="button" class="btn btnS1 btnRed" onclick="imgreg();">저장</button>
					<button type="button" class="btn btnS1 btnGry" onclick="window.close();">취소</button>
				</div>
			</div>
		</div>
	</div>
	<div class="popFooter">
		<div class="btnArea">
			<button type="button" class="btn btnS1 btnGry2" onclick="window.close();">닫기</button>
		</div>
	</div>
</div>
</body>
</html>
<!-- #include virtual="/lib/db/dbclose.asp" -->