# デフォルト値を明示的に設定
def initialize(args)
  @chainring = args[:chainring] || 40
  @cog = args[:cog] || 18
  @wheel = args[:wheel]
end

# フェッチを使ってデフォルト値を指定
# 対象のキーを見つけるのに失敗してもnilを自動で返さないのが||に勝るところ
def initialize(args)
  @chainring = args.fetch(:chainring, 40)
  @cog = args.fetch(:cog, 18)
  @wheel = args[:wheel]
end

# デフォルト値をinitializeに除去してdefaultsメソッドを定義
def initialize(args)
  args = default.merge(args)
  @wheel = args[:wheel]
end

def default
  {:chainring => 40, :cog => 18}
end
