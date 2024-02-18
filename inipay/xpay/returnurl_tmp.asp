<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
Response.AddHeader "Cache-Control","no-cache"
Response.AddHeader "Expires","0"
Response.AddHeader "Pragma","no-cache"

'Dim payReqMap
'Set payReqMap = Session.Contents("PAYREQ_MAP")
'
'  'payreq_crossplatform.asp 에서 세션에 저장했던 파라미터 값이 유효한지 체크
'  '세션 유지 시간(로그인 유지시간)을 적당히 유지 하거나 세션을 사용하지 않는 경우 DB처리 하시기 바랍니다.
'	if IsNull(payReqMap)then
'		response.write "세션이 만료 되었거나 유효하지 않은 요청 입니다."
'		response.end
'	end if

%>
<HTML>
<HEAD>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<script type="text/javascript">
		function setLGDResult() {
			if(document.getElementById('LGD_RESPCODE').value == '0000' ){
			    var fdo = opener.document.frmorder;

			    if (fdo.itemcouponOrsailcoupon[1].checked){
    			    fdo.checkitemcouponlist.value = opener.document.frmorder.availitemcouponlist.value;
    			}else{
    			    fdo.checkitemcouponlist.value = "";
    			}

    			//setEnableComp();
    			fdo.LGD_OID.value = document.getElementById('LGD_OID').value;
		        fdo.LGD_PAYKEY.value = document.getElementById('LGD_PAYKEY').value;
    			fdo.target = "";
    			fdo.price.value = document.getElementById('LGD_AMOUNT').value; 
    			fdo.action = "/inipay/xpay/ordertemp_DacomResult.asp";
    			fdo.submit();
    			window.close();
    		} else {
                //setEnableComp();
                alert("인증이 실패하였습니다. " + document.getElementById('LGD_RESPMSG').value);
                opener.HidePopLayerDcom();
                //window.close();
                //opener.document.getElementById("LGD_PAYMENTWINDOW_TOP").style.display = "none";
                //opener.HidePopLayerDcom();
                /*
                 * 인증실패 화면 처리
                */

    		}
		}

	</script>

</HEAD>

<body onload="setLGDResult()">
<form name="frmord">
<%
Dim i
    ''주석처리하면 안됨.
	For Each i In Request.Form
        Response.Write "<input type=hidden id=" & i & " " & "value='" & Request.Form(i)  & "' >"
  	Next
%>
</form>
</BODY>
</HTML>
