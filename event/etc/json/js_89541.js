var nowDt;
var customDate
var montharray=new Array("Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec")
var minus_second = 0;
var gaparam1 = '&gaparam=main_just1day17th_1'
var gaparamBrand = '&gaparam=main_just1day17th_'

var today = new Date();
var dd = today.getDate();
var vDate = dd.toString();
if(dd == 27 || dd == 28){	
	var vDate = 29
}

//  dd = 21

var testparam = getQuerystring("testdate");
var link = document.location.href;
var dataGetUrl = "/event/etc/json/act_89541_thgv.asp";



if(testparam){
	dataGetUrl = "/event/etc/json/act_89541_thgv.asp"+"?"+testparam	
	vDate = testparam.substring(testparam.length - 2, testparam.length);	
}

function getQuerystring(paramName){
	var _tempUrl = window.location.search.substring(1); 		
	if(_tempUrl != ""){
		var _tempArray = _tempUrl.split('&');		

		for(var i = 0; i < _tempArray.length; i++){
			var _keyValuePair = _tempArray[i].split('='); 			
			if(_keyValuePair[0] == paramName){
		 	return _tempUrl;
		   } 
	    } 
	}
} 

$(function(){
	$.ajax({
		type: "get",
		url: dataGetUrl,
		data: "",
		cache: false,
		success: function(message) {			
			if(typeof(message)=="object") {
				console.log(message)
				if(link.indexOf("event") == -1){
					//===========================================메인 영역 랜더링===============================================
					if(typeof(message.today)=="object") {
						//날짜 렌더링				
						if(message.today.date!=""){
							nowDt = new Date(message.today.date);									
							customDate = nowDt.format('MM')+"월"+nowDt.format('dd')+"일";												
							countdown();
						}
						//오늘의 특가 렌더링				
						$("#specialItemThumbnail img").attr("src","http://webimage.10x10.co.kr/fixevent/event/2018/today/10"+vDate+"/img_item.png?v=2.0").attr("alt",message.today.itemname);						
						$("#specialItemName").html(message.today.itemname);
						$("#17thSpecialItems .inner-cont h2").html(customDate+" <strong>오늘의 특가</strong>"); // 날짜
						$("#17thItemLink").attr("href","http://www.10x10.co.kr/shopping/category_prd.asp?itemid="+message.today.specialItemCode+gaparam1);	//랜딩url						
						$("#17thItemLink").click(function(){							
							fnAmplitudeEventMultiPropertiesAction("click_17th_todayspecial_main_item","itemname|itemcode",message.today.itemname+"|"+message.today.specialItemCode);
						})						
						if(message.today.itemdiv == 21){
							// $("#specialItemPrice s").html(message.today.orgprice);
							$("#specialItemPrice b").html(message.today.specialItemDealSalePrice+"~");
							$("#17thSpecialItemSalePer").html(message.today.specialItemDealSalePer);
						}else{
							$("#specialItemPrice s").html(message.today.orgprice);
							$("#specialItemPrice b").html(message.today.sellprice);
							$("#17thSpecialItemSalePer").html(message.today.saleper);
						}						
					}
				
					// 브랜드 리스트 렌더링
					if(typeof(message.brandList)=="object") {
						var i=0;
							$(message.brandList).each(function(){
								// console.log(this.brandName);
								var brname = this.brandName;
								$("#17thBrnadEventList li img").eq(i).attr('src', "http://webimage.10x10.co.kr/fixevent/event/2018/today/10"+vDate+"/img_brand_0"+parseInt(i+1)+".png?v=1.0");	//이미지
								$("#17thBrnadEventList li .name").eq(i).html(this.brandName);			//이름
								$("#17thBrnadEventList li .subname").eq(i).html(this.brandCopy);			//이름
								
								if (this.linktype == "1"){
									$("#17thBrnadEventList li a").eq(i).attr('href', "http://www.10x10.co.kr/shopping/category_prd.asp?itemid="+this.evtcode+gaparamBrand+parseInt(i+2));
								} else {
									$("#17thBrnadEventList li a").eq(i).attr('href', "http://www.10x10.co.kr/event/eventmain.asp?eventid="+this.evtcode+gaparamBrand+parseInt(i+2));
								}//랜딩url
								$("#17thBrnadEventList li a").eq(i).click(function(){
									fnAmplitudeEventMultiPropertiesAction("click_17th_todayspecial_main_brandlist","brandname",brname);
								})														
								$("#17thBrnadEventList li a .desc .discount").eq(i).html(this.brandSalePer + "%");	 	//할인율
								i++;
							});
						$("#lyrItemList li").each(function(){
						});
					}
				}else{
					//===========================================이벤트 영역 랜더링===============================================
					// 오늘의 특가 상품 출력

					if(message.today.date!=""){
						nowDt = new Date(message.today.date);									
						customDate = nowDt.format('MM')+"월"+nowDt.format('dd')+"일"+nowDt.format('(KS)');												
					}					
					if(typeof(message.today)=="object") {
						//랜딩					
						$("#today .today-main img").attr("src","http://webimage.10x10.co.kr/fixevent/event/2018/17th/89541/img_main_10"+vDate+"_v01.png").attr("alt",message.today.itemname);						
						$("#today .name").html(message.today.itemname);						
						$("#todayLink").attr("href","http://www.10x10.co.kr/shopping/category_prd.asp?itemid="+message.today.specialItemCode+gaparam1);	//랜딩url
						$("#todayLink").click(function(){
							fnAmplitudeEventMultiPropertiesAction("click_17th_todayspecial_event_item","itemname|itemcode",message.today.itemname+"|"+message.today.specialItemCode);
						})					

						if(message.today.itemdiv == 21){
							$("#today ul .ex-price").css("display","none");
							$("#today ul .price").html(message.today.specialItemDealSalePrice+"~");
							$("#today .rate").html(message.today.specialItemDealSalePer);
						}else{
							$("#today ul .ex-price").html(message.today.orgprice);
							$("#today ul .price").html(message.today.sellprice);
							$("#today .rate").html(message.today.saleper);
						}			
					//주말동안
						if(dd == 20 || dd == 21){							
							$("#todayImg img").attr("src", "http://webimage.10x10.co.kr/fixevent/event/2018/17th/89541/img_main_date_1022.png?v=0.01")							
							$("#todayLink img").attr("src", "http://webimage.10x10.co.kr/fixevent/event/2018/17th/89541/btn_soon.png")
							$("#today ul .ex-price").css("display","none");							
							$("#todayLink").click(function(){return false;})
							$("#brand").css("display","none");													
						}else if(dd == 27 || dd == 28){
							$("#todayImg img").attr("src", "http://webimage.10x10.co.kr/fixevent/event/2018/17th/89541/img_main_date_1029.png?v=0.01")
							$("#todayLink img").attr("src", "http://webimage.10x10.co.kr/fixevent/event/2018/17th/89541/btn_soon.png")
							$("#today ul .ex-price").css("display","none");	
							$("#todayLink").click(function(){return false;})
							$("#brand").css("display","none");							
						}else{
							$("#todayImg img").attr("src", "http://webimage.10x10.co.kr/fixevent/event/2018/17th/89541/img_main_date_today.png?v=0.01")
						}									
					}
				
					// 브랜드 리스트
					if(typeof(message.brandList)=="object") {
						var i=0;
						$("#brand .bg-img img").attr('src', "http://webimage.10x10.co.kr/fixevent/event/2018/17th/89541/img_brand_10"+vDate+".png?v=1.01");			//이미지								
							$(message.brandList).each(function(){								
								var brname = this.brandName;

								if (this.linktype == "1"){
									$("#brandList li a").eq(i).attr('href', "http://www.10x10.co.kr/shopping/category_prd.asp?itemid="+this.evtcode+gaparamBrand+parseInt(i+2));
								} else {
									$("#brandList li a").eq(i).attr('href', "http://www.10x10.co.kr/event/eventmain.asp?eventid="+this.evtcode+gaparamBrand+parseInt(i+2));
								}

								$("#brandList li a").eq(i).click(function(){
									fnAmplitudeEventMultiPropertiesAction("click_17th_todayspecial_event_brandlist","brandname",brname);									
								})																				
								$("#brandList li span").eq(i).html(this.brandSalePer + "\n<i>%</i>");			//할인율
								i++;
							});						
					}
					// 특가상품 리스트
					if(typeof(message.itemImgList)=="object") {
						var i=0;
							$(message.itemImgList).each(function(){
								var htmlDateValue = $("#itemImgList li p").eq(i).html();

								$("#itemImgList li img").eq(i).attr('src', this.itemImg);	//이미지							
								if(htmlDateValue == dd){
									$("#itemImgList li").eq(i).attr('class', 'now');	//오늘
								}else if(htmlDateValue < dd){
									$("#itemImgList li").eq(i).attr('class', 'soldout');	//지난날
								}else{
									$("#itemImgList li").eq(i).attr('class', 'comming');	//이미지 없을때
								}
								//now, soldout, comming
								i++;
							});					
					}				
				}
			}
		},
		error: function(err) {
			console.log(err.responseText);
		}
	});
});

