function copyDataEditEmployee(value) {

    var trs = document.querySelectorAll("tr");
    for (var i = 0; i < trs.length; i++) {
        trs[i].className = "td";
    }

    var tr = document.getElementById(value);
    tr.className += " selected";
    var new_tr = tr.cloneNode(true);

    var td_surname = new_tr.cells.item(1).firstChild.nodeValue.trim();
    var td_name = new_tr.cells.item(2).firstChild.nodeValue.trim();

    var td_gender = new_tr.cells.item(3).firstChild.nodeValue.trim();
    if (!td_gender.localeCompare("Мужской")) {
        td_gender = "male";
    }
    else {
        td_gender = "female";
    }

    var td_maritalStatus = new_tr.cells.item(4).firstChild.nodeValue.trim();
    if (!td_maritalStatus.localeCompare("Холост")) {
        td_maritalStatus = "single";
    }
    else if (!td_maritalStatus.localeCompare("Женат")) {
        td_maritalStatus = "married";
    }
    else {
        td_maritalStatus = "divorced";
    }

    var td_salary = new_tr.cells.item(5).firstChild.nodeValue.trim();
    var td_dob = new_tr.cells.item(6).firstChild.nodeValue.trim();

    document.getElementById("idemployeeforupdate").setAttribute("value", value);
    document.getElementById("surname").setAttribute("value", td_surname);
    document.getElementById("name").setAttribute("value", td_name);
    var gender = document.getElementById("gender");
    gender.value = td_gender;
    var maritalStatus = document.getElementById("maritalstatus");
    maritalStatus.value = td_maritalStatus;
    document.getElementById("salary").setAttribute("value", td_salary);
    document.getElementById("dob").setAttribute("value", td_dob);

    document.getElementById("buttonEdit").disabled = false;
    document.getElementById("buttonEdit").setAttribute("class", "button-edit");
    document.getElementById("buttonDelete").disabled = false;
    document.getElementById("buttonDelete").setAttribute("class", "button-delete");
    document.getElementById("buttonEditAffairs").disabled = false;
    document.getElementById("buttonEditAffairs").setAttribute("class", "button-blue");
    document.getElementById("idEmployeeEditTechnologies").setAttribute("value", value);
    document.getElementById("idEmployeeToDelete").setAttribute("value", value);
    document.getElementById("formForEditEmployeeValues").hidden = true;
}

function enableEditEmployee() {
    document.getElementById("formForEditEmployeeValues").hidden = false;
    document.getElementById("buttonDelete").disabled = true;
    document.getElementById("buttonDelete").setAttribute("class", "button-delete disabled");
    document.getElementById("buttonEditAffairs").disabled = true;
    document.getElementById("buttonEditAffairs").setAttribute("class", "button-blue disabled");
}

function copyDataEditTechnology(value) {
    var trs = document.querySelectorAll("tr");
    for (var i = 0; i < trs.length; i++) {
        trs[i].className = "td";
    }
    var tr = document.getElementById(value);
    tr.className += " selected";
    var new_tr = tr.cloneNode(true);

    var td_name = new_tr.cells.item(1).firstChild.nodeValue.trim();
    var td_description = new_tr.cells.item(2).firstChild.nodeValue.trim();

    var td_rate = new_tr.cells.item(3).firstChild.nodeValue.trim();
    if (!td_rate.localeCompare("Важная")) {
        td_rate = "1";
    }
    else if (!td_rate.localeCompare("Мезоморфная")) {
        td_rate = "2";
    }
    else {
        td_rate = "3";
    }

    document.getElementById("idtechnologyforupdate").setAttribute("value", value);

    var name = document.getElementById("name");
    name.value = td_name;
    var description = document.getElementById("description");
    description.value = td_description;
    var rate = document.getElementById("rate");
    rate.value = td_rate;

    document.getElementById("formForEditTechnologyValues").hidden = true;
    document.getElementById("buttonEdit").disabled = false;
    document.getElementById("buttonEdit").setAttribute("class", "button-edit");
    document.getElementById("buttonDelete").disabled = false;
    document.getElementById("buttonDelete").setAttribute("class", "button-delete");
}

function enableEditTechnology() {
    document.getElementById("formForEditTechnologyValues").hidden = false;
    document.getElementById("buttonDelete").disabled = true;
    document.getElementById("buttonDelete").setAttribute("class", "button-delete disabled");
}

