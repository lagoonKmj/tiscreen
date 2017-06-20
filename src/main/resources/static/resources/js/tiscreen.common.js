$.extend({
  getUrlVars: function() {
    var vars = [], hash;
    var hashes = window.location.href.slice(window.location.href.indexOf('?') + 1).split('&');
    for (var i = 0; i < hashes.length; i++) {
        hash = hashes[i].split('=');
        vars.push(hash[0]);
        vars[hash[0]] = hash[1];
    }
    return vars;
  },
  getUrlVar: function(name) {
      return $.getUrlVars()[name];
  }

});

/*
* number type의 unix timestamp 값을 받아서 문자열로 반환한다.
* 파라미터로 넘기는 날짜형식을 원하는대로 구성할 수 있다.
* ex)
* var formatted = 86400000.format("yy-mm-dd HH:mi:ss");
* console.log(formatted);
*/
Number.prototype.format = function(f) {
  var d = new Date(this);

  String.prototype.string = function(len) {
    var s = '', i = 0;
    while (i++ < len) {
      s += this;
    }
    return s;
  }; //end: String.prototype.string = function(len){
  String.prototype.zf = function(len) {
    return "0".string(len - this.length) + this;
  }; //end: String.prototype.zf = function(len){
  Number.prototype.zf = function(len) {
    return this.toString().zf(len);
  }; //end: Number.prototype.zf = function(len){

  if (!this.valueOf()) {
    return " "
  };

  var weeks= ["일요일", "월요일", "화요일", "수요일", "목요일", "금요일", "토요일"];
  var months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"];

  return f.replace(/(yyyy|yy|mm|Me|dd|E|hh|mi|ss|a\/p)/gi, function(pattern) {
    switch (pattern) {
      case "yyyy":
        return d.getFullYear();
      case "yy":
        return (d.getFullYear() % 1000).zf(2);
      case "mm":
        return (d.getMonth() + 1).zf(2);
      case "Me":
        return months[d.getMonth()];
      case "dd":
        return d.getDate().zf(2);
      case "E":
        return weeks[d.getDay()];
      case "HH":
        return d.getHours().zf(2);
      case "hh":
        return ((h = d.getHours() % 12) ? h : 12).zf(2);
      case "mi":
        return d.getMinutes().zf(2);
      case "ss":
        return d.getSeconds().zf(2);
      case "a/p":
        return d.getHours() < 12 ? "오전" : "오후";
      default:
        return pattern;
    } //end: switch(pattern){
  }); //end: return f.replace(/(yyyy|yy|mm|Me|dd|E|hh|mi|ss|a\/p)/gi, function(pattern){
}; //end: Date.prototype.format = function(f){

/*
* AS-IS: 동일
* setTimeout과 유사한 기능으로 지정한 milliseconds 이후에 구현부를 실행한다.
* ex)
* delay(function(){
*   console.log("delay...");
* }, 1000);
*/
var delay = (function() {
  var timer = 0;
  return function(callback, ms) {
    clearTimeout (timer);
    timer = setTimeout(callback, ms);
  };
})(); //end: var delay = (function() {


/**
 * 공통 자바스크립트 함수
 */
var comm = {
  /**
   * 어떤 자료형이던 Boolean 값으로 변환해서 return해 준다.
   * 
   * String: null, 공백, 0, false, n, no 를 제외한 모든 String 은 true 반환 Number: NaN,
   * 0 을 제외한 모든 Number는 true 반환
   */
  convertToBoolean : function(value) {
    if (null == value) {
      return false;
    }
    if (Object.prototype.toString.call(value) === "[object String]") {
      var strValue = value.toString().toLowerCase();
      switch (strValue) {
      case "1":
      case "true":
      case "y":
      case "yes":
      case "checked":
        return true;
  
      case "":
      case "0":
      case "false":
      case "n":
      case "no":
      case "unchecked":
      case "indeterminate":
      case "undefined":
      case "null":
        return false;
      }
    }
    return true;
  },
  convertToUnit : function(value, point, isByte) {
    var units = ["B", "KB", "MB", "GB", "TB", "PB"];
    if (value === 0) {
      return "0 B";
    }
    if (point === undefined) {
      point = 2;
    }
    if (isByte === undefined) {
      isByte = true;
    }
    var num = (isByte) ? 1024 : 1000;
    var i = parseInt(Math.floor(Math.log(value) / Math.log(num)));
    var result = (value / Math.pow(num, i)).toFixed(point);
    return result + " " + units[i];
  },
  isFunction : function(callback) {
    return (callback != undefined && typeof callback == "function");
  },
  setLocalStorage : function(key, value) {
    localStorage[key] = value;
  },
  setSessionStorage : function(key, value) {
    sessionStorage[key] = value;
  },
  getDataset : function(curThis, dataName) {
    if(curThis){
      if(curThis.dataSet == null){
        return curThis.getAttribute("data-" + dataName);
      }else{
        return curThis.dataSet[dataName];
      }
    }
  },
  replaceAll : function(str, searchStr, replaceStr) {
    return str.split(searchStr).join(replaceStr);
  },
  sumToValues : function(values) {
    var retNum = 0;
    if (values instanceof Array) {
      for (var iCnt = 0; iCnt < values.length; iCnt++) {
        if (!isNaN(values[iCnt])) {
          retNum = retNum + Number(values[iCnt]); 
        }
      }
    }
    return retNum; 
  },
  showLoading : function(delay) {
    $.mobile.loading("show");
    if (comm.convertToBoolean(delay)) {
      comm.hideLoading(delay);
    }
  }, 
  hideLoading : function(delay) {
    var _delay = 0;
    if (comm.convertToBoolean(delay)) {
      _delay = delay;
    }
    setTimeout(
        function(){
          $.mobile.loading("hide");
        }, _delay);
  }
}

