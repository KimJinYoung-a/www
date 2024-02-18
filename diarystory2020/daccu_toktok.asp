
<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.charset = "UTF-8" %>
<%
'####################################################
' Description : 다이어리 스토리 2020 다꾸톡톡 페이지
' History : 2019-09-17 원승현 생성
'####################################################
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/inc/head.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/diarystory2020/lib/worker_only_view.asp" -->
<!-- #include virtual="/diarystory2020/lib/classes/daccutoktokcls.asp" -->
<!-- #include virtual="/lib/util/pageformlib.asp" -->
<!-- #include virtual="/lib/classes/search/searchcls.asp" -->
<!-- #include virtual="/lib/util/DBcacheLib.asp" -->
<!-- #include virtual="/lib/chkDevice.asp" -->
<%

    Dim vDate, vRankingCount, vCateType, sqlStr, vDaccuType, i, gnbflag, j
    Dim UserPageSize, UserCurrPage
    
    Dim oDaccuTalk, oDaccuTalkDetail, oDaccuTalkUserList
    set oDaccuTalk = new CDaccuTokTok
    oDaccuTalk.FPageSize = 1000
    oDaccuTalk.FCurrPage = 1
    oDaccuTalk.GetDaccuTokTokManagerList

    set oDaccuTalkDetail = new CDaccuTokTok
%>
<script type="text/javascript" src="/lib/js/jquery.masonry.min.js"></script>
<script src="/lib/js/jquery.tinyscrollbar.js"></script>
<script type="text/javascript">

var vScrl=true;

$(function(){
	// MD 롤링
	if ($('.md-rolling .rolling-item').length > 1) {
		var slider = $('.md-rolling');
		var progressBar = $('.md-dctalk .progressbar-fill');
		slider.on('init', function () {
			var amt = $('.rolling-item').length;
			var init = 100 / amt;
			progressBar.css('width', init + '%');
		});
		slider.on('beforeChange', function(event, slick, currentSlide, nextSlide) {
			var calc = ( (nextSlide+1) / (slick.slideCount) ) * 100;
			progressBar.css('width', calc + '%');
		});
		$('.md-rolling').slick({
			autoplay: true,
			speed: 1000,
			infinite: true,
			fade: true,
			adaptiveHeight: true
		});
	} else {
		$(".md-dctalk .progressbar").hide();
	}

	tagDir('.md-rolling .img-area .mark-list');

	// 전면배너
	var maskW = $(document).width();
	var maskH = $(window).height();
	$('#mask').css({'width':maskW,'height':maskH,'position':'fixed'});

	// 등록 버튼 클릭시 팝업
	$('.best-list .btn-add').click(function(){
		popupShow();
	});
	// 팝업 닫기
	$('.popup-dctalk .btn-close').click(function(){
		$('.popup-dctalk').hide();
		$('#boxes').hide();
		$('#mask').hide();
	});
	$('#mask').click(function() {
		$('.popup-dctalk').hide();
	});
	vScrl = true;
    getUserDaccuMasterList();
});
$(window).load(function(){
	$('.best-list').masonry({
		columnWidth: 390,
		itemSelector: '.best-list li'
	});
});

$(window).scroll(function () {
	if ($(window).scrollTop() >= ($(document).height()-$(window).height())-500) {
		if(vScrl) {
			vScrl = false;
			$("#userCurrPage").val(parseInt($("#userCurrPage").val())+1);
			getUserDaccuMasterList();
		}            
	}
});

