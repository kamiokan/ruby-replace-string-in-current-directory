# frozen_string_literal: true

# 置換対象文字列と置き換え後文字列
before = 'XXX'
after = 'REPLACED STRING'

# ファイルを修正するメソッド定義
def replace_string(file, before, after)
  file.rewind
  body = file.read
  body = body.gsub(before) do
    after
  end

  file.rewind
  file.puts body
end

# カレントディレクトリのファイル取得
files = Dir.glob('*.txt')

# ファイル１つずつを処理
files.each do |file|
  # ファイル１つを開く
  File.open(file, 'r+') do |f|
    f.flock(File::LOCK_EX)

    replace_string(f, before, after)

    f.truncate(f.tell)
  end
end
