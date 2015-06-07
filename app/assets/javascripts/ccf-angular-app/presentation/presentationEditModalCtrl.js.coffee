angular.module('app.presentationApp').controller('PresentationEditModalCtrl', [
  '$scope', '$modalInstance', 'presentation', 'field', ($scope, $modalInstance, presentation, field)->
  
    $scope.presentation = presentation
    $scope.field = field

    $scope.submitPresentation = ->
      console.log 'submit prez'

    $scope.cancel = ->
      $modalInstance.dismiss('cancel')

])
