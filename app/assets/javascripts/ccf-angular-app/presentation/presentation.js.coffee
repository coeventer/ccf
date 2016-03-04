@presentationApp = angular
  .module('app.presentationApp', [
    "ngDialog",
    "restangular",
    "ui.bootstrap",
    "templates",
    "yaru22.md"
  ])
  .config((RestangularProvider)->
    console.log("configuring...")
    RestangularProvider.setDefaultHeaders({'X-CSRF-Token': $('meta[name=csrf-token]').attr('content')})
    RestangularProvider.setDefaultHttpFields({withCredentials: true})
  )
  .run(->
    console.log 'presentationApp running'
  )
