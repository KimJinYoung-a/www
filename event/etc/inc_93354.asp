<%@ codepage="65001" language="VBScript" %>
<% Option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #INCLUDE Virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/inc_const.asp" -->
<!-- #INCLUDE Virtual="/lib/chkDevice.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/event/lib/event_etc_function.asp" -->
<!-- #include virtual="/lib/classes/drawevent/DrawEventCls.asp" -->
<%
'####################################################
' Description :  100원의기적 게이트페이지
' History : 2019-03-26 
'####################################################
dim SqlStr
dim prd1, prd2, prd3, prd4, prd5, prd6, prd7, prd8, prd9, prd10

sqlStr = " select      (SELECT 1 - count(1) as pdt1 FROM [db_event].[dbo].[tbl_event_subscript] WHERE EVT_CODE = 93355 and sub_opt1 = '1' and sub_opt3 = 'draw' and sub_opt2 in (2290327)) as '맥북에어' "
sqlStr = sqlStr & "	 , (SELECT 2 - count(1) as pdt1 FROM [db_event].[dbo].[tbl_event_subscript] WHERE EVT_CODE = 93355 and sub_opt1 = '1' and sub_opt3 = 'draw' and sub_opt2 in (2292048,2292964)) as '아이패드' "
sqlStr = sqlStr & "	 , (SELECT 1 - count(1) as pdt1 FROM [db_event].[dbo].[tbl_event_subscript] WHERE EVT_CODE = 93355 and sub_opt1 = '1' and sub_opt3 = 'draw' and sub_opt2 in (2292057)) as '아이폰' "
sqlStr = sqlStr & "	 , (SELECT 1 - count(1) as pdt1 FROM [db_event].[dbo].[tbl_event_subscript] WHERE EVT_CODE = 93355 and sub_opt1 = '1' and sub_opt3 = 'draw' and sub_opt2 in (2292077)) as '애플워치' "
sqlStr = sqlStr & "	 , (SELECT 1 - count(1) as pdt1 FROM [db_event].[dbo].[tbl_event_subscript] WHERE EVT_CODE = 93355 and sub_opt1 = '1' and sub_opt3 = 'draw' and sub_opt2 in (2292085)) as '다이슨 청소기' "
sqlStr = sqlStr & "	 , (SELECT 1 - count(1) as pdt1 FROM [db_event].[dbo].[tbl_event_subscript] WHERE EVT_CODE = 93355 and sub_opt1 = '1' and sub_opt3 = 'draw' and sub_opt2 in (2292103)) as '마샬 스피커' "
sqlStr = sqlStr & "	 , (SELECT 1 - count(1) as pdt1 FROM [db_event].[dbo].[tbl_event_subscript] WHERE EVT_CODE = 93355 and sub_opt1 = '1' and sub_opt3 = 'draw' and sub_opt2 in (2292160)) as '발뮤다 공기청정기' "
sqlStr = sqlStr & "	 , (SELECT 1 - count(1) as pdt1 FROM [db_event].[dbo].[tbl_event_subscript] WHERE EVT_CODE = 93355 and sub_opt1 = '1' and sub_opt3 = 'draw' and sub_opt2 in (2292200)) as '다이슨 드라이기' "
sqlStr = sqlStr & "	 , (SELECT 5 - count(1) as pdt1 FROM [db_event].[dbo].[tbl_event_subscript] WHERE EVT_CODE = 93355 and sub_opt1 = '1' and sub_opt3 = 'draw' and sub_opt2 in (2292207,2292988,2293045,2293047,2293053)) as '브리츠 스피커' "
sqlStr = sqlStr & "	 , (SELECT 3 - count(1) as pdt1 FROM [db_event].[dbo].[tbl_event_subscript] WHERE EVT_CODE = 93355 and sub_opt1 = '1' and sub_opt3 = 'draw' and sub_opt2 in (2293059,2293060,2292208)) as '코닥 카메라' 		"

