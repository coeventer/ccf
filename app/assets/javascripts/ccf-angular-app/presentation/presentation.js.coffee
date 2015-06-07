@presentationApp = angular
  .module('app.presentationApp', [
    "ngDialog",
    "restangular",
    "ui.bootstrap",
    "templates"
  ])
  .config((RestangularProvider)->
    console.log("configuring this bitch")
    RestangularProvider.setDefaultHeaders({'X-CSRF-Token': $('meta[name=csrf-token]').attr('content')})
    RestangularProvider.setDefaultHttpFields({withCredentials: true})
  )
  .run(->
    console.log 'presentationApp running'
  )
