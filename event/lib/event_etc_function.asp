<%
'####################################################
' Description :  이벤트 공용 펑션
' History : 2014.01.07 한용민 생성
'####################################################

'//이벤트 당첨여부 체크
function getevent_subscriptexistscount(evt_code, userid, sub_opt1, sub_opt2, sub_opt3)
	dim sqlstr, tmevent_subscriptexistscount
	
	if evt_code="" or userid="" then
		getevent_subscriptexistscount=99999
		exit function
	end if
	
	sqlstr = "select count(*) as cnt"
	sqlstr = sqlstr & " from [db_event].[dbo].[tbl_event_subscript] sc"
	sqlstr = sqlstr & " where sc.evt_code="& evt_code &""
	sqlstr = sqlstr & " and sc.userid='"& userid &"'"
	
	if sub_opt1<>"" then
		sqlstr = sqlstr & " and isnull(sc.sub_opt1,'') = '"& sub_opt1 &"'"
	end if
	if sub_opt2<>"" then
		sqlstr = sqlstr & " and isnull(sc.sub_opt2,'') = '"& sub_opt2 &"'"
	end if
	if sub_opt3<>"" then
		sqlstr = sqlstr & " and isnull(sc.sub_opt3,'') = '"& sub_opt3 &"'"
	end if
	
	'response.write sqlstr & "<Br>"
	rsget.Open sqlstr,dbget
	IF not rsget.EOF THEN
		tmevent_subscriptexistscount = rsget("cnt")
	END IF
	rsget.close
	
	getevent_subscriptexistscount = tmevent_subscriptexistscount
end function

'//이벤트 총 참여수 체크
function getevent_subscripttotalcount(evt_code, sub_opt1, sub_opt2, sub_opt3)
	dim sqlstr, tmevent_subscripttotalcount
	
	if evt_code="" then
		getevent_subscripttotalcount=99999
		exit function
	end if
	
	sqlstr = "select count(*) as cnt"
	sqlstr = sqlstr & " from [db_event].[dbo].[tbl_event_subscript] sc"
	sqlstr = sqlstr & " where sc.evt_code="& evt_code &""
	
	if sub_opt1<>"" then
		sqlstr = sqlstr & " and isnull(sc.sub_opt1,'') = '"& sub_opt1 &"'"
	end if
	if sub_opt2<>"" then
		sqlstr = sqlstr & " and isnull(sc.sub_opt2,'') = '"& sub_opt2 &"'"
	end if
	if sub_opt3<>"" then
		sqlstr = sqlstr & " and isnull(sc.sub_opt3,'') = '"& sub_opt3 &"'"
	end if
	
	'response.write sqlstr & "<Br>"
	rsget.Open sqlstr,dbget
	IF not rsget.EOF THEN
		tmevent_subscripttotalcount = rsget("cnt")
	END IF
	rsget.close
	
	getevent_subscripttotalcount = tmevent_subscripttotalcount
end function

'//뱃지 참여 여부
function getbadgeexistscount(userid, badgeidx, categorycode, colorcode, stylecode)
	dim sqlstr, tmpbadgeexistscount
	
	if userid="" or badgeidx="" then
		getbadgeexistscount=99999
		exit function
	end if

	sqlstr = "select count(*) as cnt"
	sqlstr = sqlstr & " from [db_my10x10].[dbo].[tbl_badge_userObtain] bu"
	sqlstr = sqlstr & " where 1=1 "
	sqlstr = sqlstr & " and bu.userid='"& userid &"'"
	sqlstr = sqlstr & " and bu.badgeidx="& badgeidx &""
	
	if categorycode<>"" then
		sqlstr = sqlstr & " and isnull(bu.categorycode,'')='"& categorycode &"'"
	end if
	if colorcode<>"" then
		sqlstr = sqlstr & " and isnull(bu.colorcode,'')='"& colorcode &"'"
	end if
	if stylecode<>"" then
		sqlstr = sqlstr & " and isnull(bu.stylecode,'')='"& stylecode &"'"
	end if

	'response.write sqlstr & "<Br>"
	rsget.Open sqlstr,dbget
	IF not rsget.EOF THEN
		tmpbadgeexistscount = rsget("cnt")
	END IF
	rsget.close
	
	getbadgeexistscount = tmpbadgeexistscount
end function

'//상품 쿠폰 발급 체크
function getitemcouponexistscount(userid, couponidx, usedyn, regdate)
	dim sqlstr, tmpgetitemcouponexistscount
	
	if couponidx="" then
		tmpgetitemcouponexistscount=99999
		exit function
	end if
	
	sqlstr = "select count(*) as cnt"
	sqlstr = sqlstr & " from [db_item].[dbo].tbl_user_item_coupon"
	sqlstr = sqlstr & " where itemcouponidx in ("& couponidx &")"

	if userid<>"" then
		sqlstr = sqlstr & " and isnull(userid,'')='"& userid &"'"
	end if
	if usedyn<>"" then
		sqlstr = sqlstr & " and isnull(usedyn,'')='"& usedyn &"'"
	end if
	if regdate<>"" then
		sqlstr = sqlstr & " and isnull(convert(varchar(10),regdate,121),'')='"& regdate &"'"
	end if

	'response.write sqlstr & "<Br>"
	rsget.Open sqlstr,dbget
	IF not rsget.EOF THEN
		tmpgetitemcouponexistscount = rsget("cnt")
	END IF
	rsget.close
	
	getitemcouponexistscount = tmpgetitemcouponexistscount
