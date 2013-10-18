angular.module('messagesApp').controller 'MessageListController', ($scope, MessageList) ->

  $scope.init = ->
    @messageService = new MessageList()
    $scope.messages = @messageService.all()

