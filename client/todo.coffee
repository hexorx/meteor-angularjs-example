app.controller 'TodoCtrl', ['$scope', '$location', '$routeParams', '$meteor', 'filterFilter', ($scope, $location, $routeParams, $meteor, filterFilter) ->
  statusFilters =
    active: {completed: false}
    completed: {completed: true}

  $scope.statusFilter = statusFilters[$routeParams.filter]

  todos = $scope.todos = $meteor('todos').find({})

  $scope.newTodo = ''
  $scope.location = $location

  $scope.$watch 'todos', (newValue, oldValue) ->
    $scope.remainingCount = filterFilter(todos, { completed: false }).length
    $scope.completedCount = todos.length - $scope.remainingCount
    $scope.allChecked = !$scope.remainingCount

    changed = _.filter newValue, (todo, index) ->
      not _.isEqual(todo, oldValue[index])

    _.each changed, (todo) ->
      $meteor('todos').update(todo._id, todo)

  , true

  $scope.addTodo = ->
    newTodo = $scope.newTodo.trim()
    return if !newTodo.length

    $meteor('todos').insert
      title: newTodo
      completed: false

    $scope.newTodo = ''

  $scope.removeTodo = (todo) ->
    $meteor('todos').remove(todo._id)

  $scope.clearCompletedTodos = () ->
    completed = filterFilter todos, { completed: true }
    _.each completed, (todo) -> $scope.removeTodo(todo)

  $scope.markAll = (completed) ->
    _.each todos, (todo) -> todo.completed = completed

]
