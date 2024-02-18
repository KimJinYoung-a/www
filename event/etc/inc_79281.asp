<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/lib/inc_const.asp" -->
<!-- #include virtual="/lib/util/pageformlib.asp" -->
<!-- #include virtual="/lib/classes/item/iteminfoCls.asp" -->
<!-- #include virtual="/event/lib/event_etc_function.asp" -->
<!-- #include virtual="/event/etc/evtyouCls.asp" -->
<!-- #include virtual="/lib/util/DBcacheLib.asp" -->
<% If not(IsUserLoginOK()) Then %>
<script>
	top.location.href="/login/loginpage.asp?vType=G";
</script>
<%
Response.end
End If
%>
<%
dim eCode, userid, lp
Dim intI, oHTBCItem
dim sql, getbonuscoupon

IF application("Svr_Info") = "Dev" THEN
	eCode = "66416"
	getbonuscoupon = 2854
Else
	eCode = "79281"
	getbonuscoupon = 1000
End If
Dim logparam : logparam = "&pEtr="&eCode
userid = GetEncLoginUserID()

dim couponexistscount
	couponexistscount = getbonuscouponexistscount(userid, getbonuscoupon, "", "", "")

'dim evtyouusercnt
'	evtyouusercnt = 0
''userid = "tozzinet1"
'sql = "select count(*) as cnt"
'sql = sql & " from db_log.dbo.tbl_order_userfirstorder"
'sql = sql & " where userid = '"& userid &"'"
'sql = sql & " and isnull(secondOrderregDT,'') = ''"
''sql = sql & " and isnull(viewcount,0) = 0"
'
''response.write sql &"<Br>"
'rsget.Open sql,dbget,1
'IF Not rsget.EOF THEN
'	evtyouusercnt = rsget("cnt")
'END IF
'rsget.Close
'
'if evtyouusercnt = 0 then
'	response.write "<script>"
'	response.write "	alert('대상자가 아닙니다.');"
'	response.write "	location.replace('/')"
'	response.write "</script>"
'	dbget.close() : response.end
'end if

'//클래스 선언
set oHTBCItem = New CEvtYou
oHTBCItem.FRectUserID = userid
'// 텐바이텐 해피투게더 상품 목록
if userid<>"" then
	oHTBCItem.GetCateRightHappyTogetherList

	sql = "update db_log.dbo.tbl_order_userfirstorder set viewcount=viewcount+1 where userid = '"& userid &"' and isnull(secondOrderregDT,'') = '' and isnull(viewcount,0) = 0"
	dbget.execute sql
end if

