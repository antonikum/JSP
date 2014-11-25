<%-- Application shows this page in case of origin of errors --%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="java.io.StringWriter" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" isErrorPage="true" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Application Error</title>
</head>
<body>
<h2 style="color: red">Перехвачено исключение.</h2>

<p>Описание: </p>

<p style="color: red">
    <%
        StringWriter stringWriter = new StringWriter();
        PrintWriter printWriter = new PrintWriter(stringWriter);
        if (exception.toString().equals("java.lang.NullPointerException")) {
            out.write("Ошибка соединения с базой данных!");
            exception.printStackTrace(printWriter);
            out.print(exception.getMessage());
        } else {
    %>
</p>

<p>Трассировочная информация из стека вызовов: <br/></p>
<%
        exception.printStackTrace(printWriter);
    }
%>

<form action="index.jsp">
    <input type="submit" value="Вернуться на главную">
</form>
</body>
</html>
