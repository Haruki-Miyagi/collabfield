$(document).on('turbolinks:load', function() {

  // when conversation heading is clicked, toggle conversation
  $('body').on('click',
             '.conversation-heading, .conversation-heading-full',
             function(e) {
      e.preventDefault();
      var panel = $(this).parent();
      var panel_body = panel.find('.panel-body');
      var messages_list = panel.find('.messages-list');

      panel_body.toggle(100, function() {
        var messages_visible = $('ul', this).has('li').length;
    
        // Load first 10 messages if messages list is empty
        if (!messages_visible && $('.load-more-messages', this).length) {
            $('.load-more-messages', this)[0].click(); 
        }
      }); 
  });

  // 会話を開くリンクがクリックされたとき
  // ページに既に会話ウィンドウが存在する
  // but 折りたたまれ、展開されます
  $('#conversations-menu').on('click', 'li', function(e) {
    // 会話ウィンドウのIDを取得する
    var conv_id = $(this).attr('data-id');
    // 会話のタイプを取得する
    if ($(this).attr('data-type') == 'private') {
        var conv_type = '#pc';
    } else {
        var conv_type = '#gc';
    }
    var conversation_window = $(conv_type + conv_id);
      // if 会話ウィンドウが存在する場合
    if (conversation_window.length) {
        // if ウィンドウが折りたたまれている場合は展開します
        if (conversation_window.find('.panel-body').css('display') == 'none') {
            conversation_window.find('.conversation-heading').click();
        }
        // それをクリックしてフォーカステキストエリアに表示されるようにマークする
        conversation_window.find('form textarea').click().focus();
    }
  });
});