lp=0
%>
<style type="text/css">
.evt79281 {background-color:#fff;}
.evt79281 .btnCoupon {position:absolute; top:317px; left:50%; margin-left:370px; background-color:transparent;}

.youHead {height:400px; background-color:#b1b1f5; background-image:url(http://webimage.10x10.co.kr/eventIMG/2017/79281/bg_purple.jpg); background-position:50% 0; background-repeat:no-repeat;}
.youHead h2 {padding:140px 0 83px;}
.youHead .rcmBox {width:620px; height:30px; padding-top:40px; margin:0 auto; background-color:#fff;}
.youHead .rcmBox .userId {position:relative; padding:0 5px 1px; margin-left:2px; font-size:20px; line-height:16px; font-weight:bold; border-bottom:solid 1px #000;}
.youHead .rcmBox .userId:before {position:absolute; top:4px; left:-21px; width:16px; height:13px; content:' '; background-image:url(http://webimage.10x10.co.kr/eventIMG/2017/79281/img_heart.png);}
.prdList {overflow:hidden; width:1120px; margin:0 auto; padding-top:45px; margin-bottom:135px;}
.prdList li {float:left; margin:40px 20px 0; padding:38px; border:solid 2px #ebedec;}
.prdList li .prdImg {width:240px; height:240px;}
.prdList li .prdImg img{width:100%; height:100%;}
.prdList li .prdInfo {width:240px; margin-top:30px; font-size:11px; line-height:11px; font-weight:bold;}
.prdList li .prdInfo .brand a {color:#888; text-decoration:underline; font-weight:normal;}
.prdList li .prdInfo .name a {overflow:hidden; display:-webkit-box; display:inline-block; width:200px; height:35px; margin:11px auto 10px; word-wrap:break-word; text-overflow:ellipsis; color:#000; line-height:19px; -webkit-line-clamp:2; -webkit-box-orient: vertical; letter-spacing:1px;}
.prdList li .prdInfo .price {color:#ef3535;}

.noPage {position:absolute; left:50%; margin-left:-570px;}
.noPage.no1 {top:0;}
.noPage.no2 {bottom:-60px; margin-left:280px;}
.noPage a {display:inline-block; position:relative; width:200px; height:30px; padding-left:20px; color:#fff; font-size:11px; line-height:30px; border:solid 1px #555555; background-color:#555555;}
.noPage a:before{content:' '; display:inline-block; position:absolute; top:9px; left:18px; width:11px; height:11px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2017/79281/btn_closed.jpg);}

.coupon {position:relative; padding:55px 0; background:url(http://webimage.10x10.co.kr/eventIMG/2017/79281/bg_black.jpg) repeat-x 50% 0;}
.coupon a {display:inline-block; position:absolute; top:50px; left:50%; width:300px; height:160px; margin-left:105px; text-indent:-99em;}
</style>
<script type="text/javascript">
function jsevtDownCoupon(stype,idx){
	<% If IsUserLoginOK() Then %>
		<% If now() > #09/30/2017 23:59:59# then %>
			alert("쿠폰 다운로드 기간이 지났습니다.");
			return;
		<% elseif couponexistscount <> 0 then %>
			alert("이미 쿠폰을 다운받으셨습니다.");
			return;
		<% else %>
			var str = $.ajax({
				type: "POST",
				url: "/event/etc/coupon/couponshop_process.asp",
				data: "mode=cpok&stype="+stype+"&idx="+idx,
				dataType: "text",
				async: false
			}).responseText;
			var str1 = str.split("||")
			if (str1[0] == "11"){
				alert('쿠폰이 발급 되었습니다.\n오늘 하루 텐바이텐에서 사용하세요!');
				return false;
			}else if (str1[0] == "12"){
				alert('기간이 종료되었거나 유효하지 않은 쿠폰입니다.');
				return false;
			}else if (str1[0] == "13"){
				alert('이미 다운로드 받으셨습니다.');
				return false;
			}else if (str1[0] == "02"){
				alert('로그인 후 쿠폰을 받을 수 있습니다!');
				return false;
			}else if (str1[0] == "01"){
				alert('잘못된 접속입니다.');
				return false;
			}else if (str1[0] == "00"){
				alert('정상적인 경로가 아닙니다.');
				return false;
			}else{
				alert('오류가 발생했습니다.');
				return false;
			}
		<% end if %>
	<% Else %>
		if(confirm("로그인 후 쿠폰을 받을 수 있습니다!")){
			top.location.href="/login/loginpage.asp?vType=G";
			return false;
		}
		return false;
	<% End IF %>
}
</script>
<div class="evt79281">
	<div class="youHead">
		<h2><img src="http://webimage.10x10.co.kr/eventIMG/2017/79281/tit_you.png" alt="You" /></h2>
		<div class="rcmBox">
			<span class="userId"><%=GetLoginUserName()%></span>
			<span><img src="http://webimage.10x10.co.kr/eventIMG/2017/79281/txt_how_about.png" alt="님 이런 상품은 어떠세요?" /></span>
		</div>

		<a class="btnCoupon" href="#coupon"><img src="http://webimage.10x10.co.kr/eventIMG/2017/79281/btn_go_coupnon.png" alt="쿠폰을 확인해 보세요" /></a>
	</div>
	<% IF oHTBCItem.FResultCount > 0 Then %>
	<ul class="prdList">
		<% For lp =0 To oHTBCItem.FResultCount-1 %>
		<li>
			<div class="prdImg"><a href="/shopping/category_prd.asp?itemid=<%=oHTBCItem.FItemList(lp).FItemID %><%=logparam%>"><img src="<%=oHTBCItem.FItemList(lp).Ftentenimage400%>" alt="" /></a></div>
			<div class="prdInfo">
				<p class="brand"><a href="/street/street_brand.asp?makerid=<%=oHTBCItem.FItemList(lp).FMakerId %>"><%=oHTBCItem.FItemList(lp).FBrandName %></a></p>
				<p class="name"><a href="/shopping/category_prd.asp?itemid=<%=oHTBCItem.FItemList(lp).FItemID %><%=logparam%>"><%=oHTBCItem.FItemList(lp).FItemName%></a></p>
				<p class="price"><% = FormatNumber(oHTBCItem.FItemList(lp).getRealPrice,0) %>원
				<% IF oHTBCItem.FItemList(lp).IsSaleItem Then %>
					<span class="sale">[<% = oHTBCItem.FItemList(lp).getSalePro %>]</span>
				<% End If %>
				</p>
			</div>
		</li>
		<% Next %>
	</ul>
	<% End If %>

	<div class="coupon" id="coupon">
		<img src="http://webimage.10x10.co.kr/eventIMG/2017/79281/img_coupon.png" alt="쿠폰 다운받기" />
		<a href="" onclick="jsevtDownCoupon('evttosel','<%= getbonuscoupon %>'); return false;"></a>
	</div>
	<!--<span class="noPage no2"><a href="">이벤트 페이지 그만 보기</a></span>-->
</div>
<%
Set oHTBCItem = Nothing
%>
<!-- #include virtual="/lib/db/dbclose.asp" -->