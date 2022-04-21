<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <c:url value="/task" var="baseUrl"/>

    <link rel="icon" href="<c:url value='/assets/images/fax-solid.svg'/>">
    <link rel="stylesheet" href="<c:url value='/assets/css/bootstrap.min.css'/>">
    <link rel="stylesheet" href="<c:url value='/assets/css/bootstrap-select.min.css'/>">
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
        <table id="datatable">
            <thead>
                <tr>
                    <th>Created On</th>
                    <th>Task ID</th>
                    <th>Status</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach items="${jobs}" var="job">
                    <tr style="cursor: pointer">
                        <td>${job.uploadedOn}</td>
                        <td>${job.uuid}</td>
                        <td style="color: ${job.status.statusColor}">${job.status.statusStr}</td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
    <div class="row" style="padding-top: 10px">
        <a class="btn btn-success pull-right" href="<c:url value="/upload"/>">Add Task</a>
    </div>
</div>

<script src="<c:url value='/assets/js/jquery-3.3.1.min.js'/>"></script>
<script src="<c:url value='/assets/js/bootstrap.min.js'/>"></script>
<script src="<c:url value='/assets/js/bootstrap-select.min.js'/>"></script>
<script src="<c:url value='/assets/js/jquery.dataTables.min.js'/>"></script>
<script>
    const table = $("#datatable").DataTable({
        order: [[ 0, "desc" ]]
    });

    $('#datatable tbody').on('click', 'tr', function () {
        let datasetModel = table.row(this).data()[1];
        window.location.href = '${baseUrl}' + '?uuid=' + datasetModel;
    } );
</script>
</body>
</html>