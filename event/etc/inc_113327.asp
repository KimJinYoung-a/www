<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'####################################################
' Description : 페이백 이벤트
' History : 2021.08.09 정태훈 생성
'####################################################
%>
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/chkDevice.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/event/lib/event_etc_function.asp" -->
<!-- #include virtual="/lib/classes/ordercls/sp_myordercls.asp" -->
<%
dim eventStartDate, eventEndDate, LoginUserid, mktTest
dim eCode, currentDate

IF application("Svr_Info") = "Dev" THEN
	eCode = "108386"
    mktTest = True
ElseIf application("Svr_Info")="staging" Then
	eCode = "113327"
    mktTest = True
Else
	eCode = "113327"
    mktTest = False
End If

eventStartDate  = cdate("2021-08-11")		'이벤트 시작일
eventEndDate 	= cdate("2021-08-25")		'이벤트 종료일

LoginUserid		= getencLoginUserid()

if mktTest then
    currentDate = cdate("2021-08-11")
else
    currentDate = date()
end if

dim iniRentalInfoData, tmpRentalInfoData, iniRentalMonthLength
dim sqlstr, iniRentalMonthPrice, orderPrice, myOrderSerial
dim myorder, i
set myorder = new CMyOrder

myorder.FPageSize = 100
myorder.FCurrpage = 1
myorder.FRectUserID = LoginUserid
myorder.FRectSiteName = "10x10"
myorder.FRectStartDate = FormatDateTime("2021-07-01",2)
myorder.FRectEndDate = FormatDateTime("2021-08-01",2)
myorder.GetMyOrderListProc

if LoginUserid<>"" then
	sqlstr = "select top 1 sub_opt1"
	sqlstr = sqlstr & " from [db_event].[dbo].[tbl_event_subscript]"
	sqlstr = sqlstr & " where evt_code="& eCode &""
	sqlstr = sqlstr & " and userid='"& LoginUserid &"'"
    sqlstr = sqlstr & " and sub_opt3='try'"
	rsget.Open sqlstr,dbget
	IF not rsget.EOF THEN
		myOrderSerial = rsget("sub_opt1")
	END IF
	rsget.close
end if
%>
<style>
/* common */
.evt113327 .section{position:relative;}

