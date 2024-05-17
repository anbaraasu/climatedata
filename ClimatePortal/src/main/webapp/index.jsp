<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Climate Portal</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/bootstrap.min.css">
</head>
<body>
    <div class="container">
        <h1>Welcome to the Climate Portal</h1>
        <p>This is a Spring Boot web application that consumes a REST API web service to display climate data.</p>
        <p>To get started, click the button below:</p>
        <a href="${pageContext.request.contextPath}/climate" class="btn btn-primary">View Climate Data</a>
    </div>
    <script src="${pageContext.request.contextPath}/static/js/script.js"></script>
</body>
</html>