<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'####################################################
' Description :  2015 텐텐 연말정산
' History : 2015.09.01 유태욱 생성
'####################################################
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/inc/head.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/lib/classes/shopping/sp_evaluatesearchercls.asp" -->
<%
dim eCode, vUserID, cMil, vMileValue, vMileArr
	vUserID = GetEncLoginUserID()
	'vUserID = "10x10yellow"
	If Now() > #09/02/2015 00:00:00# AND Now() < #09/06/2015 23:59:59# Then
		vMileValue = 200
	Else
		vMileValue = 100
	End If

	Set cMil = New CEvaluateSearcher
	cMil.FRectUserID = vUserID
	cMil.FRectMileage = vMileValue
	
	If vUserID <> "" Then
		vMileArr = cMil.getEvaluatedTotalMileCnt
	End If
	Set cMil = Nothing
%>
<style type="text/css">
img {vertical-align:top;}
.evt65902 {position:relative; text-align:left;}
.evt65902 .viewMileage {overflow:hidden; padding:35px 0 35px 77px; background:#ff6c5d;}
.evt65902 .viewMileage .mgCont {float:left; width:685px; padding:0 0 5px; margin-top:10px; border-left:1px solid #fff; padding-left:30px;}
.evt65902 .viewMileage .mgCont img {vertical-align:middle; padding-right:8px;}
.evt65902 .viewMileage .mgCont strong {position:relative; top:1px; display:inline-block; font-size:17px; line-height:19px;}
.evt65902 .viewMileage .mgCont .t01 {color:#fff; border-bottom:1px solid #fff;}
.evt65902 .viewMileage .mgCont .t02 {color:#ffea5f; border-bottom:1px solid #ffea5f;}
.evt65902 .viewMileage .mgCont .t03 {color:#c40000; border-bottom:1px solid #c40000;}
.evt65902 .viewMileage .mgBtn {float:left;}
.evt65902 .evtNoti {position:relative; height:198px; background:#fcfbef url(http://webimage.10x10.co.kr/eventIMG/2015/65902/bg_noti.gif) no-repeat 0 0;}
.evt65902 .evtNoti dt {position:absolute; left:100px; top:47px;}
.evt65902 .evtNoti dd {padding:47px 0 0 304px; color:#917a70; font-size:12px; line-height:13px;}
.evt65902 .evtNoti dd li {padding-bottom:10px;}
</style>
<script type="text/javascript">

function jsSubmitComment(){
	jsChklogin('<%=IsUserLoginOK%>');
	return;
}

</script>
	<div class="evt65902">
		<h2><img src="http://webimage.10x10.co.kr/eventIMG/2015/65902/tit_year_end_adjust.gif" alt="텐텐 연말정산" /></h2>
		<% If IsUserLoginOK Then %>
			<div class="viewMileage">
				<div class="mgCont">
					<p>
						<strong class="t01"><%=vUserID%></strong> <img src="http://webimage.10x10.co.kr/eventIMG/2015/65902/txt_mileage01.png" alt="고객님," />
						<strong class="t02"><%=vMileArr(0,0)%></strong> <img src="http://webimage.10x10.co.kr/eventIMG/2015/65902/txt_mileage02.png" alt="개의 상품후기를 남길 수 있습니다." />
					</p>
					<p class="tPad10">
						<img src="http://webimage.10x10.co.kr/eventIMG/2015/65902/txt_mileage03.png" alt="이벤트 기간 동안 예상 마일리지 적립금은" />
						<strong class="t03"><%=FormatNumber(vMileArr(1,0),0)%></strong> <img src="http://webimage.10x10.co.kr/eventIMG/2015/65902/txt_mileage04.png" alt="원 입니다." />
					</p>
				</div>
				<p class="mgBtn"><a href="/my10x10/goodsusing.asp" target="_top"><img src="http://webimage.10x10.co.kr/eventIMG/2015/65902/btn_go_review.png" alt="상품후기쓰고 더블 마일리지 받기" /></a></p>
			</div>
		<% else %>
			<div class="viewMileage">
				<div class="mgCont">
					<p><img src="http://webimage.10x10.co.kr/eventIMG/2015/65902/txt_expect_mileage.png" alt="나의 예상 적립 마일리지를 확인하세요!" /></p>
				</div>
				<p class="mgBtn"><a href="#" onClick="jsSubmitComment(); return fasle;" ><img src="http://webimage.10x10.co.kr/eventIMG/2015/65902/btn_go_login.png" alt="로그인하기" /></a></p>
			</div>
		<% end if %>
		
		<div>
			<img src="http://webimage.10x10.co.kr/eventIMG/2015/65902/img_review_example01.jpg" alt="상품후기의 좋은 예" usemap="#Map01" />
			<map name="Map01" id="Map01">
				<area shape="rect" coords="70,129,394,673" href="/shopping/category_prd.asp?itemid=1323283" target="_top" alt="스크래치 나이트뷰" />
				<area shape="rect" coords="408,129,732,673" href="/shopping/category_prd.asp?itemid=1322304" target="_top" alt="파인애플 산세베리아" />
				<area shape="rect" coords="746,129,1070,673" href="/shopping/category_prd.asp?itemid=1308640" target="_top" alt="기상예측 유리병 Tempo drop" />
				<area shape="rect" coords="887,691,1072,731" href="/bestreview/bestreview_main.asp?sortDiv=pnt" target="_top" alt="더 많은 상품후기 보기" />
			</map>
		</div>
		<div>
			<img src="http://webimage.10x10.co.kr/eventIMG/2015/65902/img_best_review.jpg" alt="BEST상품에는 BEST리뷰가 따라온다!" usemap="#Map02" />
			<map name="Map02" id="Map02">
				<area shape="rect" coords="70,129,314,374" href="/shopping/category_prd.asp?itemid=1185849" target="_top" alt="내폰에도 추석빔을" />
				<area shape="rect" coords="321,129,566,372" href="/shopping/category_prd.asp?itemid=1246002" target="_top" alt="널 지켜보고 있다" />
				<area shape="rect" coords="573,128,818,372" href="/shopping/category_prd.asp?itemid=1095765" target="_top" alt="내 충전기는 소중하니까" />
				<area shape="rect" coords="826,129,1072,374" href="/shopping/category_prd.asp?itemid=1113424" target="_top" alt="머리 속으로 치워버리자" />
				<area shape="rect" coords="69,393,314,637" href="/shopping/category_prd.asp?itemid=1197918" target="_top" alt="반짝반짝 트레이" />
				<area shape="rect" coords="323,393,567,637" href="/shopping/category_prd.asp?itemid=771146" target="_top" alt="걸이에서 (feat.옷걸이)" />
				<area shape="rect" coords="573,392,818,638" href="/shopping/category_prd.asp?itemid=1328744" target="_top" alt="책상위의 서커스보이밴드" />
				<area shape="rect" coords="826,393,1071,637" href="/shopping/category_prd.asp?itemid=1202849" target="_top" alt="100% 펑키 트래쉬" />
				<area shape="rect" coords="69,656,314,900" href="/shopping/category_prd.asp?itemid=1116307" target="_top" alt="내 책상의 시크릿 향기" />
				<area shape="rect" coords="321,657,566,901" href="/shopping/category_prd.asp?itemid=1300686" target="_top" alt="가을나들이는 미키와" />
				<area shape="rect" coords="574,656,818,902" href="/shopping/category_prd.asp?itemid=972970" target="_top" alt="스탠드-UP!" />
				<area shape="rect" coords="826,656,1070,901" href="/shopping/category_prd.asp?itemid=1289019" target="_top" alt="식탁위의 오아시스" />
			</map>
		</div>
		<dl class="evtNoti">
			<dt><img src="http://webimage.10x10.co.kr/eventIMG/2015/65902/tit_event_noti.png" alt="이벤트 유의사항" /></dt>
			<dd>
				<ul>
					<li>-  이벤트 기간 내에 새롭게 작성하신 상품후기에 한해서만 더블 마일리지가 적용됩니다.</li>
					<li>-  기존에 작성했던 상품후기 수정은 적용되지 않습니다.</li>
					<li>-  상품후기가 삭제된 경우에는 마일리지 지급이 되지 않습니다.</li>
					<li>-  상품후기는 배송정보 [출고완료] 이후부터 작성 하실 수 있습니다.</li>
					<li>-  상품과 관련 없는 내용이나 이미지를 올리거나, 직접 찍은 사진이 아닐 경우 삭제 및 마일리지 지급이 취소 될 수 있습니다.</li>
				</ul>
			</dd>
		</dl>
	</div>
<!-- #include virtual="/lib/db/dbclose.asp" -->