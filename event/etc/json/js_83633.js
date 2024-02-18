var nowDt;
var montharray=new Array("Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec")
var minus_second = 0;

$(function(){
	$.ajax({
		type: "get",
		url: "/event/etc/json/act_83633_thgv.asp",
		data: "pdv="+vPageDiv,
		cache: false,
		success: function(message) {
			if(typeof(message)=="object") {
				// 오늘의 특가 상품 출력
				if(typeof(message.today)=="object") {
					$("#lyrTodayGift .thumbnail img").attr("src",message.today.imgurl).attr("alt",message.today.itemname);
					$("#lyrTodayGift a").attr("href","/shopping/category_prd.asp?itemid="+message.today.itemid);
					$("#lyrTodayGift .name").html(message.today.itemname);
					if(message.today.saleper!="") {
						$("#lyrTodayGift .price").html("<s>"+message.today.orgprice+"</s> "+message.today.sellprice+" ["+message.today.saleper+"]");
					} else {
						$("#lyrTodayGift .price").html(message.today.orgprice);
					}
					if(message.today.date!=""){
						nowDt = new Date(message.today.date);
						countdown();
					}
				}
			}
		},
		error: function(err) {
			console.log(err.responseText);
		}
	});
});

// 오늘의 특가 타이머
function countdown(){
	var usrDt=new Date();	// 현재 브라우저 시간
	var nextDt = new Date(usrDt.valueOf() + (24*60*60*1000)); //내일 시간

	var vTerm = parseInt(usrDt.getTime()/1000)-parseInt(nowDt.getTime()/1000);	// 시작시 시간과의 차이(초)
	minus_second = vTerm;	// 증가시간에 차이 반영

	var cntDt = new Date(Date.parse(nowDt) + (1000*minus_second));	//서버시간에 변화값(1초) 증가

	var todayy=cntDt.getYear()

	if(todayy < 1000) todayy+=1900;
		
	var todaym=cntDt.getMonth();
	var todayd=cntDt.getDate();
	var todayh=cntDt.getHours();
	var todaymin=cntDt.getMinutes();
	var todaysec=cntDt.getSeconds();

	// 내일용
	var nextM = nextDt.getMonth() + 1;
	var nextD = nextDt.getDate();
	var nextYY = nextDt.getFullYear();

	var todaystring=montharray[todaym]+" "+todayd+", "+todayy+" "+todayh+":"+todaymin+":"+todaysec;
	var futurestring=montharray[nextM-1]+" "+(nextD)+", "+nextYY+" 00:00:00";

	dd=Date.parse(futurestring)-Date.parse(todaystring);
	dday=Math.floor(dd/(60*60*1000*24)*1);
	dhour=Math.floor((dd%(60*60*1000*24))/(60*60*1000)*1);
	dmin=Math.floor(((dd%(60*60*1000*24))%(60*60*1000))/(60*1000)*1);
	dsec=Math.floor((((dd%(60*60*1000*24))%(60*60*1000))%(60*1000))/1000*1);

	if(dday < 0) {
		$("#countdown").html("00 : 00 : 00");
		return;
	}

	if(dhour < 10) dhour = "0" + dhour;
	if(dmin < 10) dmin = "0" + dmin;
	if(dsec < 10) dsec = "0" + dsec;
	dhour = dhour+'';
	dmin = dmin+'';
	dsec = dsec+'';

	// Print Time
	$("#lyrTodayGift .time em").eq(0).html(dhour.substr(0,1)+dhour.substr(1,1));
	$("#lyrTodayGift .time em").eq(1).html(dmin.substr(0,1)+dmin.substr(1,1));
	$("#lyrTodayGift .time em").eq(2).html(dsec.substr(0,1)+dsec.substr(1,1));
	
	setTimeout("countdown()",500);
}