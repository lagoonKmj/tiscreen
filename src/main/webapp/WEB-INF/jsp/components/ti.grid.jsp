<%@ page contentType="text/html; charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<div class="grid-stack-item-content-container" id="${tiContainerId}"></div>

<script type="text/javascript">
  var initialize = function() {
    var tiComponentId = "#" + "${tiComponentId}";
    var tiContainerId = "#" + "${tiContainerId}";
    tiComponentItems[tiComponentId] = $(tiContainerId).tiComponent({
      tiComponentId : tiComponentId,
      tiContainerId : tiContainerId,
      title : "${title}",
      minWidth : 2, 
      minHeight : 2, 
      maxWidth : 8, 
      maxHeight : 8
    });
    tiComponentItems[tiComponentId].initialize();
  };
  
  var ready = function($tiComponent) {
    $tiComponent.setNodata();
  };
  
  var onResizestop = function($tiComponent) {
    //TODO
  };
  
  var refresh = function($tiComponent) {
    //TODO
  };
  
  initialize();
</script>