<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.charset = "utf-8" %>
<%
	Response.AddHeader "Cache-Control","no-cache"
	Response.AddHeader "Expires","0"
	Response.AddHeader "Pragma","no-cache"
%>
<%
'###########################################################
' Description :  기프트
' History : 2015.02.09 한용민 생성
'			2020.10.14 정태훈 19th 선물의참견 이벤트 수정
'###########################################################
%>
<!-- #include virtual="/lib/util/tenSessionLib.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/chkDevice.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/util/functions.asp" -->
<!-- #include virtual="/lib/classes/gift/giftCls.asp" -->
<!-- #include virtual="/gift/lib/giftFunction.asp" -->
<!-- #include virtual="/gift/Underconstruction_gift.asp" -->

<%
dim vCurrPage, vSort, vTalkIdx
	vCurrPage = requestCheckVar(Request("cpg"),5)
	vSort = requestCheckVar(Request("sort"),1)

If vCurrPage = "" Then vCurrPage = 1

If isNumeric(vCurrPage) = False Then
	Response.Write "<script>alert('잘못된 경로입니다.'); location.href='/';</script>"
	dbget.close()
	Response.End
End If

	'19th 마일리지 이벤트 추가 
	dim currentDate, userid
	currentDate =  now()
	userid = GetLoginUserID()
	if userid="ley330" or userid="greenteenz" or userid="rnldusgpfla" or userid="cjw0515" or userid="thensi7" or userid = "motions" or userid = "jj999a" or userid = "phsman1" or userid = "jjia94" or userid = "seojb1983" or userid = "kny9480" or userid = "bestksy0527" or userid = "mame234" or userid = "corpse2" or userid = "starsun726" or userid = "bora2116" then
		currentDate = #10/12/2020 09:00:00#
	end if
%>

<!-- #include virtual="/lib/inc/head.asp" -->
<link rel="stylesheet" type="text/css" href="/lib/css/preVst/section.css" />
<link rel="stylesheet" type="text/css" href="/lib/css/sectionV15.css" />
<script type="text/javascript" src="/lib/js/jquery.masonry.min.js"></script>
<script type='text/javascript'>

<!-- #include virtual="/gift/talk/inc_Javascript.asp" -->

var isloading=true;
$(function(){
	//첫페이지 로딩
	getList();

	//스크롤 이벤트 시작
	$(window).unbind("scroll");
	$(window).scroll(function() {
      if ($(window).scrollTop() >= $(document).height() - $(window).height() - 350){
          if (isloading==false){
            isloading=true;
			var pg = $("#mygiftfrm input[name='cpg']").val();
			pg++;
			$("#mygiftfrm input[name='cpg']").val(pg);
            setTimeout("getList()",500);
          }
      }
    });
});

//톡리스트 아작스 호출
function getList() {
	var str = $.ajax({
			type: "GET",
	        url: "/gift/talk/index_act.asp",
	        data: $("#mygiftfrm").serialize(),
	        dataType: "text",
	        async: false
	}).responseText;

	if(str!="") {
    	if($("#mygiftfrm input[name='cpg']").val()=="1") {
        	$('#giftArticle').html(str);

			$("#giftArticle").masonry({
				itemSelector: ".article",
				columnWidth:1
			});
        } else {
       		//$('#giftArticle .article').last().after(str);
       		$str = $(str)
       		$('#giftArticle').append($str).masonry('appended',$str);

			//$("#giftArticle").masonry({
			//	itemSelector: ".article",
			//	columnWidth:1
			//});
        }
        isloading=false;
    } else {
    	$(window).unbind("scroll");
    }

	/* angel badge */
	$("#angel").hide();
	$(".navgift .badge a").mouseover(function(){
		$(this).addClass("on");
		$(this).next().show();
	});
	$(".navgift .badge").mouseleave(function(){
		$(".navgift .badge a").removeClass("on");
		$("#angel").hide();
	});

	/* comment write */
	$("#giftArticle .cmtwrite").hide();

	/* comment list */
	$("#giftArticle .commentlist").hide();
}