end function

'//쿠폰 발급 체크
function getbonuscouponexistscount(userid, couponid, deleteyn, isusing, regdate)
	dim sqlstr, tmpbonuscouponexistscount
	
	if userid="" or couponid="" then
		tmpbonuscouponexistscount=99999
		exit function
	end if
	
	sqlstr = "select count(*) as cnt"
	sqlstr = sqlstr & " from [db_user].dbo.tbl_user_coupon"
	sqlstr = sqlstr & " where masteridx in ("& couponid &")"

	If userid <> "" then
		sqlstr = sqlstr & " and userid='"& userid &"'"
	End if
	if deleteyn<>"" then
		sqlstr = sqlstr & " and isnull(deleteyn,'')='"& deleteyn &"'"
	end if
	if isusing<>"" then
		sqlstr = sqlstr & " and isnull(isusing,'')='"& isusing &"'"
	end if
	if regdate<>"" then
		sqlstr = sqlstr & " and isnull(convert(varchar(10),regdate,121),'')='"& regdate &"'"
	end if

	If getLoginUserID() = "motions" then
	'response.write sqlstr & "<Br>"
	End If 

	rsget.Open sqlstr,dbget
	IF not rsget.EOF THEN
		tmpbonuscouponexistscount = rsget("cnt")
	END IF
	rsget.close
	
	getbonuscouponexistscount = tmpbonuscouponexistscount
end function

'//쿠폰 총 발급 체크
function getbonuscoupontotalcount(couponid, deleteyn, isusing, regdate)
	dim sqlstr, tmpbonuscoupontotalcount
	
	if couponid="" then
		tmpbonuscoupontotalcount=99999
		exit function
	end if
	
	sqlstr = "select count(*) as cnt"
	sqlstr = sqlstr & " from [db_user].dbo.tbl_user_coupon"
	sqlstr = sqlstr & " where masteridx in ("& couponid &")"

	if deleteyn<>"" then
		sqlstr = sqlstr & " and isnull(deleteyn,'')='"& deleteyn &"'"
	end if
	if isusing<>"" then
		sqlstr = sqlstr & " and isnull(isusing,'')='"& isusing &"'"
	end if
	if regdate<>"" then
		sqlstr = sqlstr & " and isnull(convert(varchar(10),regdate,121),'')='"& regdate &"'"
	end if

	'response.write sqlstr & "<Br>"
	rsget.Open sqlstr,dbget
	IF not rsget.EOF THEN
		tmpbonuscoupontotalcount = rsget("cnt")
	END IF
	rsget.close
	
	getbonuscoupontotalcount = tmpbonuscoupontotalcount
end function

'//마일리지 발급 체크
function getmileageexistscount(userid, jukyocd, jukyo, mileage, deleteyn)
	dim sqlstr, tmpevent_mileageexistscount
	
	if userid="" then
		getmileageexistscount=99999
		exit function
	end if

	sqlstr = "select count(*) as cnt"
	sqlstr = sqlstr & " from db_user.dbo.tbl_mileagelog ml"
	sqlstr = sqlstr & " where ml.userid='"& userid &"'"
	
	if jukyocd<>"" then
		sqlstr = sqlstr & " and isnull(ml.jukyocd,'')='"& jukyocd &"'"
	end if
	if jukyo<>"" then
		sqlstr = sqlstr & " and isnull(ml.jukyo,'')='"& jukyo &"'"
	end if
	if mileage<>"" then
		sqlstr = sqlstr & " and isnull(ml.mileage,'')='"& mileage &"'"
	end if
	if deleteyn<>"" then
		sqlstr = sqlstr & " and isnull(ml.deleteyn,'')='"& deleteyn &"'"
	end if
	
	'response.write sqlstr & "<Br>"
	rsget.Open sqlstr,dbget
	IF not rsget.EOF THEN
		tmpevent_mileageexistscount = rsget("cnt")
	END IF
	rsget.close
	
	getmileageexistscount = tmpevent_mileageexistscount
end function

'//총 마일리지 발급 체크
function getmileageexiststotalcount(jukyocd, jukyo, mileage, deleteyn)
	dim sqlstr, tmpevent_mileageexiststotalcount

	if jukyocd="" and jukyo="" then
		getmileageexiststotalcount=99999
		exit function
	end if

	sqlstr = "select count(*) as cnt"
	sqlstr = sqlstr & " from db_user.dbo.tbl_mileagelog ml"
	sqlstr = sqlstr & " where 1=1 "
	
	if jukyocd<>"" then
		sqlstr = sqlstr & " and isnull(ml.jukyocd,'')='"& jukyocd &"'"
	end if
	if jukyo<>"" then
		sqlstr = sqlstr & " and isnull(ml.jukyo,'')='"& jukyo &"'"
	end if
	if mileage<>"" then
		sqlstr = sqlstr & " and isnull(ml.mileage,'')='"& mileage &"'"
	end if
	if deleteyn<>"" then
		sqlstr = sqlstr & " and isnull(ml.deleteyn,'')='"& deleteyn &"'"
	end if
	
	'response.write sqlstr & "<Br>"
	rsget.Open sqlstr,dbget
	IF not rsget.EOF THEN
		tmpevent_mileageexiststotalcount = rsget("cnt")
	END IF
	rsget.close
	
	getmileageexiststotalcount = tmpevent_mileageexiststotalcount
end function

