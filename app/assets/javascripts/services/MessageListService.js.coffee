angular.module('messagesApp').factory 'MessageList', ($resource, $http) ->
  class MessageList
    constructor: ->
      @service = $resource('/messages');

    all: ->
      @service.query()
