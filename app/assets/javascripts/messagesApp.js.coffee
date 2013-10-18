messagesApp = angular.module('messagesApp', ['ngResource'])

messagesApp.config ($httpProvider) ->
  authToken = $("meta[name=\"csrf-token\"]").attr("content")
  $httpProvider.defaults.headers.common["X-CSRF-TOKEN"] = authToken

messagesApp.config ($routeProvider, $locationProvider) -> 
  $locationProvider.html5Mode true
  $routeProvider.when '/', controller: 'MessageListController'
