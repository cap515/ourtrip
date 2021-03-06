<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css"
	integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh"
	crossorigin="anonymous">
<link
	href="https://fonts.googleapis.com/css?family=Stylish&display=swap"
	rel="stylesheet">
<script src="https://kit.fontawesome.com/76b49c6d9b.js"
	crossorigin="anonymous"></script>
<link rel="stylesheet" href="../resources/css/common.css">

<script src="https://code.jquery.com/jquery-3.4.1.min.js"
	integrity="sha256-CSXorXvZcTkaix6Yvo6HppcZGetbYMGWSFlBw8HfCJo="
	crossorigin="anonymous"></script>
<script
	src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"
	integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo"
	crossorigin="anonymous"></script>
<script
	src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"
	integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6"
	crossorigin="anonymous"></script>
<title>플래너 탐색</title>

<style>
#local-area {
	margin-top: 24px;
}

#check-wrapper {
	margin-top: 20px;
}

#search-wrapper {
	min-width: 300px;
}

.planner-wrapper {
	width: 100%;
	position: relative;
}

.planner {
	font-family: 'Stylish';
	padding: 10px;
	width: 25%;
	float: left;
	height: 400px;
}

.pagination-wrapper {
	width: 100%;
	clear: both;
	margin-top: 20px;
}

.card {
	height: 100%;
}

.card-body {
	height: 50%;
}

.card-img-top {
	width: 100%;
	height: 50%;
}


#footer {
	clear:both;
}

.page-num{
	color: #18a8f1;
}

.page-num:hover{
	cursor: pointer;
}


@media screen and (max-width: 1199px) {
	.planner {
		width: 33%;
	}
}

@media screen and (max-width: 991px) {
	.planner {
		width: 50%;
	}
}

@media screen and (max-width: 506px) {
	.planner {
		width: 100%;
	}
}
</style>

