<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.charset = "UTF-8" %>
<%
'###########################################################
' Description : 18주년 댓글 이벤트
' History : 2019-09-24
'###########################################################
%>
<!-- #include Virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/inc_const.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<%
public function getWord(evtcode)
    dim word, sqlstr 
    
    sqlStr = sqlStr & "  SELECT top 1 option1 as 'word' " &vbcrlf
    sqlStr = sqlStr & "  FROM DB_EVENT.DBO.tbl_realtime_event_obj " &vbcrlf
    sqlStr = sqlStr & "  where evt_code = "& evtcode &vbcrlf
    sqlStr = sqlStr & "      and datediff(day, open_date, getdate()) = 0 " &vbcrlf

    rsget.Open sqlstr, dbget, 1
    IF Not rsget.EOF THEN
        word = rsget("word")
    end if	
    rsget.close
		
    getWord = word	
end function
%>
<%
dim evtStartDate, evtEndDate, currentDate, presentDate

currentDate =  date()
evtStartDate = Cdate("2019-09-24")
evtEndDate = Cdate("2019-10-31")

'test
'currentDate = Cdate("2019-12-31")

dim eCode
IF application("Svr_Info") = "Dev" THEN
	eCode   =  90391'
Else
	eCode   =  97588
End If

dim userid
	userid = GetEncLoginUserID()
dim todaysWord
todaysWord = getWord(eCode)
%>
<link rel="stylesheet" type="text/css" href="/lib/css/anniversary18th.css?v=3.02">
<script type="text/javascript">
    $(function(){
        getList(1, true);
    })
    $(function () {
        // 스크롤
        $('.scrollD a').click(function(event){
            event.preventDefault();
            window.parent.$('html,body').animate({scrollTop:$(this.hash).offset().top}, 500);
        });
    });
    function shuffleItems(){
        //댓글 배경이미지 랜덤
        var cmtBg = new Array(10);
        for (var i = 0; i < cmtBg.length; i++) {
            cmtBg[i]=Math.floor(Math.random()*10 +1)
            for (var j=0; j<i; j++){
                if(cmtBg[j]==cmtBg[i]){i--;}
            }
        }
        $('.cmt-list li').each(function(){
            var t=$(this).index();
            $('.cmt-list li').eq(t).css({'background-image': 'url(//webimage.10x10.co.kr/fixevent/event/2019/18th/bg_cmt_'+cmtBg[t]+'.png)' })
        })
    }
    function validate(){
        var chkRes = true
        $(".input-box input[type='text']").each(function(idx, el){
            if(el.value == ''){
                alert('댓글을 적어주세요.');
                el.focus();
                chkRes = false
                return false;
            }
            chkRes = true
        })
        return chkRes
    }
    function chkLogin(){
        <% If not IsUserLoginOK() Then %>
		if(confirm("로그인을 하셔야 참여가 가능 합니다. 로그인 하시겠습니까?")){
			top.location.href="/login/loginpage.asp?vType=G&backpath=<%=Server.URLencode("/event/eventmain.asp?eventid="&eCode)%>";
		}
        return false;
        <% end if %>
        return true
    }
    function jsSubmitComment(mode, idx){
        <% if not ( currentDate >= evtStartDate and currentDate <= evtEndDate ) then %>
            alert("이벤트 참여기간이 아닙니다.");
            return false;
        <% end if %>
        if(!chkLogin()) return false;
        if(mode == 'addoo'){if(!validate()) return false;}
        if(mode == 'del'){if(!confirm('삭제 하시겠습니까?')) return false;}

        var payLoad = {
            mode: mode,
            eventCode: '<%=eCode%>',
            inputCommentData: $("#txtContent").val(),
            idx: idx
        }
        $.ajax({
            type: "post",
            url: "/event/evt_comment/api/comment_action.asp",
            data: payLoad,
            success: function(data){
                var res = data.split("|")
                if(res[0] == "ok"){
                    getList(1);
                    resetForm()
                }else if(res[0] == "Err") {
                    alert(res[1])
                }
                // console.log(data, mode)
            },
            error: function(e){
                console.log(e)
            }
        })
    }
    function resetForm(){
        $(".input-box input[type='text']").each(function(idx, el){el.value = ''})
    }

    function getList(currentPage, init){
        var pageSize = 10

        if (!currentPage){currentPage=1;}
        var payLoad = {
            currentPage: currentPage,
            eventCode: '<%=eCode%>',
            pageSize: pageSize,
            scrollCount: 10,
            evtCmtDataType: 2
            // isMyComments: 1
        }
        var items = []
        var pagingData = {}

        $.ajax({
            type: "GET",
            url: "/event/evt_comment/api/comment_list.asp",
            data: payLoad,
            dataType: "json",
            cache: false,
            success: function(Data){
                items = Data.comments
                pagingData = Data.pagingData

                renderPaging(pagingData)
                renderItems(items)
                shuffleItems();
                if(!init) window.$('html,body').animate({scrollTop:$("#cmtList").offset().top}, 400);
            },
            error: function(e){
                console.log('데이터를 받아오는데 실패하였습니다.')
            }
        })
    }
    function renderPaging(pagingObj){
        // if(Object.keys(pagingObj).length === 0 && pagingObj.constructor === Object) return false;
        var pagingHtml='';
        var totalpage = parseInt(pagingObj.totalpage);
        var currpage = parseInt(pagingObj.currpage);
        var scrollpage = parseInt(pagingObj.scrollpage);
        var scrollcount = parseInt(pagingObj.scrollcount);
        var totalcount = parseInt(pagingObj.totalcount);
        var totalHtml = totalpage > 0 ? '<h3>총 <b>'+ totalcount +'</b>개의 이야기</h3>' : ''
        $("#totCnt").html(totalHtml)

        if(totalpage > 0){
            var prevHtml = currpage > 1 ? ' <a href="" class="prev arrow" onclick="getList('+(currpage-1)+'); return false;"><span>이전페이지로 이동</span></a> ' : ''
            var nextHtml = currpage < totalpage ? ' <a href="" class="next arrow" onclick="getList('+(currpage+1)+'); return false;"><span>다음 페이지로 이동</span></a>' : ''
            
            pagingHtml +='<div class="paging">' + prevHtml
            for (var ii=(0+scrollpage); ii< (scrollpage+scrollcount); ii++) {
                if(ii > totalpage){
                    break;
                }
                if(ii==currpage){
                    pagingHtml +='<a href="javascript:void(0)" class="current"><span>'+ii+'</span></a>'
                }else{
                    pagingHtml +='<a href="" onclick="getList('+ii+'); return false;"><span>'+ii+'</span></a>'
                                   
                }
            }
            pagingHtml += nextHtml + '</div>';
        }
        $("#pagingElement").html(pagingHtml);
    }
    function renderItems(items){
        if(items.length < 1){
            var noResultHtml = ''
            $("#listContainer").html(noResultHtml);
            return false;
        }
        var listHtmlStr = ''
        var deleteBtn = ''
        items.forEach(function(item){            
            deleteBtn = item.isMyContent ? '<a href="javascript:jsSubmitComment(\'del\', '+ item.contentId +')" class="btn-del"><img src="//webimage.10x10.co.kr/fixevent/event/2019/18th/btn_del.png" alt="삭제"></a>' : ''
            listHtmlStr += '\
                    <li><span>\
                    '+ item.content +'\
                    '+ deleteBtn +'\
                    </span></li>\
            '
        })
        $("#listContainer").html(listHtmlStr);
    }
