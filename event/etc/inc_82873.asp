<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/util/pageformlib.asp" -->
<!-- #include virtual="/lib/classes/enjoy/eventApplyCls.asp" -->
<!-- #include virtual="/event/lib/event_etc_function.asp" -->
<!-- #include virtual="/event/etc/instagrameventCls.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<%
'####################################################
' Description : [SNS] #파티에서 가장 반짝이는 당신!
' History : 2017-12-08 정태훈
'####################################################
Dim eCode, userid, pagereload, i
dim iCCurrpage, iCTotCnt, eCC, iCPageSize, iCTotalPage
IF application("Svr_Info") = "Dev" THEN
	eCode   =  67488
Else
	eCode   =  82873
End If

iCCurrpage = requestCheckVar(Request("iCC"),10)	'현재 페이지 번호
	
IF iCCurrpage = "" THEN iCCurrpage = 1
IF iCTotCnt = "" THEN iCTotCnt = -1

eCC = requestCheckVar(Request("eCC"), 1)
pagereload	= requestCheckVar(request("pagereload"),2)
userid		= GetEncLoginUserID()

iCPageSize = 8		'한 페이지의 보여지는 열의 수

dim oinstagramevent
set oinstagramevent = new Cinstagrameventlist
	oinstagramevent.FPageSize	= iCPageSize
	oinstagramevent.FCurrPage	= iCCurrpage
	oinstagramevent.FTotalCount		= iCTotCnt  '전체 레코드 수
	oinstagramevent.FrectIsusing = "Y"
	oinstagramevent.FrectEcode = eCode
	oinstagramevent.fnGetinstagrameventList

	iCTotCnt = oinstagramevent.FTotalCount '리스트 총 갯수
	iCTotalPage 	=  Int(iCTotCnt/iCPageSize)	'전체 페이지 수
	IF (iCTotCnt MOD iCPageSize) > 0 THEN	iCTotalPage = iCTotalPage + 1

