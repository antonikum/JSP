<%@ page import="java.util.Enumeration" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" errorPage="404.jsp" %>
<html>
<head>
    <title>Отдел кадров</title>
    <link href='res/css/tables.css' rel='stylesheet' type='text/css'>
    <link href="res/css/buttons.css" rel="stylesheet">
    <link href="res/css/font-awesome/css/font-awesome.min.css" rel="stylesheet">
</head>
<body>
<h1>Приложение "Отдел кадров"</h1>

<p>В контексте приложения были обнаружены следующие атрибуты:
    <br/><br/>
    <%
        Enumeration applicationAttributeNames = pageContext.getAttributeNamesInScope(pageContext.APPLICATION_SCOPE);
        while (applicationAttributeNames.hasMoreElements()) {
            out.println(applicationAttributeNames.nextElement() + "<br/>");
        }
    %>
</p>

</body>
</html>