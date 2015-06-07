@presentationApp = angular
  .module('app.presentationApp', [
    "ngDialog",
    "restangular",
    "ui.bootstrap",
    "templates"
  ])
  .run(->
    console.log 'presentationApp running'
  )
