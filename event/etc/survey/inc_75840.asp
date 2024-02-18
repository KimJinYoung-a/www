<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'####################################################
' Description : 설문조사
' History : 2017-01-20 이종화 생성
'####################################################
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/lib/inc_const.asp" -->
<!-- #include virtual="/lib/util/pageformlib.asp" -->
<!-- #include virtual="/event/lib/event_etc_function.asp" -->
<%
dim eCode, userid, currenttime
IF application("Svr_Info") = "Dev" THEN
	eCode = "66267"
Else
	eCode = "75840"
End If

currenttime = now()
userid = GetEncLoginUserID()

dim subscriptcountend
subscriptcountend=0

'//본인 참여 여부
if userid<>"" then
	subscriptcountend = getevent_subscriptexistscount(eCode, userid, "", "2", "")
end If
%>
<style type="text/css">
@import url(http://fonts.googleapis.com/earlyaccess/nanumgothic.css);

.survey {background:#e3e3e3 url(http://webimage.10x10.co.kr/eventIMG/2017/75840/bg_pattern_light_grey.png) repeat 0 0;}

.survey .topic {overflow:hidden; position:relative; padding:63px 0 76px 93px; text-align:left;}
.survey .topic p {margin:30px 0 0 70px;}
.survey .topic .object {position:absolute; bottom:0; right:-85px;}
.survey .topic .object {animation:move1 2s 1;}
@keyframes move1 {
	0% {transform:translateX(-85px); opacity:0;}
	100% {transform:translateX(0); opacity:1;}
}

.survey .research {position:relative;}
.survey .page {position:relative; width:953px; height:959px;margin:-15px 0 48px 108px; background:url(http://webimage.10x10.co.kr/eventIMG/2017/75840/bg_board.png) no-repeat 50% 0; text-align:left;}
.survey .page .inner {position:relative; padding:258px 123px 0 147px;}
.survey .page .pagination {position:absolute; top:60px; right:117px; width:62px; height:71px;}
.survey .page .pagination span {position:absolute; top:0; right:0; width:100%; height:100%; background:url(http://webimage.10x10.co.kr/eventIMG/2017/75840/txt_pagination.png) no-repeat 50% 0;}
.survey .page2 .pagination span {background-position:50% -71px;}
.survey .page3 .pagination span {background-position:50% -142px;}
.survey .page4 .pagination span {background-position:50% -213px;}
.survey .page .question {margin-top:88px; font-family:'Nanum Gothic', 'Helvetica Neue', 'Helvetica', 'Arial', 'sans-serif';}
.survey .page .pagination + .question {margin-top:0;}
.survey .page1 .inner {padding-left:209px;}
.survey .page3 .inner {padding-top:156px;}
.survey .page3 .question {margin-top:30px;}
.survey .page4 .inner {padding-top:234px}
.survey .page5 {background-image:url(http://webimage.10x10.co.kr/eventIMG/2017/75840/bg_board_pink.png);}
.survey .page5 .inner {padding-top:316px; text-align:center;}
.survey .page5 .inner p img {margin-left:-40px;}
.survey .page5 .btnGo {margin-top:65px;}
.survey .page5 .btnGo img {margin-left:-40px;}
.survey .question ul {overflow:hidden; margin-top:12px;}
.survey .question ul li {float:left; width:100px; margin-top:16px; color:#444; font-size:15px; font-weight:bold;}
.survey .question1 ul li.last {overflow:hidden; position:relative; width:250px;}
.survey .question1 ul li.last span {float:left;}
.survey .question1 ul li.last .etc {width:58px;}
.survey .question1 ul li.last .itext {width:121px; margin-top:-10px; padding-left:0;}
.survey .question2 ul li {width:133px;}
.survey .question3 ul li {width:98px;}
.survey .question4 ul li {width:113px;}
.survey .question4 ul li:first-child + li,
.survey .question4 ul li:first-child + li + li + li + li + li + li {width:179px;}
.survey .question10 ul li {width:147px;}
/* 2, 6, 10 */
.survey .question10 ul li:first-child + li,
.survey .question10 ul li:first-child + li + li + li + li + li,
.survey .question10 ul li:first-child + li + li + li + li + li + li + li + li + li {width:160px;}
/* 3, 7, 11 */
.survey .question10 ul li:first-child + li + li,
.survey .question10 ul li:first-child + li + li + li + li + li + li,
.survey .question10 ul li:first-child + li + li + li + li + li + li + li + li + li + li {width:167px;}
/* 4, 8, 12 */
.survey .question10 ul li:first-child + li + li + li,
.survey .question10 ul li:first-child + li + li + li + li + li + li + li,
.survey .question10 ul li:first-child + li + li + li + li + li + li + li + li + li + li + li {width:205px;}

.survey .question .itext {margin-top:-5px; padding:0 62px 0 54px;}
.survey .question6 .itext,
.survey .question9 .itext {margin-top:10px;}
.survey .question .itext input {width:100%; height:30px; padding:0 7px; border-bottom:1px solid #000; color:#444; font-size:15px; font-family:'Nanum Gothic', 'Helvetica Neue', 'Helvetica', 'Arial', 'sans-serif'; font-weight:bold; line-height:30px;}
.survey .question .itext input::-webkit-input-placeholder {color:#a1a1a1;}
.survey .question .itext input::-moz-placeholder {color:#a1a1a1;} /* firefox 19+ */
.survey .question .itext input:-ms-input-placeholder {color:#a1a1a1;} /* ie */
.survey .question .itext input:-moz-placeholder {color:#a1a1a1;}
.survey .question textarea {width:597px; height:100px; margin:20px 0 0 54px; padding:10px 7px; border:1px solid #444; color:#444; font-size:15px; font-family:'Nanum Gothic', 'Helvetica Neue', 'Helvetica', 'Arial', 'sans-serif'; font-weight:bold;}

.survey .btnNext,
.survey .btnSubmit {position:absolute; bottom:128px; left:50%; margin-left:-147px; background-color:transparent;}
.survey .btnNext:hover,
.survey .btnNext:hover {animation:bounce infinite 0.7s;}
@keyframes bounce {
	from, to {margin-bottom:0; animation-timing-function:ease-out;}
	50% {margin-bottom:5px; animation-timing-function:ease-in;}
}

.noti {position:relative; padding:45px 0; background:#e3e3e3 url(http://webimage.10x10.co.kr/eventIMG/2017/75840/bg_pattern_grey.png) repeat 0 0; text-align:left;}
.noti h3 {position:absolute; top:50%; left:124px; margin-top:-27px;}
.noti ul {margin-left:278px; padding-left:51px; border-left:2px solid #dbdbdb;}
.noti ul li {position:relative; margin-top:7px; padding-left:10px; color:#8b8b8b; font-size:12px; line-height:1.5em;}
.noti ul li:first-child {margin-top:0;}
.noti ul li span {position:absolute; top:7px; left:0; width:5px; height:1px; background-color:#808290;}
</style>
<script type="text/javascript">
$(function(){
	$("#research .page").hide();
	<% IF subscriptcountend > 0 THEN %>
	$("#research .page:last").show();
	<% ELSE %>
	$("#research .page:first").show();
	<% END IF %>
});

function chkevt(v){
	<% If not(IsUserLoginOK()) Then %>
		if(confirm("로그인 후 신청할 수 있습니다.")){
			top.location.href="/login/loginpage.asp?vType=G";
			return false;
		}
		return false;
	<% End IF %>
	var frm =  document.frm;
	if (v == 1){
		if(!jsChkNull("radio",frm.ex1,"Q1.어느 지역에 사시나요?")){
			return;
		}

		if(!jsChkNull("radio",frm.ex2,"Q2.고객님의 연령대가 궁금해요!")){
			return;
		}
		$(".page1").hide();
		$(".page2").show();
	}else if (v == 2){
		if(!jsChkNull("radio",frm.ex3,"Q3.텐바이텐은 어떤 느낌을 주는 서비스인가요? (중복선택가능)")){
			return;
		}

		if(!jsChkNull("radio",frm.ex4,"Q4.텐바이텐 서비스를 이용하면 어떤 생각이 드나요? (중복선택가능)")){
			return;
		}
		$(".page2").hide();
		$(".page3").show();
	}else if (v == 3){
		if(!jsChkNull("text",frm.ex5,"Q5.텐바이텐과 어울리는 연예인은 누구일까요?")){
			frm.ex5.focus();
			return;
		}

		if (GetByteLength(frm.ex5.value) > 150){
			alert("150자 까지 작성 가능합니다.");
			frm.ex5.focus();
			return;
		}

		if(!jsChkNull("text",frm.ex6,"Q6.텐바이텐과 어울리는 자동차는 어떤 브랜드의 어떤 차종일까요?\n자동차가 아닌 이동수단도 좋아요!")){
			frm.ex6.focus();
			return;
		}

		if (GetByteLength(frm.ex6.value) > 150){
			alert("150자 까지 작성 가능합니다.");
			frm.ex6.focus();
			return;
		}

		if(!jsChkNull("text",frm.ex7,"Q7.텐바이텐과 어울리는 화장품 브랜드는 무엇일까요?")){
			frm.ex7.focus();
			return;
		}

		if (GetByteLength(frm.ex7.value) > 150){
			alert("150자 까지 작성 가능합니다.");
			frm.ex7.focus();
			return;
		}

		if(!jsChkNull("text",frm.ex8,"Q8.텐바이텐과 어울리는 의류 브랜드는 무엇일까요?")){
			frm.ex8.focus();
			return;
		}

		if (GetByteLength(frm.ex8.value) > 150){
			alert("150자 까지 작성 가능합니다.");
			frm.ex8.focus();
			return;
		}

		if(!jsChkNull("text",frm.ex9,"Q9.텐바이텐이 오프라인 매장을 신규 오픈한다면,\n어떤 동네와 어울릴까요?")){
			frm.ex9.focus();
			return;
		}

		if (GetByteLength(frm.ex9.value) > 150){
			alert("150자 까지 작성 가능합니다.");
			frm.ex9.focus();
			return;
		}

		$(".page3").hide();
		$(".page4").show();
	}else if (v == 4){
		if(!jsChkNull("radio",frm.ex10,"Q10.어떤 아이템을 사려고 할때 텐바이텐이 떠오르나요? (중복선택가능)")){
			return;
		}

		if (GetByteLength(frm.etc.value) > 150){
			alert("150자 까지 작성 가능합니다.");
			frm.etc.focus();
			return;
		}

		jsEventSubmit();
	}
}

function jsEventSubmit(){
	<% If IsUserLoginOK() Then %>
		<% If now() > #01/31/2017 23:59:59# then %>
			alert("이벤트 기간이 아닙니다.");
			return;
		<% else %>
			var str = $.ajax({
				type: "POST",
				url: "/event/etc/survey/do_75840.asp",
				data: $("#frm").serialize(),
				dataType: "text",
				async: false
			}).responseText;
			var str1 = str.split("||")
			console.log(str);
			if (str1[0] == "01"){
				alert(str1[1]);
				return false;
			}else if (str1[0] == "02"){
				alert(str1[1]);
				return false;
			}else if (str1[0] == "03"){
				alert(str1[1]);
				return false;
			}else if (str1[0] == "05"){
				$(".page4").hide();
				$(".page5").show();
				return false;
			}else{
				alert('오류가 발생했습니다.');
				return false;
			}
		<% end if %>
	<% Else %>
		if(confirm("로그인 후 신청할 수 있습니다.")){
			top.location.href="/login/loginpage.asp?vType=G";
			return false;
		}
		return false;
	<% End IF %>
}
</script>
<div class="evt75840 survey">
	<div class="topic">
		<h2><img src="http://webimage.10x10.co.kr/eventIMG/2017/75840/tit_survey.png" alt="고객님, 질문 있어요!" /></h2>
		<p><img src="http://webimage.10x10.co.kr/eventIMG/2017/75840/txt_survey.png" alt="텐바이텐에 애정 가득한 의견을 남겨주세요! 응답해주신 모든 고객님께 마일리지를 드립니다" /></p>
		<span class="object"><img src="http://webimage.10x10.co.kr/eventIMG/2017/75840/img_question_paper.png" alt="" /></span>
	</div>

	<div id="research" class="research">
		<form name="frm" id="frm" method="post">
			<fieldset>
			<legend>설문조사 입력 폼</legend>
				<div class="page page1">
					<div class="inner">
						<div class="pagination"><span></span>page 1 of 4</div>
						<div class="question question1">
							<h3><img src="http://webimage.10x10.co.kr/eventIMG/2017/75840/tit_question_01.png" alt="어느 지역에 사시나요?" /></h3>
							<ul>
								<li><input type="radio" id="city01" name="ex1" value="서울"/> <label for="city01">서울</label></li>
								<li><input type="radio" id="city02" name="ex1" value="경기도"/> <label for="city02">경기도</label></li>
								<li><input type="radio" id="city03" name="ex1" value="충청도"/> <label for="city03">충청도</label></li>
								<li><input type="radio" id="city04" name="ex1" value="전라도"/> <label for="city04">전라도</label></li>
								<li><input type="radio" id="city05" name="ex1" value="경상도"/> <label for="city05">경상도</label></li>
								<li><input type="radio" id="city06" name="ex1" value="강원도"/> <label for="city06">강원도</label></li>
								<li><input type="radio" id="city07" name="ex1" value="제주도"/> <label for="city07">제주도</label></li>
								<li><input type="radio" id="city08" name="ex1" value="해외"/> <label for="city08">해외</label></li>
								<li class="last">
									<span class="etc"><input type="radio" id="city09" name="ex1" value="99"/> <label for="city09">기타</label></span>
									<span class="itext"><input type="text" title="기타 사는 지역 입력" name="ex1text"/></span>
								</li>
							</ul>
						</div>

						<div class="question question2">
							<h3><img src="http://webimage.10x10.co.kr/eventIMG/2017/75840/tit_question_02.png" alt="고객님의 연령대가 궁금해요!" /></h3>
							<ul>
								<li><input type="radio" id="age01" name="ex2" value="14~20세"/> <label for="age01">14~20세</label></li>
								<li><input type="radio" id="age02" name="ex2" value="21~25세"/> <label for="age02">21~25세</label></li>
								<li><input type="radio" id="age03" name="ex2" value="26~30세"/> <label for="age03">26~30세</label></li>
								<li><input type="radio" id="age04" name="ex2" value="31~35세"/> <label for="age04">31~35세</label></li>
								<li><input type="radio" id="age05" name="ex2" value="35~40세"/> <label for="age05">35~40세</label></li>
								<li><input type="radio" id="age06" name="ex2" value="40대"/> <label for="age06">40대</label></li>
								<li><input type="radio" id="age07" name="ex2" value="50대 이상"/> <label for="age07">50대 이상</label></li>
							</ul>
						</div>
					</div>
					<button type="button" class="btnNext" onclick="chkevt(1);"><img src="http://webimage.10x10.co.kr/eventIMG/2017/75840/btn_next.png" alt="다음" /></button>
				</div>

				<div class="page page2">
					<div class="inner">
						<div class="pagination"><span></span>page 2 of 4</div>

						<div class="question question3">
							<h3><img src="http://webimage.10x10.co.kr/eventIMG/2017/75840/tit_question_03.png" alt="텐바이텐은 어떤 느낌을 주는 서비스인가요? 중복선택가능" /></h3>
							<ul>
								<li><input type="checkbox" id="feeling01" name="ex3" value="예쁘다"/> <label for="feeling01">예쁘다</label></li>
								<li><input type="checkbox" id="feeling02" name="ex3" value="평범하다"/> <label for="feeling02">평범하다</label></li>
								<li><input type="checkbox" id="feeling03" name="ex3" value="유니크하다"/> <label for="feeling03">유니크하다</label></li>
								<li><input type="checkbox" id="feeling04" name="ex3" value="센스있다"/> <label for="feeling04">센스있다</label></li>
								<li><input type="checkbox" id="feeling05" name="ex3" value="재미있다"/> <label for="feeling05">재미있다</label></li>
								<li><input type="checkbox" id="feeling06" name="ex3" value="감성적이다"/> <label for="feeling06">감성적이다</label></li>
								<li><input type="checkbox" id="feeling07" name="ex3" value="귀엽다"/> <label for="feeling07">귀엽다</label></li>
								<li><input type="checkbox" id="feeling08" name="ex3" value="기대된다"/> <label for="feeling08">기대된다</label></li>
								<li><input type="checkbox" id="feeling09" name="ex3" value="올드하다"/> <label for="feeling09">올드하다</label></li>
								<li><input type="checkbox" id="feeling10" name="ex3" value="지루하다"/> <label for="feeling10">지루하다</label></li>
								<li><input type="checkbox" id="feeling11" name="ex3" value="실망스럽다"/> <label for="feeling11">실망스럽다</label></li>
							</ul>
						</div>

						<div class="question question4">
							<h3><img src="http://webimage.10x10.co.kr/eventIMG/2017/75840/tit_question_04.png" alt="텐바이텐 서비스를 이용하면 어떤 생각이 드나요? 중복선택가능" /></h3>
							<ul>
								<li><input type="checkbox" id="think01" name="ex4" value="편리하다"/> <label for="think01">편리하다</label></li>
								<li><input type="checkbox" id="think02" name="ex4" value="가격이 합리적이다"/> <label for="think02">가격이 합리적이다</label></li>
								<li><input type="checkbox" id="think03" name="ex4" value="깔끔하다"/> <label for="think03">깔끔하다</label></li>
								<li><input type="checkbox" id="think04" name="ex4" value="물건이 많다"/> <label for="think04">물건이 많다</label></li>
								<li><input type="checkbox" id="think05" name="ex4" value="명확하다"/> <label for="think05">명확하다</label></li>
								<li><input type="checkbox" id="think06" name="ex4" value="불편하다"/> <label for="think06">불편하다</label></li>
								<li><input type="checkbox" id="think07" name="ex4" value="가격이 비싸다"/> <label for="think07">가격이 비싸다</label></li>
								<li><input type="checkbox" id="think08" name="ex4" value="복잡하다"/> <label for="think08">복잡하다</label></li>
								<li><input type="checkbox" id="think09" name="ex4" value="물건이 적다"/> <label for="think09">물건이 적다</label></li>
								<li><input type="checkbox" id="think10" name="ex4" value="헷갈린다"/> <label for="think10">헷갈린다</label></li>
							</ul>
						</div>
					</div>

					<button type="button" class="btnNext" onclick="chkevt(2);"><img src="http://webimage.10x10.co.kr/eventIMG/2017/75840/btn_next.png" alt="다음" /></button>
				</div>

				<div class="page page3">
					<div class="inner">
						<div class="pagination"><span></span>page 3 of 4</div>

						<div class="question question5">
							<h3><label for="entertainer"><img src="http://webimage.10x10.co.kr/eventIMG/2017/75840/tit_question_05.png" alt="텐바이텐과 어울리는 연예인은 누구일까요?" /></label></h3>
							<div class="itext"><input type="text" name="ex5" id="entertainer" placeholder="30자 이내로 입력해주세요" maxlength="150"/></div>
						</div>

						<div class="question question6">
							<h3><label for="car"><img src="http://webimage.10x10.co.kr/eventIMG/2017/75840/tit_question_06.png" alt="텐바이텐과 어울리는 자동차는 어떤 브랜드의 어떤 차종일까요? 자동차가 아닌 이동수단도 좋아요!" /></label></h3>
							<div class="itext"><input type="text" name="ex6" id="car" placeholder="30자 이내로 입력해주세요" maxlength="150"/></div>
						</div>

						<div class="question question7">
							<h3><label for="cosmetic"><img src="http://webimage.10x10.co.kr/eventIMG/2017/75840/tit_question_07.png" alt="텐바이텐과 어울리는 화장품 브랜드는 무엇일까요?" /></label></h3>
							<div class="itext"><input type="text" name="ex7" id="cosmetic" placeholder="30자 이내로 입력해주세요" maxlength="150"/></div>
						</div>

						<div class="question question8">
							<h3><label for="clothes"><img src="http://webimage.10x10.co.kr/eventIMG/2017/75840/tit_question_08.png" alt="텐바이텐과 어울리는 의류 브랜드는 무엇일까요?" /></label></h3>
							<div class="itext"><input type="text" name="ex8" id="clothes" placeholder="30자 이내로 입력해주세요" maxlength="150"/></div>
						</div>

						<div class="question question9">
							<h3><label for="town"><img src="http://webimage.10x10.co.kr/eventIMG/2017/75840/tit_question_09.png" alt="텐바이텐이 오프라인 매장을 신규 오픈한다면, 어떤 동네와 어울릴까요?" /></label></h3>
							<div class="itext"><input type="text" name="ex9" id="town" placeholder="30자 이내로 입력해주세요" maxlength="150"/></div>
						</div>
					</div>

					<button type="button" class="btnNext" onclick="chkevt(3);"><img src="http://webimage.10x10.co.kr/eventIMG/2017/75840/btn_next.png" alt="다음" /></button>
				</div>

				<div class="page page4">
					<div class="inner">
						<div class="pagination"><span></span>page 4 of 4</div>

						<div class="question question10">
							<h3><img src="http://webimage.10x10.co.kr/eventIMG/2017/75840/tit_question_10.png" alt="어떤 아이템을 사려고 할때 텐바이텐이 떠오르나요? 중복선택가능" /></h3>
							<ul>
								<li><input type="checkbox" id="item01" name="ex10" value="문구류"/> <label for="item01">문구류</label></li>
								<li><input type="checkbox" id="item02" name="ex10" value="다이어리"/> <label for="item02">다이어리</label></li>
								<li><input type="checkbox" id="item03" name="ex10" value="가구/조명"/> <label for="item03">가구/조명</label></li>
								<li><input type="checkbox" id="item04" name="ex10" value="인테리어 아이템"/> <label for="item04">인테리어 아이템</label></li>
								<li><input type="checkbox" id="item05" name="ex10" value="키덜트 아이템"/> <label for="item05">키덜트 아이템</label></li>
								<li><input type="checkbox" id="item06" name="ex10" value="디지털 아이템"/> <label for="item06">디지털 아이템</label></li>
								<li><input type="checkbox" id="item07" name="ex10" value="의류"/> <label for="item07">의류</label></li>
								<li><input type="checkbox" id="item08" name="ex10" value="가방, 악세서리 등 패션잡화"/> <label for="item08">가방, 악세서리 등 패션잡화</label></li>
								<li><input type="checkbox" id="item09" name="ex10" value="휴대폰 케이스"/> <label for="item09">휴대폰 케이스</label></li>
								<li><input type="checkbox" id="item10" name="ex10" value="반려동물 아이템"/> <label for="item10">반려동물 아이템</label></li>
								<li><input type="checkbox" id="item11" name="ex10" value="캠핑, 여행 아이템"/> <label for="item11">캠핑, 여행 아이템</label></li>
								<li><input type="checkbox" id="item12" name="ex10" value="베이비/키즈 아이템"/> <label for="item12">베이비/키즈 아이템</label></li>
							</ul>
						</div>

						<div class="question question11">
							<h3><label for="story"><img src="http://webimage.10x10.co.kr/eventIMG/2017/75840/tit_question_11.png" alt="답변해주셔서 감사합니다. 텐바이텐에게 전하고 싶은 이야기가 있으면 편하게 작성해주세요. 건의사항, 불만 토로, 칭찬과 응원 모두 좋습니다!" /></label></h3>
							<textarea cols="60" rows="5" name="etc" id="story" placeholder="150자 이내로 입력해주세요"></textarea>
						</div>
					</div>

					<button type="button" class="btnNext" onclick="chkevt(4);"><img src="http://webimage.10x10.co.kr/eventIMG/2017/75840/btn_submit.png" alt="응답 저장하기" /></button>
				</div>
			
				<div class="page page5">
					<div class="inner">
						<p><img src="http://webimage.10x10.co.kr/eventIMG/2017/75840/txt_finish_v1.gif" alt="짝짝짝! 모든 응답을 완료 하셨습니다 더욱 더 발전하는 텐바이텐이 되겠습니다!" /></p>
						<div class="btnGo"><a href="/index.asp"><img src="http://webimage.10x10.co.kr/eventIMG/2017/75840/btn_go.png" alt="텐바이텐 메인으로 가기" /></a></div>
					</div>
				</div>
			</fieldset>
		</form>
	</div>

	<div class="mileage">
		<p><img src="http://webimage.10x10.co.kr/eventIMG/2017/75840/txt_mileage_v1.gif" alt="여러분의 다양한 목소리에 귀 기울이겠습니다 응답을 완료하신 모든 고객님께 300 마일리지를 드립니다. 2월 1일 일괄지급" /></p>
	</div>

	<div class="noti">
		<h3><img src="http://webimage.10x10.co.kr/eventIMG/2017/75840/tit_noti.png" alt="이벤트 유의사항" /></h3>
		<ul>
			<li><span></span>이벤트는 ID당 1회만 참여할 수 있습니다.</li>
			<li><span></span>응답 중간에 페이지 이탈 시, 응답은 임시저장 되지 않습니다.</li>
			<li><span></span>이벤트는 조기 종료될 수 있습니다.</li>
		</ul>
	</div>
</div>
<!-- #include virtual="/lib/db/dbclose.asp" -->