'//고객 마일리지 가져오기
function getUserCurrentMileage(userid)
	dim sqlstr
	dim mileage	

	if userid = "" then
		mileage = ""
		exit function
	end if

	sqlstr = "select top 1 (m.jumunmileage +  m.flowerjumunmileage + m.bonusmileage  + m.academymileage - m.spendmileage -  IsNULL(m.expiredMile,0) - IsNULL(m.michulmile,0) - IsNULL(m.michulmileACA,0)) as mileage "
	sqlstr = sqlstr & " from db_user.dbo.tbl_user_current_mileage as m "
	sqlstr = sqlstr & " where userid='"& userid &"'"
	
	'response.write sqlstr & "<Br>"
	rsget.Open sqlstr,dbget
	IF not rsget.EOF THEN
		mileage = rsget("mileage")
	END IF
	rsget.close
	
	getUserCurrentMileage = mileage
end function

'//코맨트 체크
function getcommentexistscount(userid, evt_code, evtbbs_idx, evtgroup_code, device, evtcom_using)
	dim sqlstr, tmpcommentexistscount
	
	if userid="" or evt_code="" then
		getcommentexistscount=99999
		exit function
	end if

	sqlstr = "select count(*) as cnt"
	sqlstr = sqlstr & " from db_event.dbo.tbl_event_comment c"
	sqlstr = sqlstr & " where c.userid='"& userid &"' and c.evt_code="& evt_code &""
	
	if evtbbs_idx<>"" then
		sqlstr = sqlstr & " and isnull(c.evtbbs_idx,'')='"& evtbbs_idx &"'"
	end if
	if evtgroup_code<>"" then
		sqlstr = sqlstr & " and isnull(c.evtgroup_code,'')='"& evtgroup_code &"'"
	end if
	if device<>"" then
		sqlstr = sqlstr & " and isnull(c.device,'')='"& device &"'"
	end if
	if evtcom_using<>"" then
		sqlstr = sqlstr & " and isnull(c.evtcom_using,'')='"& evtcom_using &"'"
	end if

	'response.write sqlstr & "<Br>"
	rsget.Open sqlstr,dbget
	IF not rsget.EOF THEN
		tmpcommentexistscount = rsget("cnt")
	END IF
	rsget.close
	
	getcommentexistscount = tmpcommentexistscount
end function

'//코맨트 한줄 가져오기
function getcommentarrone(userid, evt_code, evtcom_idx, evtbbs_idx, evtgroup_code, device, evtcom_using)
	dim sqlstr, tmpcommentarr
	
	if evt_code="" or evtcom_idx="" then
		getcommentarrone=""
		exit function
	end if

	sqlstr = "select top 1 "
	sqlstr = sqlstr & " c.evtcom_idx, c.evt_code, c.userid, c.evtcom_txt, c.evtcom_point, c.evtcom_regdate, c.evtcom_using"
	sqlstr = sqlstr & " , c.evtbbs_idx, c.evtgroup_code, c.refip, c.blogurl, c.device"
	sqlstr = sqlstr & " from db_event.dbo.tbl_event_comment c"
	sqlstr = sqlstr & " where c.evt_code="& evt_code &""

	if userid<>"" then
		sqlstr = sqlstr & " and c.userid='"& userid &"'"
	end if
	if evtcom_idx<>"" then
		sqlstr = sqlstr & " and c.evtcom_idx="& evtcom_idx &""
	end if
	if evtbbs_idx<>"" then
		sqlstr = sqlstr & " and isnull(c.evtbbs_idx,'')='"& evtbbs_idx &"'"
	end if
	if evtgroup_code<>"" then
		sqlstr = sqlstr & " and isnull(c.evtgroup_code,'')='"& evtgroup_code &"'"
	end if
	if device<>"" then
		sqlstr = sqlstr & " and isnull(c.device,'')='"& device &"'"
	end if
	if evtcom_using<>"" then
		sqlstr = sqlstr & " and isnull(c.evtcom_using,'')='"& evtcom_using &"'"
	end if

	'response.write sqlstr & "<Br>"
	rsget.Open sqlstr,dbget
	IF not rsget.EOF THEN
		tmpcommentarr = rsget.getrows
	END IF
	rsget.close
	
	getcommentarrone = tmpcommentarr
end function

'//텐바이텐 온라인 고객 이름 가져오기
function get10x10onlineusername(userid)
	dim sqlstr, tmpusername
	
	if userid="" then
		get10x10onlineusername=""
		exit function
	end if
	
	sqlstr = "select top 1 n.username"
	sqlstr = sqlstr & " from db_user.dbo.tbl_user_n n"
	sqlstr = sqlstr & " where n.userid='"& userid &"'"

	'response.write sqlstr & "<Br>"
	rsget.Open sqlstr,dbget
	IF not rsget.EOF THEN
		tmpusername = db2html(rsget("username"))
	else
		tmpusername = ""
	END IF
	rsget.close
	
	get10x10onlineusername = tmpusername
end function

'//텐바이텐 온라인 고객 핸드폰 번호 가져오기
function get10x10onlineusercell(userid)
	dim sqlstr, tmpusercell
	
	if userid="" then
		get10x10onlineusercell=""
		exit function
	end if
	
	sqlstr = "select top 1 n.usercell"
	sqlstr = sqlstr & " from db_user.dbo.tbl_user_n n"
	sqlstr = sqlstr & " where n.userid='"& userid &"'"

	'response.write sqlstr & "<Br>"
	rsget.Open sqlstr,dbget
	IF not rsget.EOF THEN
		tmpusercell = rsget("usercell")
	else
		tmpusercell = ""
	END IF
	rsget.close
	
	get10x10onlineusercell = tmpusercell
