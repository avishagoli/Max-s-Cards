var collapseBtn = document.getElementById("collapse-btn");
var isCollapseOpen = false;
collapseBtn.addEventListener("click", setCollapse)

//var fileUploadBtn = document.getElementById("fileUploadBtn");
//fileUploadBtn.addEventListener("click", function () {
//    var hiddenFileUpload = document.getElementById("GridViewTrue_TrueFileUpload1")
//    hiddenFileUpload.click();
//})

var allTableHeaders = document.querySelectorAll(".span-all");
for (var i = 0; i < allTableHeaders.length; i++) {
    var header = allTableHeaders[i];
    header.colSpan = 3;
}

//var trueTextBtn = document.getElementById("addTextTrueClient");
//trueTextBtn.addEventListener("click", function () {
//    var addTextModalBtn = document.getElementById("add-text-modal-btn");
//    var addTrueTextBtn = document.getElementById("GridViewTrue_addTextTrue")

//    addTextModalBtn.addEventListener("click", function () {
//        addTrueTextBtn.click()
//    })
//})

function setCollapse() {
    var backdrop = document.getElementById("collapse-backdrop");

    if (!isCollapseOpen) {
        backdrop.style.display = "block";
        collapseBtn.firstElementChild.classList.add("rotate-180");
        isCollapseOpen = !isCollapseOpen;
    }
    else {
        backdrop.style.display = "none";
        collapseBtn.firstElementChild.classList.remove("rotate-180");

        isCollapseOpen = !isCollapseOpen;
    }

}

var editGameInfoBtn = document.getElementById("Button1");
var gameNameTextBox = document.getElementById("GameNameEdit");
var gameInstructionsTextBox = document.getElementById("GameInstructionsEdit");


$(document).ready(function () {

    $("#GameNameEdit").on("paste keyup", function () {
        function validateFunction(counter, label, button) { // סך תווים בתיבת טקסט
            var buttonsArray = button.split(", ");

            if (counter > 30 || counter < 2) {
                label.style.color = "red";
                for (var i = 0; i < buttonsArray.length; i++) {
                    var button = document.getElementById(buttonsArray[i]);
                    button.disabled = true;
                }
            }
            else {
                label.style.color = "green";
                for (var i = 0; i < buttonsArray.length; i++) {
                    var button = document.getElementById(buttonsArray[i]);
                    button.disabled = false;
                }
            }
        }
        checkCharacter($(this), validateFunction);//קריאה לפונקציה שבודקת את מספר התווים
    });
    $("#GameInstructionsEdit").on("paste keyup", function () {
        function validateFunction(counter, label, button) { // סך תווים בתיבת טקסט

            var buttonsArray = button.split(", ");

            if (counter > 30 || counter < 2) {
                label.style.color = "red";
                for (var i = 0; i < buttonsArray.length; i++) {
                    var button = document.getElementById(buttonsArray[i]);
                    button.disabled = true;
                }
            }
            else {
                label.style.color = "green";
                for (var i = 0; i < buttonsArray.length; i++) {
                    var button = document.getElementById(buttonsArray[i]);
                    button.disabled = false;
                }
            }
        }
        
        checkCharacter($(this), validateFunction);//קריאה לפונקציה שבודקת את מספר התווים
    });

    $("#textItem").on("paste keyup", function () {
        function validateFunction(counter, label, button) { // סך תווים בתיבת טקסט

            var buttonsArray = button.split(", ");

            if (counter > 30 || counter < 2) {
                label.style.color = "red";
                for (var i = 0; i < buttonsArray.length; i++) {
                    var button = document.getElementById(buttonsArray[i]);
                    button.disabled = true;
                }

            }
            else {
                label.style.color = "green";
                for (var i = 0; i < buttonsArray.length; i++) {
                    var button = document.getElementById(buttonsArray[i]);
                    button.disabled = false;
                }
            }
        }
        checkCharacter($(this), validateFunction);//קריאה לפונקציה שבודקת את מספר התווים
    });


    //פונקציה שמקבלת את תיבת הטקסט שבה מקלידים ובודקת את מספר התווים
    function checkCharacter(myTextBox, validateFunction) {
        //משתנה למספר התווים הנוכחי בתיבת הטקסט
        var countCurrentC = myTextBox.val().length;

        //משתנה המכיל את מספר התווים שמוגבל לתיבה זו
        var CharacterLimit = myTextBox.attr("CharacterLimit");

        //בדיקה האם ישנה חריגה במספר התווים
        if (countCurrentC >= CharacterLimit) {
            //מחיקת התווים המיותרים בתיבה
            myTextBox.val(myTextBox.val().substring(0, CharacterLimit));
            //עדכון של מספר התווים הנוכחי
            countCurrentC = CharacterLimit;
        }

        //משתנה המקבל את שם הלייבל המקושר לאותה תיבת טקסט 
        var LableToShow = document.getElementById(myTextBox.attr("CharacterForLabel"));
        var formButton = myTextBox.attr("FormButtons");
        //הדפסה כמה תווים הוקלדו מתוך כמה
        LableToShow.innerText = countCurrentC + "/" + CharacterLimit;

        validateFunction(countCurrentC, LableToShow, formButton);
    }

});