<%'// 유저가 등록한 다꾸 리스트 불러오기 %>
function getUserDaccuMasterList() {
    $.ajax({
        type:"GET",
        url:"/diarystory2020/lib/act_daccu_toktok_usermasterlist.asp",
        data:$("#daccuUserMaster").serialize(),
        dataType: "text",
        async:false,
        cache:true,
        success : function(Data, textStatus, jqXHR){
            if (jqXHR.readyState == 4) {
                if (jqXHR.status == 200) {
                    if(Data!="") {
                        if($("#userCurrPage").val()==1) {
                            $("#userMasterList").empty().html('<li><button type="button" class="btn-add" name="modal" onclick="daccuTokWrite();">다꾸템 등록하기</button></li>'+Data);
                            vScrl=true;
                        } else {
                            $str = $(Data);

                            setTimeout(function(){
                                $('#userMasterList').append($str).masonry('appended',$str);
								$('.best-list').masonry({
									columnWidth: 390,
									itemSelector: '.best-list li'
								});
                                vScrl=true;
                            }, 50);
                        }
                    } else {
                        //alert("잘못된 접근 입니다.");
                        //document.location.reload();
                        return false;
                    }
                }
            }
        },
        error:function(jqXHR, textStatus, errorThrown){
            alert("잘못된 접근 입니다.");					
            // document.location.reload();
            return false;
        }
    });
}

<%'// 모달 레이어 오픈 %>
function fnOpenModal(sUrl) {
	if(sUrl==""||sUrl=="undefind") return;

	$.ajax({
		url: sUrl,
		cache: false,
		success: function(message) {
			$("#popup-dctalk").empty().html(message);
			/*
			if($(message).find("#scrollarea").length>0) {
				setTimeout(function(){
					myScroll = new iScroll('scrollarea',{
						onBeforeScrollStart: function (e) {
							var target = e.target;
							while (target.nodeType != 1) target = target.parentNode;
							if (target.tagName != 'SELECT' && target.tagName != 'INPUT' && target.tagName != 'TEXTAREA')
								e.preventDefault();
						}
					});
				},250);
			}
			*/

			//document.addEventListener('touchmove', fEvt, false);
		}
		,error: function(err) {
			alert(err.responseText);
		}
	});

	$("#popup-dctalk").show();
}

<%'// 모달 레이어 닫기 %>
function fnCloseModal() {
	$("#popup-dctalk").hide(0,function(){
		//myScroll = null;
		$(this).empty();
	});
	$('#mask').hide();
}

<%'// 사용자가 등록한 다꾸 삭제 %>
function fnDeleteDaccu(midx) {
	if (confirm('등록하신 다꾸톡톡을 삭제하시겠습니까?')) {
		$.ajax({
            type:"GET",
            url:"/diarystory2020/lib/ajaxDaccuTokTok.asp?daccuTokMode=daccuDelete&daccuTokMasterIdx="+midx,
            //data: ,
            dataType: "text",
            async:false,
            cache:true,
            success : function(Data, textStatus, jqXHR){
                if (jqXHR.readyState == 4) {
                    if (jqXHR.status == 200) {
                        if(Data!="") {
                            var result = JSON.parse(Data)
                            if(result.response == "ok"){									
                                document.location.href='/diarystory2020/daccu_toktok.asp'									
                                return false;
                            }else{
                                alert(result.faildesc);
                                return false;
                            }
                        } else {
                            alert("잘못된 접근 입니다.");
                            document.location.reload();
                            return false;
                        }
                    }
                }
            },
            error:function(jqXHR, textStatus, errorThrown){
                alert("잘못된 접근 입니다.");					
                // document.location.reload();
                return false;
            }
        });
	} else {
		return;
	}
}

// 팝업 띄우기
function popupShow () {
	$('#boxes').show();
	$('#mask').show();
	$('.popup-dctalk').show();
	setTimeout(function(){
		tagDir('.popup-dctalk .dctem-thumb .mark-list');
		popCon('.popup-dctalk');
    }, 350);
}

<%'// 팝업을 띄울때만 팝업 창 크기 조절하는 팝콘 %>
function popCon (popup) {
	var leftH = $(popup).find('.dctem-left').outerHeight();
	var headH = $(popup).find('.dctem-head').outerHeight();
	var conH = leftH - headH - 22;
	$(popup).find('.dctem-conts').css('height', conH);
	$(popup).find('.scrollbarwrap1 .viewport').css('height', conH);
	$(popup).find('.scrollbarwrap1').tinyscrollbar();
}

