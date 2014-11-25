<%-- The page to add a new employee to the database --%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" language="java" errorPage="error.jsp" %>
<jsp:useBean id="employee" class="logic.Employee" scope="page">
</jsp:useBean>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <title>Добавить сотрудника</title>
    <link href='res/css/tables.css' rel='stylesheet' type='text/css'>
    <link href="res/css/buttons.css" rel="stylesheet">
    <link href="res/css/font-awesome/css/font-awesome.min.css" rel="stylesheet">
    <script src="res/js/main.js"></script>
</head>
<body>

<c:if test="${fn:length(sessionScope.employeeSuccessfullyAdded) > 0}">
    <input type="text" id="messageAddedNewEntry" value="${sessionScope.employeeSuccessfullyAdded}" hidden>
</c:if>
<script>showSuccessOfAdding()</script>

<form method="post" action="main" name="addEmployeeForm">
    <table class="table1">
        <thead>
        <tr>
            <th scope="col" colspan="2">Введите данные нового сотрудника</th>
        </tr>
        </thead>
        <tbody>

        <tr>
            <td hidden>
                <input type="text" id="idemployeeforupdate" name="idEmployeeForUpdate" value="0">
            </td>
            <td rowspan="2">Фамилия</td>
            <td>
                <input type="text" name="surName" id="surName" required>
            </td>
        </tr>
        <tr>
            <td><p style="font-size: 10px" id="surnameAttribute"><em>Длина до 30 символов. Разрешено использовать буквы
                русского и латинского алфавитов и тире.</em></p></td>
        </tr>
        <tr>
            <td rowspan="2">Имя</td>
            <td>
                <input type="text" name="name" id="name" required>
            </td>
        </tr>
        <tr>
            <td><p style="font-size: 10px" id="nameAttribute"><em>Длина до 30 символов. Разрешено использовать буквы
                русского и латинского алфавитов и тире.</em></p></td>
        </tr>
        <tr>
            <td>Пол</td>
            <td id="genderTd">
                <input type="radio" name="gender" value="male" required="true">Мужской<br>
                <input type="radio" name="gender" value="female" required="true">Женский<br>
            </td>
        </tr>
        <tr>
            <td>Семейное положение</td>
            <td>
                <select name="maritalStatus">
                    <option disabled>Укажите семейное положение</option>
                    <option value="single" selected>Холост</option>
                    <option value="married">Женат</option>
                    <option value="divorced">Разведён</option>
                </select>
            </td>
        </tr>
        <tr>
            <td rowspan="2">ЗП</td>
            <td><input type="number" name="salary" id="salary" required="true"></td>
        </tr>
        <tr>
            <td><p style="font-size: 10px" id="salaryAttribute"><em>Длина до 10 цифр. Разрешено использовать цифры от 0
                до
                9.</em></p></td>
        </tr>
        <tr>
            <td rowspan="2">Дата рождения</td>
            <td><input type="date" name="dob" id="dob" required="true"></td>
        </tr>
        <tr>
            <td><p style="font-size: 10px" id="dobAttribute"><em>Дата в формате "2014-09-30".</em></p></td>
        </tr>
        <tr align="center">
            <td>
                <button type="submit" name="addEmployeeButton" class="button-save"
                        onclick="return validateAddEmployeeForm()"><i
                        class="fa fa-floppy-o"></i> Сохранить
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
        </tbody>
    </table>
</form>
</body>
</html>
<c:remove var="employeeSuccessfullyAdded" scope="session"/>