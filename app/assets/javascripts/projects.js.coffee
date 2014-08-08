#= require bootstrap-tour
# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
  projectTour = new Tour
    steps: [
      title: 'Submitting a Project'
      content: 'Here you can submit and idea for a project to work on. Other attendees can then vote on the project and express interest in helping out.'
      element: '.tour-first-step'
      placement: 'bottom'
     ,
      title: 'Voting on Projects'
      content: 'Voting on a project indicates to other attendees that you believe the project to be a good idea and one that should receive other\'s attention'
      element: '.vote_container:first'
     ,
      title: 'Volunteering on Projects'
      content: 'In addition to voting, you can also indicate and interest in helping out with a project. This is not binding, so don\'t worry if you change your mind'
      element: '.volunteer_container:first'
    ]

  projectTour.init()
  projectTour.start()
