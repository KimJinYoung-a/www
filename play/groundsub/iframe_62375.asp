<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'####################################################
'### PLAY #20 FLOWER _ FIND MY SCENT
'### 2015-05-08 유태욱
'####################################################
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include Virtual="/lib/util/commlib.asp" -->
<!-- #include Virtual="/lib/chkDevice.asp" -->
<!-- #include virtual="/event/lib/event_etc_function.asp" -->
<%
	Dim eCode, sqlstr, mycomcnt, totalcnt, myscent
	dim nowdate

	nowdate = date()
'	nowdate = "2015-05-11"

	IF application("Svr_Info") = "Dev" THEN
		eCode   =  61782
	Else
		eCode   =  62375
	End If

	dim LoginUserid
	LoginUserid = getLoginUserid()

	''응모 이력 있는지 체크
	sqlstr = "select count(userid) as cnt "
	sqlstr = sqlstr & " from [db_event].[dbo].[tbl_event_subscript]"
	sqlstr = sqlstr & " where evt_code="& eCode &""
	sqlstr = sqlstr & " and userid='"& LoginUserid &"' "

	rsget.Open sqlstr, dbget, 1
	If Not rsget.Eof Then
		mycomcnt = rsget(0)
	End IF
	rsget.close

	''내향
	sqlstr = "select top 1 sub_opt1"
	sqlstr = sqlstr & " from [db_event].[dbo].[tbl_event_subscript]"
	sqlstr = sqlstr & " where evt_code="& eCode &""
	sqlstr = sqlstr & " and userid='"& LoginUserid &"' "

	rsget.Open sqlstr, dbget, 1
		If Not rsget.Eof Then
			myscent = rsget(0)
		End IF
	rsget.close

	''응모자 총 카운트
	sqlStr = "Select count(sub_idx) " &_
			" from [db_event].[dbo].[tbl_event_subscript] " &_
			" where evt_code="& eCode &" "
	rsget.Open sqlStr,dbget,1
	totalcnt = rsget(0)
	rsget.Close