</head>
<body>
	<jsp:include page="/WEB-INF/views/common/header.jsp" />
	<jsp:include page="/WEB-INF/views/common/nav.jsp" />

	<!-- 탐색 컨텐츠 시작 부분 -->
	<div class="container my-5">

		<h2 class="font-weight-bold">플래너 검색</h2>
		<hr>

		<div>

			<!-- 검색창 -->
			<div class="col-md-6 mx-auto" id="search-wrapper">
				<div class="input-group mb-3">
					<input type="text" id="searchTitle" name="searchTitle"
						class="form-control" placeholder="플래너 제목을 입력하세요" onkeypress="enterSearch(this);">
					<div class="input-group-append">
						
						<button class="btn main-btn" id="searchBtn" type="button">검색</button>
					</div>
				</div>
			</div>

			<!-- 검색 옵션 -->
			<div id="select-option" class="col-md-12 mb-3">
				<div class="row">

					<div class="col-md-6" id="location-wrapper">
						<div class="row">
							<div class="col-6">
								<label>지역</label> 
								<select name="largeArea" id="wide-area"	class="custom-select">
									<c:forEach var="largeArea" items="${largeNmList}" varStatus="vs">
										<option value="${largeArea.largeAreaCode}">${largeArea.largeAreaName}</option>
									</c:forEach>
								</select>
							</div>
							<div class="col-6">
								<select name="smallArea" id="local-area" class="custom-select">
									<option value="0" selected>전체</option>
								</select>
							</div>
						</div>
					</div>

					<div class="col-md-6" id="group-wrapper">
						<div class="row">
							<div class="col-6">
								<label>그룹</label> <select name="groupName" id="groupName"
									class="custom-select">
									<option value="전체" selected>전체</option>
									<option value="혼자">혼자</option>
									<option value="커플">커플</option>
									<option value="친구">친구</option>
									<option value="가족">가족</option>
								</select>
							</div>
							<div class="col-6">
								<div class="custom-control custom-checkbox" id="check-wrapper">
									<input type="checkbox" class="custom-control-input" id="viaCheck"
										name="viaCheck" checked> <label class="custom-control-label"
										for="viaCheck">경유 여부</label>
								</div>
							</div>
						</div>
					</div>
				</div>

			</div>

		</div>

		<!-- 플래너 컨테이너 -->
		<div class="py-3" id="planner-container">
			<h4>검색된 플래너</h4>

			<!-- 검색된 플래너 리스트 -->
			<div class="planner-wrapper my-3" id="planner-wrapper">
			</div>

			<!-- 페이징바 -->
			<div class="pagination-wrapper">
				<nav aria-label="Page navigation">
					<ul class="pagination justify-content-center" id="paging-area">
					</ul>
				</nav>
			</div>
		</div>

		<!-- 추천 플래너 컨테이너 -->
		<div class="py-3">
			<h4>추천 플래너</h4>

			<!-- 추천 플래너 리스트 -->
			<div class="planner-wrapper my-3">
			<c:if test="${empty recommendPCList}">
				<div>
					존재하는 추천 리스트가 없습니다.
				</div>
			</c:if>
			<c:if test="${!empty recommendPCList}">
				<c:forEach var="recommendCard" items="${recommendPCList}" varStatus="vs">
					<div class="planner">
						<div class="card">
							<img class="card-img-top" src="${contextPath}/resources/areaImages/${recommendCard.areaNames[0].largeAreaCode}.jpg"
                           alt="Card image">
							<div class="card-body">
								<h5 class="card-title">${recommendCard.plannerTitle}</h5>
								<p class="card-text">
									<span>시작일 : ${recommendCard.plannerStartDT} ${recommendCard.tripDate}DAYS</span><br> <span>${recommendCard.groupName} 여행</span><br>
									<c:if test="${recommendCard.areaNames.size()>1}">
										<span data-html="true" class="area-toolTip"
                                            title="<c:forEach var="areaName" items="${recommendCard.areaNames}" varStatus="vs">
                                               ${areaName.largeAreaName}&nbsp;${areaName.smallAreaName}
                                                  <c:if test="${!vs.last}"><br></c:if>
                                               </c:forEach>">
											${recommendCard.areaNames[0].largeAreaName}
											${recommendCard.areaNames[0].smallAreaName} ...</span>
									</c:if>
									<c:if test="${recommendCard.areaNames.size()==1}">
										<span>${recommendCard.areaNames[0].largeAreaName}
											${recommendCard.areaNames[0].smallAreaName} </span>
									</c:if>
									<c:if test="${recommendCard.areaNames.size()<1}">
										<span> 없음</span>
									</c:if>
								</p>
								<div class="d-flex justify-content-between">
									<div class="btn-wrapper">
										<a href="${contextPath}/planner/plannerDetail?no=${recommendCard.plannerUrl}" class="btn btn-sm main-btn">바로가기</a>
										<c:if test="${!empty loginMember}">
											<a href="${contextPath}/planner/plannerCopy?no=${recommendCard.plannerNo}" class="btn  btn-sm gray-btn copy-btn">복사</a>
										</c:if>
									</div>
									<div>
										<i class="fas fa-eye"></i>&nbsp;${recommendCard.plannerCount}
									</div>
								</div>
							</div>
						</div>
					</div>
				</c:forEach>
			</c:if>
			</div>

			<!-- 페이징바 -->
			<div class="pagination-wrapper">
				
			</div>
		</div>
		<!-- 추천플래너 컨테이너 끝나는 부분 -->
	</div>
	<!-- 탐색 컨텐츠 끝나는 부분 -->

	<script>
		// 엔터시 검색버튼 누르는 함수
		function enterSearch(){
		    var keyCode = event.keyCode;
	
		    if(keyCode == 13){
		        $("#searchBtn").click();
		    }
		}
		
		// 검색 조건을 담을 변수선언
		var searchTitle;
		var groupName;
		var largeArea;
		var smallArea;
		var viaCheck;
		var currentPage;
		
		$(function () {
        	
			// 툴팁
			$(".area-toolTip").tooltip();
			
        	// 지역 선택
        	$("#wide-area").on("change", function () {
                var wideVal = Number($(this).val());
                console.log(wideVal);
                var html = "";

                switch(wideVal){
				<c:forEach var="largeArea" items="${largeNmList}" varStatus="vs">
				case ${largeArea.largeAreaCode} : 
					<c:forEach var="smallArea" items="${smallNmList}" varStatus="vs">
						<c:if test="${smallArea.largeAreaCode eq largeArea.largeAreaCode}">
		        			html += "<option value='${smallArea.smallAreaCode}'>${smallArea.smallAreaName}</option>";
		        		</c:if>
		        	</c:forEach>break;
				</c:forEach>
                }

                $("#local-area").html(html);
            });
        	
        	
        	// 플래너 조회 ajax 처리
        	$pWrapper = $("#planner-wrapper");
        	$pContainer = $("#planner-container");
        	$pContainer.hide();
        	
        	// 검색 버튼을 눌렀을 경우 처리
        	$("#searchBtn").on("click", function(){
       		//$("#searchBtn").on("click", function(){
        		searchTitle = $("#searchTitle").val();
        		groupName = $("#groupName").val();
        		largeArea = $("#wide-area").val();
        		smallArea = $("#local-area").val();
        		viaCheck = $("#viaCheck").prop("checked");
        		currentPage = 1;
        		
        		if(viaCheck){
        			viaCheck = "on";
        		}else{
        			viaCheck = null;
        		}
        		
        		$.ajax({
        			url : "searchPlanner",
        			type : "POST",
        			data : {searchTitle: searchTitle,
        					groupName: groupName,
        					largeArea: largeArea,
        					smallArea: smallArea,
        					viaCheck: viaCheck,
        					currentPage: currentPage},
        			
        			success : function(result){
        				console.log(result);
        				$pContainer.show();
        				if(result.pList == null || result.pList == ''){
        					console.log("비어있을경우 조건문 들어옴");
        					console.log($pWrapper);
        					$pWrapper.html("<div style='height:250px'>조회결과가 없습니다.<div>");
        					$(".pagination-wrapper").html("");
        				} else {
        					//console.log(result.length);
        					console.log("비어있지안을경우 조건문 들어옴");
        					var pHtml = "";
        					for(var i=0; i<result.pList.length; i++) {
	        					pHtml += 
	        					'<div class="planner">' + 
	        					'<div class="card">' +
        						'<img class="card-img-top" src="${contextPath}/resources/areaImages/' + result.pList[i].areaNames[0].largeAreaCode + '.jpg" alt="Card image">' +
        						'<div class="card-body">' +
       							'<h5 class="card-title">' + result.pList[i].plannerTitle + '</h5>' +
   								'<p class="card-text">' +
   								'<span>시작일 : ' + result.pList[i].plannerStartDT + ' ' +result.pList[i].tripDate + 'DAYS</span><br> <span>' + result.pList[i].groupName + ' 여행</span><br>';
   								if(result.pList[i].areaNames.length > 1) { 
   									
   									var tooltipstr = "";
   									for(var j in result.pList[i].areaNames){
   										tooltipstr +=  result.pList[i].areaNames[j].largeAreaName + 
   										' ' + result.pList[i].areaNames[j].smallAreaName;
   										if(result.pList[i].areaNames.length != j+1){
   											tooltipstr += '<br>';
   										}
   									}
   									
   									pHtml += 
   									'<span data-html="true" class="area-toolTip" title="' + 
   									tooltipstr +'">' + 
   									result.pList[i].areaNames[0].largeAreaName + ' ' + 
   									result.pList[i].areaNames[0].smallAreaName + '...</span>'; 
   								} else {
   									pHtml += '<span>' + result.pList[i].areaNames[0].largeAreaName + ' ' + 
   									result.pList[i].areaNames[0].smallAreaName + '</span>'; 
   								}
   								//var now = new Date(result[i].plannerStartDT);
   								//console.log(now);
   								pHtml +=  
   								'</p>' + 
	        					'<div class="d-flex justify-content-between">' +
	        					'<div class="btn-wrapper">' +
	        					'<a href="${contextPath}/planner/plannerDetail?no=' + result.pList[i].plannerUrl + '" class="btn btn-sm main-btn">바로가기</a> ' +
	        					<c:if test="${!empty loginMember}">
									'<a href="${contextPath}/planner/plannerCopy?no=' + result.pList[i].plannerNo + '" class="btn  btn-sm gray-btn copy-btn">복사</a>' +    	        					
	        					</c:if>
	        					'</div>' +
	        					'<div>' +
	        					'<i class="fas fa-eye"></i>&nbsp;'+ result.pList[i].plannerCount +
	        					'</div>' +
	        					'</div>' +
	        					'</div>' +
	        					'</div>' +
	        					'</div>';
        					}
        					
        					// 검색리스트 넣기
        					$pWrapper.html(pHtml);
        					
        					pagingHtmlFn(result.pInf);
        					disCurrent($(".pagination-wrapper").children().children().children(), currentPage);
        					
        					// 툴팁
        					$(".area-toolTip").tooltip();
        				}
        			},
        			error : function(e){
        				alert(e);
        			}
        			
        		});
        	});
       		
        	// 페이징 번호 작성 함수
    		function pagingHtmlFn(pageInfo){
    			console.log("페이징 시작확인");
    			
    			// 검색바 보여질 부분
    			$pagingArea = $("#paging-area");
    			
    			var maxPage = pageInfo.maxPage; // 전체 페이징 수 중 가장 마지막 페이지
    			var first = pageInfo.startPage; // 현재 페이지에서 보여질 페이징버튼 시작 페이지
    			var last = pageInfo.endPage; // 현재 페이지에서 보여질 페이징 버튼의 끝 페이지
    			var currentPage = pageInfo.currentPage;//현재 페이지
    			
    			
    			var pagingHtml = "";
    			if(currentPage > 1) {
    				pagingHtml += "<li class='page-item'><span class='page-link page-num paging'><<</span></li>";
    				pagingHtml += "<li class='page-item'><span class='page-link page-num paging'><</span></li>";
    			}
    			
    			for(var i=first; i<=last; i++) {
    				pagingHtml += "<li class='page-item'><span class='page-link page-num paging'>" + i + "</span></li>";
    			}
    			
    			if(currentPage < maxPage) {
    				console.log("실행되나 확인");
    				console.log("현재페이지 : " + currentPage);
    				console.log("마지막페이지 : " + maxPage);
    				
    				pagingHtml += "<li class='page-item'><span class='page-link page-num paging'>></span></li>";
            		pagingHtml += "<li class='page-item'><span class='page-link page-num paging'>>></span></li>";
    			}
    			
    			
    			
    			$pagingArea.html(pagingHtml); 
    			
    			
    			// 페이징 버튼을 눌렀을 경우
    			$(".paging").on("click", function(){
    				var $click = $(this);
    				if($click.text() == "<<") {
    					currentPage = 1;
    				} else if ($click.text() == "<") {
    					currentPage = Number(currentPage) -1;
    				} else if($click.text() == ">>") {
    					currentPage = maxPage;
    				} else if($click.text() == ">") {
    					currentPage = Number(currentPage) +1;
    				} else if($click.text() != currentPage) {
    					currentPage = $(this).text();
    				}
    				
    				
    				// 버튼 클릭시 페이징 처리 ajax
    				$.ajax({
    	    			url : "searchPlanner",
    	    			type : "POST",
    	    			data : {searchTitle: searchTitle,
    	    					groupName: groupName,
    	    					largeArea: largeArea,
    	    					smallArea: smallArea,
    	    					viaCheck: viaCheck,
    	    					currentPage: currentPage},
    	    			
    	    			success : function(result){
    	    				console.log(result);
    	    				$pContainer.show();
    	    				if(result.pList == null || result.pList == ''){
    	    					console.log("비어있을경우 조건문 들어옴");
    	    					console.log($pWrapper);
    	    					$pWrapper.html("<div style='height:250px'>조회결과가 없습니다.<div>");
    	    				} else {
    	    					//console.log(result.length);
    	    					console.log("비어있지안을경우 조건문 들어옴");
    	    					var pHtml = "";
    	    					for(var i=0; i<result.pList.length; i++) {
    	        					pHtml += 
    	        					'<div class="planner">' + 
    	        					'<div class="card">' +
    	    						'<img class="card-img-top" src="${contextPath}/resources/areaImages/' + result.pList[i].areaNames[0].largeAreaCode + '.jpg" alt="Card image">' +
    	    						'<div class="card-body">' +
    	   							'<h5 class="card-title">' + result.pList[i].plannerTitle + '</h5>' +
    									'<p class="card-text">' +
    									'<span>시작일 : ' + result.pList[i].plannerStartDT + ' ' +result.pList[i].tripDate + 'DAYS</span><br> <span>' + result.pList[i].groupName + ' 여행</span><br>';
    									if(result.pList[i].areaNames.length > 1) { 
    	   									
    	   									var tooltipstr = "";
    	   									for(var j in result.pList[i].areaNames){
    	   										tooltipstr +=  result.pList[i].areaNames[j].largeAreaName + 
    	   										' ' + result.pList[i].areaNames[j].smallAreaName;
    	   										if(result.pList[i].areaNames.length != j+1){
    	   											tooltipstr += '<br>';
    	   										}
    	   									}
    	   									
    	   									pHtml += 
    	   									'<span data-html="true" class="area-toolTip" title="' + 
    	   									tooltipstr +'">' + 
    	   									result.pList[i].areaNames[0].largeAreaName + ' ' + 
    	   									result.pList[i].areaNames[0].smallAreaName + '...</span>'; 
    	   								} else {
    	   									pHtml += '<span>' + result.pList[i].areaNames[0].largeAreaName + ' ' + 
    	   									result.pList[i].areaNames[0].smallAreaName + '</span>'; 
    	   								}
    									//var now = new Date(result[i].plannerStartDT);
    									//console.log(now);
    									pHtml +=  
    									'</p>' + 
    	        					'<div class="d-flex justify-content-between">' +
    	        					'<div class="btn-wrapper">' +
    	        					'<a href="${contextPath}/planner/plannerDetail?no=' + result.pList[i].plannerUrl + '" class="btn btn-sm main-btn">바로가기</a> ' +
    	        					<c:if test="${!empty loginMember}">
	    								'<a href="${contextPath}/planner/plannerCopy?no=' + result.pList[i].plannerNo + '" class="btn  btn-sm gray-btn copy-btn">복사</a>' +    	        					
    	        					</c:if>
    	        					'</div>' +
    	        					'<div>' +
    	        					'<i class="fas fa-eye"></i>&nbsp;'+ result.pList[i].plannerCount +
    	        					'</div>' +
    	        					'</div>' +
    	        					'</div>' +
    	        					'</div>' +
    	        					'</div>';
    	    					}
    	    					
    	    					$click = $click.parent().parent();
    	    					$pWrapper.html(pHtml);
    	    					pagingHtmlFn(result.pInf);
    	    					disCurrent($click.children(), currentPage);
    	    					
    	    					// 툴팁
            					$(".area-toolTip").tooltip();
    	    				}
    	    			},
    	    			error : function(e){
    	    				alert(e);
    	    			}
    	    			
    	    		});
    			});
    			
    			// 복사버튼 조건
    			$(".copy-btn").on("click", function(){
    				if(${empty loginMember}) {
    					alert("로그인후 이용해 주세요");
    					location.href = "${contextPath}/member/loginForm";
    				}
    			});
    		}
       		
        });
		
        	
        function disCurrent(list, currentPage){
        	$(list).each(function(index, item){
        		if($(item).text() == currentPage){
        			$(item).addClass("disabled");
        		}else{
        			$(item).removeClass("disabled");
        		}
        	});
        }
    </script>

	<jsp:include page="/WEB-INF/views/common/footer.jsp" />
</body>
</html>