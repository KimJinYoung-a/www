<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/lib/util/DBcacheLib.asp" -->
<%
'####################################################
' Description : 19주년 구매사은품
' History : 2020-10-16 원승현
'####################################################
Dim eCode, userid
Dim vEvtOrderCnt, vEvtOrderSumPrice, vMyThisEvtCnt, sqlstr, vQuery

IF application("Svr_Info") = "Dev" THEN
	eCode   =  103242
Else
	eCode   =  106353
End If

userid = GetEncLoginUserID()

'// 이벤트 기간 구매 내역 체킹(10월 5일부터 10월 29일까지)
sqlStr = " EXEC [db_order].[dbo].[sp_Ten_MyOrderList_SUM_19THEVENT] '" & userid & "', '', '', '2020-10-05', '2020-10-29', '10x10', '', 'issue' "
'response.write sqlStr & "<br>"
rsget.CursorLocation = adUseClient
rsget.CursorType = adOpenStatic
rsget.LockType = adLockOptimistic
rsget.Open sqlStr,dbget,adOpenForwardOnly,adLockReadOnly
	vEvtOrderCnt = rsget("cnt")
	vEvtOrderSumPrice   = CHKIIF(isNull(rsget("tsum")),0,rsget("tsum"))
'	vEvtOrderCnt = 1
'	vEvtOrderSumPrice   = 1000
rsget.Close

' 현재 이벤트 본인 참여수
vQuery = "SELECT count(*) FROM [db_event].[dbo].[tbl_event_subscript] WHERE evt_code = '" & eCode & "' And userid='"&userid&"' And sub_opt3='event' "
rsget.CursorLocation = adUseClient
rsget.Open vQuery, dbget, adOpenForwardOnly, adLockReadOnly
IF Not rsget.Eof Then
	vMyThisEvtCnt = rsget(0)
End IF
rsget.close

'response.write vEvtOrderCnt&"<br>"&vEvtOrderSumPrice&"<br>"&vMyThisEvtCnt

