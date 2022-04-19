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
    <title>GP Configuration</title>
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
    <div class="jumbotron">
        <form:form modelAttribute="config" method="post">
            <div class="row">
                <div class="col-md-4 col-md-offset-2">
                    <div class="row">
                        <form:checkboxes path="functionChoices"
                                         items="${functionMap}"
                                         cssStyle="margin-right: 10px"
                                         element="div class='form-group row'"/>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="row">
                        <c:forEach items="${paramMap}" var="entry">
                            <div class="form-group row">
                                <form:label path="paramChoices[${entry.key}]" cssClass="col-md-3"
                                            cssErrorClass="text-danger"><c:out value="${entry.value}"/> </form:label>
                                <div class="col-md-3">
                                    <form:input path="paramChoices[${entry.key}]"/>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </div>
            </div>

            <div class="row">
                <button type="submit" class="btn btn-success pull-right">Submit</button>
            </div>
        </form:form>
    </div>
</div>

<script src="<c:url value='/assets/js/jquery-3.3.1.min.js'/>"></script>
<script src="<c:url value='/assets/js/bootstrap.min.js'/>"></script>
<script src="<c:url value='/assets/js/bootstrap-select.min.js'/>"></script>
<script src="<c:url value='/assets/js/jquery.dataTables.min.js'/>"></script>
</body>
</html>