//코맨트작성 슬라이드 열고 닫기
function dispcomment(talkidx,onoffgubun){
	if (onoffgubun=='1'){
		$("#cmtwrite"+talkidx).slideDown();
	}else{
		$("#cmtwrite"+talkidx).slideUp();
	}
}

//코맨트리스트 슬라이드 열고 닫기
function dispcommentlist(talkidx,onoffgubun){
	if (onoffgubun=='1'){
		$("#comment"+talkidx).slideDown();
	}else{
		$("#comment"+talkidx).slideUp();
	}
}

//코맨트리스트 아작스 호출
function getcommentlist_act(page,talkidx){
	$("#mygiftcommentfrm input[name='talkidx']").val(talkidx);

	var pg = $("#mygiftcommentfrm input[name='cpg']").val();
	var vreload = $("#mygiftcommentfrm input[name='reload']").val();
	if (vreload!=''){
		pg++;
		$("#mygiftcommentfrm input[name='reload']").val('ON');
	}else{
		pg=1;
		$("#mygiftcommentfrm input[name='reload']").val('ON');
	}

	$("#mygiftcommentfrm input[name='cpg']").val(page);

	//코맨트 보기 눌렀을때만 코맨트 가져다가 뿌림
	var str = $.ajax({
			type: "GET",
	        url: "/gift/talk/index_comment_act.asp",
	        data: $("#mygiftcommentfrm").serialize(),
	        dataType: "text",
	        async: false
	}).responseText;

	$('#comment'+talkidx).html(str);
	$('#comment'+talkidx).slideDown();
	return false;	
}

//코맨트작성
function talkcommentreg(talkidx){
	<%IF not(IsUserLoginOK) THEN%>
		if(confirm("로그인을 하셔야 글을 남길 수 있습니다.\n로그인 하시겠습니까?") == true) {
			parent.location.href = "<%=SSLUrl%>/login/login.asp?backpath=/gift/talk/index.asp";
			return true;
		} else {
			return false;
		}
	<% end if %>
	var contents = $("#contents"+talkidx).val();
	//현재코맨트수
	var commentcnt = parseInt($("#commentcnt"+talkidx).attr("commentcnt"));

	if(contents == "" || contents == "100자 이내로 입력해주세요."){
		alert("기프트톡에 대한 의견을 작성하세요.");
		$("#contents"+talkidx).val('');
		$("#contents"+talkidx).focus();
		return;
	}
	if (GetByteLength(contents) > 200){
		alert("코맨트가 없거나 제한길이를 초과하였습니다. 100자 이내로 입력해주세요.");
		$("#contents"+talkidx).focus();
		return;
	}		

	var str = $.ajax({
		type: "POST",
        url: "/gift/talk/iframe_talk_comment_proc.asp",
        data: "gubun=i&talkidx="+talkidx+"&contents="+contents,
        dataType: "text",
        async: false
	}).responseText;

	if (str.length=='2'){
		if (str=='i1'){
			//글 저장후 슬라이드 내리고
			$("#cmtwrite"+talkidx).slideUp();
			$("#mygiftcommentfrm input[name='reload']").val('');
			$("#contents"+talkidx).val('');
			
			//코맨트 리스트 아작스 재호출
			getcommentlist_act('1',talkidx);
			
			//코맨트 영역 변경
			var tmpcomment = "<a href='' onclick='getcommentlist_act(1,"+talkidx +"); return false;' talkidx='"+ talkidx +"' class='total'><strong>"+ parseInt(parseInt(commentcnt)+parseInt(1)) +"</strong>개의 코멘트</a><a href='' onclick='dispcomment("+ talkidx +",1); return false;' class='btnwrite'>쓰기</a>"
			$("#commentcnt"+talkidx).html(tmpcomment);

            // 선물의 참견 댓글 작성 앰플리튜드 연동
            fnAmplitudeEventMultiPropertiesAction('view_gifttalk', 'click_gifttalk_comment', 'Y');

			return;
		}else if (str=='99'){
			alert('로그인을 해주세요.');
			return;
		}else if (str=='i2'){
			alert('하나의 기프트톡엔 의견을 5개까지 남길 수 있습니다.');
			return;
		}else if (str=='i3'){
			alert('내용에 유효하지 않은 글자가 포함되어 있습니다. 다시 작성 해주세요.');
			return;
		}
	}else{
		alert('정상적인 경로가 아닙니다.');
		return;
	}
}

