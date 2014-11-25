<%-- The page to add a new technology to the database --%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" language="java" errorPage="error.jsp" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:useBean id="technology" class="logic.Technology" scope="page">
</jsp:useBean>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <title>Добавить технологию</title>
    <link href='res/css/tables.css' rel='stylesheet' type='text/css'>
    <link href="res/css/buttons.css" rel="stylesheet">
    <link href="res/css/font-awesome/css/font-awesome.min.css" rel="stylesheet">
    <script src="res/js/main.js"></script>
</head>
<body>

<c:if test="${fn:length(sessionScope.technologySuccessfullyAdded) > 0}">
    <input type="text" id="messageAddedNewEntry" value="${sessionScope.technologySuccessfullyAdded}" hidden>
</c:if>
<script>showSuccessOfAdding()</script>

<form method="post" action="main" name="addTechnologyForm">
    <table class="table1">
        <thead>
        <tr>
            <th scope="col" colspan="2">Введите данные новой технологии</th>
        </tr>
        </thead>
        <tr>
            <td rowspan="2">Название</td>
            <td hidden>
                <input type="text" id="idtechnologyforupdate" name="idTechnologyForUpdate" value="0">
            </td>
            <td id="nameTd">
                <textarea name="name" id="name" required="required" rows=1 cols=30></textarea>
            </td>
        </tr>
        <tr>
            <td><p style="font-size: 10px"><em>Длина до 50 символов. Разрешено использовать любые символы.</em></p></td>
        </tr>
        <tr>
            <td rowspan="2">Описание</td>
            <td id="descriptionTd">
                <textarea name="description" id="description" rows=5 cols=30 required></textarea>
            </td>
        </tr>
        <tr>
            <td><p style="font-size: 10px"><em>Длина до 200 символов. Разрешено использовать любые символы.</em></p>
            </td>
        </tr>
        <tr>
            <td>Коэффициент значимости</td>
            <td>
                <select name="rate">
                    <option disabled>Укажите коэффициент значимости</option>
                    <option value="1" selected>Важная</option>
                    <option value="2">Мезоморфная</option>
                    <option value="3">Второстепенная</option>
                </select>
            </td>
        </tr>
        <tr align="center">
            <td>
                <button type="submit" name="addTechnologyButton" class="button-save"
                        onclick="return validateAddTechnologyForm()"><i class="fa fa-floppy-o"></i> Сохранить
                </button>
            </td>
            <td>
                <button type="reset" value="reset" class="button-reset"><i class="fa fa-eraser"></i> Очистить</button>
            </td>
        </tr>
        <tr align="center">
            <td colspan="2">
                <a href="index.jsp" class="button-main"><i class="fa fa-globe"></i> Вернуться на главную</a>
            </td>
        </tr>
    </table>
</form>
</body>
</html>
<c:remove var="technologySuccessfullyAdded" scope="session"/>