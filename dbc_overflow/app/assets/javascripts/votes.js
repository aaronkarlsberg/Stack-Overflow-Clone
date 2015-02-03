$(document).ready(function(){
   var view, controller
   view = new View
   controller = new Controller(view)
   controller.bindEventListeners();
})

function Controller(view){
  this.view = view
}

Controller.prototype = {

  bindEventListeners: function(){
    $("form.button_to").submit(this.upVote.bind(this));
    $(".downvote").submit(this.downVote.bind(this));
  },

  upVote: function(event){
    event.preventDefault();
    var url = $("form.button_to").attr('action')
    $.ajax({
      url: url,
      type: 'post',
      dataType: 'json'
      }).done(function(points){
        $("#points").html(points)
      });
  },

  downVote: function(){
    event.preventDefault();
    $.ajax({
      url: downvote_question_answer_path(answer.question, answer),
      type: 'post',
    }).done(this.view.downVote(points));
  }
}

function View(){}

View.prototype = {
  upVote: function(points){
    console.log(points)
    $("#points").html(points)
  },

  downVote: function(points){
    $("#points").text(points)
  }
}


// $(document).ready(function(){
//   $(".upvote").click(function(){
//     event.preventDefault();
//   });
// })
