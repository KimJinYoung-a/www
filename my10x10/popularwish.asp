<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include virtual="/lib/util/tenSessionLib.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/lib/classes/item/iteminfoCls.asp" -->
<!-- #include virtual="/lib/classes/item/CategoryCls.asp" -->
<!-- #include virtual="/lib/classes/membercls/sp_myfavoritecls.asp" -->
<% strPageTitle = "텐바이텐 10X10 : POPULAR WISH" %>
<!-- #include virtual="/lib/chkDevice.asp" -->
<!-- #include virtual="/lib/inc/head.asp" -->
<%
	Dim cPopular, vDisp, vSort, vCurrPage, i, j, vArrEval
	vDisp = RequestCheckVar(Request("disp"),18)
	vSort = NullFillWith(RequestCheckVar(Request("sort"),1),"3")
	vCurrPage = RequestCheckVar(Request("cpg"),5)
	
	If vCurrPage = "" Then vCurrPage = 1
	
%>
<script type="text/javascript" src="/lib/js/jquery.masonry.min.js"></script>
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
			var pg = $("#popularfrm input[name='cpg']").val();
			pg++;
			$("#popularfrm input[name='cpg']").val(pg);
            setTimeout("getList()",500);
          }
      }
    });
});

function getList() {
	var str = $.ajax({
			type: "GET",
	        url: "popularwish_act.asp",
	        data: $("#popularfrm").serialize(),
	        dataType: "text",
	        async: false
	}).responseText;

	if(str!="") {
    	if($("#popularfrm input[name='cpg']").val()=="1") {
        	//내용 넣기
        	$('#lySearchResult').html(str);

			//마조니 활성
			$(".wishList").masonry({
				itemSelector: ".box"
				,isAnimatedFromBottom: true
			});
        } else {
        	//추가 내용 Import!
       		//$('#lySearchResult .box').last().after(str);
       		$str = $(str)
       		// 마조니 내용 추가
       		$('.wishList').append($str).masonry('appended',$str);

        }
        isloading=false;
    } else {
    	//더이상 자료가 없다면 스크롤 이벤트 종료
    	$(window).unbind("scroll");
    }

	// 상품정보 표시 액션
	$(".wishList .info").unbind("mouseover").unbind("mouseleave");
	$(".wishList .info .account").hide();
	$(".wishList .info").mouseover(function () {
		$(".wishList .info .account").hide();
		$(this).children(".account").show();
	});

	$(".wishList .info").mouseleave(function () {
		$(".wishList .info .account").hide();
	});
}

function goPopularWish(d,s){
	$('input[name="cpg"]').val("1");
	$('input[name="disp"]').val(d);
	$('input[name="sort"]').val(s);
	popularfrm.submit();
}
</script>
</head>
<body>
<div class="wrap">
	<!-- #include virtual="/lib/inc/incHeader.asp" -->
	<div class="container">
		<div id="contentWrap">
			<div class="shopHeader wishHeader">
				<h2><img src="http://fiximage.10x10.co.kr/web2013/wish/tit_popular_wish.png" class="pngFix" alt="POPULAR WISH" /></h2>
				<p><img src="http://fiximage.10x10.co.kr/web2013/wish/txt_popular_wish.gif" alt="바로 지금! 다른 사람들의 위시를 실시간으로 만나보세요!" /></p>
				<div class="btn"><a href="/my10x10/mywishlist.asp"><img src="http://fiximage.10x10.co.kr/web2013/wish/btn_my_wish.png" class="pngFix" alt="MY WISH" /></a></div>
			</div>
			<form id="popularfrm" name="popularfrm" method="get" style="margin:0px;">
			<input type="hidden" name="cpg" value="1" />
			<input type="hidden" name="disp" value="<%=vDisp%>" />
			<input type="hidden" name="sort" value="<%=vSort%>" />
			</form>
			<div class="shopGroup">
				<!-- content  -->
				<div class="wishWrap">
					<div class="sorting">
						<ul class="sortingTerms">
							<li><a href="javascript:goPopularWish('<%=vDisp%>','3');" <%=CHKIIF(vSort="3","class='on'","")%>>급상승위시</a></li>
							<li><a href="javascript:goPopularWish('<%=vDisp%>','1');" <%=CHKIIF(vSort="1","class='on'","")%>>최근위시</a></li>
							<li><a href="javascript:goPopularWish('<%=vDisp%>','2');" <%=CHKIIF(vSort="2","class='on'","")%>>신상품위시</a></li>
							<li><a href="javascript:goPopularWish('<%=vDisp%>','4');" <%=CHKIIF(vSort="4","class='on'","")%>>상품후기 많은순</a></li>
							<!--li><a href="javascript:goPopularWish('<%=vDisp%>','5');" <%=CHKIIF(vSort="5","class='on'","")%>>댓글낮은순</a></li-->
						</ul>

						<select title="카테고리 선택 옵션" class="optSelect2" onChange="goPopularWish(this.value,'<%=vSort%>')">
							<%=CategorySelectBoxOption(vDisp)%>
						</select>
					</div>
					<div class="wishList" id="lySearchResult"></div>
					<div class="noData" id="popwishnodata" style="display:none;">
						<p><strong>실시간으로 등록된 <span>WISH</span>가 더 이상 없습니다.</strong></p>
						<a href="/award/awardlist.asp?atype=f&disp=" class="btnView"><img src="http://fiximage.10x10.co.kr/web2013/wish/btn_view_best_wish.gif" alt="BEST WISH 보러가기" /></a>
					</div>
				</div>
				<!-- //content  -->
			</div>
		</div>
	</div>
	<!-- #include virtual="/lib/inc/incFooter.asp" -->
</div>
</body>
</html>
<!-- #include virtual="/lib/db/dbclose.asp" -->