/* section01 */
.evt113327 .section01{background:url(//webimage.10x10.co.kr/fixevent/event/2021/113327/top.jpg)no-repeat 50% 0;height:1927px;}
.evt113327 .section01 .coin{width:1140px;margin:0 auto;position:relative;}
.evt113327 .section01 .coin .coin01{position:absolute;top:50px;left:360px;animation:updown 0.8s ease-in-out alternate infinite;}
.evt113327 .section01 .coin .coin02{position:absolute;top:190px;left:400px;animation:updown 0.9s ease-in-out alternate infinite;}
.evt113327 .section01 .coin .coin03{position:absolute;top:400px;right:50px;animation:updown 0.7s ease-in-out alternate infinite;}
.evt113327 .section01 .coin .coin04{position:absolute;top:600px;left:50px;animation:updown 1s ease-in-out alternate infinite;}
.evt113327 .section01 .text{width:1140px;margin:0 auto;position:relative;}
.evt113327 .section01 .text .txt01{position:absolute;top:600px;left:50%;margin-left:-75px;opacity:0; transform:translateY(150px); transition:all 1s; }
.evt113327 .section01 .text .txt01.on{opacity:1; transform:translateY(0);}
.evt113327 .section01 .text .txt02{position:absolute;top:680px;left:50%;margin-left:-301px;}
.evt113327 .section01 .text .txt03{position:absolute;top:860px;left:50%;margin-left:-269px;}
.evt113327 .section01 .text .txt04{position:absolute;top:1300px;left:50%;margin-left:-270px;}
.evt113327 .animate {opacity:0; transform:translateY(150px); transition:all 1s; }
.evt113327 .animate.on {opacity:1; transform:translateY(0); }

/* section02 */
.evt113327 .section02 .login .top{background:url(//webimage.10x10.co.kr/fixevent/event/2021/113327/login.jpg)no-repeat 50% 0;height:498px;}
.evt113327 .section02 .login .top .user{padding-top:130px;text-align:center;font-size:30px;font-weight:bold;color:#6efcba;letter-spacing:-0.1rem;}
.evt113327 .section02 .login .top .user span{text-decoration: underline;}
.evt113327 .section02 .login .middle{background:#000d48;width:1140px;padding:30px 0;margin:0 auto;}
.evt113327 .section02 .login .middle .order{width:864px;height:142px;background:url(//webimage.10x10.co.kr/fixevent/event/2021/113327/order.png)no-repeat 0 0;margin:0 auto 20px;}
.evt113327 .section02 .login .middle .order:last-child{margin-bottom:0;}
.evt113327 .section02 .login .middle .order.on{background:url(//webimage.10x10.co.kr/fixevent/event/2021/113327/order_on.png)no-repeat 0 0;}
.evt113327 .section02 .login .middle .order .order_info01{overflow:hidden;padding-top:18px;padding-left:25px;}
.evt113327 .section02 .login .middle .order .order_info01 p{float:left;font-size:20px;font-weight:lighter;margin-right:30px;letter-spacing:-0.05rem;color:#000d48;}
.evt113327 .section02 .login .middle .order .order_info02{overflow:hidden;}
.evt113327 .section02 .login .middle .order .order_info02 .order_name{text-align:left;font-weight:bold;font-size:20px;padding-left:25px;padding-top:10px;letter-spacing:-0.1rem;color:#000d48;}
.evt113327 .section02 .login .middle .order .order_info02 .order_price{text-align:right;font-weight:bold;font-size:32px;padding-right:50px;line-height:24px;letter-spacing:-0.1rem;color:#000d48;}
.evt113327 .section02 .login .bottom{background:url(//webimage.10x10.co.kr/fixevent/event/2021/113327/submit.jpg)no-repeat 50% 0;height:304px;position:relative;}
.evt113327 .section02 .login .bottom .submit{width:500px;height:106px;display:Block;position:absolute;top:70px;left:50%;margin-left:-250px;}

.evt113327 .section02 .logout{background:url(//webimage.10x10.co.kr/fixevent/event/2021/113327/logout.jpg?v=2)no-repeat 50% 0;height:651px;position:relative;}
.evt113327 .section02 .logout .log_submit{width:500px;height:106px;display:block;position:absolute;top:415px;left:50%;margin-left:-250px;}

.evt113327 .section02 .order_one{background:url(//webimage.10x10.co.kr/fixevent/event/2021/113327/order01.jpg)no-repeat 50% 0;height:595px;position:relative;}
.evt113327 .section02 .order_one .user{padding-top:120px;text-align:center;font-size:30px;font-weight:bold;color:#6efcba;letter-spacing:-0.1rem;}
.evt113327 .section02 .order_one .user span{text-decoration: underline;}

/* section03 */
.evt113327 .section03{background:url(//webimage.10x10.co.kr/fixevent/event/2021/113327/notice.jpg)no-repeat 50% 0;height:539px;}

/* section04 */
.evt113327 .section04{background:url(//webimage.10x10.co.kr/fixevent/event/2021/113327/alert.jpg)no-repeat 50% 0;height:603px;}
.evt113327 .section04 .btn_alert{width:500px;height:106px;display:block;position:absolute;top:378px;left:50%;margin-left:-250px;}

/* popup */
/* .evt113327 .popup{display:none;} */
.evt113327 .popup .bg_dim{position:fixed;top:0;left:0;right:0;bottom:0;background:rgba(0,0,0,0.6);z-index:9;}
.evt113327 .popup .pop{position:fixed;top:200px;left:50%;margin-left:-270px;z-index:10;}
.evt113327 .popup .pop .final{position:absolute;top:205px;width:100%;font-size:22px;letter-spacing:-0.05rem;color:#000d48;font-weight:bold;}
.evt113327 .popup .pop .final .name {margin-bottom:10px;}
.evt113327 .popup .pop .final .name span{text-decoration: underline;}
.evt113327 .popup .pop .final .price span{font-size:30px;}
.evt113327 .popup .pop .btn_alert{width:500px;height:106px;display:block;position:absolute;top:423px;left:50%;margin-left:-250px;}
.evt113327 .popup .pop .btn_close{width:50px;height:50px;display:block;position:absolute;top:0;right:0;}

@keyframes updown {
    0% {transform: translateY(-20px);}
    100% {transform: translateY(20px);}
}
</style>
<script>
$(function(){
	$('.txt01').addClass('on');
    $(window).scroll(function(){
        $('.animate').each(function(){
			var y = $(window).scrollTop() + $(window).height() * 1;
			var imgTop = $(this).offset().top;
			if(y > imgTop) {
				$(this).addClass('on');
			}
		});
    });

	$('.order').click(function(){
        $('.order').removeClass('on');
        $(this).toggleClass('on');
    });
    $('.btn_close').click(function(){
        $('.popup').css('display','none');
        return false;
    });
});
function jsSubmitlogin(){
	top.location.href="/login/loginpage.asp?vType=G";
	return false;
}
function fnOrderSelect(orderserial,orderprice){
    $("#orderserial").val(orderserial);
    $("#orderprice").val(orderprice);
}
function doAction() {
	<% if not ( currentDate >= eventStartDate and currentDate <= eventEndDate ) then %>	
		alert("이벤트 참여기간이 아닙니다.");
		return false;
	<% end if %>
    <% If IsUserLoginOK() Then %>

        if($("#orderserial").val()==""){
			alert("주문을 선택해 주세요.");
			return false;
		};
        $.ajax({
            type: "POST",
            url:"/event/etc/doeventsubscript/doEventSubscript113327.asp",
            data: {
                mode: 'add',
                orderserial: $("#orderserial").val()
            },
            dataType: "JSON",
            success: function(data){
                if(data.response == "ok"){
                    fnAmplitudeEventMultiPropertiesAction('click_event_apply','evtcode','<%=eCode%>');
                    $("#myorderprice").html($("#orderprice").val());
                    $('.popup').css('display','block');
                }else if(data.response == "retry"){
                    alert('이미 신청하셨습니다.');
                }
            },
            error: function(data){
                alert('시스템 오류입니다.');
            }
        })
    <% else %>
        jsSubmitlogin();
		return false;
    <% end if %>
}
function doAlarm() {
	<% if not ( currentDate >= eventStartDate and currentDate <= eventEndDate ) then %>	
		alert("이벤트 참여기간이 아닙니다.");
		return false;
	<% end if %>
    <% If IsUserLoginOK() Then %>
        $.ajax({
            type: "POST",
            url:"/event/etc/doeventsubscript/doEventSubscript113327.asp",
            data: {
                mode: 'alarm'
            },
            dataType: "JSON",
            success: function(data){
                if(data.response == "ok"){
                    alert(data.message);
                }else{
                    alert(data.message);
                }
            },
            error: function(data){
                alert('시스템 오류입니다.');
            }
        })
    <% else %>
        jsSubmitlogin();
		return false;
    <% end if %>
}
</script>
						<div class="evt113327">
                            <input type="hidden" id="orderserial" value="<%=myOrderSerial%>">
                            <input type="hidden" id="orderprice">
							<section class="section section01">
								<div class="coin">
									<p class="coin01"><img src="//webimage.10x10.co.kr/fixevent/event/2021/113327/coin01.png" alt=""></p>
									<p class="coin02"><img src="//webimage.10x10.co.kr/fixevent/event/2021/113327/coin02.png" alt=""></p>
									<p class="coin03"><img src="//webimage.10x10.co.kr/fixevent/event/2021/113327/coin03.png" alt=""></p>
									<p class="coin04"><img src="//webimage.10x10.co.kr/fixevent/event/2021/113327/coin04.png" alt=""></p>
								</div>
								<div class="text">
									<p class="txt01"><img src="//webimage.10x10.co.kr/fixevent/event/2021/113327/txt01.png" alt=""></p>
									<p class="txt02 animate"><img src="//webimage.10x10.co.kr/fixevent/event/2021/113327/txt02.png" alt=""></p>
									<p class="txt03 animate"><img src="//webimage.10x10.co.kr/fixevent/event/2021/113327/txt03.png" alt=""></p>
									<p class="txt04 animate"><img src="//webimage.10x10.co.kr/fixevent/event/2021/113327/txt04.png" alt=""></p>
								</div>
							</section>
							<section class="section section02">
							<% if LoginUserid<>"" then %>
                                <% if myorder.FResultCount > 0 then%>
                                <div class="login">
									<div class="top">
										<p class="user"><span><%=LoginUserid%></span> 님의</p>
									</div>
									<div class="middle">
                                        <% for i = 0 to (myorder.FResultCount - 1) %>
                                        <% If myorder.FItemList(i).Faccountdiv="150" Then
                                                iniRentalInfoData = fnGetIniRentalOrderInfo(myorder.FItemList(i).FOrderSerial)
                                                If instr(lcase(iniRentalInfoData),"|") > 0 Then
                                                    tmpRentalInfoData = split(iniRentalInfoData,"|")
                                                    iniRentalMonthLength = tmpRentalInfoData(0)
                                                    iniRentalMonthPrice = tmpRentalInfoData(1)
                                                Else
                                                    iniRentalMonthLength = ""
                                                    iniRentalMonthPrice = ""
                                                End If
                                                orderPrice = FormatNumber(iniRentalMonthPrice,0)
                                            Else
                                                orderPrice = FormatNumber(myorder.FItemList(i).FSubTotalPrice,0)
                                            End If %>
										<div class="order <% if myOrderSerial=myorder.FItemList(i).FOrderSerial then %>on<% end if %>" onclick="fnOrderSelect('<%= myorder.FItemList(i).FOrderSerial %>','<%=orderPrice%>');">
											<div class="order_info01">
												<p class="order_date">주문일 : <span><%= Left(CStr(myorder.FItemList(i).Fregdate),10) %></span></p>
												<p class="order_num">주문번호 : <span><%= myorder.FItemList(i).FOrderSerial %></span></p>
											</div>
											<div class="order_info02">
												<p class="order_name"><%=myorder.FItemList(i).GetItemNames%></p>
												<% If myorder.FItemList(i).Faccountdiv="150" Then %>
                                                <p class="order_price"><span><%=iniRentalMonthLength%>개월간 월 <%=FormatNumber(iniRentalMonthPrice,0)%></span></p>
                                                <% Else %>
                                                <p class="order_price"><span><%=FormatNumber(myorder.FItemList(i).FSubTotalPrice,0)%></span></p>
                                                <% End If %>
											</div>
										</div>
                                        <% next %>
									</div>
									<div class="bottom">
										<a href="" onclick="doAction();return false;" class="submit"></a>
									</div>
								</div>
                                <% else %>
                                <div class="order_one">
									<p class="user"><span><%=LoginUserid%></span> 님의</p>
								</div>
                                <% end if %>
                            <% else %>
								<div class="logout">
									<a href="" onclick="jsSubmitlogin();return false;" class="log_submit"></a>
								</div>
                            <% end if %>
							</section>
							<section class="section section03">
							</section>
							<section class="section section04">
								<a href="" class="btn_alert" onclick="doAlarm();return false;"></a>
							</section>
							<div class="popup" style="display:none">
								<div class="bg_dim"></div>
								<div class="pop">
									<img src="//webimage.10x10.co.kr/fixevent/event/2021/113327/popup.png" alt="">
									<div class="final">
										<p class="name"><span><%=LoginUserid%></span>님의 응모 금액</p>
										<p class="price"><span id="myorderprice">999,999,999</span>원</p>
									</div>
									<a href="" class="btn_alert" onclick="doAlarm();return false;"></a>
									<a href="" class="btn_close"></a>
								</div>
							</div>
						</div>
<% set myorder = nothing %>
<!-- #include virtual="/lib/db/dbclose.asp" -->