<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
Response.AddHeader "Cache-Control","no-cache"
Response.AddHeader "Expires","0"
Response.AddHeader "Pragma","no-cache"
%>
<%
'###########################################################
' Description : ������ �̸��� ���� ��߼�
' History : 2018.04.04 �ѿ�� ����
'###########################################################
%>
<% Response.Addheader "P3P","policyref=""/w3c/p3p.xml"", CP=""CONi NOI DSP LAW NID PHY ONL OUR IND COM"""%>
<!-- #include virtual="/lib/inc_const.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/db/dbhelper.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/lib/email/maillib.asp" -->
<!-- #INCLUDE Virtual="/lib/email/maillib2.asp" -->
<!-- #include virtual="/lib/classes/ordercls/smscls.asp" -->
<!-- #include virtual="/lib/classes/membercls/sp_pointcls.asp" -->
<!-- #include virtual="/lib/classes/membercls/sp_tenCashCls.asp" -->
<!-- #include virtual="/lib/classes/ordercls/sp_myordercls.asp" -->
<!-- #include virtual="/lib/classes/giftcard/giftcard_MyCardInfoCls.asp" -->
<!-- #include virtual="/lib/classes/ordercls/pack_cls.asp" -->

<%
' ������ ������ ������
dim orderserial, email

'������ �ݵ�� �ּ�ó�� �Ұ�.
'	orderserial = "18040358965"
'	email = "judel972@hotmail.com"

if orderserial = "" then orderserial = "18040462262"
if email = "" then email = "tozzinet@10x10.co.kr"

'������ �ݵ�� ������.
response.end

call SendMailOrder(orderserial, email)

response.write orderserial & "<br>"
response.write email & "<br>"
%>

<!-- #include virtual="/lib/db/dbclose.asp" -->
