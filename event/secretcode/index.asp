<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.charset = "UTF-8" %>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/lib/inc/head.asp" -->
<!-- #include virtual="/lib/classes/enjoy/eventCls.asp" -->
<!-- #include virtual="/lib/classes/membercls/sp_myfavoriteEventCls.asp" -->
<%
Dim eCode, secretcode, strSql,userid, mysum
userid = GetencLoginUserID

secretcode="CAMPING"

IF application("Svr_Info") = "Dev" THEN
	eCode   =  65945
Else
	eCode   =  67200
End If

	if IsUserLoginOK then
		strSql = "select count(*) from db_event.dbo.tbl_event_subscript where evt_code='" & eCode & "' and userid='" & userid & "'"

		rsget.Open strsql,dbget,1
		mysum = rsget(0)
		rsget.Close

		if mysum <> 0 then
			response.write "<script>location.replace('/event/secretcode/secretsale_67200.asp');</script>"
			dbget.close()	:	response.End
		End If
	end if

%>

<script language="javascript">
<!--
	function jsSubmitComment(frm){
		<% if Not(IsUserLoginOK) then %>
			if(confirm("로그인을 하셔야 참여가 가능 합니다. 로그인 하시겠습니까?")){
				var winLogin = window.open('/login/PopLoginPage.asp','popLogin','width=400,height=300');
				winLogin.focus();
				return false;
			}
			return false;
		<% end if %>

	   if(!frm.txtcomm.value||frm.txtcomm.value=="시크릿코드를 입력해주세요."){
	    alert("시크릿코드를 입력해주세요.");
	    document.frmcom.txtcomm.value="";
	    frm.txtcomm.focus();
	    return false;
	   }

		if(frm.txtcomm.value==frm.secretcode.value){
			frm.action = "/event/secretcode/secretsale_67200.asp";
	 	 	return true;
		} else {
		    alert("시크릿코드가 일치하지 않습니다.");
		    document.frmcom.txtcomm.value="";
		    frm.txtcomm.focus();
		    return false;
		}

	}

	function jsChklogin11(blnLogin)
	{
		if (blnLogin == "True"){
			if(document.frmcom.txtcomm.value =="시크릿코드를 입력해주세요."){
				document.frmcom.txtcomm.value="";
			}
			return true;
		} else {
			jsChklogin('<%=IsUserLoginOK%>');
		}

		return false;
	}

	function jsChkUnblur()
	{

		if(document.frmcom.txtcomm.value ==""){
			document.frmcom.txtcomm.value="시크릿코드를 입력해주세요.";
		}
	}
//-->
</script>
<style type="text/css">
.secret1109 {position:relative;}
.secret1109 img {vertical-align:top;}
.secret1109 .enterCode {padding-bottom:60px; text-align:center; background:url(http://webimage.10x10.co.kr/eventIMG/2015/secret/20151109/bg_stripe.gif) 0 0 repeat;}
.secret1109 .enterCode .inpCode {display:inline-block; margin:0 7px 0 5px; width:330px; height:45px; line-height:45px; font-size:15px; text-align:center; font-weight:bold; color:#999; border:0; background:#fff;}
.secret1109 .enterCode .tip {padding-top:25px;}
</style>
</head>
<body>

<div id="eventDetailV15" class="wrap">
	<!-- #include virtual="/lib/inc/incHeader.asp" -->
	<div class="container">
		<div id="contentWrap">
			<div class="eventWrapV15">
				<div class="eventContV15 tMar15">
					<div class="contF">
					<form name="frmcom" method="post" onSubmit="return jsSubmitComment(this);" style="margin:0px;">
					<input type="hidden" name="secretcode" value="<%=secretcode%>">
					<input type="hidden" name="userid" value="<%=GetLoginUserID%>">
					<input type="hidden" name="chk" value="o">
						<div class="secret1109">
							<h2><img src="http://webimage.10x10.co.kr/eventIMG/2015/secret/20151109/img_secret_intro.jpg" alt="쉿! 당신만을 위한 특별한 할인이 시작됩니다. SECRET SALE" /></h2>
							<div class="enterCode">
								<div>
									<img src="http://webimage.10x10.co.kr/eventIMG/2015/secret/20151109/txt_code_is.png" alt="SECRET CODE IS" />
									<input type="text" class="inpCode" id="sCode" name="txtcomm" onClick="jsChklogin11('<%=IsUserLoginOK%>');" onblur="jsChkUnblur();this.value=this.value.toUpperCase();" onKeyUp="jsChklogin11('<%=IsUserLoginOK%>');this.value=this.value.toUpperCase();" onKeyDown="this.value=this.value.replace(' ','');" <%IF NOT IsUserLoginOK THEN%>readonly<%END IF%>  value="시크릿코드를 입력해주세요." autocomplete="off" />
									<input type="image" src="http://webimage.10x10.co.kr/eventIMG/2015/secret/20151109/btn_enter.gif" alt="확인" />
								</div>
								<p class="tip"><img src="http://webimage.10x10.co.kr/eventIMG/2015/secret/20151109/txt_tip.png" alt="SECRET SALE를 입력하셔야만 입장이 가능합니다." /></p>
							</div>
						</div>
						<!--// 시크릿 세일(20151109) -->
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- #include virtual="/lib/inc/incFooter.asp" -->
</div>
</body>
</html>
<!-- #include virtual="/lib/db/dbclose.asp" -->