# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

# ユーザーを取得（もしこのようなユーザーが存在しない場合、適切にユーザーを選択または作成してください）
user = User.find_by(nickname: "yoshi_5170")

# ユーザーが存在するかを確認
if user
  # UnlockableFlowerをthresholdの昇順で取得
  flowers = UnlockableFlower.order(threshold: :asc)

  250.times do |i|
    flower_to_add = nil  # ここで繰り返しのたびにflower_to_addをリセット

    # トレーニングのための仮データを追加（必要であれば）
    # user.self_negation_trainings.create(trained_at: Time.current - i.days)

    total_trainings = i + 1
    flowers.each do |flower|
      if total_trainings <= flower.threshold
        flower_to_add = flower
        break
      end
    end

    if flower_to_add
      user.planted_flowers.create(unlockable_flower: flower_to_add, added_at: Time.current - i.hours)
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