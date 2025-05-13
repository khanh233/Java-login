<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ page import="java.util.*" %>
<%@ page import="javax.servlet.http.*" %>
<%@ page import="java.io.*" %>
<%@ page import="javax.servlet.*" %>

<html>
<head>
    <title>Temperature Converter</title>
</head>
<body>
    <h2>Temperature Converter</h2>

    <form action="" method="post">
        <label for="temperature">Enter Temperature:</label>
        <input type="text" id="temperature" name="temperature" value="${param.temperature}" required />

        <label for="unit">Convert to:</label>
        <select id="unit" name="unit">
            <option value="CtoF" <c:if test="${param.unit == 'CtoF'}">selected</c:if>>Celsius to Fahrenheit</option>
            <option value="FtoC" <c:if test="${param.unit == 'FtoC'}">selected</c:if>>Fahrenheit to Celsius</option>
        </select>

        <button type="submit">Convert</button>
    </form>

    <c:if test="${not empty result}">
        <h3>Converted Temperature: ${result}</h3>
    </c:if>

    <c:if test="${errorMessage != null}">
        <p style="color:red;">${errorMessage}</p>
    </c:if>

    <h4>Total requests: ${requestCount}</h4>

    <%
        // Increment the request count
        Integer count = (Integer) application.getAttribute("requestCount");
        if (count == null) {
            count = 0;
        }
        application.setAttribute("requestCount", count + 1);

        // Handle temperature conversion
        String tempStr = request.getParameter("temperature");
        String unit = request.getParameter("unit");
        String result = null;
        String errorMessage = null;

        if (tempStr != null && !tempStr.isEmpty()) {
            try {
                double temperature = Double.parseDouble(tempStr);
                if ("CtoF".equals(unit)) {
                    result = (temperature * 9 / 5) + 32 + " °F";
                } else if ("FtoC".equals(unit)) {
                    result = (temperature - 32) * 5 / 9 + " °C";
                }
            } catch (NumberFormatException e) {
                errorMessage = "Invalid temperature value. Please enter a valid number.";
            }
        }

        request.setAttribute("result", result);
        request.setAttribute("errorMessage", errorMessage);
    %>
</body>
</html>
