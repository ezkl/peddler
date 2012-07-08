module ConfigHelper
  def mws
    @mws ||= begin
      path = File.expand_path '../config.yml', __FILE__
      unless File.exists? path
        path = File.expand_path '../config.yml.example', __FILE__
      end

      YAML.load_file path
    end
  end
end

RSpec.configure do |c|
  c.include ConfigHelper
end
