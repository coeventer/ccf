angular.module('app.presentationApp').controller('PresentationEditModalCtrl', [
  '$scope', '$modalInstance', 'presentation', 'field', '$location', 'Restangular', ($scope, $modalInstance, presentation, field, $location, Restangular)->
    $scope.presentation = presentation
    $scope.oldValue = presentation[field]
    $scope.field = field
    presentation = { presentation: $scope.presentation }
    id = $location.$$absUrl.match(/projects\/\d/g)[0].replace("projects/", "")

    $scope.submitPresentation = ->
      Restangular.one('projects', id).customPUT(presentation, 'presentation.json').then(
        (presentation) ->
          $modalInstance.dismiss('close')
      )
      
    $scope.cancel = ->
      $modalInstance.dismiss('cancel')
      $scope.presentation[field] = $scope.oldValue

])
