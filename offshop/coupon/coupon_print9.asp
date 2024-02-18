<%@ codepage="65001" language="VBScript" %>
<%
'#######################################################
'	History	:  2014.07.24 허진원 생성
'	Description : 명동 눈스퀘어 팝업스토어 쿠폰프린트
'#######################################################
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>명동 팝업스토어 스페셜쿠폰 인쇄</title>
<script type="text/javascript">
	function jsOnLoad(){
		window.print();
	}
</script>
</head>
<body onLoad="jsOnLoad();" style="margin:0;padding:0;">
<table width="100%" border="0" cellpadding="0" cellspacing="0">
  <tr>
  	<td><img src="http://webimage.10x10.co.kr/eventIMG/2014/53787/53787_noon_special_coupon.jpg" border="0" onclick="self.close();" alt="명동팝업스토어 할인쿠폰" title="창을 닫습니다" style="cursor:pointer;"" /></td>
  </tr>
</table>
</body>
</html>