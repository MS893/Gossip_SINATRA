require 'csv'

class Comment
  attr_reader :gossip_id, :author, :content, :creation_date

  def initialize(gossip_id, author, content, creation_date = Time.now.strftime('%d-%m-%Y'))
    @gossip_id = gossip_id
    @author = author
    @content = content
    @creation_date = creation_date
  end

  def save
    CSV.open('db/comments.csv', 'ab') do |csv|
      csv << [@gossip_id, @author, @content, @creation_date]
    end
  end

  def self.all_for_gossip(gossip_id)
    comments = []
    # Crée le fichier s'il n'existe pas pour éviter les erreurs de lecture
    File.new('db/comments.csv', 'w').close unless File.exist?('db/comments.csv')
    
    CSV.foreach('db/comments.csv') do |row|
      comments << Comment.new(row[0], row[1], row[2], row[3]) if row[0].to_i == gossip_id.to_i
    end
    comments
  end
end