%>
<style type="text/css">
.bon-appetit {background-color:#fff;}
.bon-appetit .topic {height:459px; background:#f8e3aa url(http://webimage.10x10.co.kr/eventIMG/2017/82873/bg_topic_v1.jpg) 50% 0 no-repeat;}
.bon-appetit .topic h2 {padding-top:171px;}
.jewellery-item {height:1116px; background:#fff url(http://webimage.10x10.co.kr/eventIMG/2017/82873/bg_jewellery_item.jpg) 50% 0 no-repeat;}
.jewellery-item h3 {padding-top:75px;}
.jewellery-item .item {margin-top:49px;}
.bon-appetit .gift {position:relative; height:636px; padding-top:71px; background:#e4bb57 url(http://webimage.10x10.co.kr/eventIMG/2017/82873/bg_gift.jpg) 50% 0 no-repeat;}
.bon-appetit .ribon {position:absolute; top:413px; right:0;}
.instagram {position:relative; padding:75px 0 65px;}
.btn-instagram {position:absolute; top:138px; left:50%; margin-left:370px;}
.instagram ul {overflow:hidden; width:1168px; margin:0 auto; padding-top:60px;}
.instagram li {overflow:hidden; float:left; width:262px; margin:15px;}
.instagram li img {width:262px; height:262px; background-color:#ddd;}
.instagram .id {overflow:hidden; display:block; height:20px; margin-top:10px; padding:0 10px; color:#767676; font-weight:bold;}
.instagram .id span {color:#ef9800;}

.pageWrapV15 {margin-top:50px;}
.pageWrapV15 .pageMove {display:none;}
.paging a {width:29px; height:29px; margin:0; border:0;}
.paging a span {height:34px; padding:0; color:#898888; font-family:Dotum, '돋움', Verdana; font-size:12px; line-height:29px;}
.paging a:hover, .paging a.arrow, .paging a, .paging a.current, .paging a.current:hover {border:0; background-color:transparent;}
.paging .first, .paging .end {display:none;}
.paging a.arrow span {background:none;}
.paging a.current span {color:#ff9600;}
.paging .prev, 
.paging .next {background:url(http://webimage.10x10.co.kr/eventIMG/2017/82873/btn_pagination_nav.png) 0 0 no-repeat;}
.paging .next {margin-left:9px; background-position:100% 0;}
.paging .prev {margin-right:5px;}

.noti {background-color:#f0f0f0;}
.noti .inner {position:relative; width:820px; margin:0 auto;}
.noti h3 {position:absolute; left:0; top:50%; margin-top:-14px;}
.noti ul {padding:50px 0 45px 180px;}
.noti li {line-height:19px; padding:0 0 4px 15px; color:#505050; text-align:left;}
</style>
<script type="text/javascript">
$(function(){
	<% if Request("eCC")<>"" then %>
		window.$('html,body').animate({scrollTop:$("#instagramlist").offset().top}, 0);
//		setTimeout("pagedown()",100);
	<% end if %>
});

$(function(){
	/* slide js */
	$("#slide").slidesjs({
		width:"1140",
		height:"870",
		pagination:{effect:"fade"},
		navigation:{effect:"fade"},
		play:{interval:3500, effect:"fade", auto:true},
		effect:{fade: {speed:1000}}
	});
});

//function pagedown(){
//	window.$('html,body').animate({scrollTop:$("#instagramlist").offset().top}, 0);
//}

function jsGoComPage(iP){
	document.frmcom.iCC.value = iP;
	document.frmcom.iCTot.value = "<%=iCTotCnt%>";
	document.frmcom.submit();
}
</script>
						<div class="evt82873 bon-appetit">
							<div class="topic">
								<h2><img src="http://webimage.10x10.co.kr/eventIMG/2017/82873/tit_you.png" alt="파티에서 가장 반짝이는 당신! 당신의 파티룩 완성을 위한 선물을 드립니다." /></h2>
							</div>

							<div class="jewellery-item">
								<h3><img src="http://webimage.10x10.co.kr/eventIMG/2017/82873/tit_jewellery.png" alt="빛나는 파티를 완성시켜줄 주얼리" /></h3>
								<div class="item">
									<img src="http://webimage.10x10.co.kr/eventIMG/2017/82873/img_jewellery_item_v1.jpg" alt="" usemap="#itemlink" />
									<map name="itemlink" id="itemlink">
										<area shape="rect" coords="2,2,303,438" href="/shopping/category_prd.asp?itemid=1851141&pEtr=82873" alt="반짝이는 나를 위한 gold pearl drop" />
										<area shape="rect" coords="325,2,633,437" href="/shopping/category_prd.asp?itemid=1851140&pEtr=82873" alt="자개와 진주의 아름다운 조화 shell flower" />
										<area shape="rect" coords="655,2,956,437" href="/shopping/category_prd.asp?itemid=1851131&pEtr=82873" alt="독특한 원석으로 더욱 빛나게 green stone drop" />
										<area shape="rect" coords="3,468,305,905" href="/shopping/category_prd.asp?itemid=1851124&pEtr=82873" alt="모두를 주목시키는 blue pearl" />
										<area shape="rect" coords="321,469,637,907" href="/shopping/category_prd.asp?itemid=1851110&pEtr=82873" alt="연말엔 더욱 과감하게 twinkle onyx" />
										<area shape="rect" coords="653,469,957,903" href="/shopping/category_prd.asp?itemid=1851032&pEtr=82873" alt="은은하게 빛나는 silver shell" />
									</map>
								</div>
							</div>

							<div class="gift">
								<p><img src="http://webimage.10x10.co.kr/eventIMG/2017/82873/txt_gift.png" alt="당신을 위한 GIFT 본아베띠 주얼리를 인스타그램에 자랑해주세요! 추첨을 통해 당신의 패션을 완성해줄 패션 아이템을 드립니다. LEATHER SATCHEL Small Pixie 5명, BREDA 브레다 정품시계 5명" /></p>
								<p style="margin-top:47px;"><img src="http://webimage.10x10.co.kr/eventIMG/2017/82873/txt_event.png" alt="이벤트 참여 방법 본아베띠 쥬얼리 구매하기, 본아베띠 쥬얼리 사진찍기, 필수 해시태그 포함하여 인스타그램에 업로드하기 필수 해시태그 #본아베띠 #쥬얼리 #귀걸이 #파티룩 #선물" /></p>
								<div class="ribon"><img src="http://webimage.10x10.co.kr/eventIMG/2017/82873/img_ribon.png" alt="" /></div>
							</div>

							<!-- instagram -->
							<div class="instagram">
								<h3><img src="http://webimage.10x10.co.kr/eventIMG/2017/82873/tit_bon_appetit.png" alt="텐바이텐에 도착한 #본아베띠" /></h3>
								<div class="btn-instagram"><a href="https://www.instagram.com/your10x10/" target="_blank"><img src="http://webimage.10x10.co.kr/eventIMG/2017/82873/btn_instgram.gif" alt="텐바이텐 공식 인스타그램 바로가기" /></a></div>
								<% if oinstagramevent.fresultcount > 0 then %>
								<ul>
									<% for i = 0 to oinstagramevent.fresultcount-1 %>
									<li>
										<img src="<%= oinstagramevent.FItemList(i).Fimgurl %>" width="262" height="262" alt="" />
										<!-- for dev msg : 아이디 ** 처리해주세요  -->
										<span class="id"><span><%=printUserId(left(oinstagramevent.FItemList(i).Fuserid,10),2,"*")%></span>님의 본아베띠</span>
									</li>
									<% next %>
								</ul>
								<% end if %>
								<!-- pagination -->
								<div class="pageWrapV15">
									<%= fnDisplayPaging_New(iCCurrpage,iCTotCnt,iCPageSize,10,"jsGoComPage") %>
								</div>
							</div>
							<form name="frmcom" method="post" onSubmit="return false;" style="margin:0px;">
							<input type="hidden" name="iCC" value="<%=iCCurrpage%>"/>
							<input type="hidden" name="iCTot" value=""/>
							<input type="hidden" name="eCC" value="1">
							</form>
							<div class="noti">
								<div class="inner">
									<h3><img src="http://webimage.10x10.co.kr/eventIMG/2017/82873/tit_noti.png" alt="이벤트 유의사항" /></h3>
									<ul>
										<li>- 인스타그램 계정이 비공개 일 경우 이벤트 참여에 제외됩니다.</li>
										<li>- 이벤트에 참여한 인증샷은 고객 동의 없이 이벤트 페이지 내에 노출될 수 있습니다.</li>
										<li>- 이벤트 페이지 내에 노출되는 SNS인증샷은 실시간 적용되지 않습니다.</li>
										<li>- SNS 이벤트에 참여하였더라도 이벤트 페이지 내에 노출되지 않을 수 있습니다.</li>
										<li>- 이벤트 페이지 내에 SNS인증샷 노출여부는 이벤트 당첨 여부와 무관합니다.</li>
										<li>- 이벤트 일정 및 당첨 상품 등은 당사 사정에 따라 부득이하게 변경 될 수 있습니다.</li>
										<li>- 제세공과금은 텐바이텐 부담이며, 세무신고를 위해 개인정보를 취합한 뒤에 경품이 증정됩니다.</li>
									</ul>
								</div>
							</div>
						</div>
<!-- #include virtual="/lib/db/dbclose.asp" -->