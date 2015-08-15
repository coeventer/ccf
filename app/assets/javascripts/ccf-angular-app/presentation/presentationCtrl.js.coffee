angular.module('app.presentationApp').controller("PresentationCtrl", ['$scope', 'ngDialog', 'Restangular', '$location', '$modal'
  ($scope, ngDialog, Restangular, $location, $modal)->
    console.log 'PresentationCtrl running'

    $scope.defaultText = "(Click to add content)"
    id = $location.$$absUrl.match(/projects\/[0-9]+/g)[0].replace("projects/", "")
    Restangular.one('projects', id).customGET('presentation.json').then(
      (presentation) ->
        $scope.presentation = presentation.presentation
        if ($scope.presentation.published)
          $scope.defaultText = ""
    )

    $scope.editPresentation = (presentation, field) ->
      modalInstance = $modal.open({
        templateUrl: '/templates/presentation/modal_edit.html ',
        controller: 'PresentationEditModalCtrl'
        resolve:
          presentation: ->
            presentation
          field: ->
            field
      })

      modalInstance.result.then(->
        console.log 'edit closed'
      )
])
