angular.module "angular-tabs", []

angular.module("angular-tabs").service "angularTabs", [() ->
  angularTabInstances = {}
  {
    getActiveTab: (id) ->
      angularTabInstances[id]
    setActiveTab: (id, title) ->
      angularTabInstances[id] = title
  }
]

angular.module("angular-tabs").directive "angularTabs", ["angularTabs", (angularTabs) ->
  {
    restrict: "E"
    scope: true
    compile: (element, attributes, transclude) ->

      tabs = angular.element("<ul></ul>")
      tabs.addClass("nav")
      tabs.addClass("nav-tabs")

      divs =  element.children("div")
      for i in [0..divs.length - 1]
        div = angular.element(divs[i])
        title = div.attr("title")
        if not title
          title = i

        div.attr("ng-show", "tabIsActive('#{title}')")

        li = angular.element("<li></li>")
        li.attr("ng-class", "{active: tabIsActive('#{title}')}")

        a = angular.element("<a>#{title}</a>")
        a.attr("href", "")

        a.attr("ng-click", "setActiveTab('#{title}')")

        li.append a

        tabs.append li

      element.prepend tabs

      {
        post: ($scope, $element, $attributes) ->

          id = $attributes.id
          activeTab = $attributes.activeTab

          $scope.setActiveTab = (title) ->
            $scope.activeTab = title
            angularTabs.setActiveTab id, title

          $scope.tabIsActive = (title) ->
            return ($scope.activeTab == title)

          $scope.setActiveTab(activeTab)

      }

  }
]