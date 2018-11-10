App.private_conversation = App.cable.subscriptions.create("Private::ConversationChannel", {
  connected: function() {},
  disconnected: function() {},
  received: function(data) {
    // 会話メニューリスト内の会話へのリンクが存在する場合
    // リンクを会話メニューリストの上部に移動する
    var conversation_menu_link = $('#conversations-menu ul')
                                     .find('#menu-pc' + data['conversation_id']);
    if (conversation_menu_link.length) {
        conversation_menu_link.prependTo('#conversations-menu ul');
    }
    
    // 変数の設定
    var conversation = findConv(data['conversation_id'], 'p');
    var conversation_rendered = ConvRendered(data['conversation_id'], 'p');
    var messages_visible = ConvMessagesVisiblity(conversation);

    if (data['recipient'] == true) {
        // 新しいメッセージを受信した後、会話を目に見えないものとしてマークする
        $('#menu-pc' + data['conversation_id']).addClass('unseen-conv');
        // 会話ウィンドウが存在する場合
        if (conversation_rendered) {
            if (!messages_visible) {
            // 見えないメッセージがあるCONVウィンドウの変更スタイル
            // 会話のウィンドウなどにクラスを追加する
            }
            conversation.find('.messages-list').find('ul').append(data['message']);
        }
        calculateUnseenConversations();
    }
    else {
        conversation.find('ul').append(data['message']);
    }

    if (conversation.length) {
        // 新しいメッセージが追加された後、会話ウィンドウの一番下までスクロールします
        var messages_list = conversation.find('.messages-list');
        var height = messages_list[0].scrollHeight;
        messages_list.scrollTop(height);
    }
  },

  send_message: function(message) {
    return this.perform('send_message', {
        message: message
    });
  }
});

$(document).on('submit', '.send-private-message', function(e) {
  e.preventDefault();
  var values = $(this).serializeArray();
  App.private_conversation.send_message(values);
  $(this).trigger('reset');
});