function checkValid() {
    var nameLength = gameNameTextBox.value.length;
    var instructionLength = gameInstructionsTextBox.value.length;

    var nameValid = false;
    var instructionValid = false;

    if (nameLength >= 2 && nameLength <= 30) {
        nameValid = true;
    }
    else {
        nameValid = false;
    }

    if (instructionLength >= 2 && instructionLength <= 30) {
        instructionValid = true;
    }
    else {
        instructionValid = false
    }

    if (nameValid == true && instructionValid == true) {
        return true;
    }
    return false
}

$(document).ready(function () { // סך הכל פריטים בתוך טבלה
    var counter = document.getElementsByTagName("tr").length - 2;
    var userInstruction = document.querySelector(".game-condition");
    if (counter >= 35) {
        document.getElementById("addTextTrueClient").disabled = true;
        document.getElementById("trueUploadBtn").disabled = true;
        document.getElementById("addTextFalseClient").disabled = true;
        document.getElementById("falseUploadBtn").disabled = true;
        userInstruction.innerText = "לא ניתן להוסיף יותר מ 35 פריטים במשחק";
        userInstruction.classList.add("custom-alert")
    }
    else {
        document.getElementById("addTextTrueClient").disabled = false;
        document.getElementById("trueUploadBtn").disabled = false;
        document.getElementById("addTextFalseClient").disabled = false;
        document.getElementById("falseUploadBtn").disabled = false;
        userInstruction.innerText = "עד 35 פריטים סך הכל במשחק";
        userInstruction.classList.remove("custom-alert")
    }
})

function fileUploadTrueClick(){
    var fileUpload = document.getElementById("TrueFileUpload1");
    fileUpload.click();
}

function fileUploadFalseClick() {
    var fileUpload = document.getElementById("FalseFileUpload");
    fileUpload.click();
}

function ShowPreview(input) {
    if (input.files && input.files[0] && input.files[0].type.includes("image")) {
        var reader = new FileReader();
        reader.onload = function (e) {
            document.getElementById("output").setAttribute("src", e.target.result);
            if (input.id.includes("True")) {
                toggle.modal('imageUpload');
            }
            else if (input.id.includes("False")) {
                toggle.modal('imageUploadFalse');
            }

        }
        reader.readAsDataURL(input.files[0]);
    }
    else {
        input.value = "";
        toggle.modal('imageError');
    }
   
}

function countBox() { // סך תווים בתיבת טקסט
    var counter = textItem.value.length;

    if (counter > 30 || counter < 2) {
        document.getElementById("letterIndex").style.color = "red";
        document.getElementById("randomBtn").disabled = true;
    }
    else {
        document.getElementById("letterIndex").style.color = "green";
        document.getElementById("randomBtn").disabled = false;
    }

    document.getElementById("letterIndex").innerHTML = counter + "/30"
}

// create new sort of class



