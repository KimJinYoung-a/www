<style type="text/css">
.navigator {position:relative; z-index:30; height:220px; border-bottom:10px solid #ffdb60; background:#b6f3ff url(http://webimage.10x10.co.kr/eventIMG/2016/fourten/common/bg_sky.jpg) repeat 50% 0;}
.navigator .fireframe {position:absolute; top:30px; left:50%; width:1324px; height:190px; margin-left:-621px; background:#b6f3ff url(http://webimage.10x10.co.kr/eventIMG/2016/fourten/common/bg_frame.png) no-repeat 50% 0;}
.navigator p {position:absolute; top:37px; left:50%; margin-left:-524px;}
.navigator ul {position:absolute; top:0; left:50%; width:723x; height:235px; margin-left:-155px;}
.navigator ul:after {content:' '; display:block; clear:both;}
.navigator ul li {float:left; width:119px; height:253px;}
.navigator ul li a {overflow:hidden; display:block; position:relative; width:100%; height:100%; color:#000; font-size:12px; line-height:235px; text-align:center; cursor:pointer;}
.navigator ul li a span {display:block; position:absolute; top:0; left:0; width:100%; height:100%; background:url(http://webimage.10x10.co.kr/eventIMG/2016/fourten/common/img_navigator.png) no-repeat 0 0;}
.navigator ul li a.on span {background-position:0 -271px;}
.navigator ul li.nav1 {width:130px;}
.navigator ul li.nav2 a span {background-position:-130px 0;}
.navigator ul li.nav2 a.on span {background-position:-130px -271px;}
.navigator ul li.nav3 a span {background-position:-249px 0;}
.navigator ul li.nav3 a.on span {background-position:-249px -271px;}
.navigator ul li.nav4 a span {background-position:-368px 0;}
.navigator ul li.nav4 a.on span {background-position:-368px -271px;}
.navigator ul li.nav5 a span {background-position:-487px 0;}
.navigator ul li.nav5 a.on span {background-position:-487px -271px;}
.navigator ul li.nav6 a span {background-position:-606px 0;}
.navigator ul li.nav6 a.on span {background-position:-606px -271px;}
.navigator ul li a i {position:absolute; top:41px; left:0; z-index:5; width:100%; text-align:center;}
.navigator ul li a:hover i {animation-iteration-count:infinite; animation-duration:0.5s; animation-name:up;}
@keyframes up {
	from, to{margin-top:0; animation-timing-function:ease-out;}
	50% {margin-top:5px; animation-timing-function:ease-in;}
}
</style>
	<div class="navigator">
		<div class="fireframe"></div>
		<p>
			<a href="/event/4ten/" title="터져라 포텐 메인 페이지로 이동">
				<img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/common/img_bnr_4ten.png" alt="4월 텐바이텐에 엄청난 일이 터진다! 터져라 포텐 이벤트 기간은 4월 18일부터 4월 27일까지 열흘동안 진행합니다." />
			</a>
		</p>
		<ul>
			<%' for dev msg : 현재 페이지 선택시 a에 클래스 on 붙여주세요. 첫번째 탭은 메인페이지으로만 링크되며 클래스 on붙지 않아요 %>
			<%
				'// 파일명 기준으로 해당 클래스에 on 함
				Dim vMenuOnFnm4ten, vSTempValue
				vSTempValue = Request.ServerVariables("PATH_INFO")
				vMenuOnFnm4ten = Split(vSTempValue, "/")
			%>
			<%'' for dev msg : 현재 페이지 선택시 a에 클래스 on 붙여주세요. %>
			<li class="nav1"><a href="/event/4ten/"><i><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/common/ico_label_coupon.png" alt="할인쿠폰" /></i> <span></span>쿠폰 받으러가기</a></li>
			<li class="nav2">
				<% if date() < "2016-04-20" then %>
					<a href="/event/4ten/ticketTeaser.asp" <% If lcase(vMenuOnFnm4ten(3))=lcase("ticketTeaser.asp") Then %> class="on" <% End If %>>
				<% else %>
					<a href="/event/4ten/ticketGet.asp" <% If lcase(vMenuOnFnm4ten(3))=lcase("ticketGet.asp") Then %> class="on" <% End If %>>
				<% end if %>
					<i><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/common/ico_label_ticket.png" alt="한정판매" /></i> <span></span>티켓이 터진다
				</a>
			</li>
			<li class="nav3"><a href="/event/4ten/bingo.asp" <% If lcase(vMenuOnFnm4ten(3))=lcase("bingo.asp") Then %> class="on" <% End If %>><i><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/common/ico_label_bingo.png" alt="출석체크" /></i> <span></span>빙고 빙고</a></li>
			<li class="nav4"><a href="/event/4ten/gift.asp"<% If lcase(vMenuOnFnm4ten(3))=lcase("gift.asp") Then %> class="on" <% End If %>><i><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/common/ico_label_gift.png" alt="사은품" /></i> <span></span>신난다 팡팡</a></li>
			<li class="nav5"><a href="/event/4ten/price.asp" <% If lcase(vMenuOnFnm4ten(3))=lcase("price.asp") Then %> class="on" <% End If %>><i><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/common/ico_label_price.png" alt="선착순" /></i> <span></span>가격이 터진다</a></li>
			<li class="nav6"><a href="/event/4ten/color.asp" <% If lcase(vMenuOnFnm4ten(3))=lcase("color.asp") Then %> class="on" <% End If %>><i><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/common/ico_label_color.png" alt="참여" /></i> <span></span>레드팡</a></li>
		</ul>
	</div>