</script>
<div class="anniversary18th cmtEvt">
    <!-- 주년 헤드 -->
    <div class="intro">
        <div class="inner">
            <h2><img src="//webimage.10x10.co.kr/fixevent/event/2019/18th/tit_18th.png" alt="18th Your 10X10"></h2>
            <ul class="nav">
                <li class="scrollD"><a href="#taste">오늘의 취향?<span class="icon-chev"></span></a></li>
                <li><a href="/event/eventmain.asp?eventid=97589">스누피의 선물? <span class="icon-chev"></span></a></li>
            </ul>
        </div>
    </div>
    <!--// 주년 헤드 -->

    <!-- 댓글 -->
    <div class="bg-wrap">
        <div class="topic">
            <div class="hello">
                <!-- 이름 -->
                <span>안녕! <%=chkIIF(IsUserLoginOK(), "<b>"& GetLoginUserName() &"</b>님", "")%><br><%=todaysWord%></span>
            </div>
            <span><img src="//webimage.10x10.co.kr/fixevent/event/2019/18th/txt_guide.png" alt="당신에게 텐바이텐이란 무엇인지 들려주세요! 추첨을 통해 1000분께 1000원 기프트카드를 드립니다. "></span>
            <p><img src="//webimage.10x10.co.kr/fixevent/event/2019/18th/txt_date.png" alt="기간 : 10.01 – 31 당첨자 발표 : 11.05"></p>
        </div>
        <div class="cmt-area">
            <div class="input-box">
                <input type="text" onclick="chkLogin()" id="txtContent" placeholder="입력해주세요" maxlength=50>
            </div>
            <button type="button" onclick="jsSubmitComment('addoo')"><img src="//webimage.10x10.co.kr/fixevent/event/2019/18th/btn_submit.png" alt="등록"></button>
        </div>
    </div>
    <div class="cmt-list" id="cmtList">        
        <div id="totCnt"></div>
        <ul id="listContainer"></ul>
        <div id="pagingElement" class="pageWrapV15"></div>
    </div>
    <!--// 댓글 -->

    <!-- 사은품 -->
    <div class="bnr-gift" id="bnr-gift">
        <a href="/event/eventmain.asp?eventid=97589">구매 금액별 스누피 선물, 스누피의 선물 더보러 가기</a>
    </div>
    <!--// 사은품 -->

    <!-- #include virtual="/event/18th/inc_banner.asp" -->
</div>
<!-- #include virtual="/lib/db/dbclose.asp" -->