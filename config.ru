require 'bundler'
Bundler.require

require 'dotenv'
Dotenv.load

$:.unshift File.expand_path("./../lib", __FILE__)
require 'controller'

# Configuration pour l'envoi d'e-mails avec Pony et le SMTP de Free.fr
Pony.options = {
  :from => "The Gossip Project <#{ENV['FREE_EMAIL_USER']}>", # Adresse d'expéditeur par défaut
  :via => :smtp,
  :via_options => {
    :address              => 'smtp.free.fr',
    :port                 => '587', # Port standard avec STARTTLS
    :enable_starttls_auto => true,  # Active STARTTLS
    :use_ssl              => false, # Incompatible avec STARTTLS
    :user_name            => ENV['FREE_EMAIL_USER'], # sont dans .env
    :password             => ENV['FREE_EMAIL_PASSWD'], 
    :authentication       => :plain,
  }
}

run ApplicationController
