<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
	'// 페이지 정보
	strPageTitle = "텐바이텐 10X10 : 이벤트 COLLECTION"		'페이지 타이틀 (필수)
	strPageImage = "https://fiximage.10x10.co.kr/page/title/pageImage_service_v1.jpg"
	strPageDesc = "텐바이텐 이벤트를 한눈에..."
	'// 오픈그래프 메타태그
	strHeaderAddMetaTag = "<meta property=""og:title"" content=""[텐바이텐] 현재 진행중인 이벤트"" />" & vbCrLf &_
						"<meta property=""og:type"" content=""website"" />" & vbCrLf &_
						"<meta property=""og:url"" content=""https://www.10x10.co.kr/shoppingtoday/shoppingchance_allevent.asp"" />" & vbCrLf &_
						"<meta property=""og:description"" content=""" & strPageDesc & """>" & vbCrLf
%>
<!-- #include virtual="/lib/util/tenSessionLib.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/inc/head.asp" -->
<!-- #include virtual="/lib/util/pageformlib.asp" -->
<!-- #include virtual="/lib/util/DBcacheLib.asp" -->
<!-- #include virtual="/lib/classes/item/CategoryCls.asp" -->
<!-- #include virtual="/lib/classes/enjoy/shoppingchanceCls_B.asp" -->
<!-- #include virtual="/lib/chkDevice.asp" -->
<%
	Dim scType, sCategory, sCateMid
	Dim cShopchance
	Dim iTotCnt, arrList,intLoop
	Dim iPageSize, iCurrpage ,iDelCnt
	Dim iStartPage, iEndPage, iTotalPage, ix,iPerCnt, k
	Dim atype,cdl,cdm , selOp

	atype = RequestCheckVar(request("atype"),1)
	selOp = RequestCheckVar(Request("selOP"),1) '정렬
	'파라미터값 받기 & 기본 변수 값 세팅
	scType 		= requestCheckVar(Request("scT"),4) '쇼핑찬스 분류
	sCategory 	= getNumeric(requestCheckVar(Request("disp"),3)) '카테고리 대분류
	iCurrpage 	= getNumeric(requestCheckVar(Request("iC"),10))	'현재 페이지 번호

	if atype="" then atype="b"

	If scType ="end" then
		selOp = "1"
	ElseIf selOp = "" Then
		selOp = "0"
	End if
%>
<script type="text/javascript" src="/lib/js/infinitegrid.gridlayout.min.js"></script>
<script type="text/javascript">
var isloading = true;
var pageEl;
$(document).ready(function() {
	var $grid = $("#grid");
		pageEl = $("#iC");
		
	var ig = new eg.InfiniteGrid("#grid", {
		isConstantSize: true,
		transitionDuration: 0.5,
		useRecycle : true,
		useFit : true,
		isEqualSize : false,
		threshold : 10,
	}).on({
		"append" : function(e) {
			var gk = pageEl.val();
			gk++;
			pageEl.val(gk);
			ig.append(getList(),gk);
		},
		"layoutComplete" : function(e) {
			$grid.css("visibility", "visible");
		}
	});

	ig.setLayout(eg.InfiniteGrid.GridLayout, {align: "center", margin: 20});
	ig.append(getList(),1);

	$(window).scroll(function() {
		var st=$(this).scrollTop();
        var wh=window.innerHeight;
        $('.label-black').each(function(){
            if(st>$(this).offset().top-wh&& $(this).offset().top+$(this).innerHeight()>st){
                $(this).addClass('on')
            }else{
                $(this).removeClass('on')
            }
        })
	});
});

function getList() {
	var str = "";
	 	str = $.ajax({
			type: "GET",
			url: "/shoppingtoday/shoppingchance_allevent_act.asp",
			data: $("#frmSC").serialize(),
			dataType: "text/html",
			async: false
		}).responseText;

	return str;
}

function jsGoUrl(scT){
	self.location.href = "/shoppingtoday/shoppingchance_allevent.asp?scT="+scT+"&disp=<%=sCategory%>&selOP=<%=selOP%>";
}

function jsGoPage(iP){
	document.frmSC.iC.value = iP;
	document.frmSC.submit();
}

function jsSelOp(selOP){ //이벤트정렬
	self.location.href = "/shoppingtoday/shoppingchance_allevent.asp?selOP="+selOP+"&scT=<%=scType%>&disp=<%=sCategory%>";
}
</script>
</head>
<body>
<div id="enjoyEventV15" class="enjoyEventV19 wrap">
	<!-- #include virtual="/lib/inc/incHeader.asp" -->
	<div class="container skinV19">
		<div id="contentWrap">
			<div class="hotHgroupV19">
				<div class="tab-area">
					<ul>
						<li class="on"><a href="/shoppingtoday/shoppingchance_allevent.asp">기획전</a></li>
						<li><a href="/shoppingtoday/couponshop.asp">쿠폰북</a></li>
						<li><a href="/shoppingtoday/shoppingchance_mailzine.asp">메일진</a></li>
					</ul>
				</div>
				<h2>COLLECTION</h2>
				<div class="grpSubWrapV19">
					<ul>
						<li <%=CHKIIF(scType="","class='on'","")%>><a href="javascript:jsGoUrl('');">전체 기획전</a></li>
						<li <%=CHKIIF(scType="ten","class='on'","")%>><a href="javascript:jsGoUrl('ten');">단독 기획전</a></li>
						<li <%=CHKIIF(scType="sale","class='on'","")%>><a href="javascript:jsGoUrl('sale');">할인 기획전</a></li>
						<li <%=CHKIIF(scType="gift","class='on'","")%>><a href="javascript:jsGoUrl('gift');">사은 기획전</a></li>
						<li <%=CHKIIF(scType="ips","class='on'","")%>><a href="javascript:jsGoUrl('ips');">참여 기획전</a></li>
						<li <%=CHKIIF(scType="test","class='on'","")%>><a href="javascript:jsGoUrl('test');">테스터후기</a></li>
						<li <%=CHKIIF(scType="end","class='on'","")%>><a href="javascript:jsGoUrl('end');">마감임박</a></li>
					</ul>
				</div>
			</div>
			<div class="snb-bar">
				<div class="snbbar-inner">
					<div class="btn-ctgr"><span><%=fnSelectCategoryName(sCategory)%></span></div>
					<div class="sortingV19">
						<div class="select-boxV19">
							<dl>
								<dt class=""><span><%=fnSelectEventSortingName(selOp)%></span></dt>
								<dd style="display: none;">
									<ul>
										<li onclick="jsSelOp('0');">최근이벤트순</li>
										<li onclick="jsSelOp('1');">마감임박순</li>
										<li onclick="jsSelOp('2');">판매순</li>
										<li onclick="jsSelOp('3');">할인율순</li>
									</ul>
								</dd>
							</dl>
						</div>
					</div>
				</div>
				<div class="lnbHotV19">
					<div class="inner">
						<ul>
							<li class="<%= chkIIF(sCategory="","on","") %>"><a href="?atype=<%=atype%>">전체 카테고리</a></li>
							<%=fnAwardBestCategoryLI(sCategory,"/shoppingtoday/shoppingchance_allevent.asp?atype="& atype &"&selOP="& selOP&"&scT="& scType &"&")%>
						</ul>
					</div>
				</div>
			</div>
			<div class="evtcollection">
				<div class="unit-area">
					<ul id="grid" style="visibility:hidden"></ul>
				</div>
				
				<form name="frmSC" id="frmSC" method="get" action="shoppingchance_allevent.asp" style="margin:0px;">
				<input type="hidden" name="iC" id="iC" value="1">
				<input type="hidden" name="scT" value="<%=scType%>">
				<input type="hidden" name="disp" value="<%=sCategory%>">
				<input type="hidden" name="cdm" value="">
				<input type="hidden" name="selOP" value="<%=selOP%>">
				</form>
			</div>
		</div>
	</div>
	<!-- #include virtual="/lib/inc/incFooter.asp" -->
</div>
</body>
</html>
<!-- #include virtual="/lib/db/dbclose.asp" -->