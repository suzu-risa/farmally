class HorsePowerConverter

  def initialize(horse_power)
    @original_horse_power = horse_power
  end

  def convert_to_ps
    if should_convert?
      exec_convert_to_ps
    end
  end

  private
    attr_reader :original_horse_power

    def should_convert?
      original_horse_power !~ /^(\d|\.|～)+PS～*$/
    end

    def exec_convert_to_ps
      # 改行が入っている場合や0がOになっていることがあるので正規化
      horse_power = original_horse_power.gsub(/\n/,'').gsub(/O/,'0')

      case horse_power
      when /^(?<kw>(\d|\.)+)\/(?<ps>(\d|\.)+)\(kW\/PS\)$/ # 2.9/4.O(kW/PS)のパターン
        $2 + "PS"
      when /^最大(?<kw>(\d|\.)+)\/(?<ps>(\d|\.)+)\(kW\/PS\)$/ # 最大2.9/4.O(kW/PS)のパターン
        $2 + "PS"
      when /^(?<kw>(\d|\.)+)kW\/(?<ps>(\d|\.)+)PS$/ # 6.3kW/8.5PSのパターン
        $2 + "PS"
      when /^(?<kw>(\d|\.)+)\/(?<ps>(\d|\.)+)PS$/ # 2.1/2.8PSのパターン
        $2 + "PS"
      when /^(?<kw>(\d|\.)+)\/(?<ps>(\d|\.)+)$/ # 2.1/2.8のパターン
        $2 + "PS"
      when /^(?<kw>(\d|\.|〜)+)\/(?<ps>(\d|\.|〜)+)$/ # 29.5～59/40～80のパターン
        $2 + "PS"
      when /^(?<kw>(\d|\.|〜)+kW)$/ # 100kWのパターン
        "#{$1 * 1.3596}PS"
      when /(?<kw>(\d|\.)+)kW.(?<ps>(\d|\.)+)PS.〜/ # 66kW(90PS)〜 or 66kW(90PS)〜 のパターン
        $2 + "PS〜"
      when /(?<kw>(\d|\.)+)\/(?<ps>(\d|\.)+).+kW\/PS/ # 44/60～(kW/PS) or 55/75～kW/PS or 66/90(kW/PS) or 1.6/2.2（kW/PS）のパターン
        $2 + "PS〜"
      end
    end

=begin
2.9/4.O(kW/PS)



end
