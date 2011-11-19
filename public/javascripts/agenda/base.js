/*
 Base for helper functions and other globals.
 @author mking@mking.me (Matt King)
*/
var degraded=false;if(typeof String.prototype.trim!=="function")String.prototype.trim=function(){return this.replace(/^\s+|\s+$/g,"")};
var io=function(){var i=function(b){return function(){var a=window.event;a.target=a.srcElement;a.preventDefault=function(){a.returnValue=false};a.stopPropagation=function(){a.cancelBubble=true};b.call(a.srcElement,a)}},g=function(b,a,d){if(a.addEventListener)g=function(c,e,f){e.addEventListener(c,f,false)};else if(a.attachEvent)g=function(c,e,f){e["on"+c]=i(f)};g(b,a,d)},h=function(b,a,d){if(a.removeEventListener)h=function(c,e,f){e.removeEventListener(c,f,false)};else if(a.attachEvent)h=function(c,
e){e["on"+c]=null};h(b,a,d)};return{el:function(b){return document.getElementById(b)},listen:g,unlisten:h,map:function(b,a){for(var d=[],c=0,e=b.length;c<e;c++)d[c]=a.call(b,b[c]);return d},injectScript:function(b,a){var d=document.createElement("script");d.setAttribute("type","text/javascript");d.setAttribute("src",b);if(a)d.onload=a;document.getElementsByTagName("body")[0].appendChild(d)},injectScripts:function(b,a){for(var d=b.length,c=0,e=function(){c++;c==d&&a()},f=0;f<d;f++)io.injectScript(b[f],
e)}}}();
