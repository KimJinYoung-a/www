<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.charset = "UTF-8" %>
<%
'####################################################
' Description : 다이어리 스토리2016 스페셜 MAIN
' History : 2015.10. 12 유태욱 생성
'####################################################
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/inc/head.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/diarystory2016/lib/worker_only_view.asp" -->
<!-- #include virtual="/diarystory2016/lib/classes/diary_class_B.asp" -->
<!-- #include virtual="/lib/util/pageformlib.asp" -->
<!-- #include virtual="/lib/classes/search/searchcls.asp" -->
<!-- #include virtual="/lib/util/DBcacheLib.asp" -->
<%
	Dim cPopular, vDisp, vCurrPage, i, j
	vDisp = RequestCheckVar(Request("disp"),18)
	vCurrPage = RequestCheckVar(Request("cpg"),5)
	
	If vCurrPage = "" Then vCurrPage = 1
	
%>
<script type="text/javascript" src="/lib/js/jquery.masonry.min.js"></script>
<link rel="stylesheet" type="text/css" href="/lib/css/diary2016.css" />
<script type="text/javascript">
var isloading=true;
$(function(){
	//첫페이지 접수
	getList();

	//스크롤 이벤트 시작
	$(window).scroll(function() {
      if ($(window).scrollTop() >= $(document).height() - $(window).height() - 350){
          if (isloading==false){
            isloading=true;
			var pg = $("#specialdiaryfrm input[name='cpg']").val();
			pg++;
			$("#specialdiaryfrm input[name='cpg']").val(pg);
            setTimeout("getList()",500);
          }
      }
    });
});

function getList() {
	var str = $.ajax({
			type: "GET",
	        url: "special_act.asp",
	        data: $("#specialdiaryfrm").serialize(),
	        dataType: "text",
	        async: false
	}).responseText;

	if(str!="") {
    	if($("#specialdiaryfrm input[name='cpg']").val()=="1") {
        	//내용 넣기
        	$('#lySearchResult').html(str);

			//마조니 활성
//			$(".wishList").masonry({
//				itemSelector: ".box"
//				,isAnimatedFromBottom: true
//			});
			$(".specialList").masonry({
				itemSelector: ".item"
				,isAnimatedFromBottom: true
			});
        } else {
        	//추가 내용 Import!
       		//$('#lySearchResult .box').last().after(str);
       		$str = $(str)
       		// 마조니 내용 추가
       		$('.specialList').append($str).masonry('appended',$str);

        }
        isloading=false;
    } else {
    	//더이상 자료가 없다면 스크롤 이벤트 종료
    	$(window).unbind("scroll");
    }

	// 상품정보 표시 액션
	$(".specialList .item .pic").mouseover(function(){
		$(this).find(".txtImg").fadeIn(150);
	});
	$(".specialList .item .pic").mouseleave(function(){
		$(this).find(".txtImg").fadeOut(150);
	});
}

</script>
</head>
<body>
<div class="wrap">
	<!-- #include virtual="/lib/inc/incHeader.asp" -->
	<div class="container diarystory2016">
		<div id="contentWrap">
			<!-- #include virtual="/diarystory2016/inc/head.asp" -->
			<div class="diaryContent diarySpecial">
				<div class="title">
					<h3><img src="http://fiximage.10x10.co.kr/web2015/diarystory2016/tit_special.gif" alt="10X10 SPECIAL EDITION" /></h3>
					<p><img src="http://fiximage.10x10.co.kr/web2015/diarystory2016/txt_special_edition.gif" alt="2016년, 잘 준비하고 있나요? 지나가는 날짜에 불과할지도 모르지만 당신의 하루는 돌아가고 싶은 시간들로 가득한 날이길 바래요. 시간을 거슬러 가고 싶을 만큼 소중한 순간들을 그냥 지나치지 말아요. 기록으로 평생 기억될 이야기를 특별한 곳에 담아주세요.그 특별함을 위해 텐바이텐에서만 만날 수 있는 2016 다이어리를 소개합니다." /></p>
				</div>

				<form id="specialdiaryfrm" name="specialdiaryfrm" method="get" style="margin:0px;">
				<input type="hidden" name="cpg" value="1" />
				<input type="hidden" name="disp" value="<%=vDisp%>" />
				</form>

				<div class="specialList" id="lySearchResult"></div>

				<div class="noData" id="popspecialnodata" style="display:none;">
					<p><strong><!--스페셜 다이어리가 더 이상 없습니다.--></strong></p>
				</div>
			</div>
		</div>
	</div>
	<!-- #include virtual="/lib/inc/incFooter.asp" -->
</div>
</body>
</html>
<!-- #include virtual="/lib/db/dbclose.asp" -->