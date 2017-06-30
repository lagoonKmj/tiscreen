/**
 * Ti-Screen 공통 자바스크립트 함수
 */
var tiCommon = {
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
  getLocalStorage : function(key) {
    return localStorage[key];
  },
  getSessionStorage : function(key) {
    return sessionStorage[key];
  },
  randomRange : function(n1, n2) {
    return Math.floor( (Math.random() * (n2 - n1 + 1)) + n1 );
  },
  deepCopy : function(value) {
    return $.extend({}, value);
  }
  
}
