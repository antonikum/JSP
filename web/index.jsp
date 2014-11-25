<%-- The home page of the application --%>
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

<table border="0">
    <tr>
        <td style="padding: 8px"><a href="main?addEmployee" class="button-main"><i class="fa fa-user"></i> Добавить
            сотрудника</a></td>
        <td style="padding: 8px"><a href="main?showEmployees" class="button-main"><i class="fa fa-list-alt"></i> Список
            всех
            сотрудников</a></td>
    </tr>
    <tr>
        <td style="padding: 8px"><a href="main?addTechnology" class="button-main"><i class="fa fa-plus-square-o"></i>
            Добавить технологию</a></td>
        <td style="padding: 8px"><a href="main?showTechnologies" class="button-main"><i class="fa fa-list-ul"></i>
            Список
            всех технологий</a></td>
    </tr>
    <tr>
        <td style="padding: 8px" colspan="2"><a href="main?searchEmployees" class="button-main"><i
                class="fa fa-search"></i> Поиск сотрудников по технологиям</a>
        </td>
    </tr>
</table>

</body>
</html>