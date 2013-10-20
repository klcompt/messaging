angular.module('messagesApp').factory 'MessageList', ($resource, $http) ->
  class MessageList
    constructor: ->
      @service = $resource('/messages/:id',
        {id: '@id'},
        {update: {method: 'PUT'}})

    all: ->
      @service.query()

    create: (attrs, successHandler) ->
      new @service(message: attrs).$save ((message) -> successHandler(message)) #, @errorHandler      

    rescend: (messageId, successHandler) ->
      new @service({ message: { rescended: true }}).$update {id: messageId}, (-> successHandler())
