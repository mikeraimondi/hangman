class Word
  attr_reader :secret, :display

  def initialize
    corpus = []
    path = File.expand_path('../../Words/Words/en.txt', __FILE__)
    File.open(path).each_line { |line| corpus << line.chomp }
    @secret = corpus.sample
    @display = ""
    @secret.length.times { @display << "_"}
  end
end
