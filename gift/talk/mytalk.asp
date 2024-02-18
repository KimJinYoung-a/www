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
'###########################################################
%>
<!-- #include virtual="/login/checklogin.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
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
	        url: "/gift/talk/mytalk_act.asp",
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
	$(".sidebar .badge a").unbind("mouseover");
	$(".sidebar .badge a").mouseover(function(){
		$(this).next().show();
	});
	$(".sidebar .badge").unbind("mouseleave");
	$(".sidebar .badge").mouseleave(function(){
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
	        url: "/gift/talk/mytalk_comment_act.asp",
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
			parent.location.href = "<%=SSLUrl%>/login/login.asp?backpath=/gift/talk/mytalk.asp";
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
			parent.location.href = "<%=SSLUrl%>/login/login.asp?backpath=/gift/talk/mytalk.asp";
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
				location.href = "/gift/talk/mytalk.asp";
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
			<div class="head">
				<!-- #include virtual="/gift/inc_gift_menu.asp" -->
			</div>

			<div class="navgift">
				<div class="hgroup mytalk">
					<h3><img src="http://fiximage.10x10.co.kr/web2013/gift/tit_my_talk.png" alt="MY TALK" /></h3>
					<p><span></span><em><%= getloginuserid() %></em>님은 <strong><em><%= getgifttalk_my_count(getloginuserid()) %></em>개의 GIFT TALK을 작성</strong>하셨습니다.</p>
				</div>
				<ul class="aside">
					<% '<!-- for dev msg : 현재 보고 있는 페이지에 a에 클래스 on 붙여주세요 --> %>
					<li><a href="/gift/talk/mytalk.asp" class="on">MY TALK</a></li>
					<li><a href="" onclick="goWriteTalk(); return false;">TALK 쓰기</a></li>
				</ul>
			</div>
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