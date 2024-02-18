<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
Response.AddHeader "Cache-Control","no-cache"
Response.AddHeader "Expires","0"
Response.AddHeader "Pragma","no-cache"

strPageTitle = "텐바이텐 10X10 : 쿠폰다운받기"		'페이지 타이틀 (필수)
%>
<!-- #include virtual="/login/checkpoplogin.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/inc/head.asp" -->
<!-- #include virtual="/lib/classes/shopping/sp_itemcouponcls.asp" -->
<%
dim itemcouponidx, prload
dim itemid, i
itemcouponidx = requestCheckVar(request("itemcouponidx"),10)
itemid = requestCheckVar(request("itemid"),10)
prload = request("prload")

if itemcouponidx="" then itemcouponidx=0

dim oitemcoupon
set oitemcoupon = new CItemCouponMaster
oitemcoupon.FRectItemCouponIdx = itemcouponidx

oitemcoupon.GetOneItemCouponMaster


if (Not oitemcoupon.FOneItem.IsOpenAvailCoupon) then
	response.write "<script>alert('기간이 종료되었거나 유효하지 않은 쿠폰입니다.');self.close();</script>"
	response.end
end if

Dim IsSSL, iFiximageURL
IsSSL = (request.ServerVariables("SERVER_PORT_SECURE")="1")
if (IsSSL) then
	iFiximageURL = "/fiximage"
else
	iFiximageURL = "http://fiximage.10x10.co.kr"
end if
%>
<link rel="stylesheet" type="text/css" href="/lib/css/preVst/popup.css" />
<link rel="stylesheet" type="text/css" href="/lib/css/popup.css" />
<script type='text/javascript'>
//팝업 리사이즈 (+20,50)
resizeTo(490,590);

function CouponDownload(){
	document.couponFrm.submit();
}
</script>
</head>
<body>
<% if CStr(oitemcoupon.FOneItem.Fitemcouponidx) = CStr(itemcouponidx) then %>
<div class="heightgird">
	<div class="popWrap">
		<div class="popHeader">
			<h1><img src="http://fiximage.10x10.co.kr/web2013/common/tit_coupon_download.gif" alt="쿠폰다운받기" /></h1>
		</div>
		<div class="popContent">
			<!-- content -->
			<!-- 쿠폰 -->
			<div class="coupArea">
				<div class="couponBox sizeTye01">
					<div class="box">
						<div class="title">
							<span class="tag green">
							<%
								if oitemcoupon.FOneItem.IsFreeBeasongCoupon then
									Response.Write "<img src=""" & iFiximageURL & "/web2013/common/cp_green_freeship.png"">"
								else
									dim tmpNum
									tmpNum = formatNumber(oitemcoupon.FOneItem.Fitemcouponvalue,0)
									for i=1 to len(tmpNum)
										Response.Write "<img src=""" & iFiximageURL & "/web2013/common/cp_green_num" & chkIIF(mid(tmpNum,i,1)=",","_comma",Num2Str(mid(tmpNum,i,1),2,"0","R")) & ".png"" alt=""" & chkIIF(mid(tmpNum,i,1)=",","comma",mid(tmpNum,i,1)) & """ />" & vbCrLf
									next
									if oitemcoupon.FOneItem.Fitemcouponvalue<100 then
										Response.Write "<img src=""" & iFiximageURL & "/web2013/common/cp_green_num_per.png"" alt=""Percent"" />"
									else
										Response.Write "<img src=""" & iFiximageURL & "/web2013/common/cp_green_num_won.png"" alt=""원"" />"
									end if
								end if
							%>
							</span>
						</div>
						<div class="account">
							<ul>
								<li class="name"><%= oitemcoupon.FOneItem.Fitemcouponname %></li>
								<% if Not(IsNULL(oitemcoupon.FOneItem.Fitemcouponexplain) or (oitemcoupon.FOneItem.Fitemcouponexplain="")) then %>
								<li class="desc"><%= oitemcoupon.FOneItem.Fitemcouponexplain %></li>
								<% end if %>
								<% if (oitemcoupon.FOneItem.IsNaverCoupon) then %>
								<li class="date"><%= formatDate(oitemcoupon.FOneItem.Fitemcouponstartdate,"0000.00.00") & " ~ " & formatDate(oitemcoupon.FOneItem.GetNaverItemcouponexpiredate,"0000.00.00 00:00:00") %></li>
								<% else %>
								<li class="date"><%= formatDate(oitemcoupon.FOneItem.Fitemcouponstartdate,"0000.00.00") & " ~ " & formatDate(oitemcoupon.FOneItem.Fitemcouponexpiredate,"0000.00.00") %></li>
								<% end if %>
							</ul>
						</div>
					</div>
				</div>

				<div class="btnArea ct tMar20 bPad10">
					<a href="" onclick="CouponDownload('<%= oitemcoupon.FOneItem.Fitemcouponidx %>');return false;" class="btn btnRed btnM2 btnW160"><span class="btnDownload">다운받기</span></a>
				</div>
			</div>
			<!-- //쿠폰 -->

			<div class="tMar25">
				<h2 class="cr000">사용 시 유의사항</h2>
				<ul class="list01 tMar07">
					<li>발행된 쿠폰은 [마이텐바이텐]에서 확인하실 수 있습니다.</li>
					<li>각 쿠폰은 한 번씩만 다운 받으실 수 있습니다. (사용후 재발행 가능)</li>
					<li>각 쿠폰은 할인되는 해당 상품이 있습니다.</li>
					<li>일부 상품은 기간 전에 종료될 수 있습니다.</li>
				</ul>
			</div>
			
			<!-- //content -->
		</div>
	</div>
	<div class="popFooter">
		<div class="btnArea">
			<button type="button" class="btn btnS1 btnGry2" onclick="window.close();">닫기</button>
		</div>
	</div>
</div>
<form name="couponFrm" method="post" action="/my10x10/downloaditemcoupon_process.asp">
<input type="hidden" name="itemcouponidx" value="<%= oitemcoupon.FOneItem.Fitemcouponidx %>">
<input type="hidden" name="prload" value="<%= prload %>">
</form>
<% end if %>
</body>
</html>
<%
set oitemcoupon = Nothing
%>
<!-- #include virtual="/lib/db/dbclose.asp" -->