Date.prototype.format = function (f) {

    if (!this.valueOf()) return " ";

    var weekKorName = ["일요일", "월요일", "화요일", "수요일", "목요일", "금요일", "토요일"];
    var weekKorShortName = ["일", "월", "화", "수", "목", "금", "토"];
    var weekEngName = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"];
    var weekEngShortName = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"];
    var d = this;

    return f.replace(/(yyyy|yy|MM|dd|KS|KL|ES|EL|HH|hh|mm|ss|a\/p)/gi, function ($1) {
        switch ($1) {
            case "yyyy": return d.getFullYear(); // 년 (4자리)
            case "yy": return (d.getFullYear() % 1000).zf(2); // 년 (2자리)
            case "MM": return (d.getMonth() + 1).zf(2); // 월 (2자리)
            case "dd": return d.getDate().zf(2); // 일 (2자리)
            case "KS": return weekKorShortName[d.getDay()]; // 요일 (짧은 한글)
            case "KL": return weekKorName[d.getDay()]; // 요일 (긴 한글)
            case "ES": return weekEngShortName[d.getDay()]; // 요일 (짧은 영어)
            case "EL": return weekEngName[d.getDay()]; // 요일 (긴 영어)
            case "HH": return d.getHours().zf(2); // 시간 (24시간 기준, 2자리)
            case "hh": return ((h = d.getHours() % 12) ? h : 12).zf(2); // 시간 (12시간 기준, 2자리)
            case "mm": return d.getMinutes().zf(2); // 분 (2자리)
            case "ss": return d.getSeconds().zf(2); // 초 (2자리)
            case "a/p": return d.getHours() < 12 ? "오전" : "오후"; // 오전/오후 구분
            default: return $1;
        }
    });
};