const toggle = {
    // Define Names 
    modalView: document.getElementById("modal-content"),
    modalCard: document.getElementById("modalCard"),
    closeBtn: document.getElementById("close-image-modal"),
    saveImgBtn: SaveImageBtns,
    filePreview: document.getElementById("output"),
    saveTextBtn: randomBtn,
    textCounter: document.getElementById("letterIndex"),
    inputBox: textItem,
    zoomImage: document.getElementById("zoomImage"),
    saveTextFalse: randomBtn_FALSE,
    saveImgFalse: SaveImageBtns_FALSE,
    editImageBtn: document.getElementById("editUplaodBtn"),
    editTextBtn: document.getElementById("editTextBtn"),
    sureDelete: document.getElementById("sureDelete"),
    confirm: document.getElementById("okButton"),

    // Create Template 
    template: {
        title: {
            // The Title of the modal
            content: "some Text",
        },
        feature: {
            modalView: true, // do you want the modal to be shown?
            modalCard: false, // do you want the modal Card (pink) to be shown?
            closeBtn: true, // do you want to have "פח" Button?
            saveImgBtn: false, // do you want the Save Image Button?
            filePreview: false, // do you want the image preview image?
            saveTextBtn: false, // do you want to the Save Text Button?
            textCounter: false, // do you want the Text counter?
            inputBox: false, // do you want the input box for text?
            zoomImg: false, // When Zoom is Enabled - Always FALSE!!
            saveTextFalse: false, // do you want to the Save Text Button (FALSE SECTION)
            saveImgFalse: false, // do you want to the Save Image Button (FALSE SECTION)
            editImage: false,
            editText: false,
            sureDelete: false,
            confirm: false,
        }
    },
    // When Closing the Modal
    close: {
        title: {
            content: "ERROR",
        },
        feature: {
            modalView: false,
            modalCard: false,
            closeBtn: false,
            saveImgBtn: false,
            filePreview: false,
            saveTextBtn: false,
            textCounter: false,
            inputBox: false,
            zoomImg: false,
            saveTextFalse: false,
            saveImgFalse: false,
            editImage: false,
            editText: false,
            sureDelete: false,
            confirm: false,
        }
    },
    imageError: {
        title: {
            content: "הקובץ שנבחר אינו נתמך",
        },
        feature: {
            modalView: true,
            modalCard: false,
            closeBtn: false,
            saveImgBtn: false,
            filePreview: false,
            saveTextBtn: false,
            textCounter: false,
            inputBox: false,
            zoomImg: false,
            saveTextFalse: false,
            saveImgFalse: false,
            editImage: false,
            editText: false,
            sureDelete: false,
            confirm: true,
        }
    },
    // Image Upload
    imageUpload: {
        title: {
            content: "הוסף פריט מסוג תמונה לטבלת פריטים נכונים",
        },
        feature: {
            modalView: true,
            modalCard: true,
            closeBtn: true,
            saveImgBtn: true,
            filePreview: true,
            saveTextBtn: false,
            textCounter: false,
            inputBox: false,
            zoomImg: false,
            saveTextFalse: false,
            saveImgFalse: false,
            editImage: false,
            editText: false,
            sureDelete: false,
            confirm: false,
        }
    },
    // text Uplod
    textUpload: {
        title: {
            content: "הוסף פריט מסוג טקסט לטבלת פריטים נכונים",
        },
        feature: {
            modalView: true,
            modalCard: true,
            closeBtn: true,
            saveImgBtn: false,
            filePreview: false,
            saveTextBtn: true,
            textCounter: true,
            inputBox: true,
            zoomImg: false,
            saveTextFalse: false,
            saveImgFalse: false,
            editImage: false,
            editText: false,
            sureDelete: false,
            confirm: false,
        }
    },
    // Edit Modal
    editText: {
        title: {
            content: "עריכת פריט",
        },
        feature: {
            modalView: true,
            modalCard: true,
            closeBtn: true,
            saveImgBtn: false,
            filePreview: false,
            saveTextBtn: false,
            textCounter: true,
            inputBox: true,
            zoomImg: false,
            saveTextFalse: false,
            saveImgFalse: false,
            editImage: false,
            editText: true,
            sureDelete: false,
            confirm: false,
        }
    },
    editImage: {
        title: {
            content: "עריכת פריט",
        },
        feature: {
            modalView: true,
            modalCard: true,
            closeBtn: true,
            saveImgBtn: false,
            filePreview: true,
            saveTextBtn: false,
            textCounter: false,
            inputBox: false,
            zoomImg: false,
            saveTextFalse: false,
            saveImgFalse: false,
            editImage: true,
            editText: true,
            sureDelete: false,
            confirm: false,
        }
    },
    // Delete Item
    delete: {
        title: {
            content: "האם ברצונך למחוק את הפריט לצמיתות?",
        },
        feature: {
            modalView: true,
            modalCard: false,
            closeBtn: true,
            saveImgBtn: false,
            filePreview: false,
            saveTextBtn: false,
            textCounter: false,
            inputBox: false,
            zoomImg: false,
            saveTextFalse: false,
            saveImgFalse: false,
            editImage: false,
            editText: false,
            sureDelete: true,
            confirm: false,
        }
    },
    // Image Upload
    imageUploadFalse: {
        title: {
            content: "הוסף פריט מסוג תמונה לטבלת פריטים לא נכונים",
        },
        feature: {
            modalView: true,
            modalCard: true,
            closeBtn: true,
            saveImgBtn: false,
            filePreview: true,
            saveTextBtn: false,
            textCounter: false,
            inputBox: false,
            zoomImg: false,
            saveTextFalse: false,
            saveImgFalse: true,
            editImage: false,
            editText: false,
            sureDelete: false,
            confirm: false,
        }
    },
    // text Uplod
    textUploadFalse: {
        title: {
            content: "הוסף פריט מסוג טקסט לטבלת פריטים לא נכונים",
        },
        feature: {
            modalView: true,
            modalCard: true,
            closeBtn: true,
            saveImgBtn: false,
            filePreview: false,
            saveTextBtn: false,
            textCounter: true,
            inputBox: true,
            zoomImg: false,
            saveTextFalse: true,
            saveImgFalse: false,
            editImage: false,
            editText: false,
            sureDelete: false,
            confirm: false,
        }
    },
    // Image Zoom
    zoom: (img) => {
        var main = toggle; // Like "this" 
        $("#add-modal").modal('show'); // Active the Modal
        main.modal("close"); // The modal style is "close"
        main.zoomImage.hidden = !true; // Put Image Only
        main.zoomImage.src = document.getElementById(img).src; // src little picture to big picture
    },
    reset: function () {
        var main = toggle;
        main.inputBox.value = "";
        main.filePreview.src = "";
        main.textCounter.innerText = "";
    },
    // Create Modal  Function
    modal: (which) => {
        var main = toggle;
        if (which == "close") {
            main.reset();
        }
        var which = toggle[which];
        document.getElementById("imageModalLabel").innerHTML = which.title.content;
        main.modalView.hidden = !which.feature.modalView;
        main.modalCard.hidden = !which.feature.modalCard;
        main.closeBtn.hidden = !which.feature.closeBtn;
        main.saveImgBtn.hidden = !which.feature.saveImgBtn;
        main.filePreview.hidden = !which.feature.filePreview;
        main.saveTextBtn.hidden = !which.feature.saveTextBtn;
        main.textCounter.hidden = !which.feature.textCounter;
        main.inputBox.hidden = !which.feature.textCounter;
        main.zoomImage.hidden = !which.feature.zoomImg;
        main.saveTextFalse.hidden = !which.feature.saveTextFalse;
        main.saveImgFalse.hidden = !which.feature.saveImgFalse;
        main.editTextBtn.hidden = !which.feature.editText;
        main.editImageBtn.hidden = !which.feature.editImage;
        main.sureDelete.hidden = !which.feature.sureDelete;
        main.confirm.hidden = !which.feature.confirm;

        $("#textItem").keyup();
        
    }
}

