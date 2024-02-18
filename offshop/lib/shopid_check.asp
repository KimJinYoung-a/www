<%
	Dim shopid, shopSn
	shopid = requestCheckVar(Request("shopid"),32)	'각 지점 아이디

	if shopid="" then
		Call Alert_Return("매장코드가 없습니다.")
		response.End
	else
		Select Case shopid
			''Case "streetshop011","streetshop012","streetshop803","streetshop014","streetshop018","streetshop809","streetshop019","streetshop810"
			Case "streetshop011","streetshop018","streetshop809","streetshop810","streetshop811","streetshop020","streetshop022","streetshop023","streetshop024","streetshop025","streetshop026"
			Case Else
				Call Alert_Return("존재하지 않는 매장입니다.")
				response.End
		End Select
	end if

	shopSn = fnGetShopSerialNo(shopid)
	
%>