@app = angular.module('app', [
  'templates'
])

# for compatibility with Rails CSRF protection

@app.run(->
  console.log 'angular app running'
)