//코맨트 삭제
function DelComments(talkidx,cmtidx){
	<% IF not(IsUserLoginOK) THEN %>
		if(confirm("로그인을 하셔야 삭제할 수 있습니다.\n로그인 하시겠습니까?") == true) {
			parent.location.href = "<%=SSLUrl%>/login/login.asp?backpath=/gift/talk/index.asp";
			return true;
		} else {
			return false;
		}
	<% end if %>
	
	if(confirm("선택한 글을 삭제하시겠습니까?") == true) {
		var str = $.ajax({
			type: "GET",
	        url: "/gift/talk/iframe_talk_comment_proc.asp",
	        data: "gubun=d&idx="+cmtidx+"&talkidx="+talkidx,
	        dataType: "text",
	        async: false
		}).responseText;
	
		if (str.length=='2'){
			if (str=='d1'){
				location.href = "/gift/talk/index.asp";
				return;			
			}else if (str=='99'){
				alert('로그인을 해주세요.');
				return;
			}
		}else{
			alert('정상적인 경로가 아닙니다.');
			return;
		}
	} else {
		return false;
	}
}

function jsCheckLimit(talkidx) {
	if ("<%=IsUserLoginOK%>"=="False") {
		jsChklogin('<%=IsUserLoginOK%>');
	}

	var contents = $("#contents"+talkidx).val();
	if (contents=='100자 이내로 입력해주세요.'){
		$("#contents"+talkidx).val('');
	}
}

