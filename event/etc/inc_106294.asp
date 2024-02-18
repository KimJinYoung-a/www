<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #INCLUDE Virtual="/lib/util/commlib.asp" -->
<!-- #include Virtual="/lib/chkDevice.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/event/lib/event_etc_function.asp" -->
<style>
.evt106294 h2, .evt106294 .story, .evt106294 .coming, .evt106294 .laundry-bnr,.evt106294 .push-way {background-image:url(//webimage.10x10.co.kr/fixevent/event/2020/106294/img_tit.jpg); background-repeat:no-repeat ; background-position:50% 50%; text-indent:-999em;}
.evt106294 h2 {height:870px; background-color:#8c6140; background-image:url(//webimage.10x10.co.kr/fixevent/event/2020/106294/img_tit.jpg)}
.evt106294 .story {height:2923px; background-color:#ffeddc; background-image:url(//webimage.10x10.co.kr/fixevent/event/2020/106294/img_story_v2.jpg)}
.evt106294 .coming {height:1718px; background-color:#eba479; background-image:url(//webimage.10x10.co.kr/fixevent/event/2020/106294/img_coming.jpg)}
.evt106294 .push {position:relative; background-color:#eb7954;}
.evt106294 .push button {position:absolute; top:245px; left:50%; width:560px; height:145px; transform:translateX(-280px); background-color:transparent; text-indent:-999em;}
.evt106294 .push-way {height:517px; background-color:#eb7954; background-image:url(//webimage.10x10.co.kr/fixevent/event/2020/106294/txt_way.jpg);}
.evt106294 .laundry-bnr {height:195px; background-color:#fff5ea; background-image:url(//webimage.10x10.co.kr/fixevent/event/2020/106294/img_bottom.jpg);}
</style>
<script type="text/javascript" src="/event/etc/json/js_regAlram.js"></script>

						<% '<!-- 106294 --> %>
						<div class="evt106294">
							<h2>Stay at home</h2>
							<div class="story">20 F/W STORY </div>
							<div class="coming">COMING SOON</div>
							<div class="push">
								<img src="//webimage.10x10.co.kr/fixevent/event/2020/106294/txt_push.png" alt="기대되는 런드리맷 홈웨어 오픈 알림 신청하시면 오픈시 앱 푸시로 알려드릴게요 ">
								<button onclick="regAlram(); return false;">오픈알림받기</button>
							</div>
							<div class="push-way"></div>
							<div class="laundry-bnr">Stay at home</div>
						</div>
						<% '<!-- // 106294 --> %>
