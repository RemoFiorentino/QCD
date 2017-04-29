app = angular.module('qcdApp',[
  'controllers',
  'ngResource'
])

app.factory "Qcd", ["$resource", ($resource) ->
  $resource("/qcds/:id", {id: "@id"}, {update: {method: "PUT"}})
]

app.factory "Asignatura", ["$resource", ($resource) ->
  $resource("/asignaturas/:id", {id: "@id"}, {update: {method: "PUT"}})
]

# app.config([ '$routeProvider',
#   ($routeProvider)->
#     $locationProvider.hashPrefix('');
#     $routeProvider
#       .when('/asignaturas',
#         controller: 'qcdIndexController'
#       )
# ])

controllers = angular.module('controllers',[])
app.controller("qcdIndexController", [ '$scope', 'Asignatura', 'Qcd'
  ($scope, Asignatura, Qcd)->
    $scope.qcds = Qcd.query()
    $scope.addQcd = ->
      $scope.newQcd.asignatura_id = Asignatura.id
      qcd = Qcd.save($scope.newQcd)
      $scope.qcds.push(qcd)
      $scope.newQcd = {}
    
])