String.prototype.string = function (len) { var s = '', i = 0; while (i++ < len) { s += this; } return s; };
String.prototype.zf = function (len) { return "0".string(len - this.length) + this; };
Number.prototype.zf = function (len) { return this.toString().zf(len); };

// 오늘의 특가 타이머
function countdown(){
	var usrDt=new Date();	// 현재 브라우저 시간
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
	var todaystring=montharray[todaym]+" "+todayd+", "+todayy+" "+todayh+":"+todaymin+":"+todaysec;
	//var futurestring=montharray[todaym]+" "+(todayd+1)+", "+todayy+" 00:00:00";
	var futurestring="Nov 01, 2018 00:00:00"

	dd=Date.parse(futurestring)-Date.parse(todaystring);
	dday=Math.floor(dd/(60*60*1000*24)*1);
	dhour=Math.floor((dd%(60*60*1000*24))/(60*60*1000)*1);
	dmin=Math.floor(((dd%(60*60*1000*24))%(60*60*1000))/(60*1000)*1);
	dsec=Math.floor((((dd%(60*60*1000*24))%(60*60*1000))%(60*1000))/1000*1);

	//console.log(futurestring);

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
	$("#time").html(dhour+":"+dmin+":"+dsec);
	
	setTimeout("countdown()",500);
}



