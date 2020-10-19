# frozen_string_literal: true

class Gossip
  attr_reader :author, :content

  def initialize(author, content)
    @content = content
    @author = author
  end

  # sauvegarder instance dans csv
  def save
    CSV.open('./db/gossip.csv', 'a+') { |csv| csv << [@author, @content] }
  end

  # retourner un array comprenant tout le csv
  def self.all
    all_gossips = []
    CSV.read('./db/gossip.csv').each do |csv_line|
      all_gossips << Gossip.new(csv_line[0], csv_line[1])
    end
    all_gossips
  end

  # trouver une instance par id
  def self.find(id)
    all[id - 1]
  end

  # éditer un potin
  def self.update(author, content, id)
    gossips = all
    gossips[id - 1].author = author
    gossips[id - 1].content = content
    # vide le csv puis le remplace
    CSV.open('./db/gossip.csv', 'w') { |_csv| csv = '' }
    CSV.open('./db/gossip.csv', 'w') { |_csv| gossips.each(&:save) }
  end
end
