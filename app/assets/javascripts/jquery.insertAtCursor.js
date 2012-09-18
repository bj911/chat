$.fn.extend({
    insertAtCaret: function(myValue){
        var obj;
        if( typeof this[0].name !='undefined' ) obj = this[0];
        else obj = this;

        if ($.browser.msie) {
            obj.focus();
            sel = document.selection.createRange();
            sel.text = myValue;
            obj.focus();
        }
        else  {
            var startPos = obj.selectionStart;
            var endPos = obj.selectionEnd;
            var scrollTop = obj.scrollTop;
            obj.value = obj.value.substring(0, startPos)+myValue+obj.value.substring(endPos,obj.value.length);
            obj.focus();
            obj.selectionStart = startPos + myValue.length;
            obj.selectionEnd = startPos + myValue.length;
            obj.scrollTop = scrollTop;
        }
    },

    getCursorPosition: function() {
        var el = $(this).get(0);
        var pos = 0;
        if('selectionStart' in el) {
            pos = el.selectionStart;
        } else if('selection' in document) {
            el.focus();
            var Sel = document.selection.createRange();
            var SelLength = document.selection.createRange().text.length;
            Sel.moveStart('character', -el.value.length);
            pos = Sel.text.length - SelLength;
        }
        return pos;
    },

    setCursorPosition: function(position){
        if(this.length == 0) return this;
        return $(this).setSelection(position, position);
    },

    setSelection: function(selectionStart, selectionEnd) {
        if(this.length == 0) return this;
        input = this[0];

        if (input.createTextRange) {
            var range = input.createTextRange();
            range.collapse(true);
            range.moveEnd('character', selectionEnd);
            range.moveStart('character', selectionStart);
            range.select();
        } else if (input.setSelectionRange) {
            input.focus();
            input.setSelectionRange(selectionStart, selectionEnd);
        }

        return this;
    }
})

function addTag(window, tag) {
    window = $(window);
    window.insertAtCaret("["+tag+"][/"+tag+"]");
    window.setCursorPosition(window.getCursorPosition() - ("[/"+tag+"]").length);
}

function addSizeTag(window, tag) {
    window = $(window);
    window.insertAtCaret("[size="+tag+"][/size]");
    window.setCursorPosition(window.getCursorPosition() - "[/size]".length);
}

function addColorTag(window, tag) {
    window = $(window);
    window.insertAtCaret("[color="+tag+"][/color]");
    window.setCursorPosition(window.getCursorPosition() - "[/color]".length);
}

function addUrlTag(window, tag) {
    window = $(window);
    window.insertAtCaret("["+tag+"]http://[/"+tag+"]");
    window.setCursorPosition(window.getCursorPosition() - ("[/"+tag+"]").length);
}

function addSmileTag(window, tag) {
    window = $(window);
    window.insertAtCaret(tag);
}

$(document).ready(function() {
    Tt();
})

function Tt() {
    $('#messages').animate({scrollTop: '+=' + 10000 + 'px'});
}

function Clear() {
    $('#history_message').val("");
    $('#history_picture').val("");
}

function Personal_message(id,login){
    $("#history_recive_id").val(id);
    $(".personal label").html("Send "+login+":");
    $(".all a").show();
}

function All_message(){
    $("#history_recive_id").val("");
    $(".personal label").html("Send all:");
    $(".all a").hide();
}