/**
 * 데이터 렌더러
 */
var render = {
  get : function(value) {
    if (comm.convertToBoolean(value)) {
      return value;
    }
    return "-";
  },
  getFirmwareInfo : function(objData, messages){
    var firmware = objData["firmware"];
    var firmware_state = objData["firmware_state"];
    var str = "<span";
    if (firmware_state === undefined)
      str += ">-";
    if (firmware_state == "0") {
      str += "> " + messages["latestVersion"];
    } else if (firmware_state == "1") {
      str += " class='em'> " + messages["notKnowing"];
    } else if (firmware_state == "2") {
      str += " class='em'> " + messages["recentlyUpgrade"];
    } else {
      var num = firmware_state.substring(0, firmware_state.length-1);
      str += " class='em'>" + num;
      var clz = firmware_state.substring(firmware_state.length-1, firmware_state.length);
      if (clz == 'M') {
        str += " " + messages["monthLast"];
      } else if (clz == 'd') {
        str += " " + messages["dayLast"];
      } else if (clz == 'h') {
        str += " " + messages["hourLast"];
      } else if (clz == 'm') {
        str += " " + messages["minuteLast"];
      }  
    }
    //
    if(comm.convertToBoolean(firmware)){
      str += " (" + firmware + ")";
    }
    str += "</span>";
    return str;
  },
  getClientCount : function(data) {
    if (data.client_count == undefined) {
      return "-";
    }      
    return data.online_client_count + " / " + data.client_count;
  },
  getUsage : function(data) {
    if (data.device_usage == undefined
        ||((data.percent_usage == undefined) && (data.rxtx_usage == undefined))
        ||(data.rxtx_usage == 0)) {
      return "-";
    }
    return comm.convertToUnit((data.rxtx_usage), 2, true);
  },
  getTags : function(value){
    if (!comm.convertToBoolean(value)) {
      return "-";
    }
    if (value instanceof Array) {
      if(value.length < 1){
        return "-";
      }
    }
    
    var str = "";
    for(var i = 0; i < value.length; i++) {
      if (value[i].name !== "") {
        str += i === 0 ? value[i].name : ", " + value[i].name;
      }
    }
    return str;
  },
  getConnectivities : function(conn, widthSize) {
    var WIDTH = 180;
    if (widthSize) {
      WIDTH = widthSize;
    }
    var colors = {
      "0": "#ABABAB"
      , "1": "#5BA718"
    };
    var status = {
      "0": "Disconnected"
      , "1": "Connected"
    }

    var bars = "";
    if (conn === undefined) {
        bars = "<div class='tooltipster' title='no data.' style='float:left; color: white; width: " + WIDTH + "px; height: 12px; background-color: " + colors["0"] + ";'></div>";
    } else {
      var total= 0;
      for (var i = 0; i < conn.length; i++) {
        total += conn[i].duration;
      }
      var flag = true;
      
      for (var i = 0; i < conn.length; i++) {
        var width = conn[i].duration / total * WIDTH;
        if (!flag) {
          width = Math.floor(width);
        }
        var text = conn[i].time.format("yyyy-mm-dd HH:mi:ss") + " / " + status[conn[i].status];
        bars += "<div class='tooltipster' title='" + text + "' style='float:left; color: white; width: " + width + "px; height: 12px; background-color: " + colors[conn[i].status] + ";'></div>";
      }
    }
    
    var divBar = "<div style='width: " + WIDTH + "px; height: 12px; color: white; border: 1px solid gray;display:inline-block;'>" + bars + "</div>";
    return divBar;
  },
  getSwitchType : function(item) {
    return ti$common.getSwitchType(item);
  },
  getToByte : function(value) {
    return comm.convertToUnit(value, 2, true);
  },
  getToBps : function(value) {
    return comm.convertToUnit(value, 2, false);
  },
  getToDate : function(value, strFormat) {
    if (!comm.convertToBoolean(strFormat)) {
      strFormat = "yyyy-mm-dd HH:mi:ss";
    }
    return value.format(strFormat);
  },
  getConnectedPort : function(deviceName, portName) {
    if (!comm.convertToBoolean(portName)) {
      return deviceName + " / " + "-";
    }
    return deviceName + " / " + portName;
  },
  getReplaceTag__ltgt : function(value) {
    if (comm.convertToBoolean(value)) {
      value = comm.replaceAll(value, "<", "&lt;");
      value = comm.replaceAll(value, ">", "&gt;")
      return value;
    } 
    return "-";
  },
  getReplaceTag__br : function(value) {
    if (comm.convertToBoolean(value)) {
      value = value.replace(/\r\n|\r|\n/g, "<br/>");
      return value;
    }
    return "-";
  },
  getReplace : function(type, value) {
    //custom.js
    var c$replace = {
        "access_policy": {"undefined": "-", "0": "open", "1": "mac whitelist", "2": "sticky macwhitelist"}
        , "cable": {"undefined": "-", "1": "copper", "2": "fiber", "3": "stacking","4":"combo"}
        , "rstp": {"undefined": "-", "0": "disabled", "1": "enabled"}
        , "poe": { "0": "disabled", "1": "enabled"}
        , "secure": {"undefined": "-", "0": "disabled", "1": "enabled"}
        , "active": {"undefined": "-", "0": "disabled", "1": "enabled"}
        , "link": {"undefined": "-", "0": "", "1": "on"}
        , "uplink": {"undefined": "-", "0": "", "1": "uplink"}
        , "oper_status": {"undefined": "-", "0": "dormant", "1": "active", "2": "alert", "3": "unreachable", "4": "dormant"}
        , "auto_nego": {"undefined": "-", "1": "auto", "0": "forced"}
        , "speed": {"undefined": "-", "10": "10 Mbps", "100": "100 Mbps", "1000": "1 Gbps", "10000": "10 Gbps"}
        , "speed_copper": {"undefined": "-", "10": "10 Mbps", "100": "100 Mbps"}
        , "speed_fiber": {"undefined": "-", "1000": "1 Gbps"}
        , "duplex": {"undefined": "-", "1": "full", "0": "half"}
        , "flow_control": {"undefined": "-", "1": "off", "4": "rx", "3": "tx", "2": "both"}
        , "jumbo_frame": {"undefined": "-", "0": "disabled", "1": "enabled"}
        , "type": {"undefined": "-", "0": "Any", "1": "ARP", "2": "IPv4", "3": "IPv6"}
        , "protocol": {"undefined": "-", "256":"Any","1":"ICMP","6":"TCP","17":"UDP","22":"IDP","44":"IPv6(Fragments)","12":"PUP","46":"RSVP","47":"GRE","58":"IPv6(ICMP)","59":"IPv6(No Text)","29":"TP","132":"SCTP","2":"IGMP","255":"RAW","4":"IPv4","103":"PIM","8":"EGP","92":"MTP","108":"COMP","60":"DSTOPTS","50":"SP","51":"AH","41":"IPv6","43":"ROUTING","98":"ENCAP"}
        , "action": {"undefined": "-", "0": "block", "1": "permit"}
        , "ipType": {"undefined": "-", "0": "DHCP", "1": "Statically assigned"}
        , "ipMode": {"undefined": "-", "0": "DHCP", "1": "Statically assigned", "2": "AP priority"}
        , "rstpPortStatus": {"undefined": "-", "0": "Discarding", "1": "Listening", "2": "Learning", "3": "Forwarding", "4": "Blocking"}
        , "channel_group_active" : {"undefined": "-", "0": "disable", "1":"enable"}
        , "channel_group_type" : {"undefined": "-", "1":"static", "2":"LACP"}
        , "channel_group" : {"undefined": "-", "1":"1", "2":"2", "3":"3", "4":"4", "5":"5", "6":"6", "7":"7", "8":"8"}
        , "channel_group_lb" : {"undefined": "-", "1":"src-mac", "2":"dst-mac", "3":"src-dst-mac", "4":"src-ip", "5":"dst-ip", "6":"src-dst-ip"}
        , "topology_edge_line_color": {"undefined": "default", "1":"#edc240", "2":"#e37553", "3":"#fa0909"}
        , "spanningTreeMode" : {"undefined":"unknown", "stp":"STP", "rstp":"RSTP", "rpvst+":"RPVST+", "pvstp+":"PVSTP+", "mstp":"MSTP"}
      }; //end: var c$replace = {
    
    if (c$replace.hasOwnProperty(type)) {
      var objItem = c$replace[type];
      if (c$replace[type].hasOwnProperty(value)) {
        return c$replace[type][value];
      }
    }
    return "-";
  }
}

