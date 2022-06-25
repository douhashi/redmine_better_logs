module RedmineBetterLogs
  class RedmineLogFormatter < Logger::Formatter
    def call(severity, _time, _progname, msg)
      log = {
        time: _time.iso8601(6),
        level: severity,
        progname: _progname,
        type: "default",
      }

      # タグが付いてる場合
      unless current_tags.empty?
        # タグのkey=valueのmapを作ってマージ 
        tagged = Rails.application.config.log_tags.zip(current_tags).to_h
        log.merge!(tagged)
        # msgの先頭に入ってるタグを削除
        msg = msg&.split(' ', current_tags.size + 1)&.last
      end
      begin
        # msgがJSON形式の場合は JSON in JSON をフラットにしてマージする
        parsed = JSON.parse(msg).symbolize_keys
        log.merge!(parsed)
      rescue JSON::ParserError
        # JSON形式ではない場合は、meessageというkeyに保存
        log.merge!({message: msg})
      end
      log.to_json + "\n"
    end
  end
end
