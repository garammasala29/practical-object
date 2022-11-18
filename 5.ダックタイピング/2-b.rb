# Railsのactive_record/relations/finder_methods.rbの例
# kind_of?を使っているけど、これは賢いダック
def first(*args)
  if args.any?
    if args.first.kind_of?(Integer) || (loaded? && !args.first.kind_of(Hash))
      to_a.first(*args)
    else
      apply_finder_options(args.first).first
    end
  else
    find_first
  end
end

# RubyのIntegerやHashは安定したもの
# 基本クラスに変更を加える「モンキーパッチ」
