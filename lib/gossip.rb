# c'est le MODEL, il pioche dans la db et sort des instances de Gossips
require 'csv'

class Gossip
attr_reader :content, :author

  def initialize(author, content)
    @author = author    # string
    @content = content  # string
  end

  # écrit (ajoute à la fin) le gossip dans le csv
  def save
    if content.nil? || content.empty? || author.nil? || author.empty?
      puts "Aucune donnée à sauvegarder dans le fichier CSV."
      return
    end
    CSV.open('db/gossip.csv', 'ab') do |csv|
      csv << [@author, @content]
    end
  end

  # Met à jour un potin spécifique dans le fichier CSV
  def self.update(id, updated_author, updated_content)
    # 1. Récupérer tous les potins
    all_gossips = self.all
    # 2. Modifier le potin à l'index spécifié (id - 1)
    all_gossips[id.to_i - 1].instance_variable_set(:@author, updated_author)
    all_gossips[id.to_i - 1].instance_variable_set(:@content, updated_content)
    # 3. Réécrire le fichier CSV avec la liste mise à jour
    CSV.open('db/gossip.csv', 'w') do |csv|
      all_gossips.each do |gossip|
        csv << [gossip.author, gossip.content]
      end
    end
    puts "Les modifs ont été sauvegardées avec succès dans db/gossip.csv"
  end

  # lit les gossips depuis un fichier CSV et les affiche
  def self.all
    file_path = 'db/gossip.csv'
    unless File.exist?(file_path)
      puts "Le fichier #{file_path} n'existe pas."
      return []
    end
    all_gossips = []
    CSV.read(file_path).each do |line|
      all_gossips << Gossip.new(line[0], line[1])
    end
    all_gossips # <=> return all_gossips
  end

  def self.find(id)
    # .all renvoie un array, on peut donc chercher le gossip par son index
    Gossip.all[id.to_i - 1]
  end

  def self.delete(id)
    # 1. Récupérer tous les potins
    all_gossips = self.all
    # 2. Supprimer le potin à l'index spécifié (id - 1)
    all_gossips.delete_at(id.to_i - 1)
    # 3. Réécrire le fichier CSV avec la liste mise à jour
    CSV.open('db/gossip.csv', 'w') do |csv|
      all_gossips.each do |gossip|
        csv << [gossip.author, gossip.content]
      end
    end
  end

  # une méthode def self.xxx est une méthode de classe qui s'appelle en faisant NomDeTaClasse.xxx
  # une méthode def xxx est une méthode d'instance qui s'appelle en faisant nom_de_l_instance.xxx

  # dans le html, <% %> sert à exécuter du Ruby. Par exemple pour faire un each do
  # <%= %> va afficher une string Ruby qui est entre ces balises (c'est l'équivalent d'un puts mais sur du HTML)

end
