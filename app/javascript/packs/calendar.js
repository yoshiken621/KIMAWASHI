import { Calendar } from '@fullcalendar/core';
import dayGridPlugin from '@fullcalendar/daygrid';
import interactionPlugin from '@fullcalendar/interaction';

document.addEventListener('turbolinks:load', function() {
  var calendarEl = document.getElementById('calendar');

  const calendar = new Calendar(calendarEl, {
    plugins: [ dayGridPlugin, interactionPlugin],
    locale: 'ja',
    timeZone: 'Asia/Tokyo',
    firstDay: 1,
    customButtons: {
      myCustomButton: {
        text: 'みんなの投稿',
        click: function(){
          location.href = "/index";
        }
      }
    },
    headerToolbar: {
      start: 'myCustomButton',
      center: 'title',
      end: 'today prev,next' 
    },
    buttonText: {
      today: '今日',
      month: '月',
    },

    events: '/events.json',
    

    expandRows: true,
    height: "auto",
    dayCellContent: function(e) {
      e.dayNumberText = e.dayNumberText.replace('日', '');
    },
    dateClick: function(e){ 
      location.href = `/events/new?date=${e.dateStr}` ;
    },
    eventClick: function(e){
      location.href = `/events/${e.event.id}`
    },

    eventContent: function(e) {
      let arrayOfDomNodes = []
      let titleEvent = document.createElement('div')
      if(e.event._def.title) {
        titleEvent.innerHTML = e.event._def.title
        titleEvent.classList = "fc-event-title fc-sticky"
      }

      let imgEventWrap = document.createElement('div')
      if(e.event.extendedProps.image_url) {
        let imgEvent = '<img src="'+e.event.extendedProps.image_url+'" >'
        imgEventWrap.classList = "fc-event-img"
        imgEventWrap.innerHTML = imgEvent;
      }

      arrayOfDomNodes = [ titleEvent,imgEventWrap ]

      return { domNodes: arrayOfDomNodes }
    },
    eventDidMount: function(info) {
      tippy(info.el, {
         content: info.event.extendedProps.description,
      });
    },
  });


  
  calendar.render();
});