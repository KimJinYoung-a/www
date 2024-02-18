<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'####################################################
' Description :  러브하우스
' History : 2015.09.17 유태욱
'####################################################
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/lib/inc_const.asp" -->
<!-- #include virtual="/lib/util/pageformlib.asp" -->
<!-- #include virtual="/contest/classes/contestCls.asp" -->
<!-- #include virtual="/event/lib/event_etc_function.asp" -->
<!-- #include virtual="/event/etc/event66174Cls.asp" -->

<%
Dim vGubun, i, evt_code
dim myidx, mydiv, myimgFile2, myimgFile3, myimgFile4, myimgFile5, myopt, myimgContent

g_Contest = CStr(requestCheckVar(request("g_Contest"),10))

IF application("Svr_Info") = "Dev" THEN
	evt_code   =  64888
Else
	evt_code   =  66174
End If

IF application("Svr_Info") = "Dev" THEN
	g_Contest = "con56"
Else
	g_Contest = "con62"
End If

if g_Contest="" then
	Response.Write "<script language='javascript'>"
	Response.Write "	alert('정상적인 페이지가 아닙니다.');"
	Response.Write "</script>"
	dbget.close()	:	Response.End
end if

Dim clsContest, vEntrySDate, vEntryEDate

Set clsContest = New cContest
	clsContest.FContest = g_Contest
	clsContest.FContestChk
	
	if clsContest.FTotalCount > 0 then
		vEntrySDate = clsContest.FOneItem.fentry_sdate
		vEntryEDate = clsContest.FOneItem.fentry_edate
	else
		Response.Write "<script language='javascript'>"
		Response.Write "	alert('해당되는 공모전이 없습니다.');"

		Response.Write "</script>"
		dbget.close()	:	Response.End
	end if

dim vPageSize, vPage, vArrList, vTotalCount, vTotalPage, iCPerCnt, vIsPaging
	vPage = getNumeric(requestCheckVar(Request("page"),5))
	If vPage = "" Then vPage = 1 End If

	vIsPaging = requestCheckVar(Request("paging"),1)
	vPageSize = 12
	iCPerCnt = 10
dim C66174
set C66174 = new Cevent66174_list
	C66174.FPageSize = vPageSize
	C66174.FCurrPage = vPage
	C66174.FRectEventID = evt_code
	C66174.FRectUserid = userid
	C66174.fnEvent_66174_List
	vTotalCount = C66174.FTotalCount

	sqlstr = "select top 1 idx, div, imgFile2, imgFile3, imgFile4, imgFile5, opt, imgContent "
	sqlstr = sqlstr & " from [db_event].[dbo].[tbl_contest_entry]"
	sqlstr = sqlstr & " where userid='"& userid &"' And div='"&g_Contest&"' "
	sqlstr = sqlstr & " order by idx desc "
	rsget.Open sqlstr, dbget, 1

	If Not rsget.Eof Then
		myidx = rsget(0)
		mydiv = rsget(1)
		myimgFile2 = rsget(2)
		myimgFile3 = rsget(3)
		myimgFile4 = rsget(4)
		myimgFile5 = rsget(5)
		myopt = rsget(6)
		myimgContent = rsget(7)
	End IF
	rsget.close
