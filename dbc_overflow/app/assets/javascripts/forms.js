$(document).ready(function(){
   $("#new_ques").on('click',function(e){
    e.preventDefault();
    $('.qform').css('display', 'block');
    $('#errorform').html("");
    })
    $(".new_question").on("submit", function(){
      event.preventDefault();
      quesSubmit($(this).serialize());
   });
   $(".new_answer").on("submit", function(){
      event.preventDefault();
      answSubmit($(this).serialize());
   });


});

function quesSubmit(data){
    event.preventDefault();
    var url = event.currentTarget.action;
    $.ajax({
      url: url,
      type: 'post',
      data: data
      }).done(function(response) {
        $('#question_index').append($(response));
        $('input[type="text"], textarea').val('');
        $('.qform').css('display', 'none');
        $('#errorform').html("");

      }).fail(function(response){
         $('.qform').css('display', 'none');
          $("#errorform").html(($(response.responseText)));
           $(".new_question").on("submit", function(){
            event.preventDefault();
            quesSubmit($(this).serialize());
           });
      })
}

function answSubmit(data){
    event.preventDefault();
    var url = event.currentTarget.action;
    $.ajax({
      url: url,
      type: 'post',
      data: data
      }).done(function(response) {
        $('#answers').append($(response));
        $('input[type="text"], textarea').val('');
        console.log(response)
      }).fail(function(){
        alert("You need to enter both fields!")
      });
}