<%'// 구매리스트를 불러올때 사용하는 팝콘 %>
function popCon2 (popup) {
	var leftH = $(popup).find('.dctem-left').outerHeight();
	var conH = leftH - 22;
	$(popup).find('.dctem-conts').css('height', conH);
	$(popup).find('.scrollbarwrap1 .viewport').css('height', conH);
	$(popup).find('.scrollbarwrap1').data("plugin_tinyscrollbar").update();
}

<%'// 구매 상품 선택 또는 구매 상품 취소 시 사용하는 팝콘 %>
function popCon3 (popup) {
	var leftH = $(popup).find('.dctem-left').outerHeight();
	var headH = $(popup).find('.dctem-head').outerHeight();
	var conH = leftH - headH - 22;
	$(popup).find('.dctem-conts').css('height', conH);
	$(popup).find('.scrollbarwrap1 .viewport').css('height', conH);
	$(popup).find('.scrollbarwrap1').data("plugin_tinyscrollbar").update();
}

// 태그 방향
function tagDir (target) {
	$(target).find('.mark').each(function(){
		var posL = $(this).position().left;
		var imgW = $(this).parent('.mark-list').width();
		if( posL > (imgW*0.7) ) {
			$(this).addClass('dl');
		}
	});
}

function daccutoktokView(midx) {
	fnOpenModal('/diarystory2020/daccu_toktok_view.asp?masterIdx='+midx);
	popupShow();
}

<%'// 이전글,다음글 %>
function fnDaccuMoveView(midx) {
	fnCloseModal();
	fnOpenModal('/diarystory2020/daccu_toktok_view.asp?masterIdx='+midx);
	popupShow();
}

