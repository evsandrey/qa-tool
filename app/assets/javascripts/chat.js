// http://www.bypeople.com/minimal-css-chat-ui/

$(document).on('turbolinks:load', function() {
  console.log("Chat.js exec")
  $('.messages-content').mCustomScrollbar();
  initChat();
  registerEvents();
});

function initChat() {
  $.ajax({
      method: "GET",
      url: "/init_chat",
    }).done(function(data) {
      unread_count = data.unread_count;
      $.each(data.messages.reverse(),
      function( index, value ) {
        insertMessage(value);
      });
      updateUnreadCounter();
      updateScrollbar();
    })
    .fail(function() {
      $(".chat-btn").addClass("hidden");
      console.log( "error in chat init" );
    })
    .always(function() {
      
    });
}




function toggleChat() {
  $(".chat").toggleClass("invisible");
  SwitchCookie("chat")
  $.cookie("lastRead",new Date());
  $(".chat-btn").removeClass("blinking");
  unread_count =0;
  updateUnreadCounter();
}

function updateUnreadCounter() {
  if (unread_count==0){
    $(".chat-btn").html('<i class="fa fa-comments"></i>');
  } else {
    $(".chat-btn").html(unread_count);
  }
}


function insertNewMessage(msg) {
  $(msg).appendTo($('.mCSB_container')).addClass('new');
  if ($.cookie("chat") == "false") {
    unread_count +=1;
    $(".chat-btn").addClass("blinking");
    updateUnreadCounter();
  }
  updateScrollbar();
}

function insertMessage(msg) {
  $(msg).appendTo($('.mCSB_container')).addClass('new');
}

function updateScrollbar() {
  $('.messages-content').mCustomScrollbar("update").mCustomScrollbar('scrollTo', 'bottom', {
    scrollInertia: 10,
    timeout: 0
  });
}

function registerEvents() {
  $('.message-input').keydown(function(event) {
    if (event.keyCode == 13)
      {
          if (event.shiftKey === true)
          {
             console.log("shift");
          }
          else
          {
            $("#new_global_message").trigger('submit.rails');
            $("#global_message_body").val("");
          }
          return false;
      }
});  
}



