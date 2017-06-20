<%@ page contentType="text/html; charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<div class="wrap" id="${divId}" style="width: 100%; height: 100%;"></div>

<script type="text/javascript">
  
  var initialize = function() {
    var id = "${divId}";
    componentItems[id] = $("#" + id).tiComponent({
      id : id,
      title : "Test Component...by.lagoon"
    });
    componentItems[id].initPage();
  };
  initialize();
  
  var test = function($curThis) {
    console.log(componentItems[$curThis].getId());
  }

</script>