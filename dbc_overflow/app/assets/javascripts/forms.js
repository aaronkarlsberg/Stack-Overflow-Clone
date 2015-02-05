$(document).ready(function(){
   $("#new_ques").on('click',function(e){
    e.preventDefault();
    $('.qform').css('display', 'block');
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
      });
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
        // $('input[type="text"], textarea').val('');
        // $('.qform').css('display', 'none');
        console.log(response)
      });
}



