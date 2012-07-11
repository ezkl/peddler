module Asins
  def self.method_missing(mth, *args, &block)
    @asins ||= File.new(File.expand_path('../asins', __FILE__))
                   .map(&:chomp)
    @asins.send mth, *args, &block
  end
end
