<%-- The page where the list of all employees is displayed (in the form of the table) --%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" language="java" errorPage="error.jsp" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <title>Список всех сотрудников(новый)</title>
    <link href='res/css/tables.css' rel='stylesheet' type='text/css'>
    <link href="res/css/font-awesome/css/font-awesome.min.css" rel="stylesheet">
    <link href="res/css/pagination.css" rel="stylesheet">
    <link href="res/css/buttons.css" rel="stylesheet">
    <script src="res/js/main.js"></script>
</head>
<body>
<a href="index.jsp" class="button-main"><i class="fa fa-globe"></i> Вернуться на главную</a>

<form method="post" action="main" id="formForEditEmployeeValues" accept-charset="UTF-8" hidden>
    <table class="table1">
        <caption>Редактирование данных о сотруднике</caption>
        <thead>
        <tr>
            <th style="width: 30%">Фамилия</th>
            <th style="width: 30%">Имя</th>
            <th style="width: 10%">Пол</th>
            <th style="width: 10%">Семейное положение</th>
            <th style="width: 10%">Зп</th>
            <th style="width: 10%">Дата рождения</th>
        </tr>
        </thead>
        <tbody>
        <tr>
            <td hidden>
                <input type="text" id="idemployeeforupdate" name="idEmployeeForUpdate">
                <input type="text" id="pageToReturn" name="pageToReturn" value="${currentPage}">
            </td>
            <td id="surnameEditTd">
                <input type="text" id="surname" name="surName" required="true">
            </td>
            <td id="nameEditTd">
                <input type="text" id="name" name="name" required="true">
            </td>
            <td id="genderEditTd">
                <select name="gender" id="gender">
                    <option disabled>Укажите пол</option>
                    <option value="male">Мужской</option>
                    <option value="female">Женский</option>
                </select>
            </td>
            <td id="maritalEditTd">
                <select name="maritalStatus" id="maritalstatus">
                    <option disabled>Укажите семейное положение</option>
                    <option value="single">Холост</option>
                    <option value="married">Женат</option>
                    <option value="divorced">Разведён</option>
                </select>
            </td>
            <td id="salaryEditTd">
                <input type="number" id="salary" name="salary" required="true">
            </td>
            <td id="dobEditTd">
                <input type="date" id="dob" name="dob" required="true" value="2014-09-29">
            </td>
        </tr>
        </tbody>
        <tfoot>
        <tr>
            <td colspan="6" style="background: #ffffff; color: #ffffff; padding: 2px">
                <button type="submit" class="button-save" id="buttonSave" name="saveEmployeeValuesButton"><i
                        class="fa fa-floppy-o"></i> Сохранить
                </button>
            </td>
        </tr>
        </tfoot>
    </table>
</form>

<table class="tableList2">
    <caption><p>Список сотрудников</p></caption>
    <thead>
    <tr>
        <th style="width: 2%" scope="col"></th>
        <th style="width: 25%" scope="col">Фамилия</th>
        <th style="width: 25%" scope="col">Имя</th>
        <th style="width: 12%" scope="col"><p align="center">Пол</p></th>
        <th style="width: 12%" scope="col"><p align="center">Семейное положение</p></th>
        <th style="width: 12%" scope="col">ЗП</th>
        <th style="width: 12%" scope="col"><p>Дата рождения</p></th>
    </tr>
    </thead>
    <tbody>
    <c:forEach var="employee" items="${requestScope.employeeList}">
        <tr id="${employee.id}">
            <td style="border: 0">
                <input type="radio" name="idEmployee" id="idEmployee" value="${employee.id}"
                       onclick="copyDataEditEmployee(value)">
            </td>
            <td>${employee.surname}</td>
            <td>${employee.name}</td>
            <td align="center">
                <c:choose>
                    <c:when test="${employee.gender eq 'male'}">
                        <c:out value="Мужской">Мужской</c:out>
                    </c:when>
                    <c:when test="${employee.gender eq 'female'}">
                        <c:out value="Женский">Женский</c:out>
                    </c:when>
                </c:choose>
            </td>
            <td align="center">
                <c:choose>
                    <c:when test="${employee.maritalStatus eq 'single'}">
                        <c:out value="Холост">Холост</c:out>
                    </c:when>
                    <c:when test="${employee.maritalStatus eq 'married'}">
                        <c:out value="Женат">Женат</c:out>
                    </c:when>
                    <c:when test="${employee.maritalStatus eq 'divorced'}">
                        <c:out value="Разведён">Разведён</c:out>
                    </c:when>
                </c:choose>
            </td>
            <td>${employee.salary}</td>
            <td>${employee.dob}</td>
        </tr>
    </c:forEach>
    </tbody>
    <tfoot>
    <tr>
        <td colspan="7" style="background: #ffffff; color: #ffffff">
            <form method="post" action="main">
                <input type="text" id="idEmployeeEditTechnologies" name="idEmployeeEditTechnologies" hidden>
                <input type="text" id="idEmployeeToDelete" name="idEmployeeToDelete" hidden>
                <input type="text" name="pageToReturn" value="${requestScope.currentPage}" hidden>
                <ul class="button-group">
                    <li>
                        <button type="submit" class="button-blue disabled" id="buttonEditAffairs"
                                name="buttonEditAffairs" disabled><i class="fa fa-user"></i> Технологии
                        </button>
                    </li>
                    <li>
                        <button type="button" class="button-edit disabled" value="edit" id="buttonEdit"
                                onclick="enableEditEmployee()"><i class="fa fa-pencil-square-o"></i> Редактировать
                        </button>
                    </li>
                    <li>
                        <button type="submit" class="button-delete disabled" name="buttonDeleteEmployee"
                                id="buttonDelete" disabled onclick="
    if (!confirm('Вы действительно хотите удалить сотрудника?')) { return false; }"><i class="fa fa-trash-o fa-lg"></i>
                            Удалить
                        </button>
                    </li>
                </ul>
            </form>
        </td>
    </tr>
    </tfoot>
</table>

<ul class="tsc_pagination tsc_paginationB tsc_paginationB02">
    <li><a href="main?showEmployees&page=1" class="first">Первая</a></li>
    <c:if test="${requestScope.currentPage != 1}">
        <td>
            <li><a href="main?showEmployees&page=${requestScope.currentPage - 1}" class="previous">Предыдущая</a></li>
        </td>
    </c:if>
    <c:forEach begin="1" end="${requestScope.noOfPages}" var="i">
        <c:choose>
            <c:when test="${requestScope.currentPage eq i}">
                <li><a href="#" class="current">${i}</a></li>
            </c:when>
            <c:otherwise>
                <li><a href="main?showEmployees&page=${i}">${i}</a></li>
            </c:otherwise>
        </c:choose>
    </c:forEach>
    <c:if test="${requestScope.currentPage lt requestScope.noOfPages}">
        <li><a href="main?showEmployees&page=${requestScope.currentPage + 1}" class="next">Следующая</a></li>
    </c:if>
    <li><a href="main?showEmployees&page=${requestScope.noOfPages}" class="last">Последняя</a></li>
</ul>

</body>
</html>