%>
<style type="text/css">
.evt106353 {text-align:center; background:#fff url(//webimage.10x10.co.kr/eventIMG/2020/106353/bg_topic.jpg) 0 0 repeat-x;}
.evt106353 a {position:absolute; left:50%; transform:translateX(-50%); font-size:0; color:transparent;}
.evt106353 .topic {position:relative; height:1384px; background:url(//webimage.10x10.co.kr/eventIMG/2020/106353/bg_topic2.jpg?v=2) 50% 0 no-repeat; font-size:0; color:transparent;}
.evt106353 .make {padding-bottom:80px; background:#ff6443;}
.evt106353 .make .slide {width:1079px; height:716px; margin:0 auto;}
.evt106353 .slick-dots {position:absolute; left:0; bottom:35px; width:100%;}
.evt106353 .slick-dots li {padding:0 7px;}
.evt106353 .slick-dots li button {width:15px; height:15px; background:#d4d4d4; border-radius:50%;}
.evt106353 .slick-dots li.slick-active button {background:#ffd648;}
.evt106353 .gift {position:relative; background:url(//webimage.10x10.co.kr/eventIMG/2020/106353/bg1.jpg) 50% 0 repeat;}
.evt106353 .gift li {position:relative;}
.evt106353 .gift li .soldout {position:absolute; left:50%; top:215px; margin-left:-414px;}
.evt106353 .gift .g1 a {bottom:60px; width:300px; height:80px;}
.evt106353 .gift .g2 a {top:615px; width:250px; height:50px;}
.evt106353 .gift-diary {position:relative; background:url(//webimage.10x10.co.kr/eventIMG/2020/106353/bg2.jpg) 50% 0 repeat;}
.evt106353 .gift-diary a {bottom:80px; width:350px; height:80px; }
.evt106353 .noti {background:#333;}
</style>
<script>
$(function(){
    $('.evt106353 .slide').slick({
        autoplay:true,
        autoplaySpeed:900,
        speed:900,
        fade:true,
        dots:true
    });
    $(".btn-more").click(function(event){
		event.preventDefault();
		window.parent.$('html,body').animate({scrollTop:$(this.hash).offset().top}, 800);
	});
});

function jsSubmit106353(){
	<% If IsUserLoginOK() Then %>
		<% If not(left(now(),10)>="2020-10-19" and left(now(),10)<"2020-10-30") Then %>
			alert("이벤트 신청 기간이 아닙니다.");
			return false;
        <% else %>
            <% if vMyThisEvtCnt > 0 then '// 1회만 신청되기때문에 신청내역이 있으면 튕김 %>
                alert("이미 신청이 완료되었습니다.");
                return;
            <% end if %>        

			<% if vEvtOrderCnt >= 3 And vEvtOrderSumPrice >= 150000 then '// 기간내 구매횟수 3회 이상, 구매금액 15만원 이상일 경우만 응모가능 %>
				$.ajax({
					type:"GET",
					url:"/event/etc/doEventSubscript106353.asp?mode=ins",
					dataType: "text",
					async:false,
					cache:true,
					success : function(Data, textStatus, jqXHR){
						if (jqXHR.readyState == 4) {
							if (jqXHR.status == 200) {
								if(Data!="") {
									var str;
									for(var i in Data)
									{
										 if(Data.hasOwnProperty(i))
										{
											str += Data[i];
										}
									}
									res = str.split("|");
									if (res[0]=="OK")
									{
										alert("신청이 완료 되었습니다.\n마일리지는 11월 9일에 지급 될 예정입니다.");
										//document.location.reload();
										return false;
									}
									else
									{
										errorMsg = res[1].replace(">?n", "\n");
										alert(errorMsg );
										return false;
									}
								} else {
									alert("잘못된 접근 입니다.");
									//document.location.reload();
									return false;
								}
							}
						}
					},
					error:function(jqXHR, textStatus, errorThrown){
						alert("잘못된 접근 입니다.");
						var str;
						for(var i in jqXHR)
						{
							 if(jqXHR.hasOwnProperty(i))
							{
								str += jqXHR[i];
							}
						}
						//alert(str);
						document.location.reload();
						return false;
					}
				});
			<% else %>
                alert("신청조건에 맞지 않습니다.");
                return;
			<% end if %>
		<% end if %>
	<% Else %>
        if(confirm("로그인 하시겠습니까?")){
            location.href='/login/loginpage.asp?backpath=<%=Server.URLencode("/event/eventmain.asp?eventid=" & eCode)%>';
            return;
        }
	<% End IF %>
}
</script>
<style>
.evt106390 {position:relative; background:#faeae1;}
.evt106390 .topic {background:url(//webimage.10x10.co.kr/fixevent/event/2020/19th/106390/bg_topic.jpg) repeat center top;}
.evt106390 .brand-wrap {position:relative; overflow:hidden;}
.evt106390 .brand-list {position:relative; display:inline-block; width:1155px; margin:-20px 0 0 -3px; vertical-align:top;}
.evt106390 .brand-list::after {content:' '; display:block; clear:both;}
.evt106390 .brand-list li {width:228px; float:left; margin:20px 0 0 3px;}
.evt106390 .brand-item {position:relative; border-top:3px solid #fae7cc;}
.evt106390 .brand-item .per {height:35px; line-height:36px; font-size:20px; background:#ff694d; color:#fffdfa;}
.evt106390 .brand-item a {display:block; position:absolute; left:0; top:0; width:100%; height:100%;}
.evt106390 .bot {margin-top:140px; background:#fd5437;}
</style>
<%'<!-- 106353 -->%>
<div class="evt106353">
    <div class="topic">19주년 특별선물</div>
    <div class="make">
        <div class="slide">
            <div><img src="//webimage.10x10.co.kr/eventIMG/2020/106353/img_slide_1.jpg?v=2" alt=""></div>
            <div><img src="//webimage.10x10.co.kr/eventIMG/2020/106353/img_slide_2.jpg?v=2" alt=""></div>
            <div><img src="//webimage.10x10.co.kr/eventIMG/2020/106353/img_slide_3.jpg?v=2" alt=""></div>
            <div><img src="//webimage.10x10.co.kr/eventIMG/2020/106353/img_slide_4.jpg?v=2" alt=""></div>
        </div>
    </div>
    <div class="gift">
        <ul>
            <li class="g1">
                <img src="//webimage.10x10.co.kr/eventIMG/2020/106353/txt_gift_1.jpg" alt="3회 이상 구매 시 5,000P 증정">
                <a href="" onclick="jsSubmit106353();return false;">신청하기</a>
            </li>
            <li class="g2">
                <img src="//webimage.10x10.co.kr/eventIMG/2020/106353/txt_gift_2.jpg" alt="">
                <a href="#noti" class="btn-more">자세히보기</a>
                <div class="soldout"><img src="//webimage.10x10.co.kr/eventIMG/2020/106353/txt_soldout.png" alt="soldout"></div>
            </li>
        </ul>
    </div>
    <div class="gift-diary">
        <p><img src="//webimage.10x10.co.kr/eventIMG/2020/106353/img_diary_gift_v2.jpg" alt="앗! 잠깐만요 다이어리 구매하면 드리는 사은품도 있다구요!"></p>
        <a href="/diarystory2021/special_benefit.asp" onclick="window.open(this.href, 'popbenefit', 'width=800,height=800,left=300,scrollbars=auto,resizable=yes'); return false;">자세히 보기</a>
    </div>
    <div id="noti" class="noti">
        <p><img src="//webimage.10x10.co.kr/eventIMG/2020/106353/txt_noti.png" alt="유의사항"></p>
    </div>
</div>
<%'<!-- // 106353 -->%>
<!-- #include virtual="/lib/db/dbclose.asp" -->