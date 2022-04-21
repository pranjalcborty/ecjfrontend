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
    <title>GP Configuration</title>
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
        <form:form modelAttribute="config" method="post" autocomplete="off">
            <div class="row">
                <div class="col-md-4 col-md-offset-2">
                    <div class="row">
                        <h4><fmt:message key="message.functions"/></h4>
                        <div class="col-md-12">
                            <form:errors path="functionChoices"
                                         cssStyle="margin-left: -15px;"
                                         element="div class='alert alert-danger'"/>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-12">
                            <form:checkboxes path="functionChoices"
                                             items="${functionMap}"
                                             cssStyle="margin-right: 10px"
                                             element="div class='form-group row'"/>
                        </div>
                    </div>

                    <div class="row" style="margin-top: 15px;">
                        <h4><fmt:message key="message.problem"/></h4>
                        <div class="col-md-12">
                            <form:errors path="problem"
                                         cssStyle="margin-left: -15px;"
                                         element="div class='alert alert-danger'"/>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-12">
                            <form:radiobuttons path="problem"
                                               items="${problemMap}"
                                               cssStyle="margin-right: 10px"
                                               element="div class='form-group row'"/>
                        </div>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="row">
                        <div class="col-md-12">
                            <div class="alert alert-info">
                                <fmt:message key="message.param"/>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-12">
                            <c:forEach items="${paramMap}" var="entry">
                                <div class="form-group row">
                                    <form:label path="paramChoices[${entry.key}]" cssClass="col-md-3"
                                                cssErrorClass="col-md-3 text-danger"><c:out value="${entry.value}"/>
                                    </form:label>
                                    <div class="col-md-3">
                                        <form:input placeholder="Default = ${defaultMap[entry.key]}"
                                                    path="paramChoices[${entry.key}]"/>
                                        <form:errors path="paramChoices[${entry.key}]" cssClass="text-danger"/>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
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
<script src="<c:url value='/assets/js/jquery.dataTables.min.js'/>"></script>
</body>
</html>