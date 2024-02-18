<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include virtual="/login/checkPopLogin.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/db/dbhelper.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/classes/ordercls/frontGiftCls.asp" -->
<!-- #include virtual="/lib/inc/head_SSL.asp" -->
<%
strPageTitle = "텐바이텐 10X10 : 사은품 상세 이미지 보기"		'페이지 타이틀 (필수)

Dim gKCode : gKCode = RequestCheckVar(request("gKCode"),10)
Dim gCode  : gCode  = RequestCheckVar(request("gCode"),10)

Dim oGiftInfo
set oGiftInfo = new CopenGift
oGiftInfo.getOneGiftInfo(gCode)

Dim oOpenGift, i
Set oOpenGift = new CopenGift
oOpenGift.FRectGiftKindCode = gKCode
oOpenGift.getGiftKindItemAddImage



%>


	<link rel="stylesheet" type="text/css" href="/lib/css/preVst/popup.css" />
	<link rel="stylesheet" type="text/css" href="/lib/css/popupV15.css" />
	<script type="text/javascript">
	$(function() {
		$('.pdtThumbList li a').click(function(){
			$('.pdtThumbList li').removeClass('current');
			$(this).parent().addClass('current');
			var imgSrc= $(this).attr("href");
			var imgAlt= $(this).find("img").attr("alt");
			$(".pdtPhotoBox > img").attr("src", imgSrc);
			$(".pdtPhotoBox > img").attr("alt", imgAlt);
		});
	});
	</script>
</head>
<body>
	<div class="heightgird">
		<div class="popWrap">
			<div class="popHeader">
				<h1><img src="/fiximage/web2013/inipay/tit_freebie_image_view.gif" alt="사은품 상세 이미지 보기" /></h1>
			</div>
			<div class="popContent">
				<% if (oGiftInfo.FResultCount>0) then %>
				<div class="pdtPhotoWrap">
					<p>&lt;<%= oGiftInfo.FOneItem.getRangeName%> 선택 가능 사은품&gt;</p>
					<h2><%= oGiftInfo.FOneItem.Fgiftkind_name%></h2>
                    <% if (oOpenGift.FResultCount>0) then %>
					<p class="pdtPhotoBox"><img src="<%= oOpenGift.FItemList(i).Fgift_kind_addimage %>" alt="<%= oGiftInfo.FOneItem.Fgiftkind_name%>01" width="400px" height="400px" /></p>
					<ul class="pdtThumbList">
					    <% for i=0 to oOpenGift.FResultCount-1 %>
					    <% if i=0 then %>
						<li class="current"><a href="<%= oOpenGift.FItemList(i).Fgift_kind_addimage %>" onclick="return false;" target="_blank"><img src="<%= oOpenGift.FItemList(i).Fgift_kind_addimage %>" alt="<%= oGiftInfo.FOneItem.Fgiftkind_name%>01" width="38px" height="38px" /><span></span></a></li>
						<% else %>
						<li><a href="<%= oOpenGift.FItemList(i).Fgift_kind_addimage %>" onclick="return false;" target="_blank"><img src="<%= oOpenGift.FItemList(i).Fgift_kind_addimage %>" alt="<%= oGiftInfo.FOneItem.Fgiftkind_name%>0<%=i%>" width="38px" height="38px" /><span></span></a></li>
						<% end if %>
						<% next %>
					</ul>
					<% end if %>
				</div>
				<% end if %>
			</div>
		</div>
		<div class="popFooter">
			<div class="btnArea">
				<button type="button" class="btn btnS1 btnGry2" onclick="window.close();">닫기</button>
			</div>
		</div>
	</div>
</body>
</html>
<%
set oGiftInfo = Nothing
Set oOpenGift = Nothing
%>
<!-- #include virtual="/lib/db/dbclose.asp" -->