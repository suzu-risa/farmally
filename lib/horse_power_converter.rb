class HorsePowerConverter
  def initialize(horse_power)
    @original_horse_power = horse_power
  end

  def convert_to_ps
    # 改行が入っている場合や0がOになっていることがあるので正規化
    horse_power = original_horse_power.gsub(/\n/,'').gsub(/O/,'0')

    case horse_power
    when /^(搭載エンジン)*(\d|\.|～)+PS(～|程度以上|微速付|微速装置付|以下|以上)*$/ # 変換しないパターン
      horse_power
    when /^(?<kw>(\d|\.)+)\/(?<ps>(\d|\.)+)\((k|ｋ)(w|W|S)\/PS\)$/ # 2.9/4.O(kW/PS)のパターン
      $2 + "PS"
    when /^最大(?<kw>(\d|\.)+)\/(?<ps>(\d|\.)+)\(k(w|W)\/PS\)$/ # 最大2.9/4.O(kW/PS)のパターン
      $2 + "PS"
    when /^(?<kw>(\d|\.)+)k(w|W)\/(?<ps>(\d|\.)+)PS$/ # 6.3kW/8.5PSのパターン
      $2 + "PS"
    when /^(?<kw>(\d|\.)+)\/(?<ps>(\d|\.)+)PS$/ # 2.1/2.8PSのパターン
      $2 + "PS"
    when /^(?<kw>(\d|\.)+)\/(?<ps>(\d|\.)+)$/ # 2.1/2.8のパターン
      $2 + "PS"
    when /^(?<kw>(\d|\.|〜)+)\/(?<ps>(\d|\.|〜)+)$/ # 29.5～59/40～80のパターン
      $2 + "PS"
    when /^((?<kw>(\d|\.)+)k(w|W))$/ # 100kWのパターン
      "#{($1.to_f * 1.3596).round(1)}PS"
    when /^((?<kw>(\d|\.)+)k(w|W))～$/ # 100kW～のパターン
      "#{($1.to_f * 1.3596).round(1)}PS～"
    when /^((?<kw_min>(\d|\.)+).(?<kw_max>(\d|\.)+)k(w|W))$/ #0.25～7.5kW
      "#{($1.to_f * 1.3596).round(1)}〜#{($2.to_f * 1.3596).round(1)}PS"
    when /(?<kw>(\d|\.)+)k(w|W).(?<ps>(\d|\.)+)PS.〜/ # 66kW(90PS)〜 or 66kW(90PS)〜 のパターン
      $2 + "PS〜"
    when /(?<kw>(\d|\.)+(～)*)(\/|～)(?<ps>(\d|\.)+(～)*).+k(w|W)\/PS/
      # 44/60～(kW/PS) or 55/75～kW/PS or 66/90(kW/PS) or 1.6/2.2（kW/PS) or 4.1～5.5(kW/PS) (/が〜として入っている)のパターン
      $2 + "PS〜"
    when /(?<ps>(\d|\.)+)\/(?<rpm>(\d|\.)+)\(PS\/rpm\)/ # 5.5/2000(PS/rpm)
      $1 + "PS"
    when /(?<kw>(\d|\.|～)+)\/(?<ps>(\d|\.|～)+)PS/ # 66～118/90～160PSのパターン
      $2 + "PS"
    when /\d+-\d+PS/ # 100-120PS
      horse_power.gsub(/-/, '～')
    when /(\d|\.)+\((?<pw_min>(\d|\.)+)\).(\d|\.)+\((?<pw_max>(\d|\.)+)\)k(w|W)\(PS\)/ # 66(90)～103.6(140)kW(PS)
      "#{$1}〜#{$2}PS"
    when /(?<kw>(\d|\.|～)+)k(w|W)\((?<ps>(\d|\.|～)+)PS\)/ # 1.3kW(1.7PS)
      $1 + "PS"
    when /(?<kw>(\d|\.|～)+)\((?<ps>(\d|\.|～)+)\)\(kW\/PS\)/ # 27(37)(kW/PS)
      $2 + "PS"
    when /^(?<kw>(\d|\.)+)k(w|W)\/(?<ps>(\d|\.)+)PS～$/# 51.5kW/70PS～
      $2 + "PS〜"
    when /^(?<kw>(\d|\.)+)k(w|W)～\((?<ps>(\d|\.)+)PS～\)$/ # 40.5kW～(55PS～)
      $2 + "PS〜"
    when /((\d|\.|～)+kW)\/(?<ps>(\d|\.|～)+PS)/  # 18.4～51.5kW/25～70PS
      $1
    when /\W+(?<kw>(\d|\.)+)k(w|W)/ # 出力174kW , 熱出力116kWなど
      "#{($1.to_f * 1.3596).round(1)}PS"
    else
      horse_power # 変換しないパターン
    end
  end

  private
    attr_reader :original_horse_power
end
