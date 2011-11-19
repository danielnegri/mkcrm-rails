/**
 * @fileoverview Handles rendering Agenda data
 * Depends on base.js.
 * @author mking@mking.me (Matt King)
 */

/**
 * Agenda wrapper.
 * @return {Object} external API.
 */
var agenda = (function() {
  /**
   * Variable to hold the info balloon DOM element
   *     so it doesn't have to be created/destroyed
   *     on every display.
   */
  var infoBalloon;

  /**
   * Returns the top and left offset of a DOM node.
   * @param {Object} obj DOM node.
   * @return {Array.<number>} left and top values of obj.
   */
  var getPos = function(obj) {
    var curleft = 0, curtop = 0;
    do {
      curleft += obj.offsetLeft;
      curtop += obj.offsetTop;
    } while (obj = obj.offsetParent);
    return [curleft, curtop];
  };

  /**
   * Returns a flaoting point representation of time used to calculate quarter
   * hour increments.
   * Examples: computeTime('13:30') returns 13.5
   *           computeTime('08:45') returns 8.75
   * Allows incrementing widths by multiples of 4, while also allowing data to
   * be in a human-friendly format.
   * @param {String} str String with a 24-hour time value (e.g. 13:30).
   * @return {Float} Float representation of the provided time string.
   */
  var computeTime = function(str) {
    var val = 0.0;
    switch (true) {
      case /^([0-9]{1,2})\:00$/.test(str):
        val = RegExp.$1 + '.00';
        break;
      case /^([0-9]{1,2})\:15$/.test(str):
        val = RegExp.$1 + '.25';
        break;
      case /^([0-9]{1,2})\:30$/.test(str):
        val = RegExp.$1 + '.50';
        break;
      case /^([0-9]{1,2})\:45$/.test(str):
        val = RegExp.$1 + '.75';
        break;
    }
    return parseFloat(val);
  };

  /**
   * Convert a 24-hour time string to 12-hour and append am/pm.
   * @param {String} time 24-hour time.
   * @return {String} 12-hour time with am/pm.
   */
  var convertToAmPm = function(time) {
    var computedTime = computeTime(time);
    if (computedTime >= 12 && computedTime < 13) {
      return (Math.floor(computedTime) +
              time.match(/(:.*?)$/)[1]) + ' pm';
    } else if (computedTime > 12) {
      return (Math.floor(computedTime) - 12 +
              time.match(/(:.*?)$/)[1]) + ' pm';
    } else {
      return time + ' am';
    }
  };

  /**
   * Generates event handler to show info balloon on mouseover.
   * @param {Object} attachTo DOM node to 'attach' balloon to, used to
   *   determine placement of balloon on page.
   * @param {Object} schedule data object representing schedule data.
   * @return {Function} Handler to display mouseover info balloon.
   */
  var showBalloon = function(attachTo, schedule) {
    return function(e) {
      if (!infoBalloon) {
        infoBalloon = document.createElement('div');
        infoBalloon.setAttribute('id', 'info-balloon');
        io.listen('mouseover', infoBalloon, function() {
          this.style.display = 'block';
        });
        io.listen('mouseout', infoBalloon, function() {
          this.style.display = 'none';
        });
        document.body.appendChild(infoBalloon);
      }
      infoBalloon.style.display = 'block';
      var pos = getPos(attachTo);
      var posx = pos[0], posy = pos[1];
      infoBalloon.innerHTML = '<h4>' + schedule.title + '</h4>';
      infoBalloon.innerHTML += '<p>' + convertToAmPm(schedule.start) +
          ' - ' + convertToAmPm(schedule.end) +
          '</p><p>' + schedule.location + '</p>';
      var height = parseInt(infoBalloon.offsetHeight);
      infoBalloon.style.left = posx - 32 + 'px';
      infoBalloon.style.top = (posy - height) + 20 + 'px';
    };
  };

  /**
   * Given a data structure, generate the agenda list item HTML.
   * @param {Object} data schedule data object.
   * @param {Object} container DOM node to append list to.
   */
  var genListItem = function(data, container) {
    var t = document.createElement('div');
    t.className = 'agenda-header';

    /**
     * Generate the agenda hour headers
     */
    for (var i = 7; i < 24; i++) {
      var h = document.createElement('span');
      h.className = 'schedule-hour';
      h.innerHTML = (i > 12 ? i - 12 : i);
      t.appendChild(h);
    }
    container.appendChild(t);

    /**
     * Iterate over all agenda items and determine placement of the time bar.
     */
    for (var i = 0; i < data.schedule.length; i++) {
      var start = computeTime(data.schedule[i].start);
      var end = computeTime(data.schedule[i].end);
      var r = document.createElement('div');
      r.className = 'agenda-row';
      var label = document.createElement('label');
      label.innerHTML = data.schedule[i].title;
      r.appendChild(label);
      r.className += (i % 2 == 0 ? '' : ' alt');
      var item = document.createElement('div');
      item.innerHTML = '<span>&bull;</span>';
      item.className = 'agenda-item';
      item.style.left = ((start - 7) * 40) + (200) + 'px';
      item.style.paddingLeft = (end - start < 1 ? '4' : '7') + 'px';
      item.style.width = ((end - start) * 40 -
                          parseInt(item.style.paddingLeft)) + 'px';
      r.appendChild(item);
      container.appendChild(r);

      io.listen('mouseover', item,
                showBalloon(item.getElementsByTagName('span')[0],
                            data.schedule[i]));
      io.listen('mouseout', item, function(e) {
        if (infoBalloon) {
          infoBalloon.style.display = 'none';
        }
      });
    }

  };

  /**
   * Iterate through all agenda items and generate HTML.
   */
  var init = function() {
    var container = io.el('agenda-container');
    // Clear non-javascript fallback code
    container.innerHTML = '';
    for (var i = 0; i < agendaData.length; i++) {
      var headline = document.createElement('h2');
      headline.innerHTML = agendaData[i].date;
      container.appendChild(headline);
      genListItem(agendaData[i], container);
    }
  };

  /**
   * Public interface.
   */
  return {
    init: init
  };

}());
