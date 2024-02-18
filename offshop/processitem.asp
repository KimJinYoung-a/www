<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
Response.AddHeader "Cache-Control","no-cache"
Response.AddHeader "Expires","0"
Response.AddHeader "Pragma","no-cache"
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<%
dim itemid
dim sql,Tcnt
dim Fitemname,Fsellcash,Fmakerid,Fsocname_kor,IsSoldOut

itemid = requestCheckVar(request("itemid"),10)

    '상품정보 가져오기
	sql = "select top 1 i.itemname,i.sellyn, i.limityn, i.limitno, i.limitsold" + vbcrlf
	sql = sql + " from  [db_item].[dbo].tbl_item i" + vbCrlf
	sql = sql + " where i.itemid = '" + Cstr(itemid) + "'" + vbcrlf
	'response.write sql
	rsget.Open sql, dbget, 1
	
	
	Tcnt = rsget.RecordCount

	if  not rsget.EOF  then

		Fitemname = rsget("itemname")
		IsSoldOut = false
		  if ((rsget("sellyn") <> "Y") or ((rsget("limityn") = "Y") and ((clng(rsget("limitno")) - clng(rsget("limitsold"))) <= 0))) then
			  IsSoldOut = true
		  end if
	end if
	rsget.close
	
	
if IsSoldOut then
%>
<script language="JavaScript">
	alert('품절된 상품입니다..\n다른 상품을 선택해주세요 ^-^');
	var frm = eval("opener.frmQ");

	frm.sD.value	= '';
	frm.che.value = '';
	
	self.close();
</script>	
<% response.end
end if

if Tcnt > 0 then
%>
<script language="JavaScript">
<!--
	var frm = eval("opener.frmQ");
	var itemval="<% = db2html(Fitemname) %>";

	frm.sD.value	= itemval;
	frm.che.value="check";
	self.close();

//-->
</script>
<% 
response.end
else 
%>
<script language="JavaScript">
	alert('품절된 상품입니다..\n다른 상품을 선택해주세요 ^-^');
	var frm = eval("opener.frmQ");

	frm.sD.value	= '';
	frm.che.value = '';
	self.close();
</script>
<% response.end
end if 
%>
<!-- #include virtual="/lib/db/dbclose.asp" -->