app = angular.module('QCD',[
  'templates',
  'ngRoute',
  'controllers',
])

app.config([ '$routeProvider',
  ($routeProvider)->
    $routeProvider
      .when('/',
        templateUrl: "index.html"
        controller: 'asignaturaController'
      )
])

controllers = angular.module('controllers',[])
controllers.controller("asignaturaController", [ '$scope',
  ($scope)->
])