end function

'//텐바이텐 온라인 메일진수신여부
function get10x10onlinemailyn(userid, emailok, email_10x10, email_way2way)
	dim sqlstr, tmp10x10onlinemailyn
	
	if userid="" then
		get10x10onlinemailyn=""
		exit function
	end if
	
	sqlstr = "select count(*) as cnt"
	sqlstr = sqlstr & " from db_user.dbo.tbl_user_n n"
	sqlstr = sqlstr & " where n.userid='"& userid &"'"

	if emailok<>"" then
		sqlstr = sqlstr & " and n.emailok='"& emailok &"'"
	end if
	if email_10x10<>"" then
		sqlstr = sqlstr & " and n.email_10x10='"& email_10x10 &"'"
	end if
	if email_way2way<>"" then
		sqlstr = sqlstr & " and n.email_way2way='"& email_way2way &"'"
	end if	

	'response.write sqlstr & "<Br>"
	rsget.Open sqlstr,dbget
	IF not rsget.EOF THEN
		if rsget("cnt")>0 then
			tmp10x10onlinemailyn = "Y"
		else
			tmp10x10onlinemailyn = "N"
		end if
	else
		tmp10x10onlinemailyn = ""
	END IF
	rsget.close
	
	get10x10onlinemailyn = tmp10x10onlinemailyn
end function

'//텐바이텐 구매내역 조회
function get10x10onlineordercount(userid, startdate, enddate, sitename, rdsite, beadaldiv, cancelyn)
	dim sqlstr, tmp10x10onlineordercount
	
	if startdate="" or enddate="" then
		get10x10onlineordercount=0
		exit function
	end if

	sqlstr = sqlstr & " select count(*) as cnt"
	sqlstr = sqlstr & " from db_order.dbo.tbl_order_master m"
	sqlstr = sqlstr & " where m.regdate >= '"& startdate &"' and m.regdate < '"& enddate &"'"
	sqlstr = sqlstr & " and m.jumundiv not in (6,9)"
	sqlstr = sqlstr & " and m.ipkumdiv>3"
	
	if userid<>"" then
		sqlstr = sqlstr & " and m.userid='"& userid &"'"
	end if
	if sitename<>"" then
		sqlstr = sqlstr & " and m.sitename in ("& sitename &")"
	end if
	if rdsite<>"" then
		sqlstr = sqlstr & " and m.rdsite in ("& rdsite &")"
	end if
		
	if beadaldiv<>"" then
		sqlstr = sqlstr & " and m.beadaldiv in ("& beadaldiv &")"
	end if
	if cancelyn<>"" then
		sqlstr = sqlstr & " and m.cancelyn='"& cancelyn &"'"
	end if

	'response.write sqlstr & "<Br>"
	rsget.Open sqlstr,dbget
	IF not rsget.EOF THEN
		tmp10x10onlineordercount = rsget("cnt")
	else
		tmp10x10onlineordercount = 0
	END IF
	rsget.close
	
	get10x10onlineordercount = tmp10x10onlineordercount
end function

'//텐바이텐 구매내역 조회 상품단위
function get10x10onlineorderdetailcount(userid, startdate, enddate, sitename, rdsite, beadaldiv, cancelyn, detailcancelyn, itemid, makerid)
	dim sqlstr, tmp10x10onlineorderdetailcount
	
	if startdate="" or enddate="" then
		get10x10onlineorderdetailcount=0
		exit function
	end if

	sqlstr = sqlstr & " select count(*) as cnt"
	sqlstr = sqlstr & " from db_order.dbo.tbl_order_master m"
	sqlstr = sqlstr & " join db_order.dbo.tbl_order_detail d"
	sqlstr = sqlstr & " 	on m.orderserial=d.orderserial"
	sqlstr = sqlstr & " where m.regdate >= '"& startdate &"' and m.regdate < '"& enddate &"'"
	sqlstr = sqlstr & " and m.jumundiv<>9"
	sqlstr = sqlstr & " and m.ipkumdiv>3"
	
	if userid<>"" then
		sqlstr = sqlstr & " and m.userid='"& userid &"'"
	end if
	if sitename<>"" then
		sqlstr = sqlstr & " and m.sitename in ("& sitename &")"
	end if
	if rdsite<>"" then
		sqlstr = sqlstr & " and m.rdsite in ("& rdsite &")"
	end if
		
	if beadaldiv<>"" then
		sqlstr = sqlstr & " and m.beadaldiv in ("& beadaldiv &")"
	end if
	if cancelyn<>"" then
		sqlstr = sqlstr & " and m.cancelyn='"& cancelyn &"'"
	end if
	if detailcancelyn<>"" then
		sqlstr = sqlstr & " and d.cancelyn<>'"& detailcancelyn &"'"
	end if
	if itemid<>"" then
		sqlstr = sqlstr & " and d.itemid in ("& itemid &")"
	end if
	if makerid<>"" then
		sqlstr = sqlstr & " and d.makerid in ("& makerid &")"
	end if
	
	'response.write sqlstr & "<Br>"
	rsget.Open sqlstr,dbget
	IF not rsget.EOF THEN
		tmp10x10onlineorderdetailcount = rsget("cnt")
	else
		tmp10x10onlineorderdetailcount = 0
	END IF
	rsget.close
	
	get10x10onlineorderdetailcount = tmp10x10onlineorderdetailcount
