angular.module('messagesApp').controller 'MessageListController',
  ['$scope', 'MessageList', ($scope, MessageList) ->
    $scope.init = ->
      @messageService = new MessageList()
      $scope.messages = @messageService.all()

    $scope.createMessage = (messageTitle, messageBody) ->
      @messageService.create { title: messageTitle, body: messageBody }, (message) ->
        $scope.messageTitle = ""
        $scope.messageBody = ""
        $scope.messages.push(message)

    $scope.rescindMessage = (message) ->
      @messageService.rescind message.id, ->
        message.rescinded = true
  ]
