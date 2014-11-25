<%-- This page shows technologies (skills) of the selected employee and allows you to remove \ enhance employee skills --%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" language="java" errorPage="error.jsp" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <title>Страница владения технологиями</title>
    <link href='res/css/tables.css' rel='stylesheet' type='text/css'>
    <link href="res/css/buttons.css" rel="stylesheet">
    <link href="res/css/font-awesome/css/font-awesome.min.css" rel="stylesheet">
    <script src="res/js/main.js"></script>
</head>
<body>
<a href="index.jsp" class="button-main"><i class="fa fa-globe"></i> Вернуться на главную</a>

<table class="table1">
    <thead>
    <tr>
        <th scope="col" colspan="2">Сотрудник</th>
    </tr>
    </thead>
    <tbody>
    <tr id="${requestScope.employeeShowTechnologies.id}">
        <td hidden>
            <input type="radio" name="idEmployee" id="idEmployee" value="${sessionScope.employeeShowTechnologies.id}">
        </td>
        <td>
            <p>Фамилия и имя</p>
        </td>
        <td width="70%">
            <c:out value="${sessionScope.employeeShowTechnologies.surname}">${sessionScope.employeeShowTechnologies.surname}</c:out>
            <c:out value="${sessionScope.employeeShowTechnologies.name}">${sessionScope.employeeShowTechnologies.name}</c:out>
        </td>
    </tr>
    <tr>
        <td><p>Пол</p></td>
        <td>
            <c:choose>
                <c:when test="${sessionScope.employeeShowTechnologies.gender eq 'male'}">
                    <c:out value="Мужской">Мужской</c:out>
                </c:when>
                <c:when test="${sessionScope.employeeShowTechnologies.gender eq 'female'}">
                    <c:out value="Женский">Женский</c:out>
                </c:when>
            </c:choose>
        </td>
    </tr>
    <tr>
        <td>
            <p>Семейное положение</p>
        </td>
        <td>
            <c:choose>
                <c:when test="${sessionScope.employeeShowTechnologies.maritalStatus eq 'single'}">
                    <c:out value="Холост">Холост</c:out>
                </c:when>
                <c:when test="${sessionScope.employeeShowTechnologies.maritalStatus eq 'married'}">
                    <c:out value="Женат">Женат</c:out>
                </c:when>
                <c:when test="${sessionScope.employeeShowTechnologies.maritalStatus eq 'divorced'}">
                    <c:out value="Разведён">Разведён</c:out>
                </c:when>
            </c:choose>
        </td>
    </tr>
    <tr>
        <td>
            <p>ЗП</p>
        </td>
        <td>
            ${sessionScope.employeeShowTechnologies.salary}
        </td>
    </tr>
    <tr>
        <td>
            <p>Дата рождения</p>
        </td>
        <td>
            ${sessionScope.employeeShowTechnologies.dob}
        </td>
    </tr>
    </tbody>
    <tfoot>
    <tr>
        <td colspan="2">
            <button type="button" class="button-blue" onclick="printListTechnologiesToDelete()"><i
                    class="fa fa-list-alt"></i> Список навыков сотрудника
            </button>
        </td>
    </tr>
    <tr>
        <td colspan="2">
            <button type="button" class="button-save" onclick="printListTechnologiesToAdd()"><i
                    class="fa fa-plus-square-o"></i> Добавить новый навык сотруднику
            </button>
        </td>
    </tr>
    </tfoot>
</table>

<form method="post" action="main" id="formTechnologiesToAdd" hidden>
    <br><br>

    <table class="tableList3" width="60%">
        <caption>Список навыков (технологий) для добавления</caption>
        <thead>
        <tr>
            <th style="width: 1%"></th>
            <th style="width: 20%">Название</th>
            <th style="width: 20%">Описание</th>
        </tr>
        </thead>
        <tbody>
        <c:if test="${fn:length(sessionScope.technologiesNotOfTheEmployee) > 0}">
            <c:forEach var="technology" items="${sessionScope.technologiesNotOfTheEmployee}">
                <tr id="${technology.id}">
                    <td>
                        <input type="radio" name="idTechnology" id="idTechnologyToAdd"
                               value="${technology.id}" onclick="enableAddTechnologyToEmployeeButton()">
                    </td>
                    <td>${technology.name}</td>
                    <td>${technology.description}</td>
                </tr>
            </c:forEach>
        </c:if>
        <c:if test="${fn:length(sessionScope.technologiesNotOfTheEmployee) == 0}">
            <tr>
                <td colspan="3">Не осталось технологий(навыков) для добавления!</td>
            </tr>
        </c:if>
        </tbody>
        <tfoot>
        <tr>
            <td colspan="3" style="background: #ffffff; color: #ffffff; padding: 2px">
                <input type="text" id="idEmployeeToAddTechnology" name="idEmployeeEditTechnologies" hidden>
                <button type="submit" id="buttonAddTechnologyToEmployee" name="buttonAddTechnologyToEmployee" disabled
                        class="button-save disabled"><i class="fa fa-plus-square-o"></i> Добавить навык
                </button>
            </td>
        </tr>
        </tfoot>
    </table>

</form>

<form method="post" action="main" accept-charset="UTF-8" id="formTechnologiesToDelete">
    <table class="tableList3">
        <caption>Список навыков сотрудника</caption>
        <thead>
        <tr>
            <th style="width: 1%"></th>
            <th style="width: 20%">Название</th>
            <th style="width: 70%">Описание</th>
        </tr>
        </thead>
        <tbody>
        <c:if test="${fn:length(sessionScope.technologiesOfTheEmployee) > 0}">
            <c:forEach var="technology" items="${sessionScope.technologiesOfTheEmployee}">
                <tr id="${technology.id}">
                    <td>
                        <input type="radio" name="idTechnology" id="idTechnologyToDelete"
                               value="${technology.id}"
                               onclick="enableDeleteTechnologyOfEmployeeButton()">
                    </td>
                    <td>${technology.name}</td>
                    <td>${technology.description}</td>
                </tr>
            </c:forEach>
        </c:if>
        <c:if test="${fn:length(sessionScope.technologiesOfTheEmployee) == 0}">
            <tr>
                <td colspan="3">У сотрудника нет навыков!</td>
            </tr>
        </c:if>
        </tbody>
        <tr>
            <td colspan="3" style="background: #ffffff; color: #ffffff; padding: 2px">
                <input type="text" id="idEmployeeToRemoveTechnology" name="idEmployeeEditTechnologies" hidden>
                <button class="button-delete disabled" disabled type="submit" id="buttonDeleteTechnologyEmployee"
                        name="buttonDeleteTechnologyEmployee" onclick="
    if (!confirm('Вы действительно хотите удалить опыт работы с этой технологией у сотрудника?')) { return false; }">
                    Удалить навык
                </button>
            </td>
        </tr>
    </table>
</form>

</body>
</html>