// Generated by CoffeeScript 1.10.0
(function() {
  var app, controllers;

  app = angular.module('QCD', ['templates', 'ngRoute', 'controllers', 'ngResource']);

  app.factory("Qcd", [
    "$resource", function($resource) {
      return $resource("/qcds/:id", {
        id: "@id"
      }, {
        update: {
          method: "PUT"
        }
      });
    }
  ]);

  app.factory("Asignatura", [
    "$resource", function($resource) {
      return $resource("/asignaturas/:id", {
        id: "@id"
      }, {
        update: {
          method: "PUT"
        }
      });
    }
  ]);

  controllers = angular.module('controllers', []);

  controllers.controller("asignaturaController", [
    '$scope', 'Asignatura', 'Qcd', function($scope, Asignatura, Qcd) {
      $scope.Qcds = Qcd.query();
      return $scope.addQcd = function() {};
    }
  ]);

}).call(this);
