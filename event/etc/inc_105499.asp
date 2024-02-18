<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #INCLUDE Virtual="/lib/util/commlib.asp" -->
<!-- #include Virtual="/lib/chkDevice.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/event/lib/event_etc_function.asp" -->
<%
dim eCode, eventStartDate, eventEndDate, currentDate, cnt
IF application("Svr_Info") = "Dev" THEN
	eCode = "102220"
Else
	eCode = "105499"
End If
eventStartDate = cdate("2020-09-07")	'이벤트 시작일
eventEndDate = cdate("2020-09-21")		'이벤트 종료일
currentDate = date()

dim userid : userid = GetEncLoginUserID()

if userId="ley330" or userId="greenteenz" or userId="rnldusgpfla" or userId="cjw0515" or userId="thensi7" or userId = "motions" or userId = "jj999a" or userId = "phsman1" or userId = "jjia94" or userId = "seojb1983" or userId = "kny9480" or userId = "bestksy0527" or userId = "mame234" or userid = "corpse2" or userid = "tozzinet" then
	currentDate = #09/07/2020 09:00:00#
end if
%>

<style type="text/css">
.evt105499 {height:1600px; background:url(//webimage.10x10.co.kr/fixevent/event/2020/105500/bg_cont.png) 50% 0 no-repeat;}
.evt105499 button {background-color:transparent;}
.my-cart {position:absolute; left:50%; top:557px; margin-left:-310px; width:620px; height:248px; text-align:center;}
.my-cart p:first-child {padding:70px 0 20px;}
.my-cart b {color:#fedc1d;}
.my-cart a {font-size:30px; line-height:1.1; color:#fff; font-weight:600; text-decoration:none;}
.my-cart .price {display:inline-block; padding-right:40px; font-size:58px; font-weight:700; background:url(//webimage.10x10.co.kr/fixevent/event/2020/105500/m/blt_arrow_1.png) no-repeat 100% 40%;}
</style>
<script>

function jsEventLogin(){
	if(confirm("로그인 하시겠습니까?")){
		location.href='/login/loginpage.asp?backpath=<%=Server.URLencode("/event/eventmain.asp?eventid=" & eCode)%>';
		return;
	}
}

</script>

						<% '<!-- 105499 보름달 --> %>
						<div class="evt105499">
                            <% '<!-- 나의 장바구니 금액 확인하기 --> %>
                            <div class="my-cart">
                                <% if not IsUserLoginOK() then %>
                                    <a href="" onclick="jsEventLogin(); return false;"><img src="//webimage.10x10.co.kr/fixevent/event/2020/105500/btn_login.png" alt="장바구니 금액 확인하기"></a>
                                <% else %>
                                    <a href="" onclick="window.location.href='/inipay/shoppingbag.asp'; return false;" >
                                        <div>
                                            <p><b><%=GetLoginUserName()%></b>님의 장바구니 금액</p>
                                            <p class="price" ><%= FormatNumber(getCartTotalAmount(userid), 0) %></b>원</p>
                                        </div>
                                    </a>
                                <% end if %>
                            </div>
						</div>
						<% '<!--// 105499 보름달 --> %>

<!-- #include virtual="/lib/db/dbclose.asp" -->