<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <link rel="icon" href="<c:url value='/assets/images/fax-solid.svg'/>">
    <link rel="stylesheet" href="<c:url value='/assets/css/bootstrap.min.css'/>">
    <link rel="stylesheet" href="<c:url value='/assets/css/fontawesome-all.min.css'/>">
    <title>Upload</title>
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
    <div class="jumbotron">
        <form:form modelAttribute="file" enctype="multipart/form-data" method="post">
            <form:errors element="div class='alert alert-danger'"/>

            <div class="form-group row">
                <form:label path="file" cssClass="col-md-3 col-md-offset-2"
                            cssErrorClass="col-md-4 col-md-offset-2 text-danger">CSV File</form:label>

                <div class="col-md-4">
                    <input type="file" name="file">
                    <form:errors path="file" element="div class='text-danger'"/>
                </div>
            </div>

            <div class="form-group row">
                <form:label path="hasColumnHeaders" cssClass="col-md-3 col-md-offset-2"
                            cssErrorClass="text-danger">Dataset contains column headers</form:label>
                <div class="col-md-4">
                    <form:checkbox path="hasColumnHeaders"/>
                </div>
            </div>

            <button type="submit" class="btn btn-success pull-right">Upload</button>
        </form:form>
    </div>
</div>

<script src="<c:url value='/assets/js/jquery-3.3.1.min.js'/>"></script>
<script src="<c:url value='/assets/js/bootstrap.min.js'/>"></script>
</body>
</html>