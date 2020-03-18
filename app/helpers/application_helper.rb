module ApplicationHelper
  def default_meta_tags
    {
      title: '',
      site: Settings.site.name,
      reverse: true,
      separator: ' - ',
      description: '中古農機具販売ならDMM 農機。 在庫の見つけにくい中古農機具をはじめとして、農業生産に必要となるあらゆる機械、農機具を掲載いたします。 お客様のご要望に応じてDMM 農機が仕入れ、販売、納品、メンテナンスまで一貫して対応いたします。',
      og: defalut_og,
      twitter: default_twitter_card
    }
  end

  def print_text(text)
    text.present? ? text : '-'
  end

  def print_price(price)
    price.present? ? price.to_s(:delimited) : '-'
  end

  def category_options
    [
      ['トラクター', 'トラクター'],
      ['コンバイン', 'コンバイン'],
      ['田植機', '田植機'],
      ['アルミブリッジ', 'アルミブリッジ'],
      ['ウエイト', 'ウエイト'],
      ['エンジン', 'エンジン'],
      ['グレンコンテナー', 'グレンコンテナー'],
      ['クローラー', 'クローラー'],
      ['ゴムロール', 'ゴムロール'],
      ['コンバイン刈取刃', 'コンバイン刈取刃'],
      ['コンプレッサー', 'コンプレッサー'],
      ['スピードスプレーヤー', 'スピードスプレーヤー'],
      ['タイヤ', 'タイヤ'],
      ['チェーンソー', 'チェーンソー'],
      ['テーラー', 'テーラー'],
      ['デバイダー', 'デバイダー'],
      ['トレーラー', 'トレーラー'],
      ['トレンチャー', 'トレンチャー'],
      ['ハーベスター', 'ハーベスター'],
      ['バインダー', 'バインダー'],
      ['バックホー', 'バックホー'],
      ['ハロー', 'ハロー'],
      ['フォークリフト', 'フォークリフト'],
      ['プラウ', 'プラウ'],
      ['ブロードキャスター', 'ブロードキャスター'],
      ['ポンプ', 'ポンプ'],
      ['マニアスプレッダー', 'マニアスプレッダー'],
      ['モアコン', 'モアコン'],
      ['ライスグレーダー', 'ライスグレーダー'],
      ['ライムソワー', 'ライムソワー'],
      ['ロータリー', 'ロータリー'],
      ['ロールベーラー', 'ロールベーラー'],
      ['運搬機', '運搬機'],
      ['刈払機', '刈払機'],
      ['管理機', '管理機'],
      ['乾燥機', '乾燥機'],
      ['畦塗機', '畦塗機'],
      ['計量器', '計量器'],
      ['結束機', '結束機'],
      ['溝切機', '溝切機'],
      ['耕運機', '耕運機'],
      ['混合機', '混合機'],
      ['催芽機', '催芽機'],
      ['砕土機', '砕土機'],
      ['散布機', '散布機'],
      ['堆肥機', '堆肥機'],
      ['車輪', '車輪'],
      ['除雪機', '除雪機'],
      ['精米機', '精米機'],
      ['洗浄機', '洗浄機'],
      ['選別機', '選別機'],
      ['草刈機', '草刈機'],
      ['貯蔵庫', '貯蔵庫'],
      ['動力噴霧機', '動力噴霧機'],
      ['播種機', '播種機'],
      ['培土機', '培土機'],
      ['発電機', '発電機'],
      ['苗コンテナー', '苗コンテナー'],
      ['防除機', '防除機'],
      ['籾摺機', '籾摺機'],
      ['その他', 'その他']
    ]
  end

  def price_options
    [
      ['10万円未満', '10万円未満'],
      ['10万円~20万円', '10万円~20万円'],
      ['20万円~30万円', '20万円~30万円'],
      ['30万円~50万円', '30万円~50万円'],
      ['50万円~70万円', '50万円~70万円'],
      ['70万円~100万円', '70万円~100万円'],
      ['100万円~150万円', '100万円~150万円'],
      ['150万円~200万円', '150万円~200万円'],
      ['200万円~300万円', '200万円~300万円'],
      ['300万円~400万円', '300万円~400万円'],
      ['400万円~500万円', '400万円~500万円'],
      ['500万円以上', '500万円以上']
    ]
  end

  def with_read_more(id, content, type)
    threshold = 5
    data = { id: id, type: type }
    lines = content.split("\n")
    if lines.size <= threshold
      return content_tag(:div, simple_format(h(content)))
    end
    content_tag(:div) do
      concat simple_format(h(lines[0...threshold].join("\n")))
      concat content_tag(:button, 'もっと読む', class: 'read-more', id: "read-more-#{type}-button-#{id}", data: data)
      concat content_tag(:div, simple_format(h(lines[threshold..-1].join("\n"))), class: 'hide', id: "read-more-#{type}-#{id}")
      concat content_tag(:button, '少なく読む', class: 'read-less hide', id: "read-less-#{type}-button-#{id}", data: data)
    end
  end

  def contact_phone_number(separate: false)
    default = Settings.phone.contact
    if @category_slug == Category::Slugs[:tractor]
      default = Settings.phone.contact_tractor
    end

    if separate
      default
    else
      default.gsub(/-/, '')
    end
  end

  private

  def defalut_og
    {
      title: :full_title,
      description: :description,
      url: request.url,
      locale: 'ja_JP',
      site_name: Settings.site.name,
      image: request.protocol + request.host_with_port + '/images/og-image.png',
      type: 'website'
    }
  end
  
  def default_twitter_card
    {
      card: 'summary_large_image',
      site: '	@farmally_nouki',
      creator: '@farmally_nouki',
      image: 'image'
    }
  end

  def embedded_svg(filename, options={})
    svgfile = File.read(Rails.root.join('app', 'assets', 'images', filename))
    svgdocument = Nokogiri::HTML::DocumentFragment.parse svgfile
    svg = svgdocument.at_css 'svg'
    if options[:class].present?
      svg['class'] = options[:class]
    end
    svgdocument.to_html.html_safe
  end

  def with_hostpath(path)
    case path
    when '/sell', '/company', '/blog' then '//' + Settings.domain.farmally + path
    else '//' + Settings.domain.nouki + path
    end
  end
end
