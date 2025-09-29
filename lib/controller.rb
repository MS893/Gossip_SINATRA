# gérer : créer un gossip, voir la liste complète des gossips ou supprimer un gossip
require 'gossip'
require 'view'
require 'sinatra/flash'
require 'comment'
require 'pony'

class ApplicationController < Sinatra::Base

  enable :sessions
  register Sinatra::Flash

  get '/' do
    erb :index, locals: {gossips: Gossip.all}
    # locals permet d'envoyer au fichier ERB des variables que l'on utilisera. Ici on veut lui envoyer l'array obtenu par Gossip.all
  end
  
  get '/gossips/new/' do
    erb :new_gossip
  end
  post '/gossips/new/' do
    # Crée un nouveau gossip avec les données du formulaire
    gossip = Gossip.new(params['gossip_author'], params['gossip_content'])
    gossip.save # Sauvegarde le gossip dans le CSV
    # Affiche un message pour l'utilisateur
    puts "Ceci est le contenu du hash params : #{params}"
    puts "Gossip créé par #{params['gossip_author']} - Contenu : #{params['gossip_content']}"
    puts "Sauvegardé dans la base de données (CSV)."
    redirect '/' # Redirige vers la page d'accueil
  end

  get '/gossips/:id' do
    # Récupère le potin correspondant à l'ID fourni dans l'URL
    gossip = Gossip.find(params['id'])
    comments = Comment.all_for_gossip(params['id'])
    puts "Potin n°#{params['id']}"    
    # Affiche la vue show.erb en lui passant le potin trouvé et son ID
    erb :show, locals: {gossip: gossip, id: params['id'], comments: comments}
  end

  get '/gossips/:id/edit' do
    # Récupère le potin correspondant à l'ID fourni dans l'URL
    gossip = Gossip.find(params['id'])
    puts "Potin n°#{params['id']}"    
    # Affiche la vue edit.erb en lui passant le potin à modifier et son ID
    erb :edit, locals: {gossip: gossip, id: params['id']}
  end
  post '/gossips/:id/edit' do
    # Récupère les nouvelles données du formulaire et l'ID depuis l'URL
    Gossip.update(params['id'], params['gossip_author'], params['gossip_content'])
    # Redirige vers la page d'accueil pour voir les changements
    redirect '/'
  end

  post '/gossips/:id/delete' do
    # Appelle la méthode de suppression du modèle
    Gossip.delete(params['id'])
    flash[:notice] = "Le potin n°#{params['id']} a bien été supprimé !"
    # Redirige vers la page d'accueil
    redirect '/'
  end

  post '/gossips/:id/comments' do
    gossip_id = params['id']
    comment_author = params['comment_author']
    comment_content = params['comment_content']
    Comment.new(gossip_id, comment_author, comment_content).save
    # Envoi de l'e-mail
    Pony.mail(
      :to => 'ms893@free.fr',
      :subject => "Nouveau commentaire de #{comment_author}",
      :body => "Un nouveau commentaire a été posté sur le potin n°#{gossip_id}.\n\nAuteur: #{comment_author}\nCommentaire: #{comment_content}"
    )
    flash[:notice] = "Votre commentaire a bien été ajouté !"
    redirect "/gossips/#{gossip_id}"
  end

end
