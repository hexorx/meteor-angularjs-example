window.app = angular.module('meteorapp', ['meteor'])
  .config(['$routeProvider', function ($routeProvider) {
    $routeProvider
      .when('/', {templateUrl: 'partials/index.html',   controller: 'TodoCtrl'})
      .when('/:filter', {templateUrl: 'partials/index.html',   controller: 'TodoCtrl'})
      .otherwise({redirectTo: '/'});
  }]);
