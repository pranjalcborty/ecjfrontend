<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <link rel="icon" href="<c:url value='/assets/images/fax-solid.svg'/>">
    <link rel="stylesheet" href="<c:url value='/assets/css/bootstrap.min.css'/>">
    <link rel="stylesheet" href="<c:url value='/assets/css/bootstrap-select.min.css'/>">
    <link rel="stylesheet" href="<c:url value='/assets/css/fontawesome-all.min.css'/>">
    <link rel="stylesheet" href="<c:url value='/assets/css/jquery.datatables.min.css'/>">
    <link rel="stylesheet" href="<c:url value='/assets/css/style.css'/>">
    <title>Home</title>
</head>
<body>
<nav class="navbar navbar-inverse navbar-static-top">
    <div class="container-fluid">
        <div class="navbar-header">
            <a class="navbar-brand" href="<c:url value="/"/>">
                <i class="fas fa-fax"></i>&nbsp;EasyGP
            </a>
        </div>
    </div>
</nav>

<div class="container">
    <div class="row">
        <table id="datatable">
            <thead>
                <tr>
                    <th>Task ID</th>
                    <th>File Name</th>
                    <th>Status</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach items="${jobs}" var="job">
                    <tr>
                        <td>${job.uuid}</td>
                        <td>${job.fileName}</td>
                        <td>${job.status}</td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
    <div class="row">
        <a class="btn btn-success pull-right" href="<c:url value="/upload"/>">Add Task</a>
    </div>
</div>

<script src="<c:url value='/assets/js/jquery-3.3.1.min.js'/>"></script>
<script src="<c:url value='/assets/js/bootstrap.min.js'/>"></script>
<script src="<c:url value='/assets/js/bootstrap-select.min.js'/>"></script>
<script src="<c:url value='/assets/js/jquery.dataTables.min.js'/>"></script>
<script>
    $("#datatable").DataTable();
</script>
</body>
</html>