<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
Response.AddHeader "Cache-Control","no-cache"
Response.AddHeader "Expires","0"
Response.AddHeader "Pragma","no-cache"
%>
<!-- #include virtual="/login/checkBaguniLogin.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/db/dbhelper.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/lib/classes/shopping/sp_itemcouponcls.asp" -->
<!-- #include virtual="/lib/classes/shopping/sp_couponcls.asp" -->
<!-- #include virtual="/lib/classes/membercls/sp_pointcls.asp" -->
<!-- #include virtual="/lib/classes/shopping/sp_mileageshopitemcls.asp" -->
<!-- #include virtual="/lib/classes/membercls/sp_userinfocls.asp" -->
<!-- #include virtual="/lib/classes/ordercls/shoppingbagDBcls.asp" -->
<!-- #include virtual="/lib/classes/ordercls/emscls.asp" -->
<!-- #include virtual="/lib/classes/ordercls/frontGiftCls.asp" -->
<!-- #include virtual="/lib/classes/membercls/sp_tenCashCls.asp" -->
<!-- #include virtual="/lib/classes/item/ticketItemCls.asp" -->
<!-- #include virtual="/lib/classes/giftcard/giftcard_MyCardInfoCls.asp" -->
<%
strPageTitle = "텐바이텐 10X10 : 주문결제"		'페이지 타이틀 (필수)
%>
<!-- #include virtual="/lib/inc/head_SSL.asp" -->
<%

%>
<style type="text/css">
.cartWrap {background:#eee url(/fiximage/web2013/cart/cart_headbg.gif) left top repeat-x; padding:25px 20px 60px 20px;}
.cartHeader {overflow:hidden;}
.orderStep {float:left; width:660px; padding-top:24px;}
.orderStep span {float:left; padding:0 36px; width:148px; height:91px; text-indent:-9999px; overflow:hidden; background-position:center top; background-repeat:no-repeat;}
.orderStep span.step01SSL {background-image:url(/fiximage/web2013/cart/order_step01.gif);}
.orderStep span.step02SSL {background-image:url(/fiximage/web2013/cart/order_step02.gif);}
.orderStep span.step03SSL {background-image:url(/fiximage/web2013/cart/order_step03.gif);}
.orderStep h2 span {background-position:center -91px;}

.btnGrylightNone {color:#555; background:#f4f4f4; border:1px solid #e0e0e0;}
.rmvIEx::-ms-clear {display: none;}
</style>
</head>
<body>
<div class="wrap">
    <!-- #include virtual="/lib/inc/incHeader_SSL.asp" -->
	<div class="container">
<!-- #include virtual="/lib/inc/incFooter_SSL.asp" -->
    </div>
</div>
<script type="text/javascript" src="https://plugin.inicis.com/pay61_unissl_cross.js"></script>
<script type="text/javascript">
StartSmartUpdate();
</script>

<!-- #include virtual="/lib/db/dbclose.asp" -->