<%-- This page displays all technologies (in the form of the table) and allows to edit \delete them. --%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" language="java" errorPage="error.jsp" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <title>Список всех технологий</title>
    <link href='res/css/tables.css' rel='stylesheet' type='text/css'>
    <link href="res/css/buttons.css" rel="stylesheet">
    <link href="res/css/font-awesome/css/font-awesome.min.css" rel="stylesheet">
    <link href="res/css/pagination.css" rel="stylesheet">
    <script src="res/js/main.js"></script>
</head>
<body>
<a href="index.jsp" class="button-main"><i class="fa fa-globe"></i> Вернуться на главную</a>

<form method="post" action="main" id="formForEditTechnologyValues" accept-charset="UTF-8" hidden>
    <table id="tableEditTechnology" class="table1">
        <caption>Редактирование данных о технологии</caption>
        <thead>
        <tr>
            <th style="width: 20%">Название</th>
            <th style="width: 70%">Описание</th>
            <th style="width: 10%">Коэффициент значимости</th>
        </tr>
        </thead>
        <tbody>
        <tr>
            <td hidden>
                <input type="text" id="idtechnologyforupdate" name="idTechnologyForUpdate">
                <input type="text" name="pageToReturnTechnology" value="${currentPage}" hidden>
            </td>
            <td id="nameEditTd">
                <textarea id="name" name="name" required rows=1 cols=70></textarea>
            </td>
            <td id="descriptionEditTd">
                <textarea id="description" name="description" required rows=1 cols=70></textarea>
            </td>
            <td id="rateEditTd">
                <select name="rate" id="rate">
                    <option disabled>Укажите коэффициент значимости</option>
                    <option value="1">Важная</option>
                    <option value="2">Мезоморфная</option>
                    <option value="3">Второстепенная</option>
                </select>
            </td>
        </tr>
        </tbody>
        <tfoot>
        <tr>
            <td colspan="3" style="background: #ffffff; color: #ffffff; padding: 2px">
                <button type="submit" class="button-save" id="buttonSave" name="saveTechnologyValuesButton"><i
                        class="fa fa-floppy-o"></i>
                    Сохранить
                </button>
            </td>
        </tr>
        </tfoot>
    </table>
</form>

<form method="post" action="main">
    <table class="tableList2">
        <caption>Список всех технологий</caption>
        <thead>
        <tr>
            <th style="width: 2%"></th>
            <th style="width: 20%">Название</th>
            <th style="width: 70%">Описание</th>
            <th style="width: 8%">Коэффициент значимости</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="technology" items="${requestScope.technologyList}">
            <tr id="${technology.id}">
                <td>
                    <input type="radio" name="idTechnology" id="idTechnology" value="${technology.id}"
                           onclick="copyDataEditTechnology(value)">
                    <input type="text" name="pageToReturnTechnology" value="${currentPage}" hidden>
                </td>
                <td>${technology.name}</td>
                <td>${technology.description}</td>
                <td align="center">
                    <c:choose>
                        <c:when test="${technology.rate eq '1'}">
                            <c:out value="Важная">Важная</c:out>
                        </c:when>
                        <c:when test="${technology.rate eq '2'}">
                            <c:out value="Мезоморфная">Мезоморфная</c:out>
                        </c:when>
                        <c:when test="${technology.rate eq '3'}">
                            <c:out value="Второстепенная">Второстепенная</c:out>
                        </c:when>
                    </c:choose>
                </td>
            </tr>
        </c:forEach>
        </tbody>
        <tfoot>
        <tr>
            <td style="background: #ffffff; color: #ffffff; padding: 0" colspan="4">
                <ul class="button-group">
                    <li>
                        <button type="button" class="button-edit disabled" value="edit" id="buttonEdit" disabled
                                onclick="enableEditTechnology()"><i class="fa fa-pencil-square-o"></i> Редактировать
                        </button>
                    </li>
                    <li>
                        <button type="submit" class="button-delete disabled" disabled name="buttonDeleteTechnology"
                                id="buttonDelete"
                                onclick="if (!confirm('Вы действительно хотите удалить технологию?')) { return false; }">
                            <i class="fa fa-trash-o fa-lg"></i> Удалить технологию
                        </button>
                    </li>

                </ul>
            </td>
        </tr>
        </tfoot>
    </table>
</form>

<ul class="tsc_pagination tsc_paginationB tsc_paginationB02">
    <li><a href="main?showTechnologies&pageTech=1" class="first">Первая</a></li>
    <c:if test="${currentPage != 1}">
        <td>
            <li><a href="main?showTechnologies&pageTech=${currentPage - 1}" class="previous">Предыдущая</a></li>
        </td>
    </c:if>
    <c:forEach begin="1" end="${noOfPages}" var="i">
        <c:choose>
            <c:when test="${currentPage eq i}">
                <li><a href="#" class="current">${i}</a></li>
            </c:when>
            <c:otherwise>
                <li><a href="main?showTechnologies&pageTech=${i}">${i}</a></li>
            </c:otherwise>
        </c:choose>
    </c:forEach>
    <c:if test="${currentPage lt noOfPages}">
        <li><a href="main?showTechnologies&pageTech=${currentPage + 1}" class="next">Следующая</a></li>
    </c:if>
    <li><a href="main?showTechnologies&pageTech=${noOfPages}" class="last">Последняя</a></li>
</ul>

</body>
</html>