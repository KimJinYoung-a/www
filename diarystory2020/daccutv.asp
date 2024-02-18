<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'####################################################
' Description : 다이어리 스토리 2020 다꾸티비 - 리스트
' History : 2019-08-21 이종화 생성
'####################################################
%>
<!-- #include virtual="/lib/util/tenSessionLib.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/lib/chkDevice.asp" -->
<!-- #include virtual="/diarystory2020/lib/worker_only_view.asp" -->
<!-- #include virtual="/lib/classes/media/mediaCls.asp" -->
<!-- #include virtual="/lib/util/DBcacheLib.asp" -->
<!-- #include virtual="/lib/inc/head.asp" -->
<%
'============== 모바일 접근시 모바일 페이지 이동(referer가 10x10이면 이동안함) ============
    if InStr(request.ServerVariables("HTTP_REFERER"),"10x10.co.kr")<1 then
        if Not(Request("mfg")="pc" or session("mfg")="pc") then
            if Not(flgDevice="W" or flgDevice="D" or flgDevice="T") then
                Response.Redirect "http://m.10x10.co.kr/diarystory2020/daccutv.asp"
                REsponse.End
            end if
        end if
    end if
    
	dim oMedia , arrSwipeList , i
	dim vServiceCode : vServiceCode = 3 '다이어리스토리
	dim vChannel : vChannel = 1 '1 pc 2 mobile
%>
<link rel="stylesheet" type="text/css" href="/lib/css/platform.css?v=1.25">
<script type="text/javascript">
var isloading=true;
$(function(){
	// amplitude 
	fnAmplitudeEventMultiPropertiesAction('view_diary_daccutv','','');
	// tab
	$(".plf-tab li").click(function(e){
		e.preventDefault();
		$(this).addClass("on").siblings("li").removeClass("on");
	});

	// video-list
	getList();

	//스크롤 이벤트 시작
	$(window).scroll(function() {
		if ($(window).scrollTop() >= $(document).height() - $(window).height() - 350){
			if (isloading==false){
				isloading=true;
				var pg = $("#listfrm input[name='cpg']").val();
				pg++;
				$("#listfrm input[name='cpg']").val(pg);
				getList();
			}
		}
	});
});

function getList() {
	var str = $.ajax({
			type: "GET",
			url: "/diarystory2020/lib/daccutv_ajaxDataList.asp",
			data: $("#listfrm").serialize(),
			dataType: "text",
			async: false
	}).responseText;

	if(str!="") {
		($("#listfrm input[name='cpg']").val()=="1") ? $('#vodLists').empty().html(str) : $('#vodLists').append(str);
		isloading=false;
	}

	if(str == "") {
		$("#etcEvents").show();
	}
}

function sortChange(num) {
	var frm = document.listfrm;
	if (num == 1) {
		frm.cpg.value = 1;
		frm.sortMet.value = 1;
	} else {
		frm.cpg.value = 1;
		frm.sortMet.value = 2;
	}

	$("#etcEvents").hide();
	getList();
}

function linkUrl(url, contentsidx, eventid) {
	if (contentsidx != null) {
		location.href = "/diarystory2020/daccutv_detail.asp?cidx="+contentsidx;
	} else if (eventid != null) {
		location.href = "/event/eventmain.asp?eventid="+eventid;
	} else {
		location.href = url;
	}
}
</script>
</head>
<body>
<div class="wrap">
	<!-- #include virtual="/lib/inc/incHeader.asp" -->
	<% if InStr(request.ServerVariables("HTTP_REFERER"),"/diarystory2021/") > 0 or date() >= "2020-09-07" then %>
	<div class="container diary2021">
	<% else %>
	<div class="container diary2020">
	<% end if %>
		<div id="contentWrap" class="diary-tv diary-tv-main">
			<% if InStr(request.ServerVariables("HTTP_REFERER"),"/diarystory2021/") > 0 or date() >= "2020-09-07" then %>
            <!-- #include virtual="/diarystory2021/inc/header.asp" -->
			<% else %>
			<!-- #include virtual="/diarystory2020/inc/head.asp" -->
			<% end if %>
			<div class="diary-content">
				<div class="sub-header">
                    <div class="inner">
                        <h3>보기만 해도 다꾸 만렙이 되는 다꾸 TV</h3>
                        <ul class="tab-menu">
                            <li class="on"><a href="" onclick="sortChange(1);return false;">신규순</a></li>
							<li><a href="" onclick="sortChange(2);return false;">인기순</a></li>
                        </ul>
                    </div>
                </div>
				<div class="inner">
					<div class="vod-list">
						<ul id="vodLists"></ul>
					</div>
					<%'!-- 박수 30번 축하 레이어 -- %>
					<div class="ly-clap">
						<div class="ly-clap-inner">
							<div class="dots dots1"></div>
							<div class="dots dots2"></div>
							<div class="dots dots3"></div>
							<div class="dots dots4"></div>
							<div class="dots dots5"></div>
							<div class="dots dots6"></div>
							<div class="dots dots7"></div>
							<div class="dots dots8"></div>
							<div class="hand"></div>
							<div class="heart"><i></i></div>
						</div>
						<div class="mask"></div>
					</div>
				</div>
				<%'!-- 관련기획전 --%>
				<div id="etcEvents" style="display:none;">
				<!-- #include virtual="/diarystory2020/inc/inc_etcevent.asp" -->
				</div>
				<%'!--// 관련기획전 --%>
			</div>
		</div>
	</div>
	<!-- #include virtual="/lib/inc/incFooter.asp" -->
</div>
<form id="listfrm" name="listfrm" method="get" style="margin:0px;">
	<input type="hidden" name="cpg" value="1" />				
	<input type="hidden" name="sortMet" value="1" />
</form>
</body>
</html>
<!-- #include virtual="/lib/db/dbclose.asp" -->