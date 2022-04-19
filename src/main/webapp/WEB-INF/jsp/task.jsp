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
    <title>Task</title>
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
        <div class="row">
            <div class="form-group row">
                <label class="col-md-3">Task UUID</label>
                <c:out value="${conf.uuid}"/>
            </div>
            <div class="form-group row">
                <label class="col-md-3">Status</label>
                <c:out value="${conf.status}"/>
            </div>
            <div class="form-group row">
                <label class="col-md-3">Dataset file name</label>
                <c:out value="${dataset.fileName}"/>
            </div>
            <div class="form-group row">
                <label class="col-md-3">Task Created On</label>
                <c:out value="${conf.uploadedOn}"/>
            </div>
        </div>
    </div>
    <div class="jumbotron">
        <div class="form-group row text-center">
            <button id="exportImage" class="btn btn-success">Download graph</button>
        </div>
        <div class="row">
            <div class="col-md-6 col-md-offset-3">
                <canvas id="chart1" height="50" width="50"></canvas>
            </div>
        </div>
    </div>
</div>

<script src="<c:url value='/assets/js/jquery-3.3.1.min.js'/>"></script>
<script src="<c:url value='/assets/js/bootstrap.min.js'/>"></script>
<script src="<c:url value='/assets/js/bootstrap-select.min.js'/>"></script>
<script src="<c:url value='/assets/js/jquery.dataTables.min.js'/>"></script>
<script src="<c:url value='/assets/js/chart.min.js'/>"></script>
<script>
    $(function () {
        const ctx = $("#chart1");

        const myChart = new Chart(ctx, {
            type: 'line',
            responsive: true,
            data: {
                labels: [1500, 1600, 1700, 1750, 1800, 1850, 1900, 1950, 1999, 2050],
                datasets: [{
                    data: [86, 114, 106, 106, 107, 111, 133, 221, 783, 2478],
                    label: "Best",
                    borderColor: "#3e95cd",
                    fill: false
                }, {
                    data: [282, 350, 411, 502, 635, 809, 947, 1402, 3700, 5267],
                    label: "Average",
                    borderColor: "#8e5ea2",
                    fill: false
                }]
            },
            options: {
                responsive: true,
                plugins: {
                    title: {
                        display: true,
                        text: 'Best and Average among the runs'
                    }
                },
                scales: {
                    x: {
                        title: {
                            display: true,
                            text: "Generations"
                        }
                    },
                    y: {
                        title: {
                            display: true,
                            text: "Fitness"
                        }
                    },
                },
            }
        });

        $("#exportImage").click(function () {
            let data = myChart.toBase64Image();
            let image = new Image();
            image.src = data;

            let w = window.open("about:blank");
            setTimeout(function () {
                w.document.write(image.outerHTML);
            }, 0);
        });
    });
</script>
</body>
</html>