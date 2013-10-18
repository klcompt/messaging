angular.module('messagesApp').factory 'MessageList', ($resource, $http) ->
  class MessageList
    constructor: ->
      @service = $resource('/messages');

    all: ->
      @service.query()

    create: (attrs, successHandler) ->
      new @service(message: attrs).$save ((message) -> successHandler(message)) #, @errorHandler      