function editItem(e) {
    e.preventDefault();
    var itemId = e.currentTarget.id;
    var content = document.querySelector("[itemlabel='" + itemId + "']")
    if (content.nodeName == "IMG") {
        toggle.modal('editImage');
        document.getElementById("output").src = content.src;
        var modelBtn = document.getElementById("editTextBtn");
        var editBtn = document.querySelector("[data-edit='" + itemId + "']")
        modelBtn.addEventListener("click", function () {
            editBtn.click()
        });
    }
    else if (content.nodeName == "SPAN") {
        toggle.modal("editText");
        var input = $("#textItem");
        input.val(content.innerText);
        var editBtn = document.querySelector("[data-edit='" + itemId + "']")
        var modelBtn = document.getElementById("editTextBtn");
        modelBtn.addEventListener("click", function () {
            editBtn.click()
        })
        $("#textItem").keyup();
    }
}

function deleteItem(e) {
    e.preventDefault();
    var itemId = e.currentTarget.id;
    var deleteBtn = document.querySelector("[data-delete='" + itemId + "']")
    var modelBtn = document.getElementById("sureDelete");
    modelBtn.addEventListener("click", function () {
        deleteBtn.click()
    })
    toggle.modal("delete");
}

$('#add-modal').on('hidden.bs.modal', function (e) {
    toggle.modal("close")
})


// Zoom Event
var img = document.querySelectorAll(".table-image");
var string = "GridViewTrue_ItemNameImage_"; // Base Structure of IMG ID
var eventListener = ""
for (index = 0; index < img.length; index++) {
    if (img[index].id) { // IMG ID EXISTS?
        img[index].addEventListener("click", function (e) { //
            toggle.zoom(e.target.id)
        });
    };
};

function resetHeaderControls() {
    var nameTxtBox = $("#GameNameEdit");
    var instructionsTxtBox = $("#GameInstructionsEdit");

    nameTxtBox.keyup();
    instructionsTxtBox.keyup();
}