</script>
</head>
<body>
<div id="giftWrapV15" class="wrap">
	<!-- #include virtual="/lib/inc/incHeader.asp" -->
	<div class="container giftSection">
		<div id="contentWrap">
			<% If (currentDate >= "2020-10-12" And currentDate < "2020-10-30") Then %>
			<style>
			.giftTopic19th {position:relative;}
			.giftTopic19th .top-section {height:530px; background:#ffd544 url(//webimage.10x10.co.kr/fixevent/event/2020/19th/gifttalk/bg_top.png?v=3.00) repeat-x 0 0;}
			.giftTopic19th .top-section.wide {height:954px; background-image:url(//webimage.10x10.co.kr/fixevent/event/2020/19th/gifttalk/bg_top02.png?v=3.00);}
			.giftTopic19th .top-section .tit-area {padding:31px 0 10px; text-align:center;}
			.giftTopic19th .top-section .tit-area h2 {position:relative; display:inline-block;}
			.giftTopic19th .top-section .tit-area h2 .star-01 {position:absolute; left:89px; top:-13px; animation:star 1.5s 1s ease-in-out infinite;}
			.giftTopic19th .top-section .tit-area h2 .star-02 {position:absolute; right:100px; top:120px; animation:star 2s ease-in-out infinite;}
			.giftTopic19th .top-section .info-area {width:750px; padding:0 81px 31px; margin:0 auto; text-align:center; border-radius:48px;}
			.giftTopic19th .top-section .info-area .txt-01 {padding:15px 0 0; font-size:22px; color:#615429;}
			.giftTopic19th .top-section .info-area .txt-01 span {font-weight:bold;}
			.giftTopic19th .top-section .info-area .btn-view {position:relative; width:147px; height:35px; margin-top:15px; font-size:18px; color:#fff; background:#ffba00; border-radius:48px;}
			.giftTopic19th .top-section .info-area .btn-view .icon-arrow {display:inline-block; width:12px; height:7px; margin:10px 0 0 11px; vertical-align:top; background:url(//webimage.10x10.co.kr/fixevent/event/2020/19th/gifttalk/icon_arrow_down.png?v=2.00) no-repeat 0 0; transition:0.4s ease-in-out;}
			.giftTopic19th .top-section .info-area .btn-view.reverse .icon-arrow {transform:rotate(180deg);}
			.giftTopic19th .top-section .info-area .hidden-txt {display:none; margin-top:23px; padding-left:67px; text-align:left;}
			.giftTopic19th .top-section .info-area .hidden-txt.show {display:block;}
			.giftTopic19th .top-section .btn-area {padding-top:36px; text-align:center;}
			.giftTopic19th .top-section .btn-area a {font-size:20px; color:#8e6e00; letter-spacing:-0.15px;}
			.giftTopic19th .top-section .btn-area .link-area {padding-top:10px;}
			.giftTopic19th .top-section .btn-area .link-area a {position:relative;}
			.giftTopic19th .top-section .btn-area .link-area a:hover {text-decoration:none;}
			.giftTopic19th .top-section .btn-area .link-area a:nth-child(1) {margin-right:10px;}
			.giftTopic19th .top-section .btn-area .link-area a:nth-child(2) {margin-left:10px;}
			@keyframes star {
				0%,100% {opacity:1;}
				50% {opacity:0;}
			}
			.popup {position:fixed; left:0; top:0; width:100vw; height:100vh; background:rgba(255, 255, 255, 0.949); z-index:150;}
			.popup .inner {position:relative; width:670px; height:415px; position:absolute; left:50%; top:50%; transform:translate(-50%, -50%);}
			.popup .inner .link {position:absolute; left:240px; top:260px;}
			.popup .btn-close {width:32px; height:32px; position:absolute; right:32px; top:32px; text-indent:-9999px; background:url(//webimage.10x10.co.kr/fixevent/event/2020/19th/gifttalk/icon_close.png?v=2.00) no-repeat 0 0;}
			</style>
			<script>
			$(function() {
				$(".giftTopic19th .btn-view").on('click',function() {
					$(".hidden-txt").toggleClass("show")
					$(".top-section").toggleClass("wide");
					$(".btn-view").toggleClass("reverse");
					if($(".btn-view").hasClass("reverse")) {
						$(".btn-view span").text("닫기");
					} else {
						$(".btn-view span").text("자세히 보기");
					}
				});
				$(".giftTopic19th .btn-close").on("click",function() {
					$(".popup").css("display","none");
				});
				$(".giftTopic19th .popup").on("click", function(e) {
					if ($(e.target).hasClass("popup")) $(e.target).fadeOut();
				});
			});
			</script>
			<div class="giftTopic19th">
				<div class="top-section">
					<div class="tit-area">
						<h2>
							<img src="//webimage.10x10.co.kr/fixevent/event/2020/19th/gifttalk/img_tit_txt.png?v=2.00" alt="선물의 참견">
							<span class="star-01"><img src="//webimage.10x10.co.kr/fixevent/event/2020/19th/gifttalk/img_star01.png" alt="icon star"></span>
							<span class="star-02"><img src="//webimage.10x10.co.kr/fixevent/event/2020/19th/gifttalk/img_star02.png" alt="icon star"></span>
						</h2>
					</div>
					<div class="info-area">
						<p><img src="//webimage.10x10.co.kr/fixevent/event/2020/19th/gifttalk/img_txt_sub01.png?v=2.00" alt="깜짝 이벤트"></p>
						<p class="txt-01">지금 다른 사람들의 고민을 도와주면 <span>최대 3,000p</span>를 드리고 있어요</p>
						<button type="button" class="btn-view"><span>자세히 보기</span><i class="icon-arrow"></i></button>
						<div class="hidden-txt">
							<img src="//webimage.10x10.co.kr/fixevent/event/2020/19th/gifttalk/img_txt_sub03.png?v=2.00" alt="이벤트 내용">
						</div>
					</div>
					<div class="btn-area">
						<p><img src="//webimage.10x10.co.kr/fixevent/event/2020/19th/gifttalk/img_txt_sub02.png?v=2.00" alt="선물 준비할 때"></p>
						<div class="link-area">
							<!-- 임시제거 20201020 <a href="/shoppingtoday/gift_recommend.asp"><img src="//webimage.10x10.co.kr/fixevent/event/2020/19th/gifttalk/btn_link01.png" alt="선물 포장 서비스"></a>/-->
							<a href="/giftcard/index.asp"><img src="//webimage.10x10.co.kr/fixevent/event/2020/19th/gifttalk/btn_link02.png" alt="텐텐 기프트카드"></a>
						</div>
					</div>
				</div>
				<!-- for dev msg : 3개 참여시 팝업 -->
				<div class="popup" id="sucessPop" style="display:none">
					<div class="inner">
						<img src="//webimage.10x10.co.kr/fixevent/event/2020/19th/gifttalk/img_pop_tit.png" alt="완료">
						<a href="/my10x10/mymileage.asp" class="link"><img src="//webimage.10x10.co.kr/fixevent/event/2020/19th/gifttalk/img_txt_pop.png" alt="마일리지 확인하기"></a>
						<button type="button" class="btn-close">닫기</button>
					</div>
				</div>
			</div>
			<% else %>
			<div class="head">
				<!-- #include virtual="/gift/inc_gift_menu.asp" -->
			</div>
			<% end if %>
			<h3 class="hidden">TALK 어떤 선물이 좋을까?</h3>
			<div class="navgift">
				<div id="badge" class="badge">
					<a href="#angel"><em>톡! 앤젤 뱃지</em>를 받으려면?</a>
					<p id="angel"><em>GIFT TALK 코멘트를<br /> 3회 이상</em> 작성하시면<br /> <strong>톡! 엔젤 뱃지</strong>를 드려요 :)</p>
				</div>
				<ul class="aside">
					<% '<!-- for dev msg : 현재 보고 있는 페이지에 a에 클래스 on 붙여주세요 --> %>
					<li><a href="/gift/talk/mytalk.asp">MY TALK</a></li>
					<li><a href="" onclick="goWriteTalk(); return false;">TALK 쓰기</a></li>
				</ul>
			</div>
			<!-- gift talk list -->
			<div id="giftArticle" class="giftArticle"></div>
			<p id="nodata" style="display:none;" class="nodata"><span></span>해당되는 GIFT TALK이 없습니다.</p>
			<p id="nodata_act" style="display:none;" class="nodata"><span></span>해당되는 GIFT TALK이 없습니다.</p>
			<form id="mygiftfrm" name="mygiftfrm" method="get" style="margin:0px;">
				<input type="hidden" name="cpg" value="1" />
				<input type="hidden" name="sort" value="<%=vSort%>" />
				<input type="hidden" name="beforepageminidx" />
			</form>
			<form id="mygiftcommentfrm" name="mygiftcommentfrm" method="get" style="margin:0px;">
				<input type="hidden" name="cpg" value="1" />
				<input type="hidden" name="talkidx" />
				<input type="hidden" name="reload" />
			</form>
			<form name="frm1" action="/gift/talk/mytalk_proc.asp" method="post" style="margin:0px;">
				<input type="hidden" name="gubun" id="gubun" value="">
				<input type="hidden" name="userid" id="userid" value="<%=GetLoginUserID()%>">
				<input type="hidden" name="talkidx" id="talkidx" value="">
				<input type="hidden" name="mydell" value="m">
			</form>
			<iframe src="about:blank" name="iframeproc" frameborder="0" width="0" height="0"></iframe>

		</div>
	</div>
	<!-- #include virtual="/lib/inc/incFooter.asp" -->
</div>
</body>
</html>

<!-- #include virtual="/lib/db/dbclose.asp" -->