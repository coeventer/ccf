@presentationApp = angular
  .module('app.presentationApp', [
    # additional dependencies here
  ])
  .run(->
    console.log 'presentationApp running'
  )
