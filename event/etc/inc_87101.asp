<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'###########################################################
' Description : 훈남정음 캐릭터 중 정음이와 어울리는 토이는?
' History : 2018-06-07 최종원
'###########################################################
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/inc_const.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/classes/enjoy/eventApplyCls.asp" -->
<!-- #include virtual="/event/lib/event_etc_function.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<%
dim eCode, vUserID, sqlstr, cnt

IF application("Svr_Info") = "Dev" THEN
	eCode = "68520"
Else
	eCode = "87101"
End If

vUserID = getEncLoginUserID

sqlstr = "SELECT COUNT(*) as cnt FROM [db_event].[dbo].[tbl_event_subscript]  WHERE userid= '"&vUserID&"' and evt_code="& eCode &" and datediff(day,regdate,getdate()) = 0 "
rsget.Open sqlstr, dbget, 1
	cnt = rsget("cnt")
rsget.close

%>
<style>
.evt87101 button{background-color:transparent;}
.evt87101 .top-hoon {position:relative; height:562px; padding-top:90px; background:#ccecba url(http://webimage.10x10.co.kr/eventIMG/2018/87101/bg_top.jpg) no-repeat 50% 0;}
.evt87101 .top-hoon .btn-dramazone {position:absolute; top:25px; left:50%; margin-left:370px; animation:bounce1 .8s 50;}
.evt87101 .inner {position:relative; top:-240px;}
.evt87101 .hoon-slide {width:960px; height:563px; margin:0 auto; background-color:#ff9590; border:solid 9px #ff9590;}
.evt87101 .hoon-cont {position:relative; height:3407px; background:#ffd9d8 url(http://webimage.10x10.co.kr/eventIMG/2018/87101/bg_cont.jpg?v=1.00) no-repeat 50% 0;}
.evt87101 .hoon-cont .vote h3 {margin-top:60px;}
.evt87101 .hoon-cont .vote ul {overflow:hidden; width:1062px; margin:16px auto 80px;}
.evt87101 .hoon-cont .vote ul li {float:left; height:340px; margin:54px 10px 0; text-align:right;}
.evt87101 .hoon-cont .vote ul li .thumb {cursor:pointer;}
.evt87101 .hoon-cont .vote ul li button {position:relative; top:-10px; right:-5px; background-color:#ffd9d8; border:solid 6px #ffd9d8; border-radius:25px;}
.evt87101 .hoon-cont .vote ul li button span {position:absolute; top:0; left:0;}
.evt87101 .hoon-cont .submit {margin-top:70px; padding-bottom:80px;}
.evt87101 .ly-vod {position:absolute; top:0; left:0; z-index:10; width:100%; height:100%; padding-top:1105px; background-color:rgba(0,0,0,.9);}
.evt87101 .ly-vod iframe {position:absolute; left:50%; margin:40px 0 0 -450px; background-color:#000;}
.evt87101 .ly-vod .btn-close {position:absolute; top:1105px; left:50%; margin-left:428px;}
.evt87101 .more {padding:126px 0 108px; background:#c3f3e8 url(http://webimage.10x10.co.kr/eventIMG/2018/87101/bg_evt.jpg?v=1.00) no-repeat 50% 0;}
.evt87101 .more ul {overflow:hidden; width:1023px; margin:0 auto;}
.evt87101 .more ul li {float:left; position:relative; margin:70px 32px 0;}
.evt87101 .more ul li span {display:none; position:absolute; top:0; left:0;}
.evt87101 .more ul li:hover span {display:block;}
.evt87101 .noti {position:relative; padding:73px 0 63px; background-color:#f2f2f2;}
.evt87101 .noti h6 {position:absolute; top:50%; left:50%; margin-left:-360px; margin-top:-10px;}
.evt87101 .noti ul {width:720px; margin:0 auto; padding-left:320px; text-align:left;}
.evt87101 .noti ul li {line-height:24px;}
@keyframes bounce1 {
	from to {transform:translateY(0);}
	50% {transform:translateY(-8px);}
}
</style>
<script type="text/javascript" src="/lib/js/jquery.kxbdmarquee.js"></script>
<script>
$(function(){
	// slide
	/*$('.hoon-slide .swiper-wrapper').slidesjs({
		width:930,
		height:575,
		pagination: false,
		navigation: false,
		play:{interval:3000, effect:'fade', auto:1200},
		effect:{fade: {speed:600, crossfade:true}
		},
		callback: {
			complete: function(number) {
				var pluginInstance = $('.hoon-slide .swiper-wrapper').data('plugin_slidesjs');
				setTimeout(function() {
					pluginInstance.play(true);
				}, pluginInstance.options.play.interval);
			}
		}
	});*/

	// pop-layer
	$('.ly-vod').hide();
	$(".hoon-cont .thumb").click(function(){
		var position = $('.hoon-cont ul').offset();
		$('html,body').animate({ scrollTop : position.top }, 100);
		$('.ly-vod').show();
		$('.ly-vod iframe').show();
	});
	$(".ly-vod").click(function(){
		$('.ly-vod').hide();
	});
});
function fnPopupLayer(idx) {
	var imgSrcNum = '';
	switch(idx){
		case 1 : imgSrcNum = 'https://player.vimeo.com/video/273810085?autoplay=1';
			 break;
		case 2 : imgSrcNum = 'https://player.vimeo.com/video/273809385?autoplay=1';
			 break;
		case 3 : imgSrcNum = 'https://player.vimeo.com/video/273809236?autoplay=1';
			 break;
		case 4 : imgSrcNum = 'https://player.vimeo.com/video/273808464?autoplay=1';
			 break;
		case 5 : imgSrcNum = 'https://player.vimeo.com/video/274004278?autoplay=1';
			 break;
		case 6 : imgSrcNum = 'https://player.vimeo.com/video/273810260?autoplay=1';
			 break;
		case 7 : imgSrcNum = 'https://player.vimeo.com/video/273809660?autoplay=1';
			 break;
		case 8 : imgSrcNum = 'https://player.vimeo.com/video/273810009?autoplay=1';
			 break;
		case 9 : imgSrcNum = 'https://player.vimeo.com/video/274004463?autoplay=1';
			 break;
	}
	$('.ly-vod iframe').attr('src', imgSrcNum);
}

function fnVote(voteval) {

	<% If vUserID = "" Then %>
		if ("<%=IsUserLoginOK%>"=="False") {
			if(confirm("로그인을 하셔야 참여할 수 있습니다.")){
				top.location.href="/login/loginpage.asp?vType=G";
				return false;
			}
		}
	<% End If %>
	<% If vUserID <> "" Then %>
	var reStr;

	var str = $.ajax({
		type: "GET",
		url:"/event/etc/doeventsubscript/doEventSubscript87101.asp",
		data: "mode=vote&voteval="+voteval,
		dataType: "text",
		async: false
	}).responseText;

		reStr = str.split("|");
		if(reStr[0]=="OK"){
			if(reStr[1] == "vt") {
				<% if date() = "2018-07-13" then %>
					alert('투표해 주셔서 감사합니다!\n당첨을 기대해 주세요!');
					location.reload();
				<% else %>
					alert('투표해 주셔서 감사합니다.\n내일 또 투표해 주세요 :)');
					location.reload();
				<% end if %>
				return false;
			}else{
				alert('오류가 발생했습니다.');
				return false;
			}
		}else{
			errorMsg = reStr[1].replace(">?n", "\n");
			alert(errorMsg);
			document.location.reload();
			return false;
		}
	<% End If %>
}

function fnClickChk(){


window.open('http://programs.sbs.co.kr/drama/theundatables/vote/54999/10000000171?company=10');

}

</script>
						<!-- 훈남정음 -->
						<div class="evt87101">
							<div class="top-hoon">
								<h2><img src="http://webimage.10x10.co.kr/eventIMG/2018/87101/tit_hoonman.png" alt="훈남정음" /></h2>
								<a href="/dramazone/" class="btn-dramazone" target="_blank"><img src="http://webimage.10x10.co.kr/eventIMG/2018/87101/btn_go_sbs.png" alt="sbs dramazone 바로 가기" /></a>
							</div>
							<div class="hoon-cont">
								<div class="inner">

									<!-- slide -->
									<!-- <div class="hoon-slide">
										<div class="swiper-container">
											<div class="swiper-wrapper">
												<div class="swiper-slide"><img src="http://webimage.10x10.co.kr/eventIMG/2018/87101/img_slide_1.jpg" alt="" /></div>
												<div class="swiper-slide"><img src="http://webimage.10x10.co.kr/eventIMG/2018/87101/img_slide_2.jpg" alt="" /></div>
												<div class="swiper-slide"><img src="http://webimage.10x10.co.kr/eventIMG/2018/87101/img_slide_3.jpg" alt="" /></div>
												<div class="swiper-slide"><img src="http://webimage.10x10.co.kr/eventIMG/2018/87101/img_slide_4.jpg" alt="" /></div>
											</div>
										</div>
									</div> -->
									<!--// slide -->
									<div class="hoon-slide">
										<img src="http://webimage.10x10.co.kr/eventIMG/2018/87101/img_slide_1.jpg" alt="" />
									</div>
								<!-- 투표 -->
								<div class="vote">
									<h3><img src="http://webimage.10x10.co.kr/eventIMG/2018/87101/tit_vote.png?v=1.00" alt="정음이와 가장 잘 어울리는 토이는?" /></h3>
									<ul>
										<li>
											<div class="thumb" onClick=fnPopupLayer(1) ><img src="http://webimage.10x10.co.kr/eventIMG/2018/87101/img_thumb_1.jpg" alt="" /></div>
											<p class="tit"><img src="http://webimage.10x10.co.kr/eventIMG/2018/87101/txt_tit_1.png" alt="[마시멜로 맨] 달콤함을 좋아하는 그녀" /></p>
											<button onClick=fnVote(1)>
												<img src="http://webimage.10x10.co.kr/eventIMG/2018/87101/btn_vote.png" alt="투표하기" /> <!-- for dev msg 투표전 -->
												<span>
												<%If cnt > 0 then%>
												<img src="http://webimage.10x10.co.kr/eventIMG/2018/87101/btn_comp.png" alt="투표완료" />
												<%End if%>
												</span>
											</button>
										</li>
										<li>
											<div class="thumb" onClick=fnPopupLayer(2)><img src="http://webimage.10x10.co.kr/eventIMG/2018/87101/img_thumb_2.jpg" alt="" /></div>
											<p class="tit"><img src="http://webimage.10x10.co.kr/eventIMG/2018/87101/txt_tit_2.png" alt="[곰돌이 푸] 푸처럼 항상 귀여운 그녀" /></p>
											<button onClick=fnVote(2)>
												<img src="http://webimage.10x10.co.kr/eventIMG/2018/87101/btn_vote.png" alt="투표하기" />
												<span>
												<%If cnt > 0 then%>
												<img src="http://webimage.10x10.co.kr/eventIMG/2018/87101/btn_comp.png" alt="투표완료" />
												<%End if%>
												</span>
											</button>
										</li>
										<li>
											<div class="thumb" onClick=fnPopupLayer(3)><img src="http://webimage.10x10.co.kr/eventIMG/2018/87101/img_thumb_3.jpg" alt="" /></div>
											<p class="tit"><img src="http://webimage.10x10.co.kr/eventIMG/2018/87101/txt_tit_3.png" alt="[호두까기 인형] 빈티지를 좋아하는 그녀" /></p>
											<button onClick=fnVote(3)>
												<img src="http://webimage.10x10.co.kr/eventIMG/2018/87101/btn_vote.png" alt="투표하기" />
												<span>
												<%If cnt > 0 then%>
												<img src="http://webimage.10x10.co.kr/eventIMG/2018/87101/btn_comp.png" alt="투표완료" />
												<%End if%>
												</span>
											</button>
										</li>
										<li>
											<div class="thumb" onClick=fnPopupLayer(4)><img src="http://webimage.10x10.co.kr/eventIMG/2018/87101/img_thumb_4.jpg" alt="" /></div>
											<p class="tit"><img src="http://webimage.10x10.co.kr/eventIMG/2018/87101/txt_tit_4.png" alt="[모빌] 조형미를 사랑하는 그녀" /></p>
											<button onClick=fnVote(4)>
												<img src="http://webimage.10x10.co.kr/eventIMG/2018/87101/btn_vote.png" alt="투표하기" />
												<span>
												<%If cnt > 0 then%>
												<img src="http://webimage.10x10.co.kr/eventIMG/2018/87101/btn_comp.png" alt="투표완료" />
												<%End if%>
												</span>
											</button>
										</li>
										<li>
											<div class="thumb" onClick=fnPopupLayer(5)><img src="http://webimage.10x10.co.kr/eventIMG/2018/87101/img_thumb_5.jpg" alt="" /></div>
											<p class="tit"><img src="http://webimage.10x10.co.kr/eventIMG/2018/87101/txt_tit_5.png?v=1.03"></p>
											<button onClick=fnVote(5)>
												<img src="http://webimage.10x10.co.kr/eventIMG/2018/87101/btn_vote.png" alt="투표하기" />
												<span>
												<%If cnt > 0 then%>
												<img src="http://webimage.10x10.co.kr/eventIMG/2018/87101/btn_comp.png" alt="투표완료" />
												<%End if%>
												</span>
											</button>
										</li>
										<li>
											<div class="thumb" onClick=fnPopupLayer(6)><img src="http://webimage.10x10.co.kr/eventIMG/2018/87101/img_thumb_6.jpg" alt="" /></div>
											<p class="tit"><img src="http://webimage.10x10.co.kr/eventIMG/2018/87101/txt_tit_6.png" alt="[블랙팬서] 영웅처럼 듬직한 그녀" /></p>
											<button onClick=fnVote(6)>
												<img src="http://webimage.10x10.co.kr/eventIMG/2018/87101/btn_vote.png" alt="투표하기" />
												<span>
												<%If cnt > 0 then%>
												<img src="http://webimage.10x10.co.kr/eventIMG/2018/87101/btn_comp.png" alt="투표완료" />
												<%End if%>
												</span>
											</button>
										</li>
										<li>
											<div class="thumb" onClick=fnPopupLayer(7)><img src="http://webimage.10x10.co.kr/eventIMG/2018/87101/img_thumb_7.jpg" alt="" /></div>
											<p class="tit"><img src="http://webimage.10x10.co.kr/eventIMG/2018/87101/txt_tit_7.png" alt="[코뿔소] 기발한 것을 좋아하는 그녀" /></p>
											<button onClick=fnVote(7)>
												<img src="http://webimage.10x10.co.kr/eventIMG/2018/87101/btn_vote.png" alt="투표하기" />
												<span>
												<%If cnt > 0 then%>
												<img src="http://webimage.10x10.co.kr/eventIMG/2018/87101/btn_comp.png" alt="투표완료" />
												<%End if%>
												</span>
											</button>
										</li>
										<li>
											<div class="thumb" onClick=fnPopupLayer(8)><img src="http://webimage.10x10.co.kr/eventIMG/2018/87101/img_thumb_8.jpg" alt="" /></div>
											<p class="tit"><img src="http://webimage.10x10.co.kr/eventIMG/2018/87101/txt_tit_8.png" alt="[스누피 스쿨버스] 항상 교훈을 주는 그녀" /></p>
											<button onClick=fnVote(8)>
												<img src="http://webimage.10x10.co.kr/eventIMG/2018/87101/btn_vote.png" alt="투표하기" />
												<span>
												<%If cnt > 0 then%>
												<img src="http://webimage.10x10.co.kr/eventIMG/2018/87101/btn_comp.png" alt="투표완료" />
												<%End if%>
												</span>
											</button>
										</li>
										<li>
											<div class="thumb" onClick=fnPopupLayer(9)><img src="http://webimage.10x10.co.kr/eventIMG/2018/87101/img_thumb_9.jpg" alt="" /></div>
											<p class="tit"><img src="http://webimage.10x10.co.kr/eventIMG/2018/87101/txt_tit_9.png" alt="[왕실 공주] 매일이 사랑스러운 그녀" /></p>
											<button onClick=fnVote(9)>
												<img src="http://webimage.10x10.co.kr/eventIMG/2018/87101/btn_vote.png" alt="투표하기" />
												<span>
												<%If cnt > 0 then%>
												<img src="http://webimage.10x10.co.kr/eventIMG/2018/87101/btn_comp.png" alt="투표완료" />
												<%End if%>
												</span>
											</button>
										</li>
									</ul>
									<div class="gift"><img src="http://webimage.10x10.co.kr/eventIMG/2018/87101/img_gift.jpg" alt="" /></div>
									<button class="submit" onclick="fnClickChk();fnAmplitudeEventMultiPropertiesAction('click_event87101_vote','','');"><img src="http://webimage.10x10.co.kr/eventIMG/2018/87101/btn_submit.png?v=1.01" alt="" /></button>
								</div>
								<!--// 투표 -->

								<!-- 팝업레이어 -->
								<div class="ly-vod">
									<h4><img src="http://webimage.10x10.co.kr/eventIMG/2018/87101/tit_best.png" alt="정음 이와 가장 잘 어울리는 토이는?" /></h4>
									<!-- for dev msg 클릭한 썸네일의 해당 동영상이 바로 재생 될수 있게 해주세요. // -->
									<iframe width='900' height='530' src='' frameborder='0' allowFullScreen mozallowfullscreen webkitAllowFullScreen></iframe>
									<button class="btn-close"><img src="http://webimage.10x10.co.kr/eventIMG/2018/87101/btn_close.png" alt="" /></button>
								</div>
								<!--// 팝업레이어 -->
									<div class="more">
										<h5><img src="http://webimage.10x10.co.kr/eventIMG/2018/87101/tit_more.png" alt="드라마 속 더욱 다양한 상품 구경하기" /></h5>
										<ul>
											<li>
												<a href="/event/eventmain.asp?eventid=86960" target="_blank">
													<img src="http://webimage.10x10.co.kr/eventIMG/2018/87101/img_more_1.png" alt="tassen" />
													<span><img src="http://webimage.10x10.co.kr/eventIMG/2018/87101/img_more_1_over.png?v=1.00" alt="more" /></span>
												</a>
											</li>
											<li>
												<a href="/event/eventmain.asp?eventid=87115" target="_blank">
													<img src="http://webimage.10x10.co.kr/eventIMG/2018/87101/img_more_2.png" alt="킨키로봇" />
													<span><img src="http://webimage.10x10.co.kr/eventIMG/2018/87101/img_more_2_over.png" alt="more" /></span>
												</a>
											</li>
											<li>
												<a href="/event/eventmain.asp?eventid=87070" target="_blank">
													<img src="http://webimage.10x10.co.kr/eventIMG/2018/87101/img_more_3.png" alt="플레이모빌" />
													<span><img src="http://webimage.10x10.co.kr/eventIMG/2018/87101/img_more_3_over.png?v=1.00" alt="more" /></span>
												</a>
											</li>
										</ul>
									</div>
									<!-- 기획전 -->

									<div class="noti">
										<h6><img src="http://webimage.10x10.co.kr/eventIMG/2018/87101/tit_noti.png" alt="유의사항" /></h6>
										<ul>
											<li>&middot; 본 이벤트는 하루에 한 번씩만 참여할 수 있습니다.</li>
											<li>&middot; 당첨자 발표는 7월 18일 텐바이텐 공지사항에 기재됩니다.</li>
											<li>&middot; 이벤트 상품은 랜덤으로 발송됩니다.</li>
											<li>&middot; 당첨자에게는 세무신고에 필요한 개인정보를 요청할 수 있으며, 제세공과금은 텐바이텐 부담입니다.</li>
										</ul>
									</div>
							</div>
						</div>
						<!--// 훈남정음 -->
<!-- #include virtual="/lib/db/dbclose.asp" -->