rsget.Open sqlstr, dbget, 1
	prd1 = rsget("맥북에어")
	prd2 = rsget("아이패드")
	prd3 = rsget("아이폰")
	prd4 = rsget("애플워치")
	prd5 = rsget("다이슨 청소기")
	prd6 = rsget("마샬 스피커")
	prd7 = rsget("발뮤다 공기청정기")
	prd8 = rsget("다이슨 드라이기")
	prd9 = rsget("브리츠 스피커")
	prd10 = rsget("코닥 카메라")
rsget.close				
%> 
<style type="text/css">
.hundred {position:relative; text-align:center;}
.hundred .inner {position:relative; height:1040px; background:#5541e0 url(//webimage.10x10.co.kr/fixevent/event/2019/salabal/hundred/bg_hundred.jpg) 50% 0 no-repeat;}
.hundred .topic {position:absolute; top:64px; left:50%; width:1140px; margin-left:-570px;}
.hundred .topic .only-app img {-webkit-animation:flash 1s both; animation:flash 1s both;}
@-webkit-keyframes flash { from, 50%, to {opacity:1;} 25%, 75% {opacity:0;} }
@keyframes flash { from, 50%, to {opacity:1;} 25%, 75% {opacity:0;} }
.hundred .topic h2 {margin-top:20px;}
.hundred .btn-schedule {position:absolute; top:304px; right:50%; margin-right:-272px; padding:0; background:transparent; outline:0; border:0; -webkit-animation:bounce 1.5s infinite; animation:bounce 1.5s infinite; -webkit-border-radius:50%; border-radius:50%; -webkit-box-shadow:0 34px 40px rgba(0,0,0,.15); box-shadow:0 34px 40px rgba(0,0,0,.15);}
@-webkit-keyframes bounce { from, to {transform:translateY(0); animation-timing-function:ease-out;} 50% {transform:translateY(10px); animation-timing-function:ease-in;} }
@keyframes bounce { from, to {transform:translateY(0); animation-timing-function:ease-out;} 50% {transform:translateY(10px); animation-timing-function:ease-in;} }
.hundred .qrcode {position:absolute; bottom:80px; left:50%; width:1140px; margin-left:-570px;}
.hundred .noti {position:relative; padding:60px 0; background:#0f1c5b;}
.hundred .noti h3 {position:absolute; top:110px; left:50%; margin-left:-420px;}
.hundred .noti ul {width:870px; margin:0 auto; padding-left:270px;}
.hundred .noti ul li {padding:3px 0; text-align:left; font-family:'Verdana', 'Malgun Gothic', '맑은고딕'; font-size:12px; color:#dadbe7;}
.hundred .noti ul li:before {content:'·'; display:inline-block; width:7px;}
.layer-popup {display:none; position:absolute; top:0; left:0; width:100%; height:100%;}
.layer-popup .layer {position:absolute; top:210px; left:50%; width:800px; padding:0 50px; margin-left:-450px; background:#fff; -webkit-border-radius:20px; border-radius:20px; z-index:10;}
.layer-popup .btn-close {position:absolute; top:0; right:0; padding:30px; background:transparent; outline:0; border:0;}
.mask {position:absolute; top:0; left:0; width:100%; height:100%; background:rgba(0,0,0,.5);}
.layer h3 {padding:59px 0 50px; border-bottom:2px solid #e2e2e2;}
.item-list ul {overflow:hidden; width:800px; padding-top:40px;}
.item-list li {overflow:hidden; float:left; width:140px; height:235px; padding:0 10px; cursor:default;}
.item-list li > a {display:block; text-decoration:none;}
.item-list .thumbnail {position:relative; overflow:hidden; width:140px; height:140px; margin-bottom:13px; -webkit-border-radius:50%; border-radius:50%;}
.item-list .thumbnail img {width:100%;}
.item-list li.soldout .thumbnail::after {content:'SOLD OUT'; position:absolute; top:0; left:0; width:100%; height:100%; background-color:rgba(17,17,17,.5); background-image:url(//webimage.10x10.co.kr/fixevent/event/2019/salabal/hundred/txt_soldout.png); background-position:50%; background-repeat:no-repeat; font-size:0; color:transparent;}
.item-list .name {overflow:hidden; font-family:'Verdana', 'Malgun Gothic', '맑은고딕'; font-size:14px; letter-spacing:-1px; color:#000; line-height:1.4; word-break:keep-all;}
.item-list li .name span {font-size:13px;}
.item-list li .name b {display:inline-block; color:#ff3131;}
.item-list li.soldout .name {opacity:.5;}
</style>
<script>
$(function() {
	var position = $('.hundred').offset();
	$(".btn-schedule").click(function(){
		$(".layer-popup").fadeIn();
		$('html,body').animate({scrollTop:position.top},300);
	});
	$(".layer-popup .btn-close, .layer-popup .mask").click(function(){
		$(".layer-popup").fadeOut();
	});
});
</script>
						<!-- 2019 정기세일 100원의 기적 93354 -->
						<div class="evt93354 hundred">
							<div class="inner">
								<div class="topic">
									<strong class="only-app"><img src="//webimage.10x10.co.kr/fixevent/event/2019/salabal/hundred/txt_only_app.png" alt="ONLY APP EVENT"></strong>
									<h2><img src="//webimage.10x10.co.kr/fixevent/event/2019/salabal/hundred/tit_hundred.png" alt="100원의 기적"></h2>
								</div>
								<p><img src="//webimage.10x10.co.kr/fixevent/event/2019/salabal/hundred/img_gift.png?v=1.0" alt="상품 이미지"></p>
								<button type="button" title="전체상품 보기" class="btn-schedule"><img src="//webimage.10x10.co.kr/fixevent/event/2019/salabal/hundred/btn_schedule.png" alt="전체상품 보기"></button>
								<span class="qrcode"><img src="//webimage.10x10.co.kr/fixevent/event/2019/salabal/hundred/img_qrcode.png" alt="텐바이텐 APP 다운받기"></span>
							</div>
							<div class="noti">
								<h3><img src="//webimage.10x10.co.kr/fixevent/event/2019/salabal/hundred/tit_noti.png" alt="유의사항"></h3>
								<ul>
									<li>본 이벤트는 텐바이텐 APP에서 로그인 후 참여 가능합니다.</li>
									<li>ID당 1일 1회만 응모 가능하며, 친구에게 공유 시 한 번 더 응모 기회가 주어집니다. (하루 최대 2번 응모 가능)</li>
									<li>모든 상품의 당첨자가 결정되면 이벤트는 조기 마감될 수 있습니다.</li>
									<li>본 이벤트의 상품은 당첨 후 즉시 결제로만 구매할 수 있으며 배송 후 반품/교환/구매취소가 불가합니다.</li>
									<li>5만원 이상의 상품을 받으신 분께는 세무신고를 위해 개인정보를 요청할 수 있습니다. 제세공과금은 텐바이텐 부담입니다.</li>
								</ul>
							</div>
							<!-- 상품 리스트 -->
							<div class="layer-popup">
								<div class="layer">
									<h3><img src="//webimage.10x10.co.kr/fixevent/event/2019/salabal/hundred/tit_schedule.png?v=1.0" alt="인생템 리스트"></h3>
									<div class="item-list">
										<ul>											
											<li <%=chkIIF(prd1 < 1, "class=""soldout""", "")%>>
												<div class="thumbnail"><img src="//webimage.10x10.co.kr/fixevent/event/2019/salabal/hundred/m/img_item_01.png" alt=""></div>
												<div class="name">맥북에어 13형 <span>(Space Grey)</span> <b><%=chkIIF(prd1 < 1, "", prd1 & "대")%></b></div>
											</li>
											<li <%=chkIIF(prd2 < 1, "class=""soldout""", "")%>>
												<div class="thumbnail"><img src="//webimage.10x10.co.kr/fixevent/event/2019/salabal/hundred/m/img_item_02.png" alt=""></div>
												<div class="name">아이패드 Pro 64GB 11형 <span>(Silver)</span> <b><%=chkIIF(prd2 < 1, "", prd2 & "대")%></b></div>
											</li>
											<li <%=chkIIF(prd3 < 1, "class=""soldout""", "")%>>
												<div class="thumbnail"><img src="//webimage.10x10.co.kr/fixevent/event/2019/salabal/hundred/m/img_item_03.png" alt=""></div>
												<div class="name">아이폰XR 128GB <span>(블랙)</span> <b><%=chkIIF(prd3 < 1, "", prd3 & "대")%></b></div>
											</li>
											<li <%=chkIIF(prd4 < 1, "class=""soldout""", "")%>>
												<div class="thumbnail"><img src="//webimage.10x10.co.kr/fixevent/event/2019/salabal/hundred/m/img_item_04.png" alt=""></div>
												<div class="name">애플워치 40mm <span>(Space Grey / 스포츠 밴드)</span> <b><%=chkIIF(prd4 < 1, "", prd4 & "대")%></b></div>
											</li>
											<li <%=chkIIF(prd5 < 1, "class=""soldout""", "")%>>
												<a href="/shopping/category_prd.asp?itemid=1932155&pEtr=93354">
													<div class="thumbnail"><img src="//webimage.10x10.co.kr/fixevent/event/2019/salabal/hundred/m/img_item_05.png" alt=""></div>
													<div class="name">다이슨 V7 플러피 <b><%=chkIIF(prd5 < 1, "", prd5 & "대")%></b></div>
												</a>
											</li>
											<li <%=chkIIF(prd6 < 1, "class=""soldout""", "")%>>
												<div class="thumbnail"><img src="//webimage.10x10.co.kr/fixevent/event/2019/salabal/hundred/m/img_item_06.png" alt=""></div>
												<div class="name">마샬 스피커 <span>(Acton 2)</span> <b><%=chkIIF(prd6 < 1, "", prd6 & "대")%></b></div>
											</li>
											<li <%=chkIIF(prd7 < 1, "class=""soldout""", "")%>>
												<a href="/shopping/category_prd.asp?itemid=1191473&pEtr=93354" >
													<div class="thumbnail"><img src="//webimage.10x10.co.kr/fixevent/event/2019/salabal/hundred/m/img_item_07.png" alt=""></div>
													<div class="name">발뮤다 공기청정기 화이트그레이 <b><%=chkIIF(prd7 < 1, "", prd7 & "대")%></b></div>
												</a>
											</li>
											<li <%=chkIIF(prd8 < 1, "class=""soldout""", "")%>>
												<a href="/shopping/category_prd.asp?itemid=1555093&pEtr=93354">
													<div class="thumbnail"><img src="//webimage.10x10.co.kr/fixevent/event/2019/salabal/hundred/m/img_item_08.png?v=1.1" alt=""></div>
													<div class="name">다이슨 헤어드라이기 <span>(슈퍼소닉)</span> <b><%=chkIIF(prd8 < 1, "", prd8 & "대")%></b></div>
												</a>
											</li>
											<li <%=chkIIF(prd9 < 1, "class=""soldout""", "")%>>
												<a href="/shopping/category_prd.asp?itemid=2074964&pEtr=93354">
													<div class="thumbnail"><img src="//webimage.10x10.co.kr/fixevent/event/2019/salabal/hundred/m/img_item_09.png" alt=""></div>
													<div class="name">브리츠 블루투스 스피커 <span>(다크체리)</span> <b><%=chkIIF(prd9 < 1, "", prd9 & "대")%></b></div>
												</a>
											</li>
											<li <%=chkIIF(prd10 < 1, "class=""soldout""", "")%>>
												<a href="/shopping/category_prd.asp?itemid=2039765&pEtr=93354" >
													<div class="thumbnail"><img src="//webimage.10x10.co.kr/fixevent/event/2019/salabal/hundred/m/img_item_10.png" alt=""></div>
													<div class="name">코닥 프린토매틱 <span>(옐로우)</span> <b><%=chkIIF(prd10 < 1, "", prd10 & "대")%></b></div>
												</a>
											</li>
										</ul>
									</div>
									<button type="button" title="닫기" class="btn-close"><img src="//webimage.10x10.co.kr/fixevent/event/2019/salabal/hundred/btn_close.png" alt="닫기"></button>
								</div>
								<div class="mask"></div>
							</div>
						</div>
						<!--// 2019 정기세일 100원의 기적 93354 -->			
<!-- #include virtual="/lib/db/dbclose.asp" -->