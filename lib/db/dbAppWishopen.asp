<OBJECT RUNAT=server PROGID=ADODB.Connection id=dbAppWishget></OBJECT>
<OBJECT RUNAT=server PROGID=ADODB.Recordset  id=rsAppWishget></OBJECT>

<%
'/���� �ֱ��� ������Ʈ ���� ������ ó�� '2011.11.11 �ѿ�� ����
'/������� ������ �ֽð� ������ ���� �ּ���
Call serverupdate_underconstruction()

dbAppWishget.Open Application("db_appWish")
%>
