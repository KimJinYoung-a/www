<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/shopping/fuji/clsFujiShop.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<%
'### 편집기 실행 페이지 ###
'본 페이지는 기본적인 샘플페이지이며, 실제와는 약간 다름니다.
Dim itemid, itemoption, itemea
Dim pcode, tplcode
Dim orderserial, didx, orgfile, tplname

''dim tplpath, strDomain

orderserial    = RequestCheckvar(request("orderserial"),11)       '장바구니 담기인지 수정인지
didx        = RequestCheckvar(request("didx"),11)
itemid  = RequestCheckvar(request("itemid"),10)
itemoption = RequestCheckvar(request("itemoption"),4)
itemea  = RequestCheckvar(request("itemea"),10)     '갯수
orgfile = RequestCheckvar(request("orgfile"),100)    '기존 편집 파일명.

if itemid = "" or itemoption = "" then response.Write "코드가 정의 되지 않았습니다." : response.End

Call getFujiCode(itemid,itemoption,pcode, tplcode, tplname)

''pcode   '제품코드
''tplcode '템플릿코드

if pcode = "" or tplcode = "" then response.Write "템플릿 코드가 정의 되지 않았습니다." : response.End

''strDomain = "http://ten.pixo.co.kr"

'템플릿 코드에 따라 호출할 템플릿 지정  //  http://info.photolooks.kr 에서 코드..
''pcode에 따라 템플릿이 지정될 수 있을듯 합니다. tplcode 필요한지 여부 확인요망 : 상품별,사이즈별로 템플릿이 달라진다면 pcode로 템플릿 결정.
''후지필름 상품코드
''550000094   포토북 5x5
''550000001   포토북 6x6
''550000002   포토북 8x8
''550000095   포토북 10x10
''550000186   캐릭터 포토북 6x6
''550000187   캐릭터 포토북 8x8
''550000034   탁상용 캘린더 6x8
''550000195   캐릭터 캘린더 6x10

Dim cFShop '포토룩스 연동을 위한 클래스 파일
Set cFShop = new clsFujiShop '객체 생성

''    if (orgfile<>"") then
''        tplpath = strDomain & "/orderfile/"&orgfile
''    else
      ''if (orgfile<>"") then
      ''  Call  cFShop.RequsetTemplate(tplcode,pcode, "")
      ''else
        Call  cFShop.RequsetTemplate(tplcode,pcode, orgfile) '정보값 가져오기 ''Call  cFShop.RequsetTemplate(265,"550000094", "")
      ''end if
        '처리된 결과 값이 에러인 경우 처리하세요.
        If cFShop.ErrCode <> "0" Then
        	response.write "ERR="&cFShop.ErrMsg
        	response.end
        End If


        ''tplpath = cFShop.DocPath
''    end if

'저장될 파일명 (유일 하게 처리)
'' 기존방식 strSaveFileName = tplname & "_" & application("Svr_Info") & "_p" & pcode & "_t"& tplcode & "_"& replace(date(), "-", "") & "_" & replace(timer(), ".", "") & ".mpd"


%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>포토룩스 - 상품편집</title>
<style type="text/css">
body { margin-left: 0px; margin-top: 0px; margin-right: 0px; margin-bottom: 0px;}
</style>
<script language="javascript">
//저장되는 파일명 검증 코드
function SafetyFileName(fn){
	var fname = fn.replace(/[\*]/g, "x");
	fname = fname.replace(/ /g, "");
	fname = fname.replace(/[\\\/\"\'\?\:\<\>\|]/g, "");
	return fname;
}

function photoLooks_load(){

	//장바구니에 저장할 폼
	//document.frmCart.ordfile.value = svfile;

	var str = "";
	str += '<object classid="clsid:<%=cFShop.AXCls%>" codebase="<%=cFShop.AXPath%>" width="100%" height="100%" id="PhotoLooksX" align="center" hspace="0" vspace="0">\n';
	str += '<param name="Vendor" value="PhotoLooks">\n';
	str += '<param name="UIType" value="Fancy">\n';
    str += '<param name="WorkStyle" value="Embed">\n';
    str += '<param name="URL_Doc" value="<%=cFShop.DocPath%>">\n';
	str += '<param name="URL_Upload" value="<%=cFShop.UpPath & "?" & cFShop.UpFileName %>">\n'; //업로드 처리 경로와 저장될 파일명을 지정, ? 로 구분
	str += '</object>';
	document.getElementById("ax").innerHTML = str;
	document.getElementById("bkimg").style.display = "block";
}
</script>
<script language="javascript" FOR="PhotoLooksX" EVENT="OnInitialized">
//ActiveX 설치후 또는 실행후 로딩시 발생되는 초기화 이벤트
document.getElementById("bkimg").style.display = "none"; //안내 이미지를 숨기고
document.getElementById("ax").style.display = "block"; //엑티브엑스를 보여준다
</script>

<script language="javascript" FOR="PhotoLooksX" EVENT="OnUpload">
//파일 업로드후 발생되는 이벤트
document.frmCart.submit();
</script>
</head>
<body>
<div id="bkimg" align="center" style="z-index:10;">
<img src="intro.gif" width="950" height="606" border="0" usemap="#Map" />
<map name="Map"id="Map"><area shape="rect" coords="394,480,544,541" href="javascript:location.reload();" /></map>
</div>
<div id="ax" style="z-index:1;display:none;width:100%;height:100%;left:0px;top:0px;position:absolute;"></div>
<% if (orderserial<>"") then %>
<form name="frmCart" id="frmCart" method="post" action="/inipay/fuji/photofileedit.asp">
<input type="hidden" name="pcode" value="<%=pcode%>"><!-- 제품 코드 -->
<input type="hidden" name="tplcode" value="<%=tplcode%>"><!-- 템플릿번호 -->
<input type="hidden" name="ordfile" value="<%= cFShop.UpFileName %>"><!-- 저장되는 파일명(유일하게 처리) -->
<input type="hidden" name="itemid" value="<%= itemid %>">
<input type="hidden" name="itemoption" value="<%= itemoption %>">
<input type="hidden" name="orderserial" value="<%= orderserial %>">
<input type="hidden" name="didx" value="<%= didx %>">

</form>
<% else %>
<form name="frmCart" id="frmCart" method="post" action="/inipay/fuji/cart_save.asp">
<input type="hidden" name="pcode" value="<%=pcode%>"><!-- 제품 코드 -->
<input type="hidden" name="tplcode" value="<%=tplcode%>"><!-- 템플릿번호 -->
<input type="hidden" name="ordfile" value="<%= cFShop.UpFileName %>"><!-- 저장되는 파일명(유일하게 처리) -->
<input type="hidden" name="itemid" value="<%= itemid %>">
<input type="hidden" name="itemoption" value="<%= itemoption %>">
<input type="hidden" name="itemea" value="<%=itemea%>"><!-- 상품갯수 -->

</form>
<% end if %>
<%
Set cFShop = Nothing
%>
<script language="javascript">photoLooks_load();</script>
<!-- * 소스보기를 위한 영역입니다.  -->
<%
 'response.write "cFShop.DocPath="&cFShop.DocPath
 'response.write "cFShop.UpFileName="&cFShop.UpFileName
%>
</body>
</html>
<!-- #include virtual="/lib/db/dbclose.asp" -->