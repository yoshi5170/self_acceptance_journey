# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)



#ユーザーを取得（もしこのようなユーザーが存在しない場合、適切にユーザーを選択または作成してください）
user = User.find_by(email: "sample@example.com")

# ユーザーが存在するかを確認
if user
  # Flowerをthresholdの昇順で取得
  flowers = Flower.order(threshold: :asc)

  15.times do |i|
    flower_to_add = nil  # ここで繰り返しのたびにflower_to_addをリセット

    # トレーニングのための仮データを追加（必要であれば）
    user.self_esteem_trainings.create(trained_at: Time.current - i.days)

    total_trainings = i + 1
    flowers.each do |flower|
      if total_trainings <= flower.threshold
        flower_to_add = flower
        break
      end
    end

    if flower_to_add
      user.planted_flowers.create(flower: flower_to_add, added_at: Time.current + i.hours)
    end
  end
else
  puts "指定されたユーザーが存在しないため、データを作成できませんでした。"
end




# user = User.find_by(nickname: "yoshi_5170")

# # ユーザーが存在するかを確認
# if user
#   # userに関連付けられたplanted_flowersのレコードを全て削除
#   user.planted_flowers.destroy_all
#   puts "指定されたユーザーのplanted_flowersデータを全て削除しました。"
# else
#   puts "指定されたユーザーが存在しないため、データを削除できませんでした。"
# end


質問文の作成
Question.create!([
  {
    text: "全体的に、私は自分自身に満足している。",
    score_type: 0
  },
  {
    text: "時々、自分は全くダメだと感じる。",
    score_type: 1
  },
  {
    text: "自分には良いところがいくつかあると思う。",
    score_type: 0
  },
  {
    text: "私は他の多くの人たちと同じくらいうまく物事をこなせると思う。",
    score_type: 0
  },
  {
    text: "私は自分を誇るべき点があまりないと感じる。",
    score_type: 1
  },
  {
    text: "時々、自分は役に立たないと感じることがある",
    score_type: 1
  },
  {
    text: "他の人と同じくらい、自分にも価値があると感じている。",
    score_type: 0
  },
  {
    text: "私はもっと自分自身を尊重できるようになりたいと思っている。",
    score_type: 1
  },
  {
    text: "全体的に見て、私は自分が出来損ないだと感じる傾向がある。",
    score_type: 1
  },
  {
    text: "自分に対して前向きな考えを持っている。",
    score_type: 0
  }
])

puts "Questions data created successfully!"

# monthly_theme = MonthlyTheme.create!(
#   month: 11,
#   title: "セルフケアの重要性",
#   message: "心と体を大切に。この月は自分自身のケアにフォーカスしましょう。"
# )

# monthly_theme.theme_resources.create!([
#   {
#     content: "瞑想",
#     url: "https://www.youtube.com/watch?v=PZDqMqKyhNo"
#   },
#   {
#     content: "リラクゼーションテクニック",
#     url: "https://voi.id/ja/lifestyle/313654"
#   },
# ])
# puts "Sample data created successfully!"



Result.create!([
  {
    title: "非常に自己否定的な傾向がある",
    description: "あなたは自分自身の価値や能力を否定的に捉えているようです。過去の失敗や他人の評価に強く影響されやすいかもしれません。このような自己否定的な姿勢は、自分の可能性や成果を制限する原因となることがあります。自己受容の道を進む一歩として自己否定を克服していきましょう。",
    score_range_start: 0,
    score_range_end: 7
  },
  {
    title: "自己否定的な傾向がある",
    description: "時には自分を否定的に見ることもある一方で、自分の良いところもある程度認めることができているようです。完璧を求めすぎず、自分の全体を受け入れる柔軟な姿勢が大切です。",
    score_range_start: 8,
    score_range_end: 15
  },
  {
    title: "やや自己否定的な傾向がある",
    description: "あなたは自己の価値や能力を一定程度受け入れられていて自己受容のバランスが取れているようです。しかし一部の状況や出来事で自己否定的な感情になることもあるかもしれません。",
    score_range_start: 16,
    score_range_end: 23
  },
  {
    title: "自己受容ができている",
    description: "あなたは自分自身のプラス面もマイナス面も受け入れることができています。他人の評価や一時的な失敗に動じることが少なく、自分の中の真実を大切にして生きているようです。この力を活かしてさらに自己受容を深めていきましょう。",
    score_range_start: 24,
    score_range_end: 30
  }
])

result1 = Result.find_by(title: "非常に自己否定的な傾向がある")
result1.recommendations.create!([
  {
    title: "自己受容トレーニング",
    description: "この機能は、入力された自己否定的な思考や感情を自己受容できるように変換してくれます。この機能を使用してガーデンページに花を増やしていき自己受容の習慣を身につけていきましょう。"
  },
  {
    title: "幸せ日記",
    description: "日々の良かった、うれしかった、幸せだと感じたことを記録して、その日を振り返ることで、より物事に対して積極的かつ前向きになることができます。"
  }
])

result2 = Result.find_by(title: "自己否定的な傾向がある")
result2.recommendations.create!([
  {
    title: "自己受容トレーニング",
    description: "この機能は、入力された自己否定的な思考や感情を自己受容できるように変換してくれます。この機能を使用してガーデンページに花を増やしていき自己受容の習慣を身につけていきましょう。"
  },
  {
    title: "幸せ日記",
    description: "日々の良かった、うれしかった、幸せだと感じたことを記録して、その日を振り返ることで、より物事に対して積極的かつ前向きになることができます。"
  }
])


result3 = Result.find_by(title: "やや自己否定的な傾向がある")
result3.recommendations.create!([
  {
    title: "幸せ日記",
    description: "日々の良かった、うれしかった、幸せだと感じたことを記録して、その日を振り返ることで、より物事に対して積極的かつ前向きになることができます。"
  },
  {
    title: "月刊セルフケア",
    description: "毎月のテーマに基づいてのメッセージやアドバイスを受け取り、自己受容のヒントやサポートを得られます。"
  }
])


result4 = Result.find_by(title: "自己受容ができている")
result4.recommendations.create!(title: "月刊セルフケア", description: "毎月のテーマに基づいてのメッセージやアドバイスを受け取り、自己受容のヒントやサポートを得られます。")

puts "Result data created successfully!"

# 昨日の日付の日記と日記エントリを作成
# user = User.find_by(email: 'sample@example.com')

# yesterday_diary = Diary.create!(date: Date.yesterday, user_id: user.id)

# DiaryEntry.create!([
#   { content: '美味しいコーヒーを飲めた', diary_id: yesterday_diary.id },
#   { content: '仕事で大きな進捗があった', diary_id: yesterday_diary.id },
#   { content: '友人から嬉しいメッセージをもらった', diary_id: yesterday_diary.id }
# ])

# # 明日の日付の日記と日記エントリを作成（未来の日記ということで仮想の内容を登録）
# tomorrow_diary = Diary.create!(date: Date.tomorrow, user_id: user.id)

# DiaryEntry.create!([
#   { content: '予定していたプロジェクトを前倒しで完了できそう', diary_id: tomorrow_diary.id },
#   { content: '散歩中に綺麗な花を見つけた', diary_id: tomorrow_diary.id },
#   { content: '新しいレシピで料理を試みて大成功', diary_id: tomorrow_diary.id }
# ])