end function

'//상품 한정수량
function getitemlimitcnt(itemid)
	dim tmpitemlimitcnt ,sqlstr
	tmpitemlimitcnt=0
	
	if itemid="" then
		getitemlimitcnt=0
		exit function
	end if

	sqlstr = "select top 1 isnull(limitno,0) as limitno, isnull(limitsold,0) as limitsold"
	sqlstr = sqlstr & " from db_item.dbo.tbl_item"
	sqlstr = sqlstr & " where itemid="&itemid&""

	'response.write sqlstr & "<Br>"
	rsget.Open sqlstr,dbget
	IF not rsget.EOF THEN
		tmpitemlimitcnt = rsget("limitno")
		
		if (rsget("limitno")-rsget("limitsold")) < 1 then tmpitemlimitcnt=0
	END IF
	rsget.close
	
	getitemlimitcnt=tmpitemlimitcnt
end function

'//사은품 한정수량
function getgiftlimitcnt(gift_code)
	dim tmpgetgiftlimitcnt ,sqlstr
	tmpgetgiftlimitcnt=0
	
	if gift_code="" then
		getgiftlimitcnt=0
		exit function
	end if

	sqlstr = "select top 1 isnull(giftkind_limit,0) as giftkind_limit, isnull(giftkind_givecnt,0) as giftkind_givecnt"
	sqlstr = sqlstr & " from db_event.dbo.tbl_gift"
	sqlstr = sqlstr & " where gift_code="&gift_code&""

	'response.write sqlstr & "<Br>"
	rsget.Open sqlstr,dbget
	IF not rsget.EOF THEN
		tmpgetgiftlimitcnt = rsget("giftkind_limit")

		if (rsget("giftkind_limit")-rsget("giftkind_givecnt")) < 1 then tmpgetgiftlimitcnt=0
	END IF
	rsget.close
	
	getgiftlimitcnt=tmpgetgiftlimitcnt
end function

'// 당첨자 핸드폰번호로 걸러내기
Function event_userCell_Selection(usercell, evtDate, evtcode)

	Dim sqlstr

	sqlstr = " Select count(e.userid) From db_event.dbo.tbl_event_subscript e "
	sqlstr = sqlstr & " inner join db_user.dbo.tbl_user_n u on e.userid = u.userid "
	sqlstr = sqlstr & " Where evt_code='"&evtcode&"' And sub_opt2 <> 0 And convert(varchar(10), e.regdate, 120) = '"&evtDate&"' "
	sqlstr = sqlstr & " And usercell='"&usercell&"' "
	rsget.Open sqlstr,dbget
		event_userCell_Selection = rsget(0)
	rsget.close

End Function

'// 당첨자 핸드폰번호로 걸러내기 - 기간 없음
Function event_userCell_Selection_nodate(usercell, evtcode)

	Dim sqlstr

	sqlstr = " Select count(e.userid) From db_event.dbo.tbl_event_subscript e "
	sqlstr = sqlstr & " inner join db_user.dbo.tbl_user_n u on e.userid = u.userid "
	sqlstr = sqlstr & " Where evt_code='"&evtcode&"' And sub_opt2 <> 0 "
	sqlstr = sqlstr & " And usercell='"&usercell&"' "
	rsget.Open sqlstr,dbget
		event_userCell_Selection_nodate = rsget(0)
	rsget.close

End Function

Class Cevent_etc_common_item
	public fsub_idx
	public fevt_code
	public fuserid
	public fsub_opt1
	public fsub_opt2
	public fsub_opt3
	public fregdate
	public FImageMain
	public FImageMain2
	public FImageMain3
	public FImageList
	public FImageList120
	public FImageSmall
	public FImageBasic
	public FImageBasicIcon
	public FImageicon2
	public FImageMask
	public FImageMaskIcon
	public fdevice

	Private Sub Class_Initialize()
	End Sub
	Private Sub Class_Terminate()
	End Sub
end class

