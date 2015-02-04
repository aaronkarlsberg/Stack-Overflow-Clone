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
    $(".up form.button_to").submit(this.upVote.bind(this));
    $(".down form.button_to").submit(this.downVote.bind(this));
  },

   upVote: function(event){
    event.preventDefault();
    target = $(event.currentTarget.parentElement.parentElement).find(".points")
    var url = event.currentTarget.action;
    $.ajax({
      url: url,
      type: 'post',
      dataType: 'json'
      }).done(this.view.upVote)
  },

  downVote: function(event){
    event.preventDefault();
    target = $(event.currentTarget.parentElement.parentElement).find(".points")
    var url = event.currentTarget.action
    $.ajax({
      url: url,
      type: 'post',
      dataType: 'json'
    }).done(this.view.downVote)
  }
}

function View(){}

View.prototype = {
  upVote: function(points){
   target.html(points);
  },

  downVote: function(points){
    target.html(points);
  }
}











//non-mvc
  // upVote: function(event){
  //   event.preventDefault();
  //   var url = $("#up form.button_to").attr('action')
  //   $.ajax({
  //     url: url,
  //     type: 'post',
  //     dataType: 'json'
  //     }).done(function(points){
  //       $("#points").html(points)
  //     });
  // },

  // downVote: function(){
  //   event.preventDefault();
  //   var url = $("#down form.button_to").attr('action')
  //   $.ajax({
  //     url: url,
  //     type: 'post',
  //     dataType: 'json'
  //   }).done(function(points){
  //     $("#points").html(points)
  //   });
  // }
