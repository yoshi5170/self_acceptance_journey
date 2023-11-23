module ApplicationHelper
  def page_title(page_title = '', admin: false)
    base_title = if admin
                   'JustBe U(管理画面)'
                 else
                   'JustBe U'
                 end
    page_title.empty? ? base_title : "#{page_title}|#{base_title}"
  end

  def show_meta_tags
    assign_meta_tags if display_meta_tags.blank?
    display_meta_tags
  end

  def assign_meta_tags(options = {})
    configs = {
      site: 'JustBe U',
      title: 'あなたの自己受容への旅をナビゲート',
      reverse: true,
      charset: 'utf-8',
      description: 'JustBe Uでは、ありのままの自分を受け入れる手助けをします。診断から始まり、AIを活用した自己受容トレーニング、励ましのメッセージ、幸せ日記まで、自己否定の連鎖を断ち切り、自己受容へと向かう一歩を踏み出しましょう。自分の全てを受け止める旅、今スタートです。',
      keywords: '自己受容, 自己肯定, 自己愛, ポジティブ思考, マインドフルネス, パーソナルグロース, セルフヘルプ, 自己改善, メンタルヘルス, ウェルビーイング, 自己受容を高める, 自己認識, セルフケア',
      canonical: request.original_url,
      separator: '|',
      icon: [
        { href: image_url('favicon.png') }
      ],
      og: {
        site_name: :site,
        title: :title,
        description: :description,
        type: 'website',
        url: options[:url].presence || request.original_url,
        image: options[:image].presence || image_url('ogp.png'),
        local: 'ja-JP'
      },
      # Twitter用の設定を個別で設定する
      twitter: {
        card: 'summary_large_image',
        image: options[:image].presence || image_url('ogp.png')
      }
    }
    set_meta_tags(configs)
  end
end
