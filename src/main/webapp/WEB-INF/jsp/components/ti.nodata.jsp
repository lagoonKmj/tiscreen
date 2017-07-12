<%@ page contentType="text/html; charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<div class="grid-stack-item-content-container" id="${tiContainerId}"></div>

<script type="text/javascript">


$(function () {
 
  var initialize = function() {
    var tiComponentId = "#" + "${tiComponentId}";
    var tiContainerId = "#" + "${tiContainerId}";
    var componentId = "${id}";
    var options = {
        tiComponentId : tiComponentId,
        tiContainerId : tiContainerId,
        componentId : componentId,
        url : "/tiscreen/getNodata.json"
    };
    var functions = {
        afterContentInit : function($tiComponent) {
        }
    };
    tiComponentItems[tiComponentId] = $(tiContainerId).tiComponent(options, functions);
    tiComponentItems[tiComponentId].initialize();
  };
  
  initialize();
  
});

</script>