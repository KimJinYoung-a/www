<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'#######################################################
'	History	: 2017-06-26 유태욱
'	Description : 오프라인 멤버쉽 카드 등록 www
'#######################################################

	'// 페이지 타이틀 및 페이지 설명 작성
	strPageTitle = "텐바이텐 10X10 : 멤버쉽카드 등록"
%>
<!-- #include virtual="/login/checkPopLogin.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/lib/inc/head.asp" -->
<%
dim vUserID
vUserID = GetencLoginUserID()
%>
<link rel="stylesheet" type="text/css" href="/lib/css/preVst/popup.css" />
<link rel="stylesheet" type="text/css" href="/lib/css/popupV15.css" />
<script type="text/javascript">
$(function(){
	resizeTo(545,830);
});


function TnJoin10x10(){
	var frm = document.myinfoForm;
	
	if (frm.txCard1.value == ""){
		alert("카드번호를 입력하세요.");
		frm.txCard1.focus();
		return ;
	}

	if (frm.txCard2.value == ""){
		alert("카드번호를 입력하세요.");
		frm.txCard2.focus();
		return ;
	}

	if (frm.txCard3.value == ""){
		alert("카드번호를 입력하세요.");
		frm.txCard3.focus();
		return ;
	}

	if (frm.txCard4.value == ""){
		alert("카드번호를 입력하세요.");
		frm.txCard4.focus();
		return ;
	}

	var ret = confirm('멤버십카드를 등록하시겠습니까?\n\n*멤버십카드 재발급시 잔여포인트는 자동으로 이관됩니다.');
	if(ret){
		frm.cardno.value = frm.txCard1.value + frm.txCard2.value + frm.txCard3.value + frm.txCard4.value;
		frm.RealCardNo.value = frm.cardno.value;
		var str = $.ajax({
			type: "POST",
			url: "/offshop/point/dojoin.asp",
			data: $("#frm").serialize(),
			dataType: "text",
			async: false
		}).responseText;
		var str1 = str.split("||")
		console.log(str);
		if (str1[0] == "OK"){
			alert(str1[1]);
			$('#cardnochk').val('o');
			opener.location.href='/offshop/point/point_search.asp';
			self.close();
		}else if (str1[0] == "ER"){
			alert(str1[1]);
//			self.close();
			return false;
		}else{
			alert('오류가 발생했습니다.');
			self.close();
			return false;
		}
	}
}

function TnTabNumber(thisform,target,num) {
   if (eval("document.myinfoForm." + thisform + ".value.length") == num) {
	  eval("document.myinfoForm." + target + ".focus()");
   }
}
</script>
</head>
<body>
	<div class="heightgird">
		<div class="popWrap">
			<div class="popHeader">
				<h1><img src="http://fiximage.10x10.co.kr/web2017/memberCard/tit_regist_memcard.gif" alt="멤버십카드 등록" /></h1>
			</div>
			<div class="popContent">
				<!-- content -->
			<form name="myinfoForm" method="post" id="frm" action="/offshop/point/dojoin.asp" >
				<input type="hidden" name="txuserid" value="<%=vUserID%>">
				<input type="hidden" name="havetotalcardyn" value="<%'=vHaveTotalCardYN%>">
				<input type="hidden" name="havecardyn" value="<%'=vHaveCardYN%>">
				<input type="hidden" name="userseq" value="<%'=vUserSeq%>">
				<input type="hidden" name="RealCardNo" value="">
				<input type="hidden" name="cardno" value="">
				<input type="hidden" name="cardnochk" id="cardnochk" value="x">
				<div class="mySection registMemcardV17">
					<div class="inputCardNum">
						<img src="http://fiximage.10x10.co.kr/web2018/memberCard/img_input_card_num.png" alt="" />
						<div class="userInput">
							<input type="text" name="txCard1" id="cardNum1" class="txtInp" style="width:43px;" maxlength="4" onKeyUp="TnTabNumber('txCard1','txCard2','4')">
							<input type="text" name="txCard2" id="[on,off,1,4][카드번호2]" class="txtInp" style="width:43px;" maxlength="4" onKeyUp="TnTabNumber('txCard2','txCard3','4')">
							<input type="text" name="txCard3" id="[on,off,1,4][카드번호3]" class="txtInp" style="width:43px;" maxlength="4" onKeyUp="TnTabNumber('txCard3','txCard4','4')">
							<input type="text" name="txCard4" id="[on,off,1,4][카드번호4]" class="txtInp" style="width:43px;" maxlength="4"></td>
						</div>
 						<p>카드에 표기된 12자리 코드를 입력해주세요</p>
					</div>

					<div class="infoAgree">
						<p class="intro">텐바이텐은 이메일과 문자메시지를 통해 할인 소식,이벤트 등과 같은 <br />다양한 정보를 알려드리고 있습니다.</p>
						<ul>
							<li>
								<p class="lt">텐바이텐의 이메일 서비스를 받아보시겠습니까?</p>
								<div class="radioBox rt">
									<input type="radio" id="agree1" checked="checked" name="email_point1010" value="Y" /><label for="agree">예</label>
									<input type="radio" id="disagree1" name="email_point1010" value="N" name="reply1" /><label for="disagree">아니오</label>
								</div>
							</li>
							<li>
								<p class="lt">텐바이텐의 문자메시지 서비스를 받아보시겠습니까?</p>
								<div class="radioBox rt">
									<input type="radio" id="agree2" checked="checked" name="smsok_point1010" value="Y" /><label for="agree">예</label>
									<input type="radio" id="disagree2" name="smsok_point1010" value="N" /><label for="disagree">아니오</label>
								</div>
							</li>
						</ul>
					</div>
					<div class="btnArea ct tPad30">
						<a href="" onclick="TnJoin10x10(); return false;" class="btn btnS1 btnRed">등록</a>
					</div>
				</div>
			</form>
				<!-- //content -->
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