# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)



# ユーザーを取得（もしこのようなユーザーが存在しない場合、適切にユーザーを選択または作成してください）
# user = User.find_by(nickname: "yoshi_5170")

# # ユーザーが存在するかを確認
# if user
#   # UnlockableFlowerをthresholdの昇順で取得
#   flowers = UnlockableFlower.order(threshold: :asc)

#   250.times do |i|
#     flower_to_add = nil  # ここで繰り返しのたびにflower_to_addをリセット

#     # トレーニングのための仮データを追加（必要であれば）
#     # user.self_negation_trainings.create(trained_at: Time.current - i.days)

#     total_trainings = i + 1
#     flowers.each do |flower|
#       if total_trainings <= flower.threshold
#         flower_to_add = flower
#         break
#       end
#     end

#     if flower_to_add
#       user.planted_flowers.create(unlockable_flower: flower_to_add, added_at: Time.current - i.hours)
#     end
#   end
# else
#   puts "指定されたユーザーが存在しないため、データを作成できませんでした。"
# end




# user = User.find_by(nickname: "yoshi_5170")

# # ユーザーが存在するかを確認
# if user
#   # userに関連付けられたplanted_flowersのレコードを全て削除
#   user.planted_flowers.destroy_all
#   puts "指定されたユーザーのplanted_flowersデータを全て削除しました。"
# else
#   puts "指定されたユーザーが存在しないため、データを削除できませんでした。"
# end


#質問文の作成
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
    text: "時々、自分は役に立たないと感じることがあります。",
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

puts "Sample data created successfully!"