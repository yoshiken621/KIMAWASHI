// フルカレンダーの機能の読み込み
import { Calendar } from '@fullcalendar/core';
import dayGridPlugin from '@fullcalendar/daygrid';
import interactionPlugin from '@fullcalendar/interaction';

// カレンダー要素を呼び出す処理
document.addEventListener('turbolinks:load', function() {
  var calendarEl = document.getElementById('calendar');

  const calendar = new Calendar(calendarEl, {
    plugins: [ dayGridPlugin, interactionPlugin],
    // 日本語化
    locale: 'ja',
    // 日本時間への変更
    timeZone: 'Asia/Tokyo',
    firstDay: 1,
    // 左上のボタンへのリンクの付与
    customButtons: {
      myCustomButton: {
        text: 'みんなの投稿',
        click: function(){
          location.href = "/index";
        }
      }
    },
    // カレンダー上部の表示内容
    headerToolbar: {
      start: 'myCustomButton',
      center: 'title',
      end: 'today prev,next' 
    },
    buttonText: {
      today: '今日',
      month: '月',
    },
    // イベント情報のデータベースからの取得
    events: '/events.json',
    

    expandRows: true,
    height: "auto",
    dayCellContent: function(e) {
      e.dayNumberText = e.dayNumberText.replace('日', '');
    },
    // カレンダーの日付部分をクリックしたときにその日付情報を取得して投稿ページに送る処理
    dateClick: function(e){ 
      location.href = `/events/new?date=${e.dateStr}` ;
    },
    // イベントをクリックしたときにイベントの詳細情報ページへの遷移
    eventClick: function(e){
      location.href = `/events/${e.event.id}`
    },

    // イベントの表示
    eventContent: function(e) {
      // イベントのタイトルの表示
      let arrayOfDomNodes = []
      let titleEvent = document.createElement('div')
      if(e.event._def.title) {
        titleEvent.innerHTML = e.event._def.title
        titleEvent.classList = "fc-event-title fc-sticky"
      }

      // イベントの画像を表示
      let imgEventWrap = document.createElement('div')
      if(e.event.extendedProps.image_url) {
        let imgEvent = '<img src="'+e.event.extendedProps.image_url+'" >'
        imgEventWrap.classList = "fc-event-img"
        imgEventWrap.innerHTML = imgEvent;
      }

      arrayOfDomNodes = [ titleEvent,imgEventWrap ]

      return { domNodes: arrayOfDomNodes }
    },
    // マウスをイベント上に置いた時にイベントの詳細を表示する処理
    eventDidMount: function(info) {
      tippy(info.el, {
         content: info.event.extendedProps.description,
      });
    },
  });


  
  calendar.render();
});