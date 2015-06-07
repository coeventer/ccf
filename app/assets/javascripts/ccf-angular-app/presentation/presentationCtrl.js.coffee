angular.module('app.presentationApp').controller("PresentationCtrl", ['$scope', 'ngDialog', 'Restangular', '$location', '$modal'
  ($scope, ngDialog, Restangular, $location, $modal)->
    console.log 'PresentationCtrl running'

    $scope.defaultText = "(Click to add content)"
    id = $location.$$absUrl.match(/projects\/\d/g)[0].replace("projects/", "")
    Restangular.one('projects', id).customGET('presentation.json').then(
      (presentation) ->
        $scope.presentation = presentation.presentation
        $location
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
