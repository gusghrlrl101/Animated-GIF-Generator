<%--
  Created by IntelliJ IDEA.
  User: naruhodo627
  Date: 2018-11-02
  Time: 오후 5:56
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"  %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<%--<!-- CSS -->--%>
<link rel="stylesheet" href="/resources/vendor/wepplication/wepplication.css" media="all" />
<%--<link rel="stylesheet" href="/resources/bootstrap/css/bootstrap.min.css" media="all" />--%>

<!-- Bootstrap Core CSS -->
<link href="/resources/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">

<!-- MetisMenu CSS -->
<link href="/resources/vendor/metisMenu/metisMenu.min.css" rel="stylesheet">

<!-- Custom CSS -->
<link href="/resources/dist/css/sb-admin-2.css" rel="stylesheet">

<!-- Morris Charts CSS -->
<link href="/resources/vendor/morrisjs/morris.css" rel="stylesheet">

<!-- Custom Fonts -->
<link href="/resources/vendor/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css">

<!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
<!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
<!--[if lt IE 9]>
<script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
<script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
<![endif]-->

<script>
    //var REST_URL = (location.host.indexOf("asuscomm.com") === -1)? "http://127.0.0.1:8081" : "http://parkkiho.asuscomm.com:8081";
    <%--<c:set var="REST_URL">
        <spring:eval expression="@config['REST_URL']"/>
    </c:set>
    var REST_URL = '<c:out value="${REST_URL}" />';
    if(REST_URL == null || REST_URL === '' || typeof REST_URL === "undefined")
        REST_URL = "http://127.0.0.1:8081";--%>

    <c:set var="storedFilePath">
        <spring:eval expression="@config['storedFilePath']"/>
    </c:set>
    /*var storedFilePath = '<c:out value="${storedFilePath}" />';
    if(storedFilePath == null || storedFilePath === '' || typeof storedFilePath === "undefined")
        storedFilePath = "G:\\Java\\InteliJ\\animated_gif_photoin\\upload";*/
</script>
<!-- 전역변수 설정 -->