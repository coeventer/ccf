angular.module('app.presentationApp').controller("PresentationCtrl", [
  '$scope',
  ($scope)->
    console.log 'PresentationCtrl running'

    $scope.exampleValue = "Hello angular and rails"

])
