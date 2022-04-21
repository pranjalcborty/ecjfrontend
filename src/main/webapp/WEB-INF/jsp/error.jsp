<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <link rel="icon" href="<c:url value='/assets/images/fax-solid.svg'/>">
    <link rel="stylesheet" href="<c:url value='/assets/css/bootstrap.min.css'/>">
    <link rel="stylesheet" href="<c:url value='/assets/css/fontawesome-all.min.css'/>">
    <link rel="stylesheet" href="<c:url value='/assets/css/jquery.datatables.min.css'/>">
    <title>Home</title>
</head>
<body>
<nav class="navbar navbar-static-top bg-success">
    <div class="container">
        <div class="navbar-header">
            <a class="navbar-brand" style="color: black" href="<c:url value="/"/>">
                <i class="fas fa-fax" style="color: #e03131;"></i>&nbsp;&nbsp;easyGP
            </a>
        </div>
    </div>
</nav>

<div class="container">
    <div class="row">
        <div class="text-center">
            <h1 style="font-size: 40em">404</h1>
        </div>
    </div>
</div>

<script src="<c:url value='/assets/js/jquery-3.3.1.min.js'/>"></script>
<script src="<c:url value='/assets/js/bootstrap.min.js'/>"></script>
<script src="<c:url value='/assets/js/jquery.dataTables.min.js'/>"></script>
<script>
    $("#datatable").DataTable();
</script>
</body>
</html>