Class Cevent_etc_common_list
    public FItemList()
    public FOneItem
	public FCurrPage
	public FTotalPage
	public FTotalCount
	public FPageSize
	public FResultCount
	public FScrollCount
	public FPageCount

	public frectsub_opt1
	public frectsub_opt2
	public frectsub_opt3
	public frectevt_code
	public frectuserid
	public frectordertype
	public frectgubun
	public frectsub_idx
	
	'//이벤트 참여자 리스트
    public Sub event_subscript_one()
		dim sqlStr, sqlsearch, sqlorder, i

		if frectevt_code="" then exit sub

		if frectsub_idx<>"" then
			sqlsearch = sqlsearch & " and sc.sub_idx = "& frectsub_idx &""
		end if
		if frectsub_opt1<>"" then
			sqlsearch = sqlsearch & " and isnull(sc.sub_opt1,'') = '"& frectsub_opt1 &"'"
		end if
		if frectsub_opt2<>"" then
			sqlsearch = sqlsearch & " and isnull(sc.sub_opt2,'') = '"& frectsub_opt2 &"'"
		end if
		if frectsub_opt3<>"" then
			sqlsearch = sqlsearch & " and isnull(sc.sub_opt3,'') = '"& frectsub_opt3 &"'"
		end if
		if frectuserid<>"" then
			sqlsearch = sqlsearch & " and sc.userid='"& frectuserid &"'"
		end if
		
		if frectordertype="new" then
			sqlorder = sqlorder & " order by sc.sub_idx desc"
		else
			sqlorder = sqlorder & " "
		end if

		sqlStr = "select top 1"
		sqlStr = sqlStr & " sc.sub_idx, sc.evt_code, sc.userid, sc.sub_opt1, sc.sub_opt2, sc.sub_opt3, sc.regdate, sc.device"
		
		if frectgubun="item" then
			sqlStr = sqlStr & " ,i.mainimage, i.mainimage2, i.mainimage3, i.listimage, i.listimage120, i.smallimage"
			sqlStr = sqlStr & " ,i.basicimage, i.maskimage, i.icon2image"
		end if
		
		sqlStr = sqlStr & " from db_event.dbo.tbl_event_subscript sc"
		
		if frectgubun="item" then
			sqlStr = sqlStr & " left join db_item.dbo.tbl_item i"
			sqlStr = sqlStr & " 	on sc.sub_opt2=i.itemid"
			sqlStr = sqlStr & " 	and i.isusing='Y' and i.sellyn<>'N'"
		end if

		sqlStr = sqlStr & " where sc.evt_code="& frectevt_code &" " & sqlsearch & sqlorder

        'response.write sqlStr&"<br>"
        rsget.Open SqlStr, dbget, 1
        FResultCount = rsget.RecordCount
        ftotalcount=rsget.recordcount

        set FOneItem = new Cevent_etc_common_item
        
        if Not rsget.Eof then

			FOneItem.fsub_idx = rsget("sub_idx")
			FOneItem.fevt_code = rsget("evt_code")
			FOneItem.fuserid = rsget("userid")
			FOneItem.fsub_opt1 = db2html(rsget("sub_opt1"))
			FOneItem.fsub_opt2 = rsget("sub_opt2")
			FOneItem.fsub_opt3 = db2html(rsget("sub_opt3"))
			FOneItem.fregdate = rsget("regdate")
			FOneItem.fdevice = rsget("device")

			if frectgubun="item" then
				FOneItem.FImageMain 		= "http://webimage.10x10.co.kr/image/main/" + GetImageSubFolderByItemid(FOneItem.fsub_opt2) + "/" + rsget("mainimage")
				FOneItem.FImageMain2		= "http://webimage.10x10.co.kr/image/main2/" + GetImageSubFolderByItemid(FOneItem.fsub_opt2) + "/" + rsget("mainimage2")
				FOneItem.FImageMain3		= "http://webimage.10x10.co.kr/image/main3/" + GetImageSubFolderByItemid(FOneItem.fsub_opt2) + "/" + rsget("mainimage3")
				FOneItem.FImageList 		= "http://webimage.10x10.co.kr/image/list/" + GetImageSubFolderByItemid(FOneItem.fsub_opt2) + "/" + rsget("listimage")
				FOneItem.FImageList120 	= "http://webimage.10x10.co.kr/image/list120/" + GetImageSubFolderByItemid(FOneItem.fsub_opt2) + "/" + rsget("listimage120")
				FOneItem.FImageSmall 		= "http://webimage.10x10.co.kr/image/small/" + GetImageSubFolderByItemid(FOneItem.fsub_opt2) + "/" + rsget("smallimage")
				FOneItem.FImageBasic 		= "http://webimage.10x10.co.kr/image/basic/" + GetImageSubFolderByItemid(FOneItem.fsub_opt2) + "/" + rsget("basicimage")
				FOneItem.FImageBasicIcon 	= "http://webimage.10x10.co.kr/image/basicicon/" + GetImageSubFolderByItemid(FOneItem.fsub_opt2) + "/C" + rsget("basicimage")
				If Not(isNull(rsget("maskimage")) OR rsget("maskimage") = "") Then
					FOneItem.FImageMask 	= "http://webimage.10x10.co.kr/image/mask/" + GetImageSubFolderByItemid(FOneItem.fsub_opt2) + "/" + rsget("maskimage")
					FOneItem.FImageMaskIcon 	= "http://webimage.10x10.co.kr/image/maskicon/" + GetImageSubFolderByItemid(FOneItem.fsub_opt2) + "/C" + rsget("maskimage")
				end if
				FOneItem.FImageicon2 		= "http://webimage.10x10.co.kr/image/icon2/" + GetImageSubFolderByItemid(FOneItem.fsub_opt2) + "/" + rsget("icon2image")
			end if	
			           
        end if
        rsget.Close
    end Sub

	'//이벤트 참여자 리스트 페이징 버전
	public sub event_subscript_paging()
		dim sqlStr, sqlsearch, sqlorder, i

		if frectevt_code="" then exit sub

		if frectsub_idx<>"" then
			sqlsearch = sqlsearch & " and sc.sub_idx = "& frectsub_idx &""
		end if
		if frectsub_opt1<>"" then
			sqlsearch = sqlsearch & " and isnull(sc.sub_opt1,'') = '"& frectsub_opt1 &"'"
		end if
		if frectsub_opt2<>"" then
			sqlsearch = sqlsearch & " and isnull(sc.sub_opt2,'') = '"& frectsub_opt2 &"'"
		end if
		if frectsub_opt3<>"" then
			sqlsearch = sqlsearch & " and isnull(sc.sub_opt3,'') = '"& frectsub_opt3 &"'"
		end if
		if frectuserid<>"" then
			sqlsearch = sqlsearch & " and sc.userid='"& frectuserid &"'"
		end if
		
		if frectordertype="new" then
			sqlorder = sqlorder & " order by sc.sub_idx desc"
		else
			sqlorder = sqlorder & " "
		end if
		
		sqlStr = " select count(*) as cnt"
		sqlStr = sqlStr & " from db_event.dbo.tbl_event_subscript sc"
		
		if frectgubun="item" then
			sqlStr = sqlStr & " left join db_item.dbo.tbl_item i"
			sqlStr = sqlStr & " 	on sc.sub_opt2=i.itemid"
			sqlStr = sqlStr & " 	and i.isusing='Y' and i.sellyn<>'N'"
		end if

		sqlStr = sqlStr & " where sc.evt_code="& frectevt_code &" " & sqlsearch
		
		'response.write sqlStr & "<Br>"
		rsget.Open sqlStr,dbget,1
			FTotalCount = rsget("cnt")
		rsget.Close
		
		if FTotalCount < 1 then exit sub

		sqlStr = "select top " & Cstr(FPageSize * FCurrPage)
		sqlStr = sqlStr & " sc.sub_idx, sc.evt_code, sc.userid, sc.sub_opt1, sc.sub_opt2, sc.sub_opt3, sc.regdate, sc.device"
		
		if frectgubun="item" then
			sqlStr = sqlStr & " ,i.mainimage, i.mainimage2, i.mainimage3, i.listimage, i.listimage120, i.smallimage"
			sqlStr = sqlStr & " ,i.basicimage, i.maskimage, i.icon2image"
		end if
		
		sqlStr = sqlStr & " from db_event.dbo.tbl_event_subscript sc"
		
		if frectgubun="item" then
			sqlStr = sqlStr & " left join db_item.dbo.tbl_item i"
			sqlStr = sqlStr & " 	on sc.sub_opt2=i.itemid"
			sqlStr = sqlStr & " 	and i.isusing='Y' and i.sellyn<>'N'"
		end if

		sqlStr = sqlStr & " where sc.evt_code="& frectevt_code &" " & sqlsearch & sqlorder

		'response.write sqlStr & "<Br>"
		rsget.pagesize = FPageSize
		rsget.Open sqlStr,dbget,1

		if (FCurrPage * FPageSize < FTotalCount) then
			FResultCount = FPageSize
		else
			FResultCount = FTotalCount - FPageSize*(FCurrPage-1)
		end if

		FTotalPage = (FTotalCount\FPageSize)
		if (FTotalPage<>FTotalCount/FPageSize) then FTotalPage = FTotalPage +1

		redim preserve FItemList(FResultCount)

		FPageCount = FCurrPage - 1

		i=0
		if  not rsget.EOF  then
			rsget.absolutepage = FCurrPage
			do until rsget.EOF
				set FItemList(i) = new Cevent_etc_common_item

				FItemList(i).fsub_idx = rsget("sub_idx")
				FItemList(i).fevt_code = rsget("evt_code")
				FItemList(i).fuserid = rsget("userid")
				FItemList(i).fsub_opt1 = db2html(rsget("sub_opt1"))
				FItemList(i).fsub_opt2 = rsget("sub_opt2")
				FItemList(i).fsub_opt3 = db2html(rsget("sub_opt3"))
				FItemList(i).fregdate = rsget("regdate")
				FItemList(i).fdevice = rsget("device")

				if frectgubun="item" then
					FItemList(i).FImageMain 		= "http://webimage.10x10.co.kr/image/main/" + GetImageSubFolderByItemid(FItemList(i).fsub_opt2) + "/" + rsget("mainimage")
					FItemList(i).FImageMain2		= "http://webimage.10x10.co.kr/image/main2/" + GetImageSubFolderByItemid(FItemList(i).fsub_opt2) + "/" + rsget("mainimage2")
					FItemList(i).FImageMain3		= "http://webimage.10x10.co.kr/image/main3/" + GetImageSubFolderByItemid(FItemList(i).fsub_opt2) + "/" + rsget("mainimage3")
					FItemList(i).FImageList 		= "http://webimage.10x10.co.kr/image/list/" + GetImageSubFolderByItemid(FItemList(i).fsub_opt2) + "/" + rsget("listimage")
					FItemList(i).FImageList120 	= "http://webimage.10x10.co.kr/image/list120/" + GetImageSubFolderByItemid(FItemList(i).fsub_opt2) + "/" + rsget("listimage120")
					FItemList(i).FImageSmall 		= "http://webimage.10x10.co.kr/image/small/" + GetImageSubFolderByItemid(FItemList(i).fsub_opt2) + "/" + rsget("smallimage")
					FItemList(i).FImageBasic 		= "http://webimage.10x10.co.kr/image/basic/" + GetImageSubFolderByItemid(FItemList(i).fsub_opt2) + "/" + rsget("basicimage")
					FItemList(i).FImageBasicIcon 	= "http://webimage.10x10.co.kr/image/basicicon/" + GetImageSubFolderByItemid(FItemList(i).fsub_opt2) + "/C" + rsget("basicimage")
					If Not(isNull(rsget("maskimage")) OR rsget("maskimage") = "") Then
						FItemList(i).FImageMask 	= "http://webimage.10x10.co.kr/image/mask/" + GetImageSubFolderByItemid(FItemList(i).fsub_opt2) + "/" + rsget("maskimage")
						FItemList(i).FImageMaskIcon 	= "http://webimage.10x10.co.kr/image/maskicon/" + GetImageSubFolderByItemid(FItemList(i).fsub_opt2) + "/C" + rsget("maskimage")
					end if
					FItemList(i).FImageicon2 		= "http://webimage.10x10.co.kr/image/icon2/" + GetImageSubFolderByItemid(FItemList(i).fsub_opt2) + "/" + rsget("icon2image")
				end if	
				
				rsget.movenext
				i=i+1
			loop
		end if
		rsget.Close
	end sub

	public Function HasPreScroll()
		HasPreScroll = StartScrollPage > 1
	end Function
	public Function HasNextScroll()
		HasNextScroll = FTotalPage > StartScrollPage + FScrollCount -1
	end Function
	public Function StartScrollPage()
		StartScrollPage = ((FCurrpage-1)\FScrollCount)*FScrollCount +1
	end Function
	
	Private Sub Class_Initialize()
		redim preserve FItemList(0)
		FCurrPage =1
		FPageSize = 10
		FResultCount = 0
		FScrollCount = 10
		FTotalCount = 0
	End Sub
	Private Sub Class_Terminate()
	End Sub
