angular.module "angular-tabs", []

angular.module("angular-tabs").service "angularTabs", [() ->
  activeTabs = {}
  {
    getActiveTab: (id) ->
      activeTabs[id]
    setActiveTab: (id, title) ->
      activeTabs[id] = title

  }
]

angular.module("angular-tabs").directive "angularTabs", ["$compile", "angularTabs", ($compile, angularTabs) ->

  compileTabsBody = (divs) ->
    titles = []

    for div in divs
      div = angular.element(div)
      title = div.attr("tab-title")
      titles.push title
      div.attr("ng-show", "isActive('#{title}')")

    titles

  createControl = (classes, titles) ->
    tabs = angular.element("<ul></ul>")

    if not classes
      tabs.addClass("nav")
      tabs.addClass("nav-tabs")
    else
      tabs.addClass classes

    for title in titles
      tabs.append createTab(title)

    tabs

  createTab = (title) ->
    li = angular.element("<li></li>")
    li.attr("ng-class", "{active: isActive('#{title}')}")

    li.append a = angular.element("<a>#{title}</a>")
    a.attr("href", "")
    a.attr("ng-click", "setActive('#{title}')")

    li

  {
    restrict: "E"
    scope: true
    compile: (element, attributes, transclude) ->

      id = attributes.id
      divs =  element.children("div")
      titles = compileTabsBody(divs)
      tabControls = angular.element("angular-tabs-control[for=#{id}]")

      if tabControls.length <= 0
        control = createControl attributes.class, titles
        element.prepend control

      {
        post: ($scope, $element, $attributes) ->

          # Create additional tab controls if required.
          # The resulting element needs to be compiled.
          # It is not compiled by the compile function because the control
          # is not a child of element but located somewhere else in the DOM.
          # We can't call the compile service in the compile function,
          # because we don't have a scope there.
          if tabControls.length > 0
            for tabControl in tabControls
              tabControl = angular.element(tabControl)
              control = createControl tabControl.attr("class"), titles
              $compile(control)($scope)
              tabControl.append control

          $scope.setActive = (title) ->
            angularTabs.setActiveTab id, title

          $scope.isActive = (title) ->
            return (angularTabs.getActiveTab(id) == title)

          $scope.setActive($attributes.activeTab)

          return
      }

  }
]