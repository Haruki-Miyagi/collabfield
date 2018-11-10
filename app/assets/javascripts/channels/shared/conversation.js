// DOM内の会話を見つけます
function findConv(conversation_id, type) {
  // 現在の会話がメッセンジャーで開かれている場合
  var messenger_conversation = $('body .conversation');
  if (messenger_conversation.length) {
      // メッセンジャーで会話が開かれている
      return messenger_conversation;
  } else { 
      // 会話はポップアップウィンドウで開きます
      var data_attr = "[data-" + type + "conversation-id='" + 
                       conversation_id + 
                       "']";
      var conversation = $('body').find(data_attr);
      return conversation;
  }
}

// ブラウザ上で会話ウィンドウが表示されているかどうかを調べる
function ConvRendered(conversation_id, type) {
  // 現在の会話がメッセンジャーで開かれている場合
  if ($('body .conversation').length) {
      // メッセンジャーで会話が開かれている
      // 自動的にそれが可視であることを意味します
      return true;
  } else { 
      // 会話はポップアップウィンドウで開きます
      var data_attr = "[data-" + type + "conversation-id='" + 
                       conversation_id + 
                       "']";
      var conversation = $('body').find(data_attr);
      return conversation.is(':visible');
  }
}

function ConvMessagesVisiblity(conversation) {
  // 現在の会話がメッセンジャーで開かれている場合
  if ($('body .conversation').length) {
      // メッセンジャーで会話が開かれている
      // 自動的にメッセージが表示されることを意味します
      return true;
  } else {
      // 会話はポップアップウィンドウで開きます
      // ウィンドウが折りたたまれているか、展開されているかを確認する
      var visibility = conversation
                           .find('.panel-body')
                           .is(':visible');
      return visibility;
  }
}