end Class

'// 다량아이디(블랙리스트)체크
function userBlackListCheck(userid)
	dim sqlstr, tmpuserchk
	
	if userid="" then
		userBlackListCheck=False
		exit function
	end if
	
	sqlstr = "select top 1 invaliduserid "
	sqlstr = sqlstr & " from db_user.dbo.tbl_invalid_user "
	sqlstr = sqlstr & " where gubun='ONEVT' And isusing='Y' And invaliduserid='"& userid &"'"

	'response.write sqlstr & "<Br>"
	rsget.Open sqlstr,dbget, adOpenForwardOnly, adLockReadOnly
	IF not rsget.EOF Then
		'// 블랙리스트에 등재되어 있음.
		tmpuserchk = True
	else
		tmpuserchk = False
	END IF
	rsget.close
	
	userBlackListCheck = tmpuserchk
End function


'// App 설치 내역 조회
Function fnUserGetDownAppCheck(userid)
	Dim sqlstr
	
	sqlstr = "SELECT count(*) FROM db_contents.[dbo].[tbl_app_regInfo] WHERE userid = '"& userid &"' "
	'response.write sqlstr & "<Br>"
	rsget.Open sqlstr,dbget, adOpenForwardOnly, adLockReadOnly
	IF not rsget.EOF Then
		fnUserGetDownAppCheck = True
	else
		fnUserGetDownAppCheck = False
	END IF
	rsget.close