%>
<style type="text/css">
img {vertical-align:top;}
.weddingCont {position:relative; width:1140px; margin:0 auto;}
.myPerfectWedding {padding-bottom:70px; background:url(http://webimage.10x10.co.kr/eventIMG/2015/66174/bg_dot.gif) 0 0 repeat;}
.weddingWrap {background:url(http://webimage.10x10.co.kr/eventIMG/2015/66174/bg_heart.png) 50% 0 no-repeat;}
.weddingHead {height:384px; background:url(http://webimage.10x10.co.kr/eventIMG/2015/66174/bg_lace.png) 0 0 repeat-x;}
.weddingHead .now {position:absolute; left:442px; top:102px; margin-top:-3px; opacity:0; filter:alpha(opacity=0);}
.weddingHead .tit {position:absolute; left:205px; top:182px; width:725px; height:67px;}
.weddingHead .tit:after {content:' '; display:block; clear:both;}
.weddingHead .tit span {overflow:hidden; display:inline-block; height:67px; position:absolute; left:0; top:0; margin-left:-5px; z-index:50;}
.weddingHead .tit span img {display:inline-block;}
.weddingHead .tit span.up img {margin-top:67px;}
.weddingHead .tit span.down img {margin-top:-67px;}
.weddingHead .tit .house {position:relative; width:340px;}
.weddingHead .tit .ring {position:absolute; left:284px; top:-18px; margin-top:3px;}
.weddingHead .tit .arrow {position:absolute; left:444px; top:-15px; margin:-20px 0 0 35px; opacity:0; filter:alpha(opacity=0); z-index:60;}
.weddingHead .copy {position:absolute; left:346px; top:285px; margin-top:3px; opacity:0; filter:alpha(opacity=0);}
.weddingHead .date {position:absolute; left:0; top:45px;}
.weddingHead .goMyWed {position:absolute; right:-5px; top:36px;}
.weddingHead .goMyWed a {display:inline-block; position:absolute; left:25px; top:104px;}
.slideWrap {width:930px; padding:7px; margin:0 auto; border:3px solid #fff;}
.slide {overflow:visible !important; position:relative; width:930px; height:490px;}
.slide .slidesjs-navigation {display:block; position:absolute; top:50%; margin-top:-25px; width:22px; height:50px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2015/66174/btn_nav.png); background-repeat:no-repeat; z-index:30; text-indent:-9999px;}
.slide .slidesjs-previous {left:-54px; background-position:0 0;}
.slide .slidesjs-next {right:-54px; background-position:100% 0;}
.slide .slidesjs-pagination {overflow:hidden; position:absolute; left:50%; bottom:-28px; width:86px; z-index:30; margin-left:-43px;}
.slide .slidesjs-pagination li {float:left; width:7px; height:7px; margin:0 5px;}
.slide .slidesjs-pagination li a {display:block; width:100%; height:7px; text-indent:-9999px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2015/66174/btn_pagination.png);}
.slide .slidesjs-pagination li a.active {background-position:100% 0;}
.woozoo {position:relative; margin:85px 0 40px;}
.woozoo a {display:inline-block; width:135px; height:32px; position:absolute; left:425px; bottom:-3px; font-size:0; line-height:0; text-align:left; text-indent:-9999px;}
.process {padding-bottom:80px;}
.applyLoveHouse {background:#fff;}
.applyLoveHouse .titArea {padding-bottom:60px; border-bottom:2px solid #333;}
.applyLoveHouse .titArea h3 {padding:70px 0 28px;}
.applyForm {padding:50px 118px 65px; background:#f5f5f5;}
.applyForm h4 {padding-bottom:50px;}
.applyForm h5 {padding-bottom:40px;}
.applyForm .overHidden {padding:4px 0; margin-bottom:30px; text-align:left; background:url(http://webimage.10x10.co.kr/eventIMG/2015/66174/bg_dash.gif) 50% 0 repeat-y;}
.applyForm .overHidden .ftLt,
.applyForm .overHidden .ftRt {width:390px;}
.applyForm textarea {width:306px; height:380px; padding:40px; font-size:14px; line-height:22px; border:1px solid #ddd; color:#f8675a;}
.applyForm dl {padding-top:30px;}
.applyForm dt {line-height:15px; padding-bottom:10px;}
.applyForm ul {overflow:hidden; padding-top:3px;}
.applyForm li {float:left; line-height:15px; padding-right:19px;}
.applyForm li input {display:inline-block; vertical-align:top; margin:1px 6px 0 0; *margin:0;}
.applyForm .txtInp {height:21px; border:1px solid #ddd; background:#fff;}
.applyForm .agree {padding:20px 0 16px; line-height:13px; border-top:1px solid #fff; border-bottom:1px solid #fff;}
.applyForm .confirm {padding:40px 0 13px;}
.houseList {margin-top:2px; border-top:2px solid #333;}
.houseList ul {overflow:hidden; padding:50px 0 0 44px; border-bottom:1px solid #ddd;}
.houseList li {position:relative; float:left; width:330px; height:206px; padding:84px 30px 50px 0; background-position:0 0; background-repeat:no-repeat;}
.houseList li.h01 {background-image:url(http://webimage.10x10.co.kr/eventIMG/2015/66174/bg_house01.gif);}
.houseList li.h02 {background-image:url(http://webimage.10x10.co.kr/eventIMG/2015/66174/bg_house02.gif);}
.houseList li.h03 {background-image:url(http://webimage.10x10.co.kr/eventIMG/2015/66174/bg_house03.gif);}
.houseList li .writer {width:130px; height:26px; text-align:center; color:#666; font-size:11px; line-height:28px; margin:0 auto 20px; background:url(http://webimage.10x10.co.kr/eventIMG/2015/66174/bg_writer.gif) 0 0 no-repeat;}
.houseList li .writer img {vertical-align:middle; padding-right:3px;}
.houseList li .story {font-size:11px; line-height:22px; color:#000;}
.houseList li .num {margin-top:18px; color:#666; font-size:11px; line-height:11px;}
.houseList li .num span {padding:0 10px;}
.houseList li .num span:first-child {position:relative;}
.houseList li .num span:first-child:after {content:' '; display:inline-block; position:absolute; right:0; top:1px; width:1px; height:9px; background:#666;}
.houseList li .btnDel {position:absolute; left:232px; top:85px; z-index:30;}
.houseList .pageMove {display:none;}
/* animation */
.ring {-webkit-animation: swinging 3s ease-in-out 0s 5; -moz-animation: swinging 3s ease-in-out 0s 5;  -ms-animation: swinging 3s ease-in-out 0s 5;}
@-webkit-keyframes swinging {0% {-webkit-transform:rotate(0);} 40%{-webkit-transform:rotate(-5deg);} 75%{-webkit-transform:rotate(5deg);} 100%{-webkit-transform:rotate(0);}}
@-moz-keyframes swinging {0%{-moz-transform:rotate(0);} 40%{-moz-transform:rotate(-5deg);} 75%{-moz-transform:rotate(5deg);} 100%{-moz-transform:rotate(0);}}
@-ms-keyframes swinging {0%{-ms-transform:rotate(0);} 40%{-ms-transform:rotate(-5deg);} 75%{-ms-transform:rotate(5deg);} 100%{-ms-transform:rotate(0);}}
/* tiny scrollbar */
.scrollbarwrap {width:205px; margin:0 auto;}
.scrollbarwrap .viewport {overflow:hidden; position:relative; width:190px; height:103px;}
.scrollbarwrap .overview {position: absolute; top:0; left:0; width:100%; background:url(http://webimage.10x10.co.kr/eventIMG/2015/66174/bg_note.gif) 0 0 repeat;}
.scrollbarwrap .scrollbar {float:right; position:relative; width:3px; background-color:#e5e5e5;}
.scrollbarwrap.track {position: relative; width:3px; height:100%; background-color:#e5e5e5;}
.scrollbarwrap .thumb {overflow:hidden; position:absolute; top: 0; left:0; width:3px; height:24px; background-color:#bbb; cursor:pointer;}
.scrollbarwrap .thumb .end {overflow:hidden; width:3px; height:5px;}
.scrollbarwrap .disable {display:none;}
.total {padding:10px 10px 0 0; text-align:right; font-family:verdana; font-weight:bold;}
</style>
<script src="/lib/js/jquery.tinyscrollbar.js"></script>
<script type="text/javascript">
function jsGoPage(a) {
	frmGubun2.page.value = a;
	frmGubun2.submit();
}

$(document).ready(function(){
	$('.scrollbarwrap').tinyscrollbar();
});
$(function(){
	// title animation
	$('.now').animate({"margin-top":"5px","opacity":"1"},500).animate({"margin-top":"0"}, 300);
	$('.tit span img').delay(600).animate({"margin-top":"0"}, 900);
	$('.tit .ring').delay(200).animate({"margin-top":"0"}, 900);
	$('.tit .arrow').delay(2400).animate({"opacity":"1"}, 100).animate({"margin-left":"0","margin-top":"0"}, 600);
	$('.copy').delay(1400).animate({"margin-top":"-3px","opacity":"1"}, 600).animate({"margin-top":"0"}, 300);

	// 신청서 toggle
	$('.applyForm').hide();
	$('.btnApply').click(function(){
		$('.applyForm').slideDown(800);
		$('.houseList').css('margin-top','0');
	});

	$('.slide').slidesjs({
		width:"930",
		height:"490",
		pagination:{effect:"fade"},
		navigation:{effect:"fade"},
		play:{interval:2400, effect:"fade", auto:true},
		effect:{fade: {speed:800, crossfade:true}
		},
		callback: {
			complete: function(number) {
				var pluginInstance = $('.slide').data('plugin_slidesjs');
				setTimeout(function() {
					pluginInstance.play(true);
				}, pluginInstance.options.play.interval);
			}
		}
	});

	<% If IsUserLoginOK() Then %>
		<% if myimgFile2 <> "" then %>
			document.frmApply.myArea.value="<%= myimgFile2 %>";
		<% end if %>
		<% if myimgContent <> "" then %>
			document.frmApply.imgContent.value="<%= myimgContent %>";
		<% end if %>
		$(":radio[id='age0<%= myopt %>']").attr("checked", true);
		$(":radio[id='time0<%= myimgFile3 %>']").attr("checked", true);
		$(":radio[id='size0<%= myimgFile4 %>']").attr("checked", true);
		$(":radio[id='type0<%= myimgFile5 %>']").attr("checked", true);
	<% end if %>

});


function frmSubmit() {
	<% If IsUserLoginOK() Then %>
		<% If Now() > #10/04/2015 23:59:59# Then %>
			alert("응모가 마감되었습니다.");
			return;
		<% Else %>
			<% if usercnt < 1 then %>
				var frm = document.frmApply;
	
				var tmpage='';
				for (var i=0; i < frm.age.length; i++){
					if (frm.age[i].checked){
						tmpage = frm.age[i].value;
					}
				}
				if (tmpage==''){
					alert('나이를 선택해 주세요');
					return false;
				}
	
				if (frm.myArea.value == '' || frm.myArea.value == 'ex) 서울시 종로구'){
					alert("사는 지역(시/구)을 입력해 주세요.");
					frm.myArea.focus();
					return;
				}
	
				var tmpwedding='';
				for (var i=0; i < frm.wedding.length; i++){
					if (frm.wedding[i].checked){
						tmpwedding = frm.wedding[i].value;
					}
				}
				if (tmpwedding==''){
					alert('결혼시기를 선택해 주세요');
					return false;
				}
	
				var tmppyongsu='';
				for (var i=0; i < frm.pyongsu.length; i++){
					if (frm.pyongsu[i].checked){
						tmppyongsu = frm.pyongsu[i].value;
					}
				}
				if (tmppyongsu==''){
					alert('집 평수를 선택해 주세요');
					return false;
				}
	
				var tmphome='';
				for (var i=0; i < frm.home.length; i++){
					if (frm.home[i].checked){
						tmphome = frm.home[i].value;
					}
				}
				if (tmphome==''){
					alert('집 형태를 선택해 주세요');
					return false;
				}
				
				if (frm.imgContent.value == '' || frm.imgContent.value == '최대 200자 이내로 작성 해 주세요'){
					alert("나의 워너비 신혼집을 입력해 주세요.");
					frm.imgContent.focus();
					return;
				}
				if(GetByteLength(frm.imgContent.value)>400){
					alert('최대 한글 200자 까지 입력 가능합니다.');
				frm.imgContent.focus();
				return false;
				}

				//* 파일확장자 체크
				for(var ii=1; ii<2; ii++)
				{
					var frmname		 = eval("frm.imgfile"+ii+"");
			
					if(frmname.value != "")
					{
						var sarry        = frmname.value.split("\\");      // 선택된 이미지 화일의 풀 경로
						var maxlength    = sarry.length-1;       // 이미지 화일 풀 경로에서 이미지만 뽑아내기
						var ext = sarry[maxlength].split(".");
			
						if(ext[1].toLowerCase() == "jpg" || ext[1].toLowerCase() == "png"){
							
						}else{
							alert('jpg나 png파일만 업로드가 가능합니다.');
							return;
						}
					}
				}
			
				if(!document.getElementById('agreecheck').checked) {
					alert("개인정보 취급방침에 동의하셔야만 지원이 가능합니다");
					return;
				}
					frm.mode.value = 'addreg';
				frm.submit();
		   	<% else %>
				alert("한번만 응모 가능 합니다.");
				return;
			<% end if %>
		<% End if %>
	<% Else %>
		if(confirm("로그인을 하셔야 참여가 가능 합니다. 로그인 하시겠습니까?")){
			var winLogin = window.open('/login/PopLoginPage.asp','popLogin','width=400,height=300');
			winLogin.focus();
			return;
		}
	<% End IF %>
}

function frmSubmitedit(idx) {
	<% If IsUserLoginOK() Then %>
		<% If Now() > #10/04/2015 23:59:59# Then %>
			alert("응모가 마감되었습니다.");
			return;
		<% Else %>
			var frm = document.frmApply;

			if (frm.myArea.value == '' || frm.myArea.value == 'ex) 서울시 종로구'){
				alert("사는 지역(시/구)을 입력해 주세요.");
				frm.myArea.focus();
				return;
			}

			if (frm.imgContent.value == '' || frm.imgContent.value == '최대 200자 이내로 작성 해 주세요'){
				alert("나의 워너비 신혼집을 입력해 주세요.");
				frm.imgContent.focus();
				return;
			}
			if(GetByteLength(frm.imgContent.value)>400){
				alert('최대 한글 200자 까지 입력 가능합니다.');
			frm.imgContent.focus();
			return false;
			}

			//* 파일확장자 체크
			for(var ii=1; ii<2; ii++)
			{
				var frmname		 = eval("frm.imgfile"+ii+"");
		
				if(frmname.value != "")
				{
					var sarry        = frmname.value.split("\\");      // 선택된 이미지 화일의 풀 경로
					var maxlength    = sarry.length-1;       // 이미지 화일 풀 경로에서 이미지만 뽑아내기
					var ext = sarry[maxlength].split(".");
		
					if(ext[1].toLowerCase() == "jpg" || ext[1].toLowerCase() == "png"){
						
					}else{
						alert('jpg나 png파일만 업로드가 가능합니다.');
						return;
					}
				}
			}
			if(!document.getElementById('agreecheck').checked) {
				alert("개인정보 취급방침에 동의하셔야만 지원이 가능합니다");
				return;
			}

			frm.idx.value = idx;
			frm.mode.value = 'edit';
			frm.submit();
		<% End if %>
	<% Else %>
		if(confirm("로그인을 하셔야 참여가 가능 합니다. 로그인 하시겠습니까?")){
			var winLogin = window.open('/login/PopLoginPage.asp','popLogin','width=400,height=300');
			winLogin.focus();
			return;
		}
	<% End IF %>
}

function jseditComment(idx)	{
	<% If IsUserLoginOK() Then %>
		<% If Now() > #10/04/2015 23:59:59# Then %>
			//alert("공모전이 종료되었습니다.");
			alert("응모가 마감되었습니다.");
			return;
		<% Else %>
			var frm = document.frmApply;

			if (frm.myArea.value == '' || frm.myArea.value == 'ex) 서울시 종로구'){
				alert("사는 지역(시/구)을 입력해 주세요.");
				frm.myArea.focus();
				return;
			}
			if (frm.imgContent.value == '' || frm.imgContent.value == '최대 200자 이내로 작성 해 주세요'){
				alert("나의 워너비 신혼집을 입력해 주세요.");
				frm.imgContent.focus();
				return;
			}
			if(GetByteLength(frm.imgContent.value)>400){
				alert('최대 한글 200자 까지 입력 가능합니다.');
			frm.imgContent.focus();
			return false;
			}

			if(!document.getElementById('agreecheck').checked) {
				alert("개인정보 취급방침에 동의하셔야만 지원이 가능합니다");
				return;
			}
			document.frmdelcom.age.value = frm.age.value;
			document.frmdelcom.myArea.value = frm.myArea.value;
			document.frmdelcom.wedding.value = frm.wedding.value;
			document.frmdelcom.pyongsu.value = frm.pyongsu.value;
			document.frmdelcom.home.value = frm.home.value;
			document.frmdelcom.imgContent.value = frm.imgContent.value;
			
			document.frmdelcom.mode.value = 'edit';
			document.frmdelcom.idx.value = idx;
	   		document.frmdelcom.submit();
		<% End if %>
	<% Else %>
		if(confirm("로그인을 하셔야 참여가 가능 합니다. 로그인 하시겠습니까?")){
			var winLogin = window.open('/login/PopLoginPage.asp','popLogin','width=400,height=300');
			winLogin.focus();
			return;
		}
	<% End IF %>
}

function jsDelComment(idx)	{
	if(confirm("삭제하시겠습니까?")){
		document.frmdelcom.mode.value = 'del';
		document.frmdelcom.idx.value = idx;
   		document.frmdelcom.submit();
	}
}

function loginchk()	{
	<% If Now() > #10/04/2015 23:59:59# Then %>
		alert("이벤트가 종료되었습니다.");
		return;
	<% Else %>
		if(confirm("로그인을 하셔야 참여가 가능 합니다. 로그인 하시겠습니까?")){
			var winLogin = window.open('/login/PopLoginPage.asp','popLogin','width=400,height=300');
			winLogin.focus();
			return;
		}
	<% End if %>
}

function jsCheckLimit(ta) {
	if ("<%=IsUserLoginOK%>"=="False") {
		jsChklogin('<%=IsUserLoginOK%>');
	}

	if (ta=="ta1") {
		if(frmApply.imgContent.value == "최대 200자 이내로 작성 해 주세요"){
			frmApply.imgContent.value ="";
		}
	}else{
		if(frmApply.myArea.value == "ex) 서울시 종로구"){
			frmApply.myArea.value ="";
		}
	}
}
</script>
</head>
<body>
	<div class="eventContV15 tMar15">
		<!-- event area(이미지만 등록될때 / 수작업일때) -->
		<div class="contF contW">
			<!-- 2015웨딩기획전 : 러브하우스 -->
			<div class="wedding2015">
				<!-- 브랜드 소개, 이벤트 안내 -->
				<div class="myPerfectWedding">
					<div class="weddingWrap">
						<div class="weddingHead">
							<div class="weddingCont">
								<p class="now"><img src="http://webimage.10x10.co.kr/eventIMG/2015/66174/txt_go_now.png" alt="지금 만나러 갑니다" /></p>
								<div class="tit">
									<p class="ftLt love">
										<span class="up"><img src="http://webimage.10x10.co.kr/eventIMG/2015/66174/tit_love01.png" alt="LOVE" /></span>
										<span class="down"><img src="http://webimage.10x10.co.kr/eventIMG/2015/66174/tit_love02.png" alt="" /></span>
									</p>
									<p class="ftRt house">
										<span class="up"><img src="http://webimage.10x10.co.kr/eventIMG/2015/66174/tit_house01.png" alt="HOUSE" /></span>
										<span class="down"><img src="http://webimage.10x10.co.kr/eventIMG/2015/66174/tit_house02.png" alt="HOUSE" /></span>
										<span class="down"><img src="http://webimage.10x10.co.kr/eventIMG/2015/66174/tit_house_o.png" alt="HOUSE" /></span>
										<span class="down" style="z-index:70;"><img src="http://webimage.10x10.co.kr/eventIMG/2015/66174/tit_house_o2.png" alt="HOUSE" /></span>
									</p>
									<p class="deco ring"><img src="http://webimage.10x10.co.kr/eventIMG/2015/66174/img_ring.png" alt="반지" /></p>
									<p class="deco arrow"><img src="http://webimage.10x10.co.kr/eventIMG/2015/66174/img_arrow.png" alt="화살" /></p>
								</div>
								
								<p class="copy"><img src="http://webimage.10x10.co.kr/eventIMG/2015/66174/txT_copy.png" alt="LOVE" /></p>
								<p class="date"><img src="http://webimage.10x10.co.kr/eventIMG/2015/66174/txt_date.png" alt="HOUSE" /></p>
								<div class="goMyWed">
									<p><img src="http://webimage.10x10.co.kr/eventIMG/2015/66174/txt_go_main.png" alt="내게 너무 완벽한 웨딩 보러가기" /></p>
									<a href="/event/eventmain.asp?eventid=66108"><img src="http://webimage.10x10.co.kr/eventIMG/2015/66174/btn_go.gif" alt="GO" /></a>
								</div>
							</div>
						</div>
						<div class="weddingContent">
							<div class="weddingCont">
								<div class="slideWrap">
									<div class="slide">
										<img src="http://webimage.10x10.co.kr/eventIMG/2015/66174/img_slide01.jpg" alt="STYLE 01 : 북유럽" />
										<img src="http://webimage.10x10.co.kr/eventIMG/2015/66174/img_slide02.jpg" alt="STYLE 02 : 내추럴" />
										<img src="http://webimage.10x10.co.kr/eventIMG/2015/66174/img_slide03.jpg" alt="STYLE 03 : 액티브" />
										<img src="http://webimage.10x10.co.kr/eventIMG/2015/66174/img_slide04.jpg" alt="STYLE 04 : 러블리" />
										<img src="http://webimage.10x10.co.kr/eventIMG/2015/66174/img_slide05.jpg" alt="STYLE 05 : 빈티지" />
									</div>
								</div>
								<div class="woozoo">
									<p><img src="http://webimage.10x10.co.kr/eventIMG/2015/66174/txt_about_woozoo.png" alt="WOOZOO - 생각이 담긴 쉐어하우스를 만드는 우주! WOOZOO는 같은 관심사와 취미, 꿈을 가진 사람들이 함께 즐거운 삶을 공유할 수 있도록 공간을 만들어 갑니다. 이러한 우주와 함께 텐바이텐이 당신의 신혼집 스타일링을 도와드립니다." /></p>
									<a href="http://www.woozoo.kr/front/main.do" target="_blank">홈페이지 바로가기</a>
								</div>
								<p class="process"><img src="http://webimage.10x10.co.kr/eventIMG/2015/66174/txt_process.png" alt="일정소개" /></p>
								<p class="evtNoti"><img src="http://webimage.10x10.co.kr/eventIMG/2015/66174/txt_evt_noti.png" alt="이벤트 공지사항" /></p>
							</div>
							
						</div>
					</div>
				</div>
				<!--// 브랜드 소개, 이벤트 안내 -->

				<!-- 이벤트 참여(★★여기부터 개발영역★★) -->
				<div class="applyLoveHouse">
					<div class="weddingCont">
					<div class="titArea">
						<h3><img src="http://webimage.10x10.co.kr/eventIMG/2015/66174/tit_apply.gif" alt="당신이 주인공이 되고 싶다면 지금 바로 신청하세요!" /></h3>
						<button class="btnApply"><img src="http://webimage.10x10.co.kr/eventIMG/2015/66174/btn_apply.gif" alt="신청하기" /></button>
					</div>
					<!-- 신청서 작성 -->
					<div class="applyForm">
					<form name="frmApply" method="POST" action="<%=staticImgUrl%>/linkweb/enjoy/66174_Contest_upload.asp" onsubmit="return false" enctype="multipart/form-data">
					<input type="hidden" name="div" value="<%=g_Contest%>">
					<input type="hidden" name="mode" value="">
					<input type="hidden" name="idx" value="">
					<input type="hidden" name="userid" value="<%= userid %>">
					<input type="hidden" name="optText" value="W">
					
						<h4><img src="http://webimage.10x10.co.kr/eventIMG/2015/66174/tit_apply02.gif" alt="LOVE HOUSE - 당신이 원하는 신혼집에 대해서 적어주세요. 당첨된 한 분에게 텐바이텐이 스타일링을 제공합니다" /></h4>
						<div class="overHidden">
							<div class="ftLt">
								<h5><img src="http://webimage.10x10.co.kr/eventIMG/2015/66174/tit_my_wannabe.gif" alt="나의 워너비 신혼집은?(공개용)" /></h5>
								<textarea name="imgContent" maxlength="200" onClick="jsCheckLimit('ta1');" onKeyUp="jsCheckLimit('ta1');" ><% IF NOT(IsUserLoginOK) THEN %>로그인 후 글을 남길 수 있습니다.<% else %>최대 200자 이내로 작성 해 주세요<% END IF %></textarea>
							</div>
							<div class="ftRt">
								<h5><img src="http://webimage.10x10.co.kr/eventIMG/2015/66174/tit_house_info.gif" alt="러브하우스 상세정보(비공개용)" /></h5>
								<dl class="tPad0">
									<dt><img src="http://webimage.10x10.co.kr/eventIMG/2015/66174/tit_age.gif" alt="나이" /></dt>
									<dd>
										<ul>
											<li><input type="radio" id="age01" name="age" value="1" class="radio" /><label for="age01"><img src="http://webimage.10x10.co.kr/eventIMG/2015/66174/txt_age01.gif" alt="24세 미만" /></label></li>
											<li><input type="radio" id="age02" name="age" value="2" class="radio" /><label for="age02"><img src="http://webimage.10x10.co.kr/eventIMG/2015/66174/txt_age02.gif" alt="25세~30세" /></label></li>
											<li><input type="radio" id="age03" name="age" value="3" class="radio" /><label for="age03"><img src="http://webimage.10x10.co.kr/eventIMG/2015/66174/txt_age03.gif" alt="35세~40세" /></label></li>
											<li><input type="radio" id="age04" name="age" value="4" class="radio" /><label for="age04"><img src="http://webimage.10x10.co.kr/eventIMG/2015/66174/txt_age04.gif" alt="40세 이상" /></label></li>
										</ul>
									</dd>
								</dl>
								<dl>
									<dt><img src="http://webimage.10x10.co.kr/eventIMG/2015/66174/tit_area.gif" alt="지역(시/구 까지)" /></dt>
									<dd><input type="text" name="myArea" class="txtInp" onClick="jsCheckLimit('ta2');" onKeyUp="jsCheckLimit('ta2');" style="width:350px; color:#f8675a;" <% IF NOT(IsUserLoginOK) THEN %>value="로그인 후 글을 남길 수 있습니다."<% else %>value="ex) 서울시 종로구"<% END IF %>/></dd>
								</dl>
								<dl>
									<dt><img src="http://webimage.10x10.co.kr/eventIMG/2015/66174/tit_time.gif" alt="결혼시기" /></dt>
									<dd>
										<ul>
											<li><input type="radio" id="time01" name="wedding" value="1" class="radio" /><label for="time01"><img src="http://webimage.10x10.co.kr/eventIMG/2015/66174/txt_time01.gif" alt="결혼 예정" /></label></li>
											<li><input type="radio" id="time02" name="wedding" value="2" class="radio" /><label for="time02"><img src="http://webimage.10x10.co.kr/eventIMG/2015/66174/txt_time02.gif" alt="신혼(3년이내)" /></label></li>
											<li><input type="radio" id="time03" name="wedding" value="3" class="radio" /><label for="time03"><img src="http://webimage.10x10.co.kr/eventIMG/2015/66174/txt_time03.gif" alt="마음만은 신혼(3년 이상)" /></label></li>
										</ul>
									</dd>
								</dl>
								<dl>
									<dt><img src="http://webimage.10x10.co.kr/eventIMG/2015/66174/tit_size.gif" alt="집 평수" /></dt>
									<dd>
										<ul>
											<li><input type="radio" id="size01" name="pyongsu" value="1" class="radio" /><label for="size01"><img src="http://webimage.10x10.co.kr/eventIMG/2015/66174/txt_size01.gif" alt="10~15평" /></label></li>
											<li><input type="radio" id="size02" name="pyongsu" value="2" class="radio" /><label for="size02"><img src="http://webimage.10x10.co.kr/eventIMG/2015/66174/txt_size02.gif" alt="15~20평" /></label></li>
											<li><input type="radio" id="size03" name="pyongsu" value="3" class="radio" /><label for="size03"><img src="http://webimage.10x10.co.kr/eventIMG/2015/66174/txt_size03.gif" alt="21~30평" /></label></li>
											<li><input type="radio" id="size04" name="pyongsu" value="4" class="radio" /><label for="size04"><img src="http://webimage.10x10.co.kr/eventIMG/2015/66174/txt_size04.gif" alt="30평 이상" /></label></li>
										</ul>
									</dd>
								</dl>
								<dl>
									<dt><img src="http://webimage.10x10.co.kr/eventIMG/2015/66174/tit_type.gif" alt="집 형태" /></dt>
									<dd>
										<ul>
											<li><input type="radio" id="type01" name="home" value="1" class="radio" /><label for="type01"><img src="http://webimage.10x10.co.kr/eventIMG/2015/66174/txt_type01.gif" alt="원룸" /></label></li>
											<li><input type="radio" id="type02" name="home" value="2" class="radio" /><label for="type02"><img src="http://webimage.10x10.co.kr/eventIMG/2015/66174/txt_type02.gif" alt="오피스텔" /></label></li>
											<li><input type="radio" id="type03" name="home" value="3" class="radio" /><label for="type03"><img src="http://webimage.10x10.co.kr/eventIMG/2015/66174/txt_type03.gif" alt="빌라" /></label></li>
											<li><input type="radio" id="type04" name="home" value="4" class="radio" /><label for="type04"><img src="http://webimage.10x10.co.kr/eventIMG/2015/66174/txt_type04.gif" alt="아파트" /></label></li>
											<li><input type="radio" id="type05" name="home" value="5" class="radio" /><label for="type05"><img src="http://webimage.10x10.co.kr/eventIMG/2015/66174/txt_type05.gif" alt="주택" /></label></li>
										</ul>
									</dd>
								</dl>
								<%' if usercnt < 1 then %>
									<dl>
										<dt><img src="http://webimage.10x10.co.kr/eventIMG/2015/66174/tit_photo.gif" alt="여러분의 신혼집을 찍어서 올려주세요(선택사항/최대 10mb,jpg파일)" /></dt>
										<dd>
											<input type="file" name="imgfile1" class="ifile txtInp" style="width:350px;" />
											<!--<input type="image" src="http://webimage.10x10.co.kr/eventIMG/2015/66174/btn_upload.gif" alt="업로드" />-->
										</dd>
									</dl>
								<%' end if %>
							</div>
						</div>
						<p class="agree"><input type="checkbox" id="agreecheck" name="ch" class="check rMar05" id="agr" /> <label for="agr"><img src="http://webimage.10x10.co.kr/eventIMG/2015/66174/txt_agree.gif" alt="본 이벤트 참여를 위한 개인정보 취급방침에 동의합니다" /><label></p>
						<p class="confirm"><img src="http://webimage.10x10.co.kr/eventIMG/2015/66174/txt_confirm.gif" alt="꼭 상단의 공지사항을 확인 후 응모 부탁드립니다" /></p>
						<% if usercnt < 1 then %>
							<button class="btnSubmit" onclick="frmSubmit(); return false;"><img src="http://webimage.10x10.co.kr/eventIMG/2015/66174/btn_submit.gif" alt="제출하기" /></button>
						<% else %>
							<button class="btnSubmit" onclick="frmSubmitedit('<%=C66174.FItemList(i).Fidx %>'); return false;"><img src="http://webimage.10x10.co.kr/eventIMG/2015/66174/btn_modify.gif" alt="수정하기" /></button>
						<% end if %>
					</form>
					</div>
					<!--// 신청서 작성 -->

					<!-- 사연 목록 -->
					<a name="cmtListList"></a>
					<% If C66174.FResultCount > 0 Then %>
					<div class="houseList">
						<p class="total">total : <%= C66174.FTotalCount %></p>
						<ul>
							<% For i = 0 to C66174.FResultCount -1 %>
								<%
								dim renloop
								randomize
								renloop=int(Rnd*3)+1
								%>
								<li class="h0<%= renloop %>">
									<p class="writer">
										<% if C66174.FItemList(i).FoptText = "M" then %>
											<img src="http://webimage.10x10.co.kr/eventIMG/2015/66174/ico_mobile.gif" alt="모바일에서 작성" />
										<% end if %>
										<%=printUserId(C66174.FItemList(i).Fuserid,2,"*")%>
									</p>
									<div class="scrollbarwrap">
										<div class="scrollbar"><div class="track"><div class="thumb"><div class="end"></div></div></div></div>
										<div class="viewport">
											<div class="overview">
												<p class="story"><%=db2html(C66174.FItemList(i).Fimgcontent)%></p>
											</div>
										</div>
									</div>
									<p class="num">
										<span>no.<%=vTotalCount-i-(vPageSize*(VPage-1))%></span><span><%=FormatDate(C66174.FItemList(i).Fregdate,"0000.00.00")%></span>
									</p>
									<% If userid = C66174.FItemList(i).Fuserid Then %>
										<button class="btnDel" onclick="jsDelComment('<%=C66174.FItemList(i).Fidx %>')"><img src="http://webimage.10x10.co.kr/eventIMG/2015/66174/btn_delete.gif" alt="삭제" /></button>
									<% end if %>
								</li>
							<% Next %>
						</ul>
						<div class="pageWrapV15 tMar20">
							<%= fnDisplayPaging_New(vPage,vTotalCount,vPageSize,iCPerCnt,"jsGoPage") %>
						</div>
					</div>
					<% end if %>
					<!--// 사연 목록 -->
				</div>
				<!--// 이벤트 참여 -->
			</div>
			<!--// 2015웨딩기획전 : 러브하우스 -->
		</div>
		<!-- //event area(이미지만 등록될때 / 수작업일때) -->
	</div>
<form name="frmdelcom" method="post" action="/event/etc/doEventSubscript66174.asp" style="margin:0px;">
<input type="hidden" name="div" value="<%=g_Contest%>">
<input type="hidden" name="idx" value=""> 
<input type="hidden" name="ecode" value="<%=evt_code%>">
<input type="hidden" name="mode" value="">
<input type="hidden" name="age" value="">
<input type="hidden" name="myArea" value="">
<input type="hidden" name="wedding" value="">
<input type="hidden" name="pyongsu" value="">
<input type="hidden" name="home" value="">
<input type="hidden" name="userid" value="<%= userid %>">
<input type="hidden" name="imgContent" value="">
</form>
<form name="frmGubun2" method="post" action="#cmtListList" style="margin:0px;">
<input type="hidden" name="page" value="<%=vPage%>">
<input type="hidden" name="paging" value="o">
</form>
</body>
</html>
<% set C66174=nothing %>
<% Set clsContest = Nothing %>
<!-- #include virtual="/lib/db/dbclose.asp" -->