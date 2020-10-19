# frozen_string_literal: true
require 'comment'
require 'gossip'

class ApplicationController < Sinatra::Base
  # page d'accueil
  get '/' do
    erb :index, locals: { gossips: Gossip.all }
  end

  # page création nouveau gossip
  get '/gossips/new/' do
    erb :new_gossip
  end

  # traitement du formulaire nouveau gossip
  post '/gossips/new/' do
    Gossip.new(params['gossip_author'], params['gossip_content']).save
    redirect '/'
  end

  # affichage dynamique du gossip par ID
  get '/gossips/:id/' do
    id = params['id'].to_i
    erb :show, locals: { gossip: Gossip.find(id), index: id, comments: Comment.find(id) }
  end

  # page de modification du gossip (dynamique)
  get '/gossips/:id/edit/' do
    id = params['id'].to_i
    erb :edit, locals: { gossip: Gossip.find(id), index: id }
  end

  # traitement du formulaire de modif de gossip
  post '/gossips/:id/edit/' do
    id = params['id'].to_i
    Gossip.update(params['gossip_author'], params['gossip_content'], id)
    redirect '/'
  end

  # Traitement de l'ajout d'un commentaire
  post '/gossips/:id/' do
    id = params['id'].to_i
    Comment.new(id, params['comment']).save
    erb :show, locals: { gossip: Gossip.find(id), index: id, comments: Comment.find(id) }
  end
end
