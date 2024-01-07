Ransack.configure do |config|
  config.add_predicate 'lteq_end_of_day',  #設定するpredicateに名前をつける
                      arel_predicate: 'lteq',  #使いたいpredicate
                      formatter: proc { |v| v.end_of_day } # 受け取った値をどうフォーマットするか
end