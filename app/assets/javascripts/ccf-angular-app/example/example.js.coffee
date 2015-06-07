@exampleApp = angular
  .module('app.exampleApp', [
    # additional dependencies here
  ])
  .run(->
    console.log 'exampleApp running'
  )