function daccuTokWrite() {
	<% If IsUserLoginOK() Then %>
		fnOpenModal('/diarystory2020/daccu_toktok_write.asp');
		popupShow();	
    <% Else %>
		if(confirm("로그인을 하셔야 작성하실 수 있습니다.")){
			location.href='/login/loginpage.asp?backpath=<%=Server.URLencode("/diarystory2020/daccu_toktok.asp")%>';
			return;
		}
    <% End If %>
}
</script>
<!-- 주년 기간동안 배너추가 10/10 ~ 11/30 css 수정 -->
<style>
	.diary-header {display:none;}
	.bnr_top {width:1140px; margin:-300px auto 0;}
	.bg_top {width:1920px; height:360px; margin:0 auto; background:#ffbadf;}
	.diary2021 .best-dctalk > .inner {border-top:0!important;}
</style>
</head>
<body>
<div class="wrap">
	<!-- #include virtual="/lib/inc/incHeader.asp" -->
	<% if InStr(request.ServerVariables("HTTP_REFERER"),"/diarystory2021/") > 0 or date() >= "2020-09-07" then %>
	<div class="container diary2021">
	<% else %>
	<div class="container diary2020">
	<% end if %>
		<div id="contentWrap" class="diary-sub">
			<% if InStr(request.ServerVariables("HTTP_REFERER"),"/diarystory2021/") > 0 or date() >= "2020-09-07" then %>
            <!-- #include virtual="/diarystory2021/inc/header.asp" -->
			<% else %>
			<!-- #include virtual="/diarystory2020/inc/head.asp" -->
			<% end if %>
			<div class="diary-content">
				<!-- <div class="talk-wrap">
					<div class="md-dctalk">
						<%' for dev msg : MD 롤링 ( 어드민에서 bg 색상 지정(추후개발) ) %>
						<div class="md-rolling">
                            <% If oDaccuTalk.FResultCount > 0 Then  %>
                                <% FOR i = 0 to oDaccuTalk.FResultCount-1 %>
                                    <div class="rolling-item">
                                        <i class="bg-color" style="background-color:;"></i>
                                        <div class="img-area">
                                            <img src="<%=oDaccuTalk.FItemList(i).FMasterImage%>" alt="">
                                            <%
                                                oDaccuTalkDetail.FRectMasterIdx = oDaccuTalk.FItemList(i).FMasterIdx
                                                oDaccuTalkDetail.GetDaccuTokTokDetailManagerList
                                            %>                                            
                                            <ul class="mark-list">
                                                <% If oDaccuTalkDetail.FResultCount > 0 Then %>
                                                    <% For j = 0 to oDaccuTalkDetail.FResultCount-1 %>                                            
                                                        <li class="mark" style="left:<%=oDaccuTalkDetail.FItemList(j).FDetailXValue%>%; top:<%=oDaccuTalkDetail.FItemList(j).FDetailYValue%>%;">
                                                            <a href="/shopping/category_prd.asp?itemid=<%=oDaccuTalkDetail.FItemList(j).FDetailItemId%>" target="_blank">
                                                                <i class="ico-plus"></i>
                                                                <div class="box">
                                                                    <%' for dev msg : 상품명 2줄 이상은 말줄임 처리 해주세요 %>
                                                                    <p class="name"><%=chrbyte(oDaccuTalkDetail.FItemList(j).FDetailItemName, 25, "Y")%></p>
                                                                </div>
                                                            </a>
                                                        </li>
                                                    <% Next %>
                                                <% End If %>
                                            </ul>
                                        </div>
                                        <div class="text-area">
                                            <%' for dev msg : MD 등록일 경우 a href 제거 / 업체 등록일 경우 a href 브랜드 페이지 랜딩 %>
                                            <%' 모바일엔 없는 기능이 pc엔 추가되어 있어서 일단 기능 구현 안함 %>  -->
                                            <!--a href="/street/street_brand_sub06.asp?makerid=dailylike"-->
                                                <!-- <div class="tit"><%=oDaccuTalk.FItemList(i).FMasterRegUserFrontName%>의 다꾸템 대공개!</div>
                                                <div class="md-info">
                                                    <div class="thumbnail"><img src="<%=oDaccuTalk.FItemList(i).FMasterRegUserImage%>" alt=""></div>
                                                    <div class="desc">텐바이텐<br><%=oDaccuTalk.FItemList(i).FMasterRegUserFrontName%></div>
                                                </div> -->
                                            <!--/a-->
                                        <!-- </div>
                                    </div>
                                <% Next %>
                            <% End If %>
						</div>
						<div class="progressbar"><span class="progressbar-fill"></span></div>
						<%' // MD 롤링 %>
					</div>  -->
					<!-- 주년 기간동안 배너추가 10/10 ~ 11/30 -->
					<div class="bg_top"></div>
					<div class="bnr_top">
						<% If now() < "2022-12-01" Then %>
						<img src="//fiximage.10x10.co.kr/web2019/diary2020/bnr_talk2023.png?v=1.2" alt="월간 다꾸왕">
						<% End If %>
						<% If now() >= "2022-12-01" Then %>
						<img src="//fiximage.10x10.co.kr/web2019/diary2020/bnr_talk2023_new.png" alt="월간 다꾸왕">
						<% End If %>
					</div>
					<div class="best-dctalk">
						<div class="inner">
							<div class="hgroup">
								<h3>나두 한 다꾸 한다면 <strong>베스트 다꾸러 도전!</strong></h3>
								<%' 20190906 : 텍스트 수정(br) %>
								<div>
									<p class="txt1">나만의 다이어리를 자랑해주세요! <br>다꾸 부터 데스크테리어까지 다이어리와 함께한 모든 순간을 남겨주세요. </p>
								</div>
							</div>
							<ul class="best-list" id="userMasterList"></ul>
						</div>
					</div>
			</div>
		</div>
		<div class="popup-dctalk" id="popup-dctalk" style="display:none"></div>
	</div>
	<!-- #include virtual="/lib/inc/incFooter.asp" -->
</div>
<form name="daccuUserMaster" id="daccuUserMaster" method="post">
    <input type="hidden" name="userCurrPage" id="userCurrPage" value="1">
</form>
</body>
</html>
<%
    Set oDaccuTalk = Nothing
    Set oDaccuTalkDetail = Nothing
%>
<!-- #include virtual="/lib/db/dbclose.asp" -->