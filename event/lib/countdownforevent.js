/*
    ## 기획전 타이머 플러그인
    ## 2020.07.16; 임보라
    -----------------------------
    * 사용법
    <script type="text/javascript">
    countDownEventTimer({
        eventid: 104412,
        useDay: true
    });
    </script>
*/

function countDownEventTimer(opts) {
    var eventid = opts.eventid;
    var eventStartdate = '';
    var eventEnddate = '';
    $.ajax({
        type:"GET",
        url:"/event/etc/json/act_eventinfo.asp?eventid="+eventid,
        dataType: "text",
        async:false,
        cache:true,
        success : function(Data, textStatus, jqXHR){
            if (jqXHR.readyState == 4) {
                if (jqXHR.status == 200) {
                    if (Data!="") {
                        var result = JSON.parse(Data);
                        eventStartdate = result.events.startdate;
                        eventEnddate = result.events.enddate;						
                    } else {
                        alert("잘못된 접근 입니다.");
                        return false;
                    }
                }
            }
        },
        error : function(jqXHR, textStatus, errorThrown){
            alert("잘못된 접근 입니다.");					
            return false;
        }
    });

    var eventStartTime = new Date(eventStartdate);
    var eventEndTime = new Date(eventEnddate);
    var timerID;
    var startTime = new Date();
    var time = Math.floor((eventEndTime.getTime() - startTime.getTime()) / 1000);
    if (startTime < eventEndTime) {
        start_timer();
    } else {
        $("#day, #hour, #min, #sec").text("00");
    }
    function start_timer() {
        decrementTime();
        timerID = setInterval(decrementTime, 1000);
    }
    function decrementTime() {
        if(time > 0) time--;
        else clearInterval(timerID);
        toHourMinSec(time);
    }
    function toHourMinSec(t) {
        var day = 0;
        var hour = Math.floor(t / 3600);
        var min = Math.floor( (t-(hour*3600)) / 60 );
        var sec = t - (hour*3600) - (min*60);
        if (opts.useDay) {
            if (hour > 23) {
                day = Math.floor(hour / 24);
                hour = hour % 24;
            }
            if (day == 0) {
                $("#day").text("DAY");
            } else { 
                $("#day").text(day < 10 ? "0" + day : day);
            }
        }
        $("#hour").text(hour>99 ? 99 : hour < 10 ? "0" + hour : hour);
        $("#min").text(min < 10 ? "0" + min : min);
        $("#sec").text(sec < 10 ? "0" + sec : sec);
    }

    var actionStartDateElement = $("#evtStartDate");
    var actionEndDateElement = $("#evtEndDate");
    if (actionStartDateElement.length > 0) {
        actionStartDateElement.text(new Date(eventStartdate).formatDate("yyyy. MM. dd"));
    }
    if (actionEndDateElement.length > 0) {
        actionEndDateElement.text(new Date(eventEnddate).formatDate("yyyy. MM. dd"));
    }
}