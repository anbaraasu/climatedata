<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Climate Data</title>
</head>
<body>
    <div class="container">
        <h1>Climate Data</h1>
        <table class="table">
            <thead>
                <tr>
                    <th>Date</th>
                    <th>Temperature</th>
                    <th>Humidity</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="climate" items="${climateList}">
                    <tr>
                        <td>${climate.date}</td>
                        <td>${climate.temperature}</td>
                        <td>${climate.humidity}</td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
</body>
</html>