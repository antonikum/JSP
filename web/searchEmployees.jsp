<%-- On this page it is possible to find the employees owning certain skills --%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" language="java" errorPage="error.jsp" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <title>Поиск сотрудников по технологиям</title>
    <link href='res/css/tables.css' rel='stylesheet' type='text/css'>
    <link href="res/css/buttons.css" rel="stylesheet">
    <link href="res/css/font-awesome/css/font-awesome.min.css" rel="stylesheet">
    <script src="res/js/main.js"></script>
</head>
<body>
<a href="index.jsp" class="button-main"><i class="fa fa-globe"></i> Вернуться на главную</a>

<form method="post" action="main" accept-charset="UTF-8">
    <table class="tableList3">
        <thead>
        <tr>
            <th style="width: 2%"></th>
            <th style="width: 20%">Название</th>
            <th style="width: 70%">Описание</th>
        </tr>
        </thead>
        <tbody>
        <c:if test="${fn:length(sessionScope.AllTechnologies) > 0}">
            <c:forEach var="technology" items="${sessionScope.AllTechnologies}">
                <tr id="${technology.id}">
                    <td>
                        <input type="checkbox" name="idTechnologies" id="idTechnology"
                               value="${technology.id}" onclick="enableSearchButton()">
                    </td>
                    <td>${technology.name}</td>
                    <td>${technology.description}</td>
                </tr>
            </c:forEach>
        </c:if>
        <c:if test="${fn:length(sessionScope.AllTechnologies) == 0}">
            <tr>
                <td colspan="3">Технологии не найдены</td>
            </tr>
        </c:if>
        </tbody>
        <tfoot>
        <tr>
            <td colspan="3" style="background: #ffffff; color: #ffffff; padding: 0">
                <button type="submit" class="button-blue disabled" disabled id="buttonSearchEmployees"
                        name="buttonSearchEmployees"><i class="fa fa-search"></i> Найти сотрудников
                </button>
            </td>
        </tr>
        </tfoot>
    </table>
</form>

<br/>
<c:if test="${sessionScope.ListOfTechnologies ne null}">
    <p>Ниже представлена таблица сотрудников, владеющих следующими технологиями: </p>
    <ul>
        <c:forEach var="technology" items="${sessionScope.ListOfTechnologies}">
            <li>${technology.name}</li>
        </c:forEach>
    </ul>

    <table class="table1">
        <thead>
        <tr>
            <th scope="col" width="35%">Фамилия</th>
            <th scope="col" width="35%">Имя</th>
            <th scope="col" width="10%">ЗП</th>
            <th scope="col" width="20%">Дата рождения</th>
        </tr>
        </thead>
        m
        <tbody>
        <c:if test="${fn:length(sessionScope.ListOfEmployees) == 0}">
            <tr>
                <td colspan="4"><p>Сотрудники не найдены!</p></td>
            </tr>
        </c:if>

        <c:if test="${fn:length(sessionScope.ListOfEmployees) > 0}">
            <c:forEach var="employee" items="${sessionScope.ListOfEmployees}">
                <tr>
                    <td>${employee.surname}</td>
                    <td>${employee.name}</td>
                    <td>${employee.salary}</td>
                    <td>${employee.dob}</td>
                </tr>
            </c:forEach>
        </c:if>

        </tbody>
        <tfoot>
        <tr>
            <td colspan="4">
                <p><em>
                    <c:out value="Всего найдено сотрудников: ${fn:length(sessionScope.ListOfEmployees)}">${fn:length(sessionScope.ListOfEmployees)}</c:out>
                </em></p>
            </td>
        </tr>
        </tfoot>
    </table>
    <c:remove var="ListOfTechnologies" scope="session"/>
    <c:remove var="ListOfEmployees" scope="session"/>
</c:if>
</body>
</html>
