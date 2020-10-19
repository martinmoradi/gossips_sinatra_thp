# frozen_string_literal: true
require 'csv'


class Comment

  attr_accessor :id, :content
  @@all_comments = []

  def initialize(id, content)
    @id = id
    @content = content
    @@all_comments << [@id, @content]
  end

  # sauvegarder les comments dans une variable de classe
  def save
    CSV.open('./db/comment.csv', 'a+') { |csv| csv << [@id, @content] }
  end
  
  def self.all
    
    CSV.read('./db/gossip.csv').each do |csv_line|
    @@all_comments << Comment.new(csv_line[0], csv_line[1])
    end
    @@all_comments
  end
  
  # selectionner le commentaire grace à l'id
  def self.find_all(id)        
    @@all_comments.select  { |comment| comment[0].to_i == id.to_i }
  end


end
