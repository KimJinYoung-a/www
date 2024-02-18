<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'####################################################
' Description : 크리스마스 이벤트
' History : 2019-11-26 최종원 
'####################################################
%>
<!-- #INCLUDE Virtual="/lib/util/commlib.asp" -->
<!-- #include Virtual="/lib/chkDevice.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/event/lib/event_etc_function.asp" -->
<%
dim userid : userid = GetEncLoginUserID()
%>
<style type="text/css">
.evt98974 {position: relative; background-color: #1b263c;}
.evt98974 .bnr-top a {display: block; background-color: #1b4129;}
.evt98974 .topic {position: relative; height:1039px; background: url(//webimage.10x10.co.kr/fixevent/event/2019/98974/bg_tit.jpg?v=1.01) no-repeat center top}
.evt98974 .topic .ani-move span {position: absolute; top: 0; left: 50%; transform: translateX(-50%); animation:star 2.5s ease-in infinite;}
.evt98974 .topic .ani-move span:nth-child(2) {animation-delay: .5s;}
.evt98974 .topic .ani-move span:nth-child(3) {animation-delay: .8s;}
.evt98974 .topic .pos {position: absolute; top: 585px; left: 50%; transform: translateX(-50%);}
.evt98974 .topic .pos .non {padding-top: 7px;}
.evt98974 .topic .pos .mem {font-family: 'Roboto','Noto Sans KR','malgun Gothic','맑은고딕',sans-serif; color: #fff; text-align: center;}
.evt98974 .topic .pos .mem .txt {height: 35px; font-size: 22px;}
.evt98974 .topic .pos .mem .txt span {color: #11ff33; }
.evt98974 .topic .pos .mem .txt span b {font-weight: normal;}
.evt98974 .topic .pos .mem .price {height: 54px; line-height: 1.2;}
.evt98974 .topic .pos .mem .price span {font-size: 27px;}
.evt98974 .topic .pos .mem .price span b {font-family: 'AvenirNext-DemiBold','Roboto'; font-size: 45px;  vertical-align: -5px;}
.evt98974 .topic .pos .mem .price img {vertical-align: baseline;}
.evt98974 .topic .pos .mem p {margin-top: 50px;}
.evt98974 .topic .bounce {position: absolute; top: 320px; left: 50%; margin-left: 120px; animation:bounce .7s 20;}
@keyframes star {
    50%{opacity: 0;}
}
@keyframes bounce {
    from to {transform:translateY(0); animation-timing-function:ease-out;}
    50% {transform:translateY(-10px); animation-timing-function:ease-in;}
}
</style>
<script type="text/javascript">
function jsEventLogin(){
	if(confirm("로그인 하시겠습니까?")){
		location.href='/login/loginpage.asp?backpath=<%=Server.URLencode("/event/eventmain.asp?eventid=98975")%>';
		return;
	}
}
</script>
                        <!-- 98975 mkt 크리스박스 -->
                        <div class="evt98974">
                            <div class="bnr-top">
                                <a href="/christmas"><img src="//webimage.10x10.co.kr/fixevent/event/2019/98974/bnr_top.jpg" alt="당신이 찾고 있는 크리스마스 소품의 모든 것"></a>
                            </div>
                            <div class="topic">
                                <div class="ani-move">
                                    <span><img src="//webimage.10x10.co.kr/fixevent/event/2019/98974/bg_star_1.png" alt=""></span>
                                    <span><img src="//webimage.10x10.co.kr/fixevent/event/2019/98974/bg_star_2.png" alt=""></span>
                                    <span><img src="//webimage.10x10.co.kr/fixevent/event/2019/98974/bg_star_3.png" alt=""></span>
                                </div>
                                <p class="bounce"><img src="//webimage.10x10.co.kr/fixevent/event/2019/98974/ico_bounce.png" alt="App 전용"></p>
                                <div class="pos">
                                    <% if not IsUserLoginOK() then %>
                                    <div class="non">
                                        <a href="javascript:jsEventLogin()"><img src="//webimage.10x10.co.kr/fixevent/event/2019/98974/txt_non.png" alt="내가 담은 금액은? 로그인하고 확인하기"></a>
                                    </div>
                                    <% else %>
                                    <div class="mem">
                                        <div class="txt">
                                            <span><b><%=GetLoginUserName()%></b>님</span>의 장바구니 금액
                                        </div>
                                        <div class="price" style="cursor:pointer" onclick="window.location.href='/inipay/shoppingbag.asp'">
                                            <span><b><%= FormatNumber(getCartTotalAmount(userid), 0) %></b> 원 </span><img src="//webimage.10x10.co.kr/fixevent/event/2019/98974/ico_arrow.png" alt="">
                                        </div>
                                        <p><img src="//webimage.10x10.co.kr/fixevent/event/2019/98974/txt_mem.png" alt="* 위 금액은 품절 상품 및 배송비를 제외한 금액입니다."></p>
                                    </div>
                                    <% end if %>
                                </div>
                            </div>
                            <p style="background-color:#3c3a3a"><img src="//webimage.10x10.co.kr/fixevent/event/2019/98974/txt_notice.jpg" alt="유의사항"></p>
                        </div>
                        <!-- // 98975 mkt 크리스박스 -->
<!-- #include virtual="/lib/db/dbclose.asp" -->