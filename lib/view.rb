class View

  def notify output
    puts output
  end

  def error output
    puts "Error: #{output}"
  end

  def prompt question
    print "#{question} "
    gets.chomp
  end

  def prompt_for_player_count
    prompt "How many players? (1-5)"
  end

  def prompt_for_player_name num
    prompt "What is player #{num}'s name?"
  end

end