End Function

Function fnUserGetOrderCheck(userid,orderstate)
	Dim sqlstr
	
	sqlstr = "SELECT count(*) as cnt FROM db_order.dbo.tbl_order_master WHERE jumundiv<>9 and ipkumdiv>3 and userid = '"& userid &"'"

	if orderstate<>"" Then
		If orderstate = "PC" Then '// PC 주문
			sqlstr = sqlstr & " and beadaldiv in (1,2)"
		ElseIf orderstate = "MOBILE" Then '// 모바일웹 주문
			sqlstr = sqlstr & " and beadaldiv in (4,5)"
		ElseIf orderstate = "APP" Then '// APP 주문
			sqlstr = sqlstr & " and beadaldiv in (7,8)"
		ElseIf orderstate = "PARTNER" Then '// 제휴몰 주문
			sqlstr = sqlstr & " and beadaldiv in (50,51,90)"
		ElseIf orderstate = "OVERSEA" Then '// 해외 주문
			sqlstr = sqlstr & " and beadaldiv in (80)"
		End If 
	end If

	'response.write sqlstr & "<Br>"
	rsget.Open sqlstr,dbget, adOpenForwardOnly, adLockReadOnly
	IF not rsget.EOF Then
		if rsget("cnt")>0 then
			fnUserGetOrderCheck = true
		else
			fnUserGetOrderCheck = false
		end if
	else
		fnUserGetOrderCheck = False
	END IF
	rsget.close
End Function

'// 타임세일 이벤트 관련 
'####################################################################
' 1. 상품 품절 여부 
'####################################################################
public sub fnGetItemLimited(itemid , byref isSoldOut , byref RemainCount)
	if itemid = "" then exit sub
	dim strSql
	dim rItemid , rSellyn , rLimityn , rLimitno , rLimitsold , rLimitdispyn

	strSql = "SELECT itemid , sellyn , limityn , limitno , limitsold , limitdispyn FROM db_item.dbo.tbl_item WITH(NOLOCK) WHERE itemid = '"& itemid &"' "
	rsget.Open strSql,dbget, adOpenForwardOnly, adLockReadOnly
	IF not rsget.EOF Then
		rItemid 	= rsget("itemid")
		rSellyn 	= rsget("sellyn")
		rLimityn 	= rsget("limityn")
		rLimitno 	= rsget("limitno")
		rLimitsold  = rsget("limitsold")
		rLimitdispyn= rsget("limitdispyn")
	END IF
	rsget.close

	IF rLimitno<>"" and rLimitsold<>"" Then
		isSoldOut = (rSellyn<>"Y") or ((rLimityn = "Y") and (clng(rLimitno)-clng(rLimitsold)<1))
	Else
		isSoldOut = (rSellyn<>"Y")
	End If

	IF isSoldOut Then
		RemainCount = 0
	Else
		RemainCount = (clng(rLimitno) - clng(rLimitsold))
	End If
End sub
%>