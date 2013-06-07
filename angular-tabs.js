// author: Samuel Mueller 
// homepage: http://github.com/ssmm/angular-tabs 
(function() {
  angular.module("angular-tabs", []);

  angular.module("angular-tabs").service("angularTabs", [
    function() {
      var angularTabInstances;

      angularTabInstances = {};
      return {
        getActiveTab: function(id) {
          return angularTabInstances[id];
        },
        setActiveTab: function(id, title) {
          return angularTabInstances[id] = title;
        }
      };
    }
  ]);

  angular.module("angular-tabs").directive("angularTabs", [
    "angularTabs", function(angularTabs) {
      return {
        restrict: "E",
        scope: true,
        compile: function(element, attributes, transclude) {
          var a, div, divs, i, li, tabs, title, _i, _ref;

          tabs = angular.element("<ul></ul>");
          tabs.addClass("nav");
          tabs.addClass("nav-tabs");
          divs = element.children("div");
          for (i = _i = 0, _ref = divs.length - 1; 0 <= _ref ? _i <= _ref : _i >= _ref; i = 0 <= _ref ? ++_i : --_i) {
            div = angular.element(divs[i]);
            title = div.attr("title");
            if (!title) {
              title = i;
            }
            div.attr("ng-show", "tabIsActive('" + title + "')");
            li = angular.element("<li></li>");
            li.attr("ng-class", "{active: tabIsActive('" + title + "')}");
            a = angular.element("<a>" + title + "</a>");
            a.attr("href", "");
            a.attr("ng-click", "setActiveTab('" + title + "')");
            li.append(a);
            tabs.append(li);
          }
          element.prepend(tabs);
          return {
            post: function($scope, $element, $attributes) {
              var activeTab, id;

              id = $attributes.id;
              activeTab = $attributes.activeTab;
              $scope.setActiveTab = function(title) {
                $scope.activeTab = title;
                return angularTabs.setActiveTab(id, title);
              };
              $scope.tabIsActive = function(title) {
                return $scope.activeTab === title;
              };
              return $scope.setActiveTab(activeTab);
            }
          };
        }
      };
    }
  ]);

}).call(this);
