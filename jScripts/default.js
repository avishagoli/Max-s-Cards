var submitNewGameBtn = document.getElementById("submitNewGame");
var gameNameTextBox = document.getElementById("GameName");
var gameInstructionsTextBox = document.getElementById("GameInstructions");
var tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'))
var tooltipList = tooltipTriggerList.map(function (tooltipTriggerEl) {
    return new bootstrap.Tooltip(tooltipTriggerEl)
})

$(document).ready(function () {

    $("#GameName").on("paste keyup", function () {
        checkCharacter($(this));//קריאה לפונקציה שבודקת את מספר התווים
    });
    $("#GameInstructions").on("paste keyup", function () {
        checkCharacter($(this));//קריאה לפונקציה שבודקת את מספר התווים
    });


    //פונקציה שמקבלת את תיבת הטקסט שבה מקלידים ובודקת את מספר התווים
    function checkCharacter(myTextBox) {

        //משתנה למספר התווים הנוכחי בתיבת הטקסט
        var countCurrentC = myTextBox.val().length;

        //משתנה המכיל את מספר התווים שמוגבל לתיבה זו
        var CharacterLimit = myTextBox.attr("CharacterLimit");

        //בדיקה האם ישנה חריגה במספר התווים
        if (countCurrentC > CharacterLimit) {

            //מחיקת התווים המיותרים בתיבה
            myTextBox.val(myTextBox.val().substring(0, CharacterLimit));
            //עדכון של מספר התווים הנוכחי
            countCurrentC = CharacterLimit;

        }

        //משתנה המקבל את שם הלייבל המקושר לאותה תיבת טקסט 
        var LableToShow = myTextBox.attr("CharacterForLabel");

        //הדפסה כמה תווים הוקלדו מתוך כמה
        var label = $("#" + LableToShow)
        label.text(countCurrentC + "/" + CharacterLimit);

        if (countCurrentC >= 2 && countCurrentC <= CharacterLimit) {
            label.css("color", "green");
        }
        else {
            label.css("color", "red");
        }
        
        var formValid = checkValid(label);
        if (formValid == true) {
            submitNewGameBtn.disabled = false;
        }
        else {
            submitNewGameBtn.disabled = true;
        }
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
        instructionValid = false;
    }

    if (nameValid == true && instructionValid == true) {
        return true;
    }
    return false
}

function openModal(e) {// מקבל איבנט משורה 93
    var gameCodeToDelete = e.currentTarget.id;// מקבל את האיי די של הכפתור שנלחץ כדי לדעת איזה משחק למחוק
    var buttonToClick = document.querySelector("[theGame='" + gameCodeToDelete + "']")// הכפתור המוסתר שמוחק בפועל, מזוהה על ידי מאפיין שנקרא דה גיים
    var okButton = document.getElementById('okDelete');// הכפתור שבמודל עצמו שמסכים למחיקה
    okButton.onclick = function () {// ברגע הלחיצה על הכפתור הוא מפעיל לחיצה על הכפתור המוסתר
        buttonToClick.click()// מפעיל את הלחיצה על הכפתור המוסתר
    };
}

function resetInputs() {
    var gameInput = $("#GameName");
    var instructionsInput = $("#GameInstructions");
    gameInput.val("")
    instructionsInput.val("")
    gameInput.keyup();
    instructionsInput.keyup();
    

}