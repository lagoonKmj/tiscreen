<%@ page contentType="text/html; charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<div class="wrap" id="${tiContainerId}" style="width: 100%; height: 100%;"></div>

<script type="text/javascript">
  
  var initialize = function() {
    var tiComponentId = "${tiComponentId}";
    var tiContainerId = "${tiContainerId}";
    tiComponentItems[tiComponentId] = $("#" + tiContainerId).tiComponent({
      id : tiComponentId,
      title : "Test Component...by.lagoon"
    });
    tiComponentItems[tiComponentId].initPage();
  };
  initialize();
  
  var test = function($curThis) {
    console.log(tiComponentItems[$curThis].getId());
  }

</script>