<%
'########################################################
' PageName : /offshop/lib/include/commonFunction.asp
' Description : 오프라인숍 공통함수
' History : 2006.12.5 정윤정 생성
'########################################################

'--[index]-----------------------------------------------
'	fnGetShopName : 오프라인숍 이름 가져오기 
'--------------------------------------------------------

	'// 오프라인숍 이름 가져오기 (2006.12.05 정윤정)
	Function fnGetShopName(ByVal shopID)
		Dim strSql
	
		strSql = "SELECT shopname FROM [db_shop].[dbo].[tbl_shop_user] WHERE userid='"&shopID&"'"
		rsget.Open strSql,dbget
		IF Not rsget.EOF THEN
			fnGetShopName = rsget("shopname")
		END IF	
		rsget.Close	
	End Function

	public function GetImageFolerName(byval FItemID)
		'GetImageFolerName = "0" + CStr(FItemID\10000)
		GetImageFolerName = GetImageSubFolderByItemid(FItemID)
	
	end function
%>	