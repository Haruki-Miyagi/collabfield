$(document).on('turbolinks:load', function() {
  chat_windows_count = $('.conversation-window').length;
  // 最新のチャットウィンドウが未設定で、チャットウィンドウが既に存在する場合
  // last_visible_chat_window変数を設定
  if (gon.last_visible_chat_window == null && chat_windows_count > 0) {
      gon.last_visible_chat_window = chat_windows_count;
  }
  // igon.hidden_chatsがない場合は値を設定
  if (gon.hidden_chats == null) {
      gon.hidden_chats = 0;
  }
  window.addEventListener('resize', hideShowChatWindow);

  positionChatWindows();
  hideShowChatWindow();
});

function positionChatWindows() {
  chat_windows_count = $('.conversation-window').length;
  // 新しいチャットウィンドウが追加された場合、
  // 表示可能な最新のチャットウィンドウとして設定し、
  // viewportの幅に応じて
  // hideShowChatWindow関数で表示をオンオフできるようにする
  if (gon.hidden_chats + gon.last_visible_chat_window !== chat_windows_count) {
      if (gon.hidden_chats == 0) {
          gon.last_visible_chat_window = chat_windows_count;
      }
  }

  // 新しいチャットウィンドウが追加されたときにリストの一番左に配置する
  for (i = 0; i < chat_windows_count; i++ ) {
      var right_position = i * 410;
      var chat_window = i + 1;
      $('.conversation-window:nth-of-type(' + chat_window + ')')
          .css('right', '' + right_position + 'px');
  }
}

// viewportの右側に接近したら常に最新のチャットウィンドウを隠す
function hideShowChatWindow() {
  // チャットウィンドウが1つもない場合は関数を終了
  if ($('.conversation-window').length < 1) {
      return;
  }
  // 最も左にあるチャットウィンドウのオフセットを取得
  var offset = $('.conversation-window:nth-of-type(' + gon.last_visible_chat_window + ')').offset();
  // チャットウィンドウの左のオフセットが50より小さい場合、
  // そのチャットウィンドウを隠す
  if (offset.left < 50 && gon.last_visible_chat_window !== 1) {
      $('.conversation-window:nth-of-type(' + gon.last_visible_chat_window + ')')
          .css('display', 'none');
      gon.hidden_chats++;
      gon.last_visible_chat_window--;
  }
  // 一番左のチャットウィンドウのオフセットが550より大きく、
  // かつ非表示のチャットがある場合は、非表示チャットを表示する
  if (offset.left > 550 && gon.hidden_chats !== 0) {
      gon.hidden_chats--;
      gon.last_visible_chat_window++;
      $('.conversation-window:nth-of-type(' + gon.last_visible_chat_window + ')')
          .css('display', 'initial');
  }
}
