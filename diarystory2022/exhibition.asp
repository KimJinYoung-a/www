<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.charset = "UTF-8" %>
<%
'####################################################
' Description : 다이어리 스토리 2021 이벤트 리스트
' History : 2020-08-31 정태훈
'####################################################
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/inc/head.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/lib/util/pageformlib.asp" -->
<!-- #include virtual="/lib/classes/search/searchcls.asp" -->
<!-- #include virtual="/lib/util/DBcacheLib.asp" -->
<!-- #include virtual="/lib/chkDevice.asp" -->
<!-- #include virtual="/lib/classes/event/exhibitionCls.asp" -->
<!-- #include virtual="/diarystory2022/lib/classes/diary_class_B.asp" -->
<%
'============== 모바일 접근시 모바일 페이지 이동(referer가 10x10이면 이동안함) ============
if InStr(request.ServerVariables("HTTP_REFERER"),"10x10.co.kr")<1 then
	if Not(Request("mfg")="pc" or session("mfg")="pc") then
		if Not(flgDevice="W" or flgDevice="D" or flgDevice="T") then
			Response.Redirect "//m.10x10.co.kr/diarystory2022/"
			REsponse.End
		end if
	end if
end if

Dim mktevent
dim masterCode
dim i

IF application("Svr_Info") = "Dev" THEN
    masterCode = "3"
else
    masterCode = "15"
end if

set mktevent = new cdiary_list
    mktevent.fnGetDiaryMKTEvent
%>
<%
public function couponDisp(couponVal)
	if couponVal = "" or isnull(couponVal) then exit function
	couponDisp = chkIIF(couponVal > 100, couponVal, couponVal & "%")
end function
%>
<style>
.gift-popup .btn-close {position: fixed !important;top: 0;right: 0;}
</style>
<script>
var _vPg=1, _vScrl=true;
var _scType="";
$(function(){
	// 스크롤시 추가페이지 접수
	$(window).scroll(function() {
		if ($(window).scrollTop() >= ($(document).height()-$(window).height())-512){
			if(_vScrl) {
                if(_scType!="P"){
                    _vScrl = false;
                    _vPg++;
                    $.ajax({
                        url: "/diarystory2022/api/diaryevent.asp?scT="+_scType+"&cpg="+_vPg,
                        cache: false,
                        success: function(message) {
                            if(message!="") {
                                $("#evtlist").append(message);
                                _vScrl=true;
                            } else {
                                $(window).unbind("scroll");
                            }
                        }
                        ,error: function(err) {
                            alert(err.responseText);
                            $(window).unbind("scroll");
                        }
                    });
                }
			}
		}
	});
    fnSortView('all');
    fnAmplitudeEventAction('view_diarystory_eventlist','','');
});

function fnSortView(scType){
    _scType=scType;
        $.ajax({
            url: "/diarystory2022/api/diaryevent.asp?scT=" + _scType + "&cpg=1",
            cache: false,
            success: function(message) {
                if(message!="") {
                    $("#evtlist").empty().append(message);
                    _vScrl=true;
                } else {
                    $(window).unbind("scroll");
                }
            }
            ,error: function(err) {
                alert(err.responseText);
                $(window).unbind("scroll");
            }
        });
        if(_scType=="all"){
            $("#mktevt").show();
        }
        else{
            $("#mktevt").hide();
        }
        $('#all').removeClass('on');
        $('#sale').removeClass('on');
        $('#gift').removeClass('on');
        $('#ips').removeClass('on');
        $('#'+scType).addClass('on');
        _vPg=1;
}
</script>
</head>
<body>
<div class="wrap">
    <!-- #include virtual="/lib/inc/incHeader.asp" -->
	<div class="container diary2021 new-type">
		<div id="contentWrap" class="dr-list-evt">
			<%'다이어리 스토리 GNB %>
			<!-- #include virtual="/diarystory2022/inc/header.asp" -->
            <section class="dr-top">
				<h2>주목해야 할 기획전</h2>
				<ul class="cate-evt">
					<li id="all"><a href="javascript:fnSortView('all');">전체</a></li>
					<li id="sale"><a href="javascript:fnSortView('sale');">할인이벤트</a></li>
					<li id="gift"><a href="javascript:fnSortView('gift');">사은이벤트</a></li>
					<li id="ips"><a href="javascript:fnSortView('ips');">참여이벤트</a></li>
				</ul>
			</section>
			<section class="sect-evt">
				<div class="sect-evt">
					<div class="evt-list" id="evtlist"></div>
				</div>
			</section>
		</div>
	</div>
	<!-- #include virtual="/lib/inc/incFooter.asp" -->
</div>
</body>
</html>
<!-- #include virtual="/lib/db/dbclose.asp" -->