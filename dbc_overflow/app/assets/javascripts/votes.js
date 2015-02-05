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
    var target = $(event.currentTarget.parentElement.parentElement).find(".points")
    var url = event.currentTarget.action;
    var that = this
    $.ajax({
      url: url,
      type: 'post',
      dataType: 'json'
      }).done(function(response) {
        that.view.upVote(response, target)
      })
  },

  downVote: function(event){
    event.preventDefault();
    var target = $(event.currentTarget.parentElement.parentElement).find(".points")
    var url = event.currentTarget.action
    var that = this
    $.ajax({
      url: url,
      type: 'post',
      dataType: 'json'
    }).done(function(response) {
      that.view.downVote(response, target)
    })
  }
}

function View(){}

View.prototype = {
  upVote: function(points, target){
   target.html(points);
  },
  downVote: function(points, target){
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