function validateAddEmployeeForm() {
    var surName = document.forms["addEmployeeForm"]["surName"].value;
    var name = document.forms["addEmployeeForm"]["name"].value;
    var salary = document.forms["addEmployeeForm"]["salary"].value;
    var dob = document.forms["addEmployeeForm"]["dob"].value;
    var regText = /^[a-zа-яA-ZА-ЯёЁ-]+$/;
    var regNumbers = /^[0-9]{1,9}$/;
    var regDob = /^[0-9]{4}-[0-9]{2}-[0-9]{2}$/;
    var result = false;
    if (regText.exec(surName) == null || surName.length > 30) {
        alert("Вы указали неправильную фамилию!");
        document.getElementById("surName").setAttribute("style", "background-color: red");
        document.getElementById("surnameAttribute").setAttribute("style", "border: 2px dotted red");
    }
    else {
        if (regText.exec(name) == null || name.length > 30) {
            alert("Вы указали неправильное имя!");
            document.getElementById("name").setAttribute("style", "background-color: red");
            document.getElementById("nameAttribute").setAttribute("style", "border: 2px dotted red");
        }
        else {
            if (document.addEmployeeForm.gender[0].checked == false && document.addEmployeeForm.gender[1].checked == false) {
                alert("Пожалуйста, выберите пол: Мужской или Женский");
                document.getElementById("genderTd").setAttribute("style", "background-color: red");
            }
            else {
                if (regNumbers.exec(salary) == null || salary.length > 10) {
                    alert("Вы указали неправльную ЗП!");
                    document.getElementById("salary").setAttribute("style", "background-color: red");
                    document.getElementById("salaryAttribute").setAttribute("style", "border: 2px dotted red");
                }
                else {
                    if (regDob.exec(dob) == null) {
                        document.getElementById("dob").setAttribute("style", "background-color: red");
                        document.getElementById("dobAttribute").setAttribute("style", "border: 2px dotted red");
                        alert("Вы указали неправильный формат даты рождения!");
                    }
                    else {
                        result = true;
                    }
                }
            }
        }
    }
    return result;
}

function validateAddTechnologyForm() {
    var name = document.forms["addTechnologyForm"]["name"].value;
    var description = document.forms["addTechnologyForm"]["description"].value;
    var result = false;
    if (name.length == 0) {
        alert("Пожалуйста, укажите название технологии!");
        document.getElementById("nameTd").setAttribute("style", "background-color: red");
    }
    else if (name.length > 50) {
        alert("Вы превысили количество символов в названии технологии");
        document.getElementById("nameTd").setAttribute("style", "background-color: red");
    }
    else {
        if (description.length == 0) {
            alert("Пожалуйста, укажите описание технологии!");
            document.getElementById("descriptionTd").setAttribute("style", "background-color: red");
        }
        else if (description.length > 200) {
            alert("Вы превысили количество символов в описании технологии");
            document.getElementById("descriptionTd").setAttribute("style", "background-color: red");
        }
        else {
            result = true;
        }
    }
    return result;
}

function showSuccessOfAdding() {
    var successMessage = document.getElementById("messageAddedNewEntry").getAttribute("value");
    if (successMessage != null) {
        alert(successMessage);
    }
}

function enableSearchButton() {
    var groupCheckBox = document.getElementsByName("idTechnologies");
    var result = false;
    window.onclick = function () {
        for (var i = 0; i < groupCheckBox.length; i++)
            if (groupCheckBox[i].checked) {
                result = true
            }
        if (result) {
            document.getElementById("buttonSearchEmployees").disabled = false;
            document.getElementById("buttonSearchEmployees").setAttribute("class", "button-blue");
        }
        else {
            document.getElementById("buttonSearchEmployees").disabled = true;
            document.getElementById("buttonSearchEmployees").setAttribute("class", "button-blue disabled");
        }
    }
}

function printListTechnologiesToAdd() {
    document.getElementById("formTechnologiesToAdd").hidden = false;
    document.getElementById("formTechnologiesToDelete").hidden = true;
}

function printListTechnologiesToDelete() {
    document.getElementById("formTechnologiesToDelete").hidden = false;
    document.getElementById("formTechnologiesToAdd").hidden = true;
}

function enableAddTechnologyToEmployeeButton() {
    document.getElementById("buttonAddTechnologyToEmployee").disabled = false;
    document.getElementById("buttonAddTechnologyToEmployee").setAttribute("class", "button-save");
    document.getElementById("idEmployeeToAddTechnology").setAttribute("value", document.getElementById("idEmployee").value);
}

function enableDeleteTechnologyOfEmployeeButton() {
    document.getElementById("buttonDeleteTechnologyEmployee").disabled = false;
    document.getElementById("buttonDeleteTechnologyEmployee").setAttribute("class", "button-delete");
    document.getElementById("idEmployeeToRemoveTechnology").setAttribute("value", document.getElementById("idEmployee").value);
}