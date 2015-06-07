@app = angular.module('app', [
  'restangular',
  'templates'
])

# for compatibility with Rails CSRF protection

@app.config([
  '$httpProvider', ($httpProvider)->
    $httpProvider.defaults.headers.common['X-CSRF-Token'] = $('meta[name=csrf-token]').attr('content')
])

@app.run(->
  console.log 'angular app running'
)
