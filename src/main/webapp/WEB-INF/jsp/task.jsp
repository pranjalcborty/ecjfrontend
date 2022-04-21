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
    <title>Task</title>
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
        <div class="row">
            <div class="form-group row">
                <label class="col-md-3">Task UUID</label>
                <c:out value="${conf.uuid}"/>
            </div>
            <div class="form-group row">
                <label class="col-md-3">Status</label>
                <div style="color: ${conf.status.statusColor}"><c:out value="${conf.status.statusStr}"/></div>
            </div>
            <div class="form-group row">
                <label class="col-md-3">Problem</label>
                <c:out value="${confModel.problem.titleStr}"/>
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
    <c:if test="${not empty result}">
        <div class="jumbotron">
            <div class="row">
                <div class="col-md-8 col-md-offset-2">
                    <div id="codeBlock" class="form-group row text-center">
                        <h4>Best Individual Among All the Runs</h4>
                        <code>Code</code>
                    </div>
                    <div class="form-group row text-center">
                        <button id="exportImage" class="btn btn-success">Download graph</button>
                    </div>
                    <canvas id="chart" height="50" width="50"></canvas>
                </div>
            </div>
        </div>
    </c:if>
</div>

<script src="<c:url value='/assets/js/jquery-3.3.1.min.js'/>"></script>
<script src="<c:url value='/assets/js/bootstrap.min.js'/>"></script>
<script src="<c:url value='/assets/js/jquery.dataTables.min.js'/>"></script>
<script src="<c:url value='/assets/js/chart.min.js'/>"></script>
<script>
    <c:if test="${not empty result}">
    $(function () {
        const ctx = $("#chart");
        let jData = JSON.parse('${resultJson}');

        const maxIdx = Object.keys(jData["bestIndividualFitnessMap"])
            .reduce(function (a, b) {
                return jData["bestIndividualFitnessMap"][a] > jData["bestIndividualFitnessMap"][b] ? a : b
            });

        if (jData["bestTreeMap"]) {
            $("#codeBlock").find("code").text(jData["bestTreeMap"][maxIdx]);
        } else {
            $("#codeBlock").hide();
        }

        const avg = Array(${maxGen});
        for (let i = 0; i < ${maxGen}; i++) {
            let sum = 0;
            let cnt = 0;

            Object.keys(jData["allRunInfoMap"]).forEach((key, index) => {
                if (jData["allRunInfoMap"][key][i]) {
                    sum += jData["allRunInfoMap"][key][i];
                    cnt++;
                }
            });

            avg[i] = sum / cnt;
        }

        const myChart = new Chart(ctx, {
            type: 'line',
            responsive: true,
            data: {
                labels: Array.from(Array(${maxGen}).keys()),
                datasets: [{
                    data: jData["allRunInfoMap"][maxIdx],
                    label: "Best",
                    borderColor: "#3e95cd",
                    fill: false
                }, {
                    data: avg,
                    label: "Average",
                    borderColor: "#8e5ea2",
                    fill: false
                }
                ]
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
            let datasetModel = myChart.toBase64Image();
            let image = new Image();
            image.src = datasetModel;

            let w = window.open("about:blank");
            setTimeout(function () {
                w.document.write(image.outerHTML);
            }, 0);
        });
    });
    </c:if>
</script>
</body>
</html>