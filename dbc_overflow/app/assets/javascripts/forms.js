$(document).ready(function(){
   var view, controller
   view = new View
   controller = new Controller(view)
   controller.bindEventListeners();
   $("#new_ques").on('click',function(e){
    e.preventDefault();
    $('.qform').css('display', 'block');

    $(".new_question").on("submit", function(){
      event.preventDefault();
      quesSubmit($(this).serialize());
    })
   });
});

function quesSubmit(data){
    event.preventDefault();
    var url = event.currentTarget.action;
    $.ajax({
      url: url,
      type: 'post',
      data: data,
      dataType: 'json'
      }).done(function(response) {
        console.log(response);
        var questionel = $(".question_row").clone();
        var title = response.title
        var content = response.content
        var points = response.points
        questionel.find(".points").html(points)
        questionel.find(".title").html(title)
        questionel.find(".content").html(content)
        $("#question_index").append(questionel)
        $('input[type="text"], textarea').val('');
        $('.qform').css('display', 'none');
      });
}



