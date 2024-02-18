<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
Response.AddHeader "Cache-Control","no-cache"
Response.AddHeader "Expires","0"
Response.AddHeader "Pragma","no-cache"
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="Cache-Control" content="no-cache"/>
<meta http-equiv="Expires" content="0"/>
<meta http-equiv="Pragma" content="no-cache"/>
<title>텐바이텐 휴대폰결제</title>
<base target="_self"></base>
</head>
<body><!-- step1을 없애려 했으나, step2가 페이지 로딩될때 opener의 값을 스크립트로 받기전에 LGDacom과 한번의 통신으로 해쉬 암호화를 지정하기 때문에 어쩔수 없이 step1을 만들었음. -->
<form name="frm1" method="post" action="payreq_crossplatform.asp" >
<input type="hidden" name="LGD_BUYER" value="">                      <!-- 구매자 -->
<input type="hidden" name="LGD_PRODUCTINFO" value="">                <!-- 상품정보 -->
<input type="hidden" name="LGD_AMOUNT" value="">                     <!-- 결제금액 -->
<input type="hidden" name="LGD_BUYEREMAIL" value="">                 <!-- 구매자 이메일 -->
<input type="hidden" name="LGD_BUYERPHONE" value="">                 <!-- 구매자 휴대폰 -->
<input type="hidden" name="isAx" value="<%=request("isAx")%>">
</form>
<script language="javascript">
<% if (request("isAx")="D") then %>
document.frm1.LGD_BUYER.value = window.dialogArguments["buyname"];
document.frm1.LGD_PRODUCTINFO.value = window.dialogArguments["mobileprdtnm"];
document.frm1.LGD_AMOUNT.value = window.dialogArguments["mobileprdprice"];
document.frm1.LGD_BUYEREMAIL.value = window.dialogArguments["buyemail"];
document.frm1.LGD_BUYERPHONE.value = window.dialogArguments["buyhp"];
document.frm1.submit();
<% else %>
document.frm1.LGD_BUYER.value = parent.document.frmorder.buyname.value;
document.frm1.LGD_PRODUCTINFO.value = parent.document.frmorder.mobileprdtnm.value;
document.frm1.LGD_AMOUNT.value = parent.document.frmorder.mobileprdprice.value;
document.frm1.LGD_BUYEREMAIL.value = parent.document.frmorder.buyemail.value;
document.frm1.LGD_BUYERPHONE.value = parent.document.frmorder.buyhp1.value + "" + parent.document.frmorder.buyhp2.value + "" + parent.document.frmorder.buyhp3.value;
document.frm1.submit();
<% end if %>
</script>
</body>
</html>