<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/inc_const.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/util/pageformlib.asp" -->
<!-- #include virtual="/lib/classes/enjoy/eventApplyCls.asp" -->
<!-- #include virtual="/event/lib/event_etc_function.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<%
'#################################################################
' Description : 삼양 이벤트 - 세상에 없던 매운맛이 왔다옹
' History : 2020-12-08 이전도
'#################################################################
%>
<%
Dim userid, currentDate
currentDate =  now()
userid = GetEncLoginUserID()

if userid="ley330" or userid="greenteenz" or userid="rnldusgpfla" or userid="kobula" or userid="thensi7" or userid = "motions" or userid = "jj999a" or userid = "phsman1" or userid = "jjia94" or userid = "seojb1983" or userid = "kny9480" or userid = "bestksy0527" or userid = "mame234" or userid = "corpse2" or userid = "starsun726" or userid = "dlwjseh" then
	currentDate = #12/11/2020 09:00:00#
end if

Dim eCode
IF application("Svr_Info") = "Dev" THEN
	eCode   =  104276
Else
	eCode   =  108042
End If
%>
<style type="text/css">
.evt108042 {background-color:#fff;}
.evt108042 h2 {position:relative; background-color:#fff9e9;}
.evt108042 h2 .badge {position:absolute; top:140px; left:50%; margin-left:-50px; animation:bounce 1s 30;}
.evt108042 .intro,
.evt108042 .evt-item a,
.evt108042 .evt-prize,
.evt108042 .detail .character,
.evt108042 .thumbs {background-repeat:no-repeat; background-position:50% 50%; color:transparent;}
.evt108042 .intro {height:926px; background-image:url(//webimage.10x10.co.kr/fixevent/event/2020/108042/img_intro.jpg); background-color:#fff9e9;}
.evt108042 .evt-item a {display:block; width:100%; height:783px; background-color:#fff2ca; background-image:url(//webimage.10x10.co.kr/fixevent/event/2020/108042/img_item_v2.jpg);}
.evt108042 .smayang-evt {position:relative;}
.evt108042 .smayang-evt .input-box {display:flex; position:absolute; top:545px; left:50%; width:650px; height:86px; margin-left:-325px;}
.evt108042 .smayang-evt .input-box input {width:100%; padding:0 45px; background-color:transparent; font-size:24px; color:#999;}
.evt108042 .smayang-evt input::-ms-clear,
.evt108042 .smayang-evt input::-ms-reveal{display:none; width:0; height:0;}
.evt108042 .smayang-evt input::-webkit-search-decoration,
.evt108042 .smayang-evt input::-webkit-search-cancel-button,
.evt108042 .smayang-evt input::-webkit-search-results-button,
.evt108042 .smayang-evt input::-webkit-search-results-decoration{display:none;}
.evt108042 .smayang-evt .input-box .btn-submit {flex-shrink:0; margin-left:auto; width:152px; background-color:transparent; color:transparent;}
.evt108042 .smayang-evt .evt-prize {height:944px; background-image:url(//webimage.10x10.co.kr/fixevent/event/2020/108042/img_prize_v2.jpg);}
.evt108042 .detail {background-color:#ff6e1f;}
.evt108042 .detail .vod {width:920px; height:520px; margin:0 auto; background-color:#000;}
.evt108042 .detail .vod video {width:520px; height:100%;}
.evt108042 .detail .character {position:relative; height:2098px; background-image:url(//webimage.10x10.co.kr/fixevent/event/2020/108042/txt_detail.png);}
.evt108042 .detail .character a {display:inline-block; position:absolute; bottom:130px; left:50%; width:610px; height:140px; color:transparent;}
.evt108042 .detail .character .bnr-md1 {margin-left:-612px;}
.evt108042 .thumbs {height:2841px; background-image:url(//webimage.10x10.co.kr/fixevent/event/2020/108042/img_thumbs_v2.jpg);}
.evt108042 .noti {background-color:#111;}
@keyframes bounce {
	from, to {transform:translateY(0); animation-timing-function:ease-in;}
	50% {transform:translateY(-10px); animation-timing-function:ease-out;}
}
</style>
<div class="evt108042">
    <h2>
        <img src="//webimage.10x10.co.kr/fixevent/event/2020/108042/tit_event.png" alt="세상에 없던 매운맛이 왔다옹">
        <span class="badge"><img src="//webimage.10x10.co.kr/fixevent/event/2020/108042/img_badge.png" alt=""></span>
    </h2>
    <div class="intro">2020년 힘들었던 한 해를 보낸 분들을 위해 텐바이텐과 삼양이 세상에 없던 불타는 매운맛을 위해 뭉쳤어요!</div>
    <div class="evt-item">
        <a href="/shopping/category_prd.asp?itemid=3493198&pEtr=108042" target="_blank">하이, 페퍼스 키친 1인 식기세트<img src="" alt=""></a>
    </div>
    <div class="smayang-evt">
        <div class="evt-cont">
            <img src="//webimage.10x10.co.kr/fixevent/event/2020/108042/txt_event.jpg" alt="힘들었던 2020년, 귀엽게 이겨낼 수 있도록 초성 힌트를 보고 페퍼밀 리빙 신상 굿즈의 이름을 맞춰주세요!">
            <div class="input-box">
                <input id="txtAnswer" type="text" placeholder="텍스트를 입력해주세요.">
                <button id="btnAnswer" class="btn-submit">등록</button>
            </div>
        </div>
        <div class="evt-prize">이벤트 당첨상품</div>
    </div>
    <div class="detail">
        <p><img src="//webimage.10x10.co.kr/fixevent/event/2020/108042/tit_detail.png" alt="detail"></p>
        <div class="vod">
            <video preload="auto" autoplay="true" loop="loop" muted="muted" volume="0">
                <source src="http://webimage.10x10.co.kr/video/vid1049.mp4" type="video/mp4">
            </video>
        </div>
        <div class="character">
            <a href="#mapGroup351116" class="bnr-md1">세상에 없던 불타게 매운맛 더보기!</a>
            <a href="#mapGroup351136" class="bnr-md2">한국인의 맵부심의 원조 붉닭시리즈 더보기!</a>
        </div>
    </div>
    <div class="thumbs"></div>
    <div class="noti"><img src="//webimage.10x10.co.kr/fixevent/event/2020/108042/txt_noti.png" alt="유의사항"></div>
</div>
<script>
    document.getElementById('btnAnswer').addEventListener('click', function() {
        const ans = document.getElementById('txtAnswer').value.trim();
        if( ans === '' )
            return false;

        <% If IsUserLoginOK() Then %>
            <% If not( left(currentDate,10) >= "2020-12-10" and left(currentDate,10) <= "2021-01-08" ) Then %>
                alert("이벤트 응모 기간이 아닙니다.");
                return;
            <% else %>
                let apiUrl
                if( unescape(location.href).includes('//localhost') || unescape(location.href).includes('//2015www') || unescape(location.href).includes('//localwww')) {
                    apiUrl =  '//testfapi.10x10.co.kr/api/web/v1'
                } else if( unescape(location.href).includes('//stgwww') || unescape(location.href).includes('//www') ) {
                    apiUrl =  '//fapi.10x10.co.kr/api/web/v1'
                }

                const subscription_apiurl = apiUrl + '/event/common/subscription';

                const post_data = {
                    event_code: '<%=eCode%>',
                    event_option1: ans,
                    check_option1: false
                };
                $.ajax({
                    type: "POST",
                    url: subscription_apiurl,
                    data: post_data,
                    ContentType: "json",
                    crossDomain: true,
                    xhrFields: {
                        withCredentials: true
                    },
                    success: function (data) {
                        if( data.result ) {
                            document.getElementById('txtAnswer').value = '';
                            alert(data.message);
                            fnAmplitudeEventMultiPropertiesAction('click_event_apply','evtcode', post_data.event_code);
                        } else {
                            alert('데이타를 저장하는 도중에 에러가 발생하였습니다. 관리자 문의 요망. (에러코드 : 001)');
                        }
                    },
                    error: function (xhr) {
                        console.log(xhr.responseText);
                        try {
                            const err_obj = JSON.parse(xhr.responseText);
                            console.log(err_obj);
                            switch (err_obj.code) {
                                case -10: alert('이벤트에 응모를 하려면 로그인이 필요합니다.'); return false;
                                case -602: case -603: alert(err_obj.message); return false;
                                default: alert(err_obj.message); return false;
                            }
                        }catch(error) {

                            console.log(error);
                            alert('데이타를 저장하는 도중에 에러가 발생하였습니다. 관리자 문의 요망. (에러코드 : 002)');
                        }
                    }
                });
            <% end if %>
		<% Else %>
			if(confirm("로그인을 하셔야 참여가 가능 합니다. 로그인 하시겠습니까?")){
				top.location.href="/login/loginpage.asp?vType=G";
				return false;
			}
			return false;
		<% End IF %>
    });
</script>