<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css"
        integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
    <link rel="stylesheet" href="${contextPath}/resources/css/common.css">
    <title>공지사항</title>

    <style>
        textarea {
            resize: none;
        }
    </style>
</head>

<body>
    <script src="https://code.jquery.com/jquery-3.4.1.min.js"
        integrity="sha256-CSXorXvZcTkaix6Yvo6HppcZGetbYMGWSFlBw8HfCJo=" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"
        integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo"
        crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"
        integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6"
        crossorigin="anonymous"></script>
	
	<jsp:include page="../common/header.jsp" />
	<jsp:include page="../common/nav.jsp" />
	
    <!-- 공지사항 상세조회 시작 -->
    <div class="container my-5">
        <h2 class="font-weight-bold">공지사항 수정</h2>
        <hr>
        <div class="container">
            <form action="./update?no=${notice.noticeNo}" method="POST" onsubmit="false">

                <!-- 제목 -->
                <div class="form-inline mb-3">
                    <label for="inputTitle" class="mr-3">제목</label>
                    <input class="form-control" type="text" size="70" id="inputTitle" name="noticeTitle"
                        placeholder="공지사항 제목을 입력해주세요" value="${notice.noticeTitle}">
                </div>

                <!-- 작성일 및 조회수 -->
                <div class="d-flex my-3">
                    <div class="mr-auto">
                        <label class="mr-3">수정일</label>
                    	<h5 class="my-0" id="today"></h5>
                    </div>
                    <div class="ml-auto">
                        <span>조회수 : ${notice.noticeCount}</span>
                    </div>
                </div>

                <hr>

                <!-- 내용 -->
                <div class="form-group">
                    <label for="content">
                        <h5 class="my-0">내용</h5>
                    </label>
                    <!-- 일반회원 상세조회시 textarea에 readonly 속성 추가 -->
                    <textarea class="form-control my-3" rows="20" id="content" name="noticeContent">
${notice.noticeContent}</textarea>
                </div>

                <!-- 버튼들 -->
                <div class="d-flex" id="btn-wrapper">
                    <a href="#" class="btn gray-btn mr-auto"  id="historyBack">이전페이지</a>
                    <!-- 수정, 삭제 버튼 -->
                    <div class="ml-auto">
	                    <c:if test="${loginMember.memberGrade == 'A'}">
	                        <button class="btn main-btn">수정하기</button>
                      	</c:if>
                    </div>
                </div>

            </form>
        </div>
    </div>
    <!-- 공지사항 상세조회 끝 -->
    
    <jsp:include page="../common/footer.jsp" />

</body>
<script>
    // 오늘 날짜 출력 
	var today = new Date();
	
	var str = today.getFullYear() + "-"
			+ (today.getMonth()+1) + "-"
			+ today.getDate();
	$("#today").html(str);
	
	$("#historyBack").click(function(){
		window.history.go(-1);
	})
</script>
</html>