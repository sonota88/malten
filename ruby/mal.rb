require_relative File.join(CONFIG[:mal_dir], "impls/ruby/stepA_mal")

class Mal
  ADDITIONAL_CORE_FUNCS = {
    :print => lambda { |x| print x },
    :"s#first" => lambda { |_self| _self[0] },

    :"s#rest" => lambda { |_self|
      if _self.size <= 1
        nil
      else
        _self[1..-1]
      end
    },

    :"s.cons" => lambda { |first, rest|
      if rest.nil?
        first
      else
        first + rest
      end
    }
  }

  def self.eval(env, src)
    malten_path = File.expand_path("../malten.mal", __dir__)

    new.eval(
      to_mal_val(env),
      <<~MAL
        (do
          (load-file "#{malten_path}")
          #{src}
        )
      MAL
    )
  end

  def self.to_mal_val(v)
    case v
    when Array
      ary =
        v.map { |el|
          to_mal_val(el)
        }
      List.new(ary)
    when Hash
      v
        .to_a
        .map { |k, _v|
          # Java版に合わせてキーを String にする
          [k.to_s, to_mal_val(_v)]
        }
        .to_h
    else
      v
    end
  end

  def self.from_mal_val(v)
    case v
    when List
      v.map { |el|
        from_mal_val(el)
      }
    when Hash
      v
        .to_a
        .map { |k, _v|
          [k, from_mal_val(_v)]
        }
        .to_h
    else
      v
    end
  end
end
