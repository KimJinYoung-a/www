<%
const Addmileage_join       = 0
const Constpoint_finger     = 100
const Constpoint_zoom       = 100
const Constpoint_goodusing  = 200
const Constpoint_giftselect = 300
const Constpoint_10x10album = 300
const Constpoint_valentine  = 1000
const Constpoint_mail       = 300

const ID_fingerComment = 100000
const ID_zommComment = 300000
const ID_goodsUsing = 400000
const ID_GiftSelect = 500000
const ID_10x10album = 600000

class TenPoint
    public FTotalMileage

    public FTotJumunMileage
	public FBonusMileage
	public FSpendMileage
	public FRecentJumunmileage
	public FOLDJumunmileage
	public FAcademymileage
	public FrealExpiredMileage

	public Fmichulmile
	public FmichulmileACA

	public FOffShopMileage
	public FJuminno
	public FPointUserNo
	public FRegShopid
	public FCardNo
	public FOffShopMileagePopCount

    public FRectUserID
    public FGubun

	Private Sub Class_Initialize()
	    FTotalMileage       = 0

		FTotJumunMileage    = 0
		FBonusMileage       = 0
		FSpendMileage       = 0
		FRecentJumunmileage = 0
		FOLDJumunmileage    = 0
		FAcademymileage     = 0
		FrealExpiredMileage = 0


		FOffShopMileage = 0
	End Sub

	Private Sub Class_Terminate()

	End Sub

	public Function getOffShopMileagePop
		dim juminno, sqlStr

		if (FRectUserID="") then exit Function

		sqlStr = "[db_user].[dbo].sp_Ten_UserOffMileagePop('" & FGubun & "','" & FRectUserID & "','" & FCardNo & "')"
		rsget.CursorLocation = adUseClient
		rsget.Open sqlStr, dbget, adOpenForwardOnly, adLockReadOnly, adCmdStoredProc
		IF Not (rsget.EOF OR rsget.BOF) THEN
			If FCardNo = "" Then
				If FGubun = "my10x10" Then
					FOffShopMileage = rsget("point")
				Else
					getOffShopMileagePop = rsget.getRows()
				End If
			Else
				FOffShopMileage = rsget("point")
			End If
			FOffShopMileagePopCount = rsget.RecordCount
		END IF
		rsget.close

	End Function

	public Sub getOffShopMileage()
		dim juminno, sqlStr

		if (FRectUserID="") then exit sub

        sqlStr = "exec [db_user].[dbo].sp_Ten_UserOffMileage '" & FRectUserID & "'"


		rsget.Open sqlStr,dbget,1
		if Not Rsget.Eof then
			FOffShopMileage = rsget("shoppoint")
			FPointUserNo = rsget("pointuserno")
			FRegShopid   = rsget("regshopid")
		end if
		rsget.Close

	end Sub

	Public Sub getTotalMileage()
		dim mile,sqlStr
		if (FRectUserID="") then exit sub

        sqlStr = "exec [db_user].[dbo].sp_Ten_UserCurrentMileage '" & FRectUserID & "'"

    	rsget.Open sqlStr,dbget


		if Not (Rsget.Eof) then
		    FTotalmileage       = rsget("Totalmileage")
			FBonusMileage       = rsget("bonusmileage") 
			FSpendMileage       = rsget("spendmileage")

			Fmichulmile       	= rsget("michulmile")
			FmichulmileACA      = rsget("michulmileACA")

			'' 6개월 이내 주문마일리지
			FRecentJumunMileage = rsget("RecentJumunmileage")
			'' 6개월 이전 주문마일리지
			FOLDJumunmileage = rsget("OLDjumunmileage")
			'' 총 주문마일리지
			FTotJumunmileage = FRecentJumunMileage + FOLDJumunmileage

			'' 아카데미 주문마일리지
			FAcademymileage     = CLng(rsget("academymileage"))

			'' 소멸된 마일리지
			FrealExpiredMileage = CLng(rsget("realExpiredMileage"))

		end if
		rsget.Close

        ''마일리지 세팅 : 쿠키
        '' 이렇게 사용할 경우 특정브라우져에서.. 페이지 안열림..?? 2010-09-15
        ''Call SetLoginCurrentMileage(FTotalmileage)
	end Sub

 

end class

Function fnevent_luckyletter_mileage_insert(ByVal userid)
	Dim objCmd
	if userid="" or isnull(userid) then
		fnevent_luckyletter_mileage_insert="0"
	end if

	Set objCmd = Server.CreateObject("ADODB.COMMAND")
	With objCmd
		.ActiveConnection = dbget
		.CommandType = adCmdText
		.CommandText = "{?= call db_event.dbo.usp_ten_event_luckyletter_mileage_insert('"& userid &"')}"
		.Parameters.Append .CreateParameter("RETURN_VALUE", adInteger, adParamReturnValue)
		.Execute, , adExecuteNoRecords
		End With	
	    fnevent_luckyletter_mileage_insert = objCmd(0).Value	
	Set objCmd = Nothing	
END Function
%>
