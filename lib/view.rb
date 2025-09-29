# affichage des résultats dans le terminal

class View

  def initialize
    @gossips = []
  end

  def create_gossip
    # Gossip à saisir
    clear_screen()
    print "Nom de l'auteur   : "
    gossip_author = gets.chomp.to_s
    print "Contenu du gossip : "
    gossip_content = gets.chomp.to_s
    params = { author: gossip_author, content: gossip_content } # <=> return params
  end

  def index_gossips(gossips)
    puts "\nVoici la liste de tous les potins :"
    gossips.each_with_index do |gossip, index|
      puts "#{index + 1}. #{gossip.author} a dit : #{gossip.content}"
    end
    print "\nEntrée pour continuer..."
    gets.chomp
    clear_screen()
  end

  def delete_gossips(gossips)
    puts "\nVoici la liste de tous les potins :"
    gossips.each_with_index do |gossip, index|
      puts "#{index + 1}. #{gossip.author} a dit : #{gossip.content}"
    end
    print "\nQuelle ligne à supprimer : "
    line = gets.chomp.to_i
  end

  def confirm_delete_gossips(gossips)
    puts "\nVoici la liste après suppression de la ligne choisie :"
    gossips.each_with_index do |gossip, index|
      puts "#{index + 1}. #{gossip.author} a dit : #{gossip.content}"
    end
    print "\nConfirmez-vous la suppression de la ligne [Y/n] : "
    confirm = (gets.chomp.to_s.downcase == "y")
    return confirm ? true : false
  end

  # efface l'écran
  def clear_screen
    system("clear")
  end

end