%>
<!-- #include virtual="/lib/inc/head.asp" -->
<link rel="stylesheet" type="text/css" href="/lib/css/preVst/section.css" />
<link rel="stylesheet" type="text/css" href="/lib/css/sectionV15.css" />
<style type="text/css">
img {vertical-align:top;}
.playGr20150511 {}
.topic .hgroup {position:relative; height:880px; background:#fffdfc url(http://webimage.10x10.co.kr/play/ground/20150511/bg_on_table.jpg) no-repeat 50% 0;}
.topic .hgroup h1 {position:absolute; top:123px; left:50%; margin-left:-350px; width:700px; height:180px;}
.topic .hgroup h1 span {display:block; position:absolute; background:url(http://webimage.10x10.co.kr/play/ground/20150511/bg_tit_find_my_scent_01.png) no-repeat 0 0; text-indent:-999em;}
.topic .hgroup h1 .letter1 {top:55px; left:69px; width:218px; height:117px;}
.topic .hgroup h1 .letter2 {top:55px; left:287px; width:142px; height:117px; background-position:-218px 0;}
.topic .hgroup h1 .letter3 {top:55px; left:428px; width:202px; height:117px; background-position:100% 0;}
.topic .hgroup h1 .letter4 {top:-2px; left:50%; width:244px; height:16px; margin-left:-122px; background:url(http://webimage.10x10.co.kr/play/ground/20150511/bg_tit_find_my_scent_02.png) no-repeat 0 0;}
.topic .hgroup h1 .linebox {top:0; left:0; width:700px; height:180px; background:url(http://webimage.10x10.co.kr/play/ground/20150511/bg_line_box.png) no-repeat 0 0;}
.topic .article {position:relative; height:380px; background:#f9ebdd url(http://webimage.10x10.co.kr/play/ground/20150511/bg_vertical_pattern.png) repeat 0 0; text-align:center;}
.topic .article .bg {position:absolute; top:82px; left:50%; margin-left:-542px; width:1085px; height:213px; background:url(http://webimage.10x10.co.kr/play/ground/20150511/bg_collabo.png) no-repeat 50% 50%;}
.topic .article .deco {position:absolute; top:93px; left:50%; width:10px; height:2px; margin-left:-5px; background-color:#b0ada9;}
.topic .article p {padding-top:30px;}
.topic .article span + p {padding-top:136px;}

.package {background-color:#fdfdfd; text-align:center;}
.package .inner {position:relative; width:1140px; margin:0 auto; padding:135px 0 105px;}
.package .bg {position:absolute; top:0; left:-187px; width:440px; height:220px; background:url(http://webimage.10x10.co.kr/play/ground/20150511/bg_triangle.png) no-repeat 50% 0;}
.package h2 {position:absolute; top:79px; left:35px;}
.package .btngift {margin:105px 0;}
.package .in h3 {text-align:center;}
.package .in ul {overflow:hidden; width:1040px; margin:70px auto 0; padding-bottom:90px;}
.package .in ul li {float:left; margin-right:40px;}

.psychologicalTest {min-height:932px; background:#fcfbf9 url(http://webimage.10x10.co.kr/play/ground/20150511/bg_bottle_v1.jpg) no-repeat 50% 0;}
.psychologicalTest .inner {width:1140px; margin:0 auto; padding-top:88px;}
.psychologicalTest .hgroup {position:relative; height:115px; text-align:center;}
.psychologicalTest .hgroup h2 {width:625px; height:56px; margin:0 auto;}
.psychologicalTest .hgroup p {margin-top:30px;}
.psychologicalTest .itemList {margin-top:68px;}
.psychologicalTest .item {position:relative; width:860px; height:491px; margin:0 auto; padding:120px 122px 81px 110px; background:url(http://webimage.10x10.co.kr/play/ground/20150511/bg_box.png) no-repeat 50% 0;}
.psychologicalTest .item h3 span {position:absolute; top:0; left:70px; width:88px; height:90px; background:url(http://webimage.10x10.co.kr/play/ground/20150511/bg_num.png) no-repeat 0 0; text-indent:-999em;}
.psychologicalTest .itemB h3 span {background-position:-88px 0;}
.psychologicalTest .itemC h3 span {background-position:-176px 0;}
.psychologicalTest .itemD h3 span {background-position:-264px 0;}
.psychologicalTest .itemE h3 span {background-position:-352px 0;}
.psychologicalTest .itemF h3 span {background-position:-440px 0;}
.psychologicalTest .itemG h3 span {background-position:-528px 0;}
.psychologicalTest .itemH h3 span {background-position:-616px 0;}
.psychologicalTest .itemI h3 span {background-position:-704px 0;}
.psychologicalTest .itemJ h3 span {background-position:100% 0;}
.psychologicalTest .itemK {width:1060px; height:660px; padding:10px 22px 22px 10px;}
.psychologicalTest .item .typeA {margin-top:78px; margin-left:64px;}
.psychologicalTest .item .typeA ul li {margin-bottom:33px;}
.psychologicalTest .item .typeA ul li input {margin-top:-3px; margin-right:22px; vertical-align:middle;}
.psychologicalTest .item .typeB {margin-top:53px; margin-left:64px;}
.psychologicalTest .item .typeB ul {overflow:hidden;}
.psychologicalTest .item .typeB ul li {position:relative; float:left; margin-bottom:40px; padding:0 25px 25px;}
.psychologicalTest .item .typeB ul li label {display:block;}
.psychologicalTest .item .typeB ul li input {position:absolute; bottom:0; left:50%; width:12px; height:12px; margin-left:-6px;}
.psychologicalTest .item .typeB .nth-child4 {clear:left; margin-left:95px;}
.psychologicalTest .item .typeC {width:640px; margin:54px auto 0;}
.psychologicalTest .item .typeC ul {overflow:hidden; margin-top:30px;}
.psychologicalTest .item .typeC ul li {float:left; position:relative; width:20%; padding-bottom:21px; text-align:center;}
.psychologicalTest .item .typeC ul li input {position:absolute; bottom:0; left:50%; width:12px; height:12px; margin-left:-6px;}
.psychologicalTest .item .btnnext, .psychologicalTest .item .btnresult {position:absolute; right:92px; bottom:82px; width:120px; height:120px; background:url(http://webimage.10x10.co.kr/play/ground/20150511/bg_btn_next.png) no-repeat 50% 0; text-align:center;}
.psychologicalTest .item .btnresult {background:url(http://webimage.10x10.co.kr/play/ground/20150511/bg_btn_result.png) no-repeat 50% 0;}
.psychologicalTest .item .btnnext:hover img, .psychologicalTest .item .btnresult:hover img {-webkit-animation-name:updown; -webkit-animation-iteration-count:infinite; -webkit-animation-duration:0.5s; -moz-animation-name:updown; -moz-animation-iteration-count:infinite; -moz-animation-duration:0.5s; -ms-animation-name:updown; -ms-animation-iteration-count:infinite; -ms-animation-duration:0.5s;}
@-webkit-keyframes updown {
	from, to{margin-top:0; -webkit-animation-timing-function:ease-out;}
	50% {margin-top:8px; -webkit-animation-timing-function:ease-in;}
}
@keyframes updown {
	from, to{margin-top:0; animation-timing-function:ease-out;}
	50% {margin-top:8px; animation-timing-function:ease-in;}
}

.count {padding:70px 0 100px; border-bottom:1px solid #eae8e4; background-color:#fcfbf9; text-align:center;}
.count p {width:660px; height:53px; margin:0 auto; padding-top:27px; background:url(http://webimage.10x10.co.kr/play/ground/20150511/bg_round_box.png) no-repeat 50% 0;}
.count p strong {margin-left:6px; color:#7c6a65; font-size:30px; font-family:'Verdana', 'Doutm', '돋움'; line-height:20px;}

.rollingwrap {overflow:hidden; position:relative; height:840px;}
.rolling {position:relative; width:1140px; height:840px; margin:0 auto;}
.rolling .swiper {position:absolute; top:0; left:50%; width:4560px; height:840px; margin-left:-2280px;}
.rolling .swiper .swiper-container {overflow:hidden; width:100%; height:840px;}
.rolling .swiper .swiper-wrapper {position:relative; width:100%;}
.rolling .swiper .swiper-slide {float:left; width:100%; height:840px;}
.rolling .swiper .swiper-slide img { vertical-align:top;}
.rolling .pagination {position: absolute; left:50%; bottom:50px; width:160px; margin-left:-80px;}
.rolling .swiper-pagination-switch {display:block; float:left; width:30px; height:4px; margin:0 5px; background-color:#eae4d7; cursor:pointer; opacity:0.6; filter:alpha(opacity=60);}
.rolling .swiper-active-switch {background-color:#3e362a;}
.rolling .btn-nav {display:block; position:absolute; top:50%; z-index:500; width:28px; height:100px; margin-top:-50px; background-color:transparent; background-image:url(http://webimage.10x10.co.kr/play/ground/20150511/btn_nav.png); background-repeat:no-repeat; text-indent:-999em}
.rolling .btn-nav.arrow-left {left:0; background-position:0 0;}
.rolling .btn-nav.arrow-right {right:0; background-position:100% 0;}
.swipemask {position:absolute; top:0; width:1140px; height:840px; z-index:100; background-color:#000; opacity:0.3; filter:alpha(opacity=30);}
.mask-left {left:0; margin-left:-1140px;}
.mask-right {right:0; margin-right:-1140px;}

.brandstory {border-top:1px solid #d1cfc8; background-color:#f6f6f6;}
.brandstory .inner {width:1140px; margin:0 auto; padding:130px 0 125px; border-bottom:1px solid #e6e6e6;}
.brandstory p {padding-left:70px;}

.animated {-webkit-animation-duration:5s; animation-duration:5s; -webkit-animation-fill-mode:both; animation-fill-mode:both; -webkit-animation-iteration-count:infinite;animation-iteration-count:infinite;}

/* Pulse Animation */
@-webkit-keyframes pulse {
	0% {-webkit-transform: scale(1);}
	50% {-webkit-transform: scale(1.1);}
	100% {-webkit-transform: scale(1);}
} 
@keyframes pulse {
	0% {transform:scale(1);}
	50% {transform:scale(1.1);}
	100% {transform:scale(1);}
}
.pulse {
	-webkit-animation-name:pulse;
	animation-name:pulse;
}

/* flash animation */
@-webkit-keyframes flash {
	0% {opacity:0;}
	100% {opacity:1;}
}
@keyframes flash {
	0% {opacity:0;}
	100% {opacity:1;}
}
.flash {-webkit-animation-duration:1s; animation-duration:1s; -webkit-animation-name:flash; animation-name:flash; -webkit-animation-iteration-count:infinite; animation-iteration-count:infinite;}
</style>
<script type="text/javascript">
function resultA(){
	<% If IsUserLoginOK Then %>
		<% If nowdate >="2015-05-11" and nowdate <"2015-05-21" Then %>
			var tmpgubun='';
			for (var i=0; i < frmcom.rebntA.length ; i++){
				if (frmcom.rebntA[i].checked){
					tmpgubun=frmcom.rebntA[i].value;
				}
			}
			if (tmpgubun==''){
				alert('선택을 해주세요');
				return false;
			}
			$("#viewResult").show();
			$("#viewResult .itemJ").hide();
			$("#viewResult .itemI").hide();
			$("#viewResult .itemH").hide();
			$("#viewResult .itemG").hide();
			$("#viewResult .itemF").hide();
			$("#viewResult .itemE").hide();
			$("#viewResult .itemD").hide();
			$("#viewResult .itemC").hide();
			$("#viewResult .itemA").hide();

			$("#viewResult .itemB").show();
			return false;
		<% else %>
			alert("이벤트 기간이 아닙니다.");
			return false;
		<% end if %>
	<% Else %>
	    jsChklogin('<%=IsUserLoginOK%>');
	    return false;
	<% end if %>
}

function resultB(){
	<% If IsUserLoginOK Then %>
		<% If nowdate >="2015-05-11" and nowdate <"2015-05-21" Then %>
			var tmpgubun='';
			for (var i=0; i < frmcom.rebntB.length ; i++){
				if (frmcom.rebntB[i].checked){
					tmpgubun=frmcom.rebntB[i].value;
				}
			}
			if (tmpgubun==''){
				alert('선택을 해주세요');
				return false;
			}
			$("#viewResult").show();
			$("#viewResult .itemJ").hide();
			$("#viewResult .itemI").hide();
			$("#viewResult .itemH").hide();
			$("#viewResult .itemG").hide();
			$("#viewResult .itemF").hide();
			$("#viewResult .itemE").hide();
			$("#viewResult .itemD").hide();
			$("#viewResult .itemB").hide();
			$("#viewResult .itemA").hide();

			$("#viewResult .itemC").show();
			return false;
		<% else %>
			alert("이벤트 기간이 아닙니다.");
			return false;
		<% end if %>
	<% Else %>
	    jsChklogin('<%=IsUserLoginOK%>');
	    return false;
	<% end if %>
}

function resultC(){
	<% If IsUserLoginOK Then %>
		<% If nowdate >="2015-05-11" and nowdate <"2015-05-21" Then %>
			var tmpgubun='';
			for (var i=0; i < frmcom.rebntC.length ; i++){
				if (frmcom.rebntC[i].checked){
					tmpgubun=frmcom.rebntC[i].value;
				}
			}
			if (tmpgubun==''){
				alert('선택을 해주세요');
				return false;
			}
			$("#viewResult").show();
			$("#viewResult .itemJ").hide();
			$("#viewResult .itemI").hide();
			$("#viewResult .itemH").hide();
			$("#viewResult .itemG").hide();
			$("#viewResult .itemF").hide();
			$("#viewResult .itemE").hide();
			$("#viewResult .itemC").hide();
			$("#viewResult .itemB").hide();
			$("#viewResult .itemA").hide();

			$("#viewResult .itemD").show();
			return false;
		<% else %>
			alert("이벤트 기간이 아닙니다.");
			return false;
		<% end if %>
	<% Else %>
	    jsChklogin('<%=IsUserLoginOK%>');
	    return false;
	<% end if %>
}

function resultD(){
	<% If IsUserLoginOK Then %>
		<% If nowdate >="2015-05-11" and nowdate <"2015-05-21" Then %>
			var tmpgubun='';
			for (var i=0; i < frmcom.rebntD.length ; i++){
				if (frmcom.rebntD[i].checked){
					tmpgubun=frmcom.rebntD[i].value;
				}
			}
			if (tmpgubun==''){
				alert('선택을 해주세요');
				return false;
			}
			$("#viewResult").show();
			$("#viewResult .itemJ").hide();
			$("#viewResult .itemI").hide();
			$("#viewResult .itemH").hide();
			$("#viewResult .itemG").hide();
			$("#viewResult .itemF").hide();
			$("#viewResult .itemD").hide();
			$("#viewResult .itemC").hide();
			$("#viewResult .itemB").hide();
			$("#viewResult .itemA").hide();

			$("#viewResult .itemE").show();
			return false;
		<% else %>
			alert("이벤트 기간이 아닙니다.");
			return false;
		<% end if %>
	<% Else %>
	    jsChklogin('<%=IsUserLoginOK%>');
	    return false;
	<% end if %>
}

function resultE(){
	<% If IsUserLoginOK Then %>
		<% If nowdate >="2015-05-11" and nowdate <"2015-05-21" Then %>
			var tmpgubun='';
			for (var i=0; i < frmcom.rebntE.length ; i++){
				if (frmcom.rebntE[i].checked){
					tmpgubun=frmcom.rebntE[i].value;
				}
			}
			if (tmpgubun==''){
				alert('선택을 해주세요');
				return false;
			}
			$("#viewResult").show();
			$("#viewResult .itemJ").hide();
			$("#viewResult .itemI").hide();
			$("#viewResult .itemH").hide();
			$("#viewResult .itemG").hide();
			$("#viewResult .itemE").hide();
			$("#viewResult .itemD").hide();
			$("#viewResult .itemC").hide();
			$("#viewResult .itemB").hide();
			$("#viewResult .itemA").hide();

			$("#viewResult .itemF").show();
			return false;
		<% else %>
			alert("이벤트 기간이 아닙니다.");
			return false;
		<% end if %>
	<% Else %>
	    jsChklogin('<%=IsUserLoginOK%>');
	    return false;
	<% end if %>
}

function resultF(){
	<% If IsUserLoginOK Then %>
		<% If nowdate >="2015-05-11" and nowdate <"2015-05-21" Then %>
			var tmpgubun='';
			for (var i=0; i < frmcom.rebntF.length ; i++){
				if (frmcom.rebntF[i].checked){
					tmpgubun=frmcom.rebntF[i].value;
				}
			}
			if (tmpgubun==''){
				alert('선택을 해주세요');
				return false;
			}
			$("#viewResult").show();
			$("#viewResult .itemJ").hide();
			$("#viewResult .itemI").hide();
			$("#viewResult .itemH").hide();
			$("#viewResult .itemF").hide();
			$("#viewResult .itemE").hide();
			$("#viewResult .itemD").hide();
			$("#viewResult .itemC").hide();
			$("#viewResult .itemB").hide();
			$("#viewResult .itemA").hide();

			$("#viewResult .itemG").show();
			return false;
		<% else %>
			alert("이벤트 기간이 아닙니다.");
			return false;
		<% end if %>
	<% Else %>
	    jsChklogin('<%=IsUserLoginOK%>');
	    return false;
	<% end if %>
}

function resultG(){
	<% If IsUserLoginOK Then %>
		<% If nowdate >="2015-05-11" and nowdate <"2015-05-21" Then %>
			var tmpgubun='';
			for (var i=0; i < frmcom.rebntG.length ; i++){
				if (frmcom.rebntG[i].checked){
					tmpgubun=frmcom.rebntG[i].value;
				}
			}
			if (tmpgubun==''){
				alert('선택을 해주세요');
				return false;
			}
			$("#viewResult").show();
			$("#viewResult .itemJ").hide();
			$("#viewResult .itemI").hide();
			$("#viewResult .itemG").hide();
			$("#viewResult .itemF").hide();
			$("#viewResult .itemE").hide();
			$("#viewResult .itemD").hide();
			$("#viewResult .itemC").hide();
			$("#viewResult .itemB").hide();
			$("#viewResult .itemA").hide();

			$("#viewResult .itemH").show();
			return false;
		<% else %>
			alert("이벤트 기간이 아닙니다.");
			return false;
		<% end if %>
	<% Else %>
	    jsChklogin('<%=IsUserLoginOK%>');
	    return false;
	<% end if %>
}

function resultH(){
	<% If IsUserLoginOK Then %>
		<% If nowdate >="2015-05-11" and nowdate <"2015-05-21" Then %>
			var tmpgubun='';
			for (var i=0; i < frmcom.rebntH.length ; i++){
				if (frmcom.rebntH[i].checked){
					tmpgubun=frmcom.rebntH[i].value;
				}
			}
			if (tmpgubun==''){
				alert('선택을 해주세요');
				return false;
			}
			$("#viewResult").show();
			$("#viewResult .itemJ").hide();
			$("#viewResult .itemH").hide();
			$("#viewResult .itemG").hide();
			$("#viewResult .itemF").hide();
			$("#viewResult .itemE").hide();
			$("#viewResult .itemD").hide();
			$("#viewResult .itemC").hide();
			$("#viewResult .itemB").hide();
			$("#viewResult .itemA").hide();

			$("#viewResult .itemI").show();
			return false;
		<% else %>
			alert("이벤트 기간이 아닙니다.");
			return false;
		<% end if %>
	<% Else %>
	    jsChklogin('<%=IsUserLoginOK%>');
	    return false;
	<% end if %>
}

function resultI(){
	<% If IsUserLoginOK Then %>
		<% If nowdate >="2015-05-11" and nowdate <"2015-05-21" Then %>
			var tmpgubun='';
			for (var i=0; i < frmcom.rebntI.length ; i++){
				if (frmcom.rebntI[i].checked){
					tmpgubun=frmcom.rebntI[i].value;
				}
			}
			if (tmpgubun==''){
				alert('선택을 해주세요');
				return false;
			}
			$("#viewResult").show();
			$("#viewResult .itemI").hide();
			$("#viewResult .itemH").hide();
			$("#viewResult .itemG").hide();
			$("#viewResult .itemF").hide();
			$("#viewResult .itemE").hide();
			$("#viewResult .itemD").hide();
			$("#viewResult .itemC").hide();
			$("#viewResult .itemB").hide();
			$("#viewResult .itemA").hide();

			$("#viewResult .itemJ").show();
			return false;
		<% else %>
			alert("이벤트 기간이 아닙니다.");
			return false;
		<% end if %>
	<% Else %>
	    jsChklogin('<%=IsUserLoginOK%>');
	    return false;
	<% end if %>
}

function resultJ(){
	<% If IsUserLoginOK Then %>
		<% If nowdate >="2015-05-11" and nowdate <"2015-05-21" Then %>
			var tmpgubun='';
			for (var i=0; i < frmcom.rebntJ.length ; i++){
				if (frmcom.rebntJ[i].checked){
					tmpgubun=frmcom.rebntJ[i].value;
				}
			}
			if (tmpgubun==''){
				alert('선택을 해주세요');
				return false;
			}

			var rstStr = $.ajax({
				type: "POST",
				url: "/play/groundsub/doEventSubscript62375.asp",
				data: "mode=add&myscent="+tmpgubun,
				dataType: "text",
				async: false
			}).responseText;

			if (rstStr.substring(0,8) == "SUCCESS1"){
				var myscent;
				myscent = rstStr.substring(11,12);

				var entercnt;
				entercnt = rstStr.substring(15,20);
				$("#entercnt").html(entercnt);

				$("#viewResult").show();
				$("#viewResult .itemJ").hide();
				$("#viewResult .itemI").hide();
				$("#viewResult .itemH").hide();
				$("#viewResult .itemG").hide();
				$("#viewResult .itemF").hide();
				$("#viewResult .itemE").hide();
				$("#viewResult .itemD").hide();
				$("#viewResult .itemC").hide();
				$("#viewResult .itemB").hide();
				$("#viewResult .itemA").hide();

				$("#imgSrc").attr("src", "http://webimage.10x10.co.kr/play/ground/20150511/txt_result_0"+myscent+".png");
				$("#viewResult .itemK").show();
			}else if (rstStr == "END"){
				alert('더이상 응모할 수 없습니다');
				return false;
			}
			return false;
		<% else %>
			alert("이벤트 기간이 아닙니다.");
			return false;
		<% end if %>
	<% Else %>
	    jsChklogin('<%=IsUserLoginOK%>');
	    return false;
	<% end if %>
}
</script>
</head>
<body>
<!-- iframe -->
<div class="playGr20150511">

	<div class="topic">
		<div class="hgroup">
			<h1>
				<span class="letter1">FIND</span>
				<span class="letter2">MY</span>
				<span class="letter3">SCENT</span>
				<span class="letter4">TEN BY TEN X BLOOM</span>
				<span class="linebox"></span>
			</h1>
		</div>
		<div class="article">
			<span class="deco"></span>
			<p><img src="http://webimage.10x10.co.kr/play/ground/20150511/txt_topic_01.png" alt="따뜻한 봄날의 꽃 향기, 여름의 시원한  꽃 향기 등등 꽃에는 각자 이름처럼 기분 좋은 향이 있습니다. 우리는 디퓨저나 향초 또는 룸스프레이를 통해 그 좋은 향기를 나의 공간으로 데려오고 싶어하죠." /></p>
			<p><img src="http://webimage.10x10.co.kr/play/ground/20150511/txt_topic_02.png" alt="텐바이텐과 블룸은 이러한 분들을 위해 [FIND MY SCENT] 패키지를 제작했습니다. 패키지에는 향기를 오래도록 은은하게 퍼뜨려주는 디퓨저와 공간마다 손쉽게 향기를 뿌려줄 수 있는 룸스프레이(페브릭퍼퓸)가 있습니다." /></p>
			<p><img src="http://webimage.10x10.co.kr/play/ground/20150511/txt_topic_03.png" alt="당신의 향기를 찾아 좋은 기분을 한가득 맡아보세요!" /></p>
			<div class="bg animated pulse"></div>
		</div>
	</div>

	<div class="package">
		<div class="inner">
			<div class="bg"></div>
			<h2><img src="http://webimage.10x10.co.kr/play/ground/20150511/tit_make.png" alt="당신의 향을 만들어 드립니다." /></h2>
			<p><img src="http://webimage.10x10.co.kr/play/ground/20150511/txt_package.jpg" alt="다음의 심리테스트에 참여하시면 자동으로 응모됩니다. 재미있는 심리테스트를 통해 나만의 향을 찾아보세요! 심리테스트를 하신 분들 중 추첨을 통해 총 5분께 이름이 새겨진 디퓨저와 페브릭 퍼퓸을 선물해드립니다! 이벤트 기간은 2015년 5월 11일부터 5월 20일까지며, 당첨자 발표는 2015년 5월 21일입니다. 다음의 심리테스트에 참여하시면 자동으로 응모되며 한 ID당 한 번의 참여만 가능합니다." /></p>
			<div class="btngift"><a href="#psychologicalTest"><img src="http://webimage.10x10.co.kr/play/ground/20150511/btn_gift.png" alt="심리테스트로 향기 찾고 패키지 선물 받기!" /></a></div>
			<div class="in">
				<h3><img src="http://webimage.10x10.co.kr/play/ground/20150511/tit_package_box.png" alt="PACKAGE" /></h3>
				<ul>
					<li class="goods1"><img src="http://webimage.10x10.co.kr/play/ground/20150511/img_package_01.png" alt="디퓨저 케이스" /></li>
					<li class="goods2"><img src="http://webimage.10x10.co.kr/play/ground/20150511/img_package_02.png" alt="향료" /></li>
					<li class="goods3"><img src="http://webimage.10x10.co.kr/play/ground/20150511/img_package_03.png" alt="리드스틱과 드라이플라워" /></li>
					<li class="goods4"><img src="http://webimage.10x10.co.kr/play/ground/20150511/img_package_04.png" alt="패브릭퍼퓸" /></li>
				</ul>
				<p><img src="http://webimage.10x10.co.kr/play/ground/20150511/txt_copyright.png" alt="블룸에서 출시되는 향은 모두 블룸에서 새롭게 모듈 하여 출시하는 블룸만의 향으로, 향에 대한 모든 권리는 블룸에 있습니다." /></p>
			</div>
		</div>
	</div>

	<!-- for dev msg : 심리테스트 -->
	<div id="psychologicalTest" class="psychologicalTest">
		<div class="inner">
			<div class="hgroup">
				<h2><img src="http://webimage.10x10.co.kr/play/ground/20150511/tit_find_my_scent_02.png" alt="나만의 향기를 찾아서!" /></h2>
				<p><img src="http://webimage.10x10.co.kr/play/ground/20150511/txt_gift.png" alt="심리테스트에 참여하시면 추첨을 통해총 5분에게 텐바이텐x블룸의 한정판 패키지 find my scent를 드립니다!" /></p>
			</div>

			<form name="frmcom" method="post" style="margin:0px;">
			<div class="itemList" id="viewResult">
		<% If IsUserLoginOK Then %>
			<% if mycomcnt < 1 then %>
				<!-- Q1 -->
				<div class="item itemA" style="display:block">
					<h3><span>1</span><img src="http://webimage.10x10.co.kr/play/ground/20150511/tit_question_01.png" alt="연인에게 메시지를 남기려는 당신, 당신의 선택은?" /></h3>
					<div class="typeA">
						<ul>
							<li>
								<input type="radio" id="answer01A" name="rebntA" value="1"/>
								<label for="answer01A"><img src="http://webimage.10x10.co.kr/play/ground/20150511/txt_label_01_01.png" alt="작은 카드" /></label>
							</li>
							<li>
								<input type="radio" id="answer02A" name="rebntA" value="2"/>
								<label for="answer02A"><img src="http://webimage.10x10.co.kr/play/ground/20150511/txt_label_01_02.png" alt="포스트 잇" /></label>
							</li>
							<li>
								<input type="radio" id="answer03A" name="rebntA" value="3"/>
								<label for="answer03A"><img src="http://webimage.10x10.co.kr/play/ground/20150511/txt_label_01_03.png" alt="깔끔한 느낌의 유선 편지지" /></label>
							</li>
							<li>
								<input type="radio" id="answer04A" name="rebntA" value="4"/>
								<label for="answer04A"><img src="http://webimage.10x10.co.kr/play/ground/20150511/txt_label_01_04.png" alt="파스텔 톤의 색지로 만들어진 편지지" /></label>
							</li>
							<li>
								<input type="radio" id="answer05A" name="rebntA" value="5"/>
								<label for="answer05A"><img src="http://webimage.10x10.co.kr/play/ground/20150511/txt_label_01_05.png" alt="아기자기한 일러스트 편지지" /></label>
							</li>
						</ul>
					</div>
					<button type="button" onclick="resultA(); return false;" class="btnnext"><img src="http://webimage.10x10.co.kr/play/ground/20150511/btn_next.png" alt="다음" /></button>
				</div>

				<!-- Q2 -->
				<div class="item itemB" style="display:none">
					<h3><span>2</span><img src="http://webimage.10x10.co.kr/play/ground/20150511/tit_question_02.png" alt="다음 중 가장 마음에 드는 사진은?" /></h3>
					<div class="typeB">
						<ul>
							<li>
								<input type="radio" id="answer01B" name="rebntB" value="1"/>
								<label for="answer01B"><img src="http://webimage.10x10.co.kr/play/ground/20150511/img_label_02_01.jpg" alt="야경" /></label>
							</li>
							<li>
								<input type="radio" id="answer02B" name="rebntB" value="2"/>
								<label for="answer02B"><img src="http://webimage.10x10.co.kr/play/ground/20150511/img_label_02_02.jpg" alt="초원" /></label>
							</li>
							<li>
								<input type="radio" id="answer03B" name="rebntB" value="3"/>
								<label for="answer03B"><img src="http://webimage.10x10.co.kr/play/ground/20150511/img_label_02_03.jpg" alt="함께 식사하고 있는 사진" /></label>
							</li>
							<li class="nth-child4">
								<input type="radio" id="answer04B" name="rebntB" value="4"/>
								<label for="answer04B"><img src="http://webimage.10x10.co.kr/play/ground/20150511/img_label_02_04.jpg" alt="은은한 조명이 든 거실 사진" /></label>
							</li>
							<li>
								<input type="radio" id="answer05B" name="rebntB" value="5"/>
								<label for="answer05B"><img src="http://webimage.10x10.co.kr/play/ground/20150511/img_label_02_05.jpg" alt="한적한 바다" /></label>
							</li>
						</ul>
					</div>
					<button type="button" onclick="resultB(); return false;" class="btnnext"><img src="http://webimage.10x10.co.kr/play/ground/20150511/btn_next.png" alt="다음" /></button>
				</div>

				<!-- Q3 -->
				<div class="item itemC" style="display:none">
					<h3><span>3</span><img src="http://webimage.10x10.co.kr/play/ground/20150511/tit_question_03.png" alt="친구와의 약속 장소에 나왔지만, 10분 이상 전화를 받지 않는 친구. 어떻게 할까?" /></h3>
					<div class="typeA">
						<ul>
							<li>
								<input type="radio" id="answer01C" name="rebntC" value="1"/>
								<label for="answer01C"><img src="http://webimage.10x10.co.kr/play/ground/20150511/txt_label_03_01.png" alt="쿨하게 집으로 향한다." /></label>
							</li>
							<li>
								<input type="radio" id="answer02C" name="rebntC" value="2"/>
								<label for="answer02C"><img src="http://webimage.10x10.co.kr/play/ground/20150511/txt_label_03_02.png" alt="걱정하는 마음으로 계속해서 전화를 한다." /></label>
							</li>
							<li>
								<input type="radio" id="answer03C" name="rebntC" value="3"/>
								<label for="answer03C"><img src="http://webimage.10x10.co.kr/play/ground/20150511/txt_label_03_03.png" alt="집 주소를 알아내 집으로 찾아간다." /></label>
							</li>
							<li>
								<input type="radio" id="answer04C" name="rebntC" value="4"/>
								<label for="answer04C"><img src="http://webimage.10x10.co.kr/play/ground/20150511/txt_label_03_04.png" alt="문자 메시지를 남겨 놓고 기다린다." /></label>
							</li>
							<li>
								<input type="radio" id="answer05C" name="rebntC" value="5"/>
								<label for="answer05C"><img src="http://webimage.10x10.co.kr/play/ground/20150511/txt_label_03_05.png" alt="다른 친구에게 연락해 약속을 잡는다." /></label>
							</li>
						</ul>
					</div>
					<button type="button" onclick="resultC(); return false;" class="btnnext"><img src="http://webimage.10x10.co.kr/play/ground/20150511/btn_next.png" alt="다음" /></button>
				</div>

				<!-- Q4 -->
				<div class="item itemD" style="display:none">
					<h3><span>4</span><img src="http://webimage.10x10.co.kr/play/ground/20150511/tit_question_04.png" alt="다음 중 가장 마음에 드는 아이템은?" /></h3>
					<div class="typeB">
						<ul>
							<li>
								<input type="radio" id="answer01D" name="rebntD" value="1"/>
								<label for="answer01D"><img src="http://webimage.10x10.co.kr/play/ground/20150511/img_label_04_01.jpg" alt="하얀 수국 꽃잎 화관" /></label>
							</li>
							<li>
								<input type="radio" id="answer02D" name="rebntD" value="2"/>
								<label for="answer02D"><img src="http://webimage.10x10.co.kr/play/ground/20150511/img_label_04_02.jpg" alt="빨간 하이힐" /></label>
							</li>
							<li>
								<input type="radio" id="answer03D" name="rebntD" value="3"/>
								<label for="answer03D"><img src="http://webimage.10x10.co.kr/play/ground/20150511/img_label_04_03.jpg" alt="자몽빛 매니큐어" /></label>
							</li>
							<li class="nth-child4">
								<input type="radio" id="answer04D" name="rebntD" value="4"/>
								<label for="answer04D"><img src="http://webimage.10x10.co.kr/play/ground/20150511/img_label_04_04.jpg" alt="녹색 미니 선인장" /></label>
							</li>
							<li>
								<input type="radio" id="answer05D" name="rebntD" value="5"/>
								<label for="answer05D"><img src="http://webimage.10x10.co.kr/play/ground/20150511/img_label_04_05.jpg" alt="노란색 테이블" /></label>
							</li>
						</ul>
					</div>
					<button type="button" onclick="resultD(); return false;" class="btnnext"><img src="http://webimage.10x10.co.kr/play/ground/20150511/btn_next.png" alt="다음" /></button>
				</div>

				<!-- Q5 -->
				<div class="item itemE" style="display:none">
					<h3><span>5</span><img src="http://webimage.10x10.co.kr/play/ground/20150511/tit_question_05.png" alt="로또에 당첨된 당신. 당첨금을 어떻게 쓸 것인가?" /></h3>
					<div class="typeA">
						<ul>
							<li>
								<input type="radio" id="answer01E" name="rebntE" value="1"/>
								<label for="answer01E"><img src="http://webimage.10x10.co.kr/play/ground/20150511/txt_label_05_01.png" alt="감사했던 지인들에게 나누어 준다." /></label>
							</li>
							<li>
								<input type="radio" id="answer02E" name="rebntE" value="2"/>
								<label for="answer02E"><img src="http://webimage.10x10.co.kr/play/ground/20150511/txt_label_05_02.png" alt="아무에게도 이 사실을 알리지 않고, 비밀장소에 숨긴다." /></label>
							</li>
							<li>
								<input type="radio" id="answer03E" name="rebntE" value="3"/>
								<label for="answer03E"><img src="http://webimage.10x10.co.kr/play/ground/20150511/txt_label_05_03.png" alt="가족에게만 사실을 알리고 함께 계획을 세운다." /></label>
							</li>
							<li>
								<input type="radio" id="answer04E" name="rebntE" value="4"/>
								<label for="answer04E"><img src="http://webimage.10x10.co.kr/play/ground/20150511/txt_label_05_04.png" alt="세계 여행을 떠난다." /></label>
							</li>
							<li>
								<input type="radio" id="answer05E" name="rebntE" value="5"/>
								<label for="answer05E"><img src="http://webimage.10x10.co.kr/play/ground/20150511/txt_label_05_05.png" alt="어려운 이웃이나 도움이 필요한 기관에 기부한다." /></label>
							</li>
						</ul>
					</div>
					<button type="button" onclick="resultE(); return false;" class="btnnext"><img src="http://webimage.10x10.co.kr/play/ground/20150511/btn_next.png" alt="다음" /></button>
				</div>

				<!-- Q6 -->
				<div class="item itemF" style="display:none">
					<h3><span>6</span><img src="http://webimage.10x10.co.kr/play/ground/20150511/tit_question_06.png" alt="새로 이사한 집에 물건을 놓는다면 가장 먼저 어떤 것을 놓을 것인가?" /></h3>
					<div class="typeC">
						<div><img src="http://webimage.10x10.co.kr/play/ground/20150511/img_living_room.jpg" alt="" /></div>
						<ul>
							<li>
								<input type="radio" id="answer01F" name="rebntF" value="1"/>
								<label for="answer01F"><img src="http://webimage.10x10.co.kr/play/ground/20150511/txt_label_06_01.png" alt="큰 액자" /></label>
							</li>
							<li>
								<input type="radio" id="answer02F" name="rebntF" value="2"/>
								<label for="answer02F"><img src="http://webimage.10x10.co.kr/play/ground/20150511/txt_label_06_02.png" alt="싱글 침대" /></label>
							</li>
							<li>
								<input type="radio" id="answer03F" name="rebntF" value="3"/>
								<label for="answer03F"><img src="http://webimage.10x10.co.kr/play/ground/20150511/txt_label_06_03.png" alt="소파" /></label>
							</li>
							<li>
								<input type="radio" id="answer04F" name="rebntF" value="4"/>
								<label for="answer04F"><img src="http://webimage.10x10.co.kr/play/ground/20150511/txt_label_06_04.png" alt="공기청정기" /></label>
							</li>
							<li>
								<input type="radio" id="answer05F" name="rebntF" value="5"/>
								<label for="answer05F"><img src="http://webimage.10x10.co.kr/play/ground/20150511/txt_label_06_05.png" alt="스탠드 조명" /></label>
							</li>
						</ul>
					</div>
					<button type="button" onclick="resultF(); return false;" class="btnnext"><img src="http://webimage.10x10.co.kr/play/ground/20150511/btn_next.png" alt="다음" /></button>
				</div>

				<!-- Q7 -->
				<div class="item itemG" style="display:none">
					<h3><span>7</span><img src="http://webimage.10x10.co.kr/play/ground/20150511/tit_question_07.png" alt="나만의 핫플레이스를 꼽는다면 어느 장소일까?" /></h3>
					<div class="typeA">
						<ul>
							<li>
								<input type="radio" id="answer01G" name="rebntG" value="1"/>
								<label for="answer01G"><img src="http://webimage.10x10.co.kr/play/ground/20150511/txt_label_07_01.png" alt="사람들이 북적 이는 번화가" /></label>
							</li>
							<li>
								<input type="radio" id="answer02G" name="rebntG" value="2"/>
								<label for="answer02G"><img src="http://webimage.10x10.co.kr/play/ground/20150511/txt_label_07_02.png" alt="산 또는 바다 근처 펜션" /></label>
							</li>
							<li>
								<input type="radio" id="answer03G" name="rebntG" value="3"/>
								<label for="answer03G"><img src="http://webimage.10x10.co.kr/play/ground/20150511/txt_label_07_03.png" alt="외진 곳에 위치해 있는 작은 카페" /></label>
							</li>
							<li>
								<input type="radio" id="answer04G" name="rebntG" value="4"/>
								<label for="answer04G"><img src="http://webimage.10x10.co.kr/play/ground/20150511/txt_label_07_04.png" alt="나의 집 또는 방" /></label>
							</li>
							<li>
								<input type="radio" id="answer05G" name="rebntG" value="5"/>
								<label for="answer05G"><img src="http://webimage.10x10.co.kr/play/ground/20150511/txt_label_07_05.png" alt="음악과 젊음이 가득한 클럽" /></label>
							</li>
						</ul>
					</div>
					<button type="button" onclick="resultG(); return false;" class="btnnext"><img src="http://webimage.10x10.co.kr/play/ground/20150511/btn_next.png" alt="다음" /></button>
				</div>

				<!-- Q8 -->
				<div class="item itemH" style="display:none">
					<h3><span>8</span><img src="http://webimage.10x10.co.kr/play/ground/20150511/tit_question_08.png" alt="주스를 만든다고 했을 때, 재료로 쓸 과일은?" /></h3>
					<div class="typeB">
						<ul>
							<li>
								<input type="radio" id="answer01H" name="rebntH" value="1"/>
								<label for="answer01H"><img src="http://webimage.10x10.co.kr/play/ground/20150511/img_label_08_01.jpg" alt="복숭아" /></label>
							</li>
							<li>
								<input type="radio" id="answer02H" name="rebntH" value="2"/>
								<label for="answer02H"><img src="http://webimage.10x10.co.kr/play/ground/20150511/img_label_08_02.jpg" alt="딸기" /></label>
							</li>
							<li>
								<input type="radio" id="answer03H" name="rebntH" value="3"/>
								<label for="answer03H"><img src="http://webimage.10x10.co.kr/play/ground/20150511/img_label_08_03.jpg" alt="오렌지" /></label>
							</li>
							<li class="nth-child4">
								<input type="radio" id="answer04H" name="rebntH" value="4"/>
								<label for="answer04H"><img src="http://webimage.10x10.co.kr/play/ground/20150511/img_label_08_04.jpg" alt="키위" /></label>
							</li>
							<li>
								<input type="radio" id="answer05H" name="rebntH" value="5"/>
								<label for="answer05H"><img src="http://webimage.10x10.co.kr/play/ground/20150511/img_label_08_05.jpg" alt="자몽" /></label>
							</li>
						</ul>
					</div>
					<button type="button" onclick="resultH(); return false;" class="btnnext"><img src="http://webimage.10x10.co.kr/play/ground/20150511/btn_next.png" alt="다음" /></button>
				</div>

				<!-- Q9 -->
				<div class="item itemI" style="display:none">
					<h3><span>9</span><img src="http://webimage.10x10.co.kr/play/ground/20150511/tit_question_09.png" alt="꽃을 선물 받은 당신, 꽃을 둘 위치는?" /></h3>
					<div class="typeA">
						<ul>
							<li>
								<input type="radio" id="answer01I" name="rebntI" value="1"/>
								<label for="answer01I"><img src="http://webimage.10x10.co.kr/play/ground/20150511/txt_label_09_01.png" alt="창가" /></label>
							</li>
							<li>
								<input type="radio" id="answer02I" name="rebntI" value="2"/>
								<label for="answer02I"><img src="http://webimage.10x10.co.kr/play/ground/20150511/txt_label_09_02.png" alt="테이블 위" /></label>
							</li>
							<li>
								<input type="radio" id="answer03I" name="rebntI" value="3"/>
								<label for="answer03I"><img src="http://webimage.10x10.co.kr/play/ground/20150511/txt_label_09_03.png" alt="침실 협탁 위" /></label>
							</li>
							<li>
								<input type="radio" id="answer04I" name="rebntI" value="4"/>
								<label for="answer04I"><img src="http://webimage.10x10.co.kr/play/ground/20150511/txt_label_09_04.png" alt="화장실 세면대 옆" /></label>
							</li>
							<li>
								<input type="radio" id="answer05I" name="rebntI" value="5"/>
								<label for="answer05I"><img src="http://webimage.10x10.co.kr/play/ground/20150511/txt_label_09_05.png" alt="현관 선반 위" /></label>
							</li>
						</ul>
					</div>
					<button type="button" onclick="resultI(); return false;" class="btnnext"><img src="http://webimage.10x10.co.kr/play/ground/20150511/btn_next.png" alt="다음" /></button>
				</div>

				<!-- Q10 -->
				<div class="item itemJ" style="display:none">
					<h3><span>10</span><img src="http://webimage.10x10.co.kr/play/ground/20150511/tit_question_10.png" alt="다음 중 가장 좋아하는 꽃은?" /></h3>
					<div class="typeB">
						<ul>
							<li>
								<input type="radio" id="answer01J" name="rebntJ" value="1"/>
								<label for="answer01J"><img src="http://webimage.10x10.co.kr/play/ground/20150511/img_label_10_01.jpg" alt="릴리" /></label>
							</li>
							<li>
								<input type="radio" id="answer02J" name="rebntJ" value="2"/>
								<label for="answer02J"><img src="http://webimage.10x10.co.kr/play/ground/20150511/img_label_10_02.jpg" alt="장미" /></label>
							</li>
							<li>
								<input type="radio" id="answer03J" name="rebntJ" value="3"/>
								<label for="answer03J"><img src="http://webimage.10x10.co.kr/play/ground/20150511/img_label_10_03.jpg" alt="작약" /></label>
							</li>
							<li class="nth-child4">
								<input type="radio" id="answer04J" name="rebntJ" value="4"/>
								<label for="answer04J"><img src="http://webimage.10x10.co.kr/play/ground/20150511/img_label_10_04.jpg" alt="자스민" /></label>
							</li>
							<li>
								<input type="radio" id="answer05J" name="rebntJ" value="5"/>
								<label for="answer05J"><img src="http://webimage.10x10.co.kr/play/ground/20150511/img_label_10_05.jpg" alt="후리지아" /></label>
							</li>
						</ul>
					</div>
					<button type="button" onclick="resultJ(); return false;" class="btnresult"><img src="http://webimage.10x10.co.kr/play/ground/20150511/btn_result.png" alt="결과보기" /></button>
				</div>

				<div class="item itemK" style="display:none">
					<p>
						<img id="imgSrc" src="" alt="" />
					</p>
					<!--p><img src="http://webimage.10x10.co.kr/play/ground/20150511/txt_result_01.png" alt="당신의 향기 타입은 깨끗한 순백의 미소입니다. 겉은 화려하고 강한 성격처럼 보이지만 속은 여린 당신. 향기 역시 화려해 보이지만 맑고 깨끗한 향기가 잘 어울립니다. 순백의 하얀 드레스를 입은 신부의 수줍은 미소가 연상되는 우아하고 화려한 깨끗한 순백의 미소 향기. 이벤트 응모가 완료되었습니다! 행운이 있기를 바랍니다!" /></p>
					<p><img src="http://webimage.10x10.co.kr/play/ground/20150511/txt_result_02.png" alt="당신의 향기 타입은 매력적인 첫인상입니다. 자존심이 강하고 리더십이 있는 당신 강렬하면서 매력적인 첫인상을 지니고 있습니다. 향기 역시 첫 느낌부터 확연히 향을 느끼게 하지만 시간이 지날수록 은은하게 남아 지속적으로 느껴지는 향이 어울립니다. 이벤트 응모가 완료되었습니다! 행운이 있기를 바랍니다!" /></p>
					<p><img src="http://webimage.10x10.co.kr/play/ground/20150511/txt_result_03.png" alt="당신의 향기 타입은 상큼하고 달콤한 과일입니다. 모든 사람들과 잘 어울리고 통통 튀는 매력으로 주변 사람들을 기분 좋게 만드는 귀여운 당신 상큼하고 달콤한 과일 향이 여기 있습니다. 이벤트 응모가 완료되었습니다! 행운이 있기를 바랍니다!" /></p>
					<p><img src="http://webimage.10x10.co.kr/play/ground/20150511/txt_result_04.png" alt="당신의 향기 타입은 봄날의 따뜻한 햇살입니다. 자존심이 강하고 리더십이 있는 당신 강렬하면서 매력적인 첫인상을 지니고 있습니다. 향기 역시 첫 느낌부터 확연히 향을 느끼게 하지만 시간이 지날수록 은은하게 남아 지속적으로 느껴지는 향이 어울립니다. 이벤트 응모가 완료되었습니다! 행운이 있기를 바랍니다!" /></p>
					<p><img src="http://webimage.10x10.co.kr/play/ground/20150511/txt_result_05.png" alt="당신의 향기 타입은 살랑살랑 청순한 봄바람입니다. 자존심이 강하고 리더십이 있는 당신 강렬하면서 매력적인 첫인상을 지니고 있습니다. 향기 역시 첫 느낌부터 확연히 향을 느끼게 하지만 시간이 지날수록 은은하게 남아 지속적으로 느껴지는 향이 어울립니다. 이벤트 응모가 완료되었습니다! 행운이 있기를 바랍니다!" /></p-->
				</div>
			<% else %>
				<div class="item itemK">
					<p>
						<img src="http://webimage.10x10.co.kr/play/ground/20150511/txt_result_0<%= myscent %>.png" alt="" />
					</p>
					<!--p><img src="http://webimage.10x10.co.kr/play/ground/20150511/txt_result_01.png" alt="당신의 향기 타입은 깨끗한 순백의 미소입니다. 겉은 화려하고 강한 성격처럼 보이지만 속은 여린 당신. 향기 역시 화려해 보이지만 맑고 깨끗한 향기가 잘 어울립니다. 순백의 하얀 드레스를 입은 신부의 수줍은 미소가 연상되는 우아하고 화려한 깨끗한 순백의 미소 향기. 이벤트 응모가 완료되었습니다! 행운이 있기를 바랍니다!" /></p>
					<p><img src="http://webimage.10x10.co.kr/play/ground/20150511/txt_result_02.png" alt="당신의 향기 타입은 매력적인 첫인상입니다. 자존심이 강하고 리더십이 있는 당신 강렬하면서 매력적인 첫인상을 지니고 있습니다. 향기 역시 첫 느낌부터 확연히 향을 느끼게 하지만 시간이 지날수록 은은하게 남아 지속적으로 느껴지는 향이 어울립니다. 이벤트 응모가 완료되었습니다! 행운이 있기를 바랍니다!" /></p>
					<p><img src="http://webimage.10x10.co.kr/play/ground/20150511/txt_result_03.png" alt="당신의 향기 타입은 상큼하고 달콤한 과일입니다. 모든 사람들과 잘 어울리고 통통 튀는 매력으로 주변 사람들을 기분 좋게 만드는 귀여운 당신 상큼하고 달콤한 과일 향이 여기 있습니다. 이벤트 응모가 완료되었습니다! 행운이 있기를 바랍니다!" /></p>
					<p><img src="http://webimage.10x10.co.kr/play/ground/20150511/txt_result_04.png" alt="당신의 향기 타입은 봄날의 따뜻한 햇살입니다. 자존심이 강하고 리더십이 있는 당신 강렬하면서 매력적인 첫인상을 지니고 있습니다. 향기 역시 첫 느낌부터 확연히 향을 느끼게 하지만 시간이 지날수록 은은하게 남아 지속적으로 느껴지는 향이 어울립니다. 이벤트 응모가 완료되었습니다! 행운이 있기를 바랍니다!" /></p>
					<p><img src="http://webimage.10x10.co.kr/play/ground/20150511/txt_result_05.png" alt="당신의 향기 타입은 살랑살랑 청순한 봄바람입니다. 자존심이 강하고 리더십이 있는 당신 강렬하면서 매력적인 첫인상을 지니고 있습니다. 향기 역시 첫 느낌부터 확연히 향을 느끼게 하지만 시간이 지날수록 은은하게 남아 지속적으로 느껴지는 향이 어울립니다. 이벤트 응모가 완료되었습니다! 행운이 있기를 바랍니다!" /></p-->
				</div>
			<% end if %>
		<% else %>
				<div class="item itemL">
					<h3><span>1</span><img src="http://webimage.10x10.co.kr/play/ground/20150511/tit_question_01.png" alt="연인에게 메시지를 남기려는 당신, 당신의 선택은?" /></h3>
					<div class="typeA">
						<ul>
							<li>
								<input type="radio" id="answer01A" name="rebntA" value="1"/>
								<label for="answer01A"><img src="http://webimage.10x10.co.kr/play/ground/20150511/txt_label_01_01.png" alt="작은 카드" /></label>
							</li>
							<li>
								<input type="radio" id="answer02A" name="rebntA" value="2"/>
								<label for="answer02A"><img src="http://webimage.10x10.co.kr/play/ground/20150511/txt_label_01_02.png" alt="포스트 잇" /></label>
							</li>
							<li>
								<input type="radio" id="answer03A" name="rebntA" value="3"/>
								<label for="answer03A"><img src="http://webimage.10x10.co.kr/play/ground/20150511/txt_label_01_03.png" alt="깔끔한 느낌의 유선 편지지" /></label>
							</li>
							<li>
								<input type="radio" id="answer04A" name="rebntA" value="4"/>
								<label for="answer04A"><img src="http://webimage.10x10.co.kr/play/ground/20150511/txt_label_01_04.png" alt="파스텔 톤의 색지로 만들어진 편지지" /></label>
							</li>
							<li>
								<input type="radio" id="answer05A" name="rebntA" value="5"/>
								<label for="answer05A"><img src="http://webimage.10x10.co.kr/play/ground/20150511/txt_label_01_05.png" alt="아기자기한 일러스트 편지지" /></label>
							</li>
						</ul>
					</div>
					<button type="button" onclick="resultA(); return false;" class="btnnext"><img src="http://webimage.10x10.co.kr/play/ground/20150511/btn_next.png" alt="다음" /></button>
				</div>
			<% end if %>
			</div>
			</form>
		</div>
	</div>
	<!-- //for dev msg : 심리테스트 -->

	<!-- for dev msg : 참여자 카운트 -->
	<div class="count">
		<p><img src="http://webimage.10x10.co.kr/play/ground/20150511/txt_count_01.png" alt="총" />
		<strong id="entercnt" class="animated flash"><%= totalcnt %></strong>
		<img src="http://webimage.10x10.co.kr/play/ground/20150511/txt_count_02.png" alt="명이 향기를 찾았습니다!" /></p>
	</div>

	<div class="rollingwrap">
		<div class="rolling">
			<div class="swipemask mask-left"></div>
			<div class="swipemask mask-right"></div>
			<button type="button" class="btn-nav arrow-left">Previous</button>
			<button type="button" class="btn-nav arrow-right">Next</button>
			<div class="swiper">
				<div class="swiper-container swiper1">
					<div class="swiper-wrapper" style="height:840px;">
						<div class="swiper-slide"><img src="http://webimage.10x10.co.kr/play/ground/20150511/img_slide_01.jpg" alt="" /></div>
						<div class="swiper-slide"><img src="http://webimage.10x10.co.kr/play/ground/20150511/img_slide_02.jpg" alt="" /></div>
						<div class="swiper-slide"><img src="http://webimage.10x10.co.kr/play/ground/20150511/img_slide_03.jpg" alt="" /></div>
						<div class="swiper-slide"><img src="http://webimage.10x10.co.kr/play/ground/20150511/img_slide_04.jpg" alt="" /></div>
					</div>
				</div>
			</div>
			<div class="pagination pagination1"></div>
		</div>
	</div>

	<div class="brandstory">
		<div class="inner">
			<p><a href="/street/street_brand_sub06.asp?makerid=bloomstudio" target="_top" title="Bloom 브랜드 바로가기"><img src="http://webimage.10x10.co.kr/play/ground/20150511/txt_brand_story.jpg" alt="Bloom은 가장 좋은 방향제는 싱그러운 꽃을 한아름 방안에 가져다 놓는 것이며, 자연의 향기만큼 좋은 향기는 없다고 생각합니다. Bloom은 기존에 양산화된 제품에서는 느낄 수 없는 소소하고 정성을 가득 담은 자연 그대로의 자연스러움을 추구합니다. Bloom의 디퓨저는 프랑스 그라스 지방의 굴지의 향료회사의 기술력으로 탄생한 디퓨저 베이스로 제작됩니다. 이 베이스는 곡물을 발효시켜 만든 마실 수 있는 원료인 발효주정(소주와 같은 원료)을 사용하여 제작되며, 코스메틱 향료 등급 중에서도 가장 높은 등급인 fine fragrance 등급으로 제작되었습니다. 또한 높은 강도로 압축된 고농축 향료 인만큼 마지막 한 방울까지 강한 발향력을 지니고 있습니다." /></a></p>
		</div>
	</div>
</div>
<!-- //iframe -->
<script type="text/javascript" src="/lib/js/swiper-2.1.min.js"></script>
<script type="text/javascript">
$(function(){
	/* label select */
	$(".item label").click(function(){
		labelID = $(this).attr("for");
		$('#'+labelID).trigger("click");
	});

	/* swipe */
	var swiper1 = new Swiper('.swiper1',{
	centeredSlides:true,
	slidesPerView:4,
	//initialSlide:0,
	loop: true,
	speed:2000,
	autoplay:6000,
	simulateTouch:false,
	pagination: '.pagination1',
	paginationClickable: true
	})
	$('.arrow-left').on('click', function(e){
		e.preventDefault()
		swiper1.swipePrev()
	})
	$('.arrow-right').on('click', function(e){
		e.preventDefault()
		swiper1.swipeNext()
	});

	$(window.parent).scroll(function(){
		var scrollTop = $(window.parent).scrollTop();
		if (scrollTop > 90 ) {
			animation1();
		}
		if (scrollTop > 1400 ) {
			animation2();
		}
		if (scrollTop > 2800 ) {
			animation3();
		}
	});

	$(".topic .hgroup h1 span").css({"opacity":"0"});
	$(".topic .hgroup h1 .letter1").css({"margin-top":"20px"});
	$(".topic .hgroup h1 .letter4").css({"top":"7px"});
	$(".topic .hgroup h1 .linebox").css({"height":"0"});
	function animation1 () {
		$(".topic .hgroup h1 .linebox").delay(100).animate({"opacity":"1", "height":"300px"},1000);
		$(".topic .hgroup h1 .letter2").delay(1000).animate({"opacity":"1"},500);
		$(".topic .hgroup h1 .letter3").delay(1500).animate({"opacity":"1"},500);
		$(".topic .hgroup h1 .letter1").delay(2000).animate({"opacity":"1", "margin-top":"0"},800);
		$(".topic .hgroup h1 .letter4").delay(2500).animate({"opacity":"1", "top":"-2px"},800);
	}

	$(".package h2").css({"opacity":"0", "left":"0"});
	$(".package .in ul li").css({"opacity":"0"});
	function animation2 () {
		$(".package h2").delay(300).animate({"opacity":"1", "left":"35px"},1500);
		$(".package .in ul li.goods1").delay(1800).animate({"opacity":"1"},500);
		$(".package .in ul li.goods4").delay(2300).animate({"opacity":"1"},500);
		$(".package .in ul li.goods3").delay(3000).animate({"opacity":"1"},500);
		$(".package .in ul li.goods2").delay(3800).animate({"opacity":"1"},500);
	}

	$(".psychologicalTest .hgroup h2").css({"opacity":"0", "width":"300px"});
	$(".psychologicalTest .hgroup p").css({"opacity":"0", "margin-top":"25px"});
	function animation3 () {
		$(".psychologicalTest .hgroup h2").delay(1000).animate({"opacity":"1", "width":"625px"},2000);
		$(".psychologicalTest .hgroup p").delay(100).animate({"opacity":"1", "margin-top":"35px"},500);
	}
});
</script>
</body>
</html>
<!-- #include virtual="/lib/db/dbclose.asp" -->