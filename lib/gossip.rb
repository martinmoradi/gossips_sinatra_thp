class Gossip

  attr_reader :author, :content

  def initialize(author, content)
    @content = content
    @author = author
  end

  def save
    CSV.open("./db/gossip.csv", "a+") { |csv| csv << [@author, @content] }
  end

  def self.all
  all_gossips = []
  CSV.read("./db/gossip.csv").each do |csv_line|
    all_gossips << Gossip.new(csv_line[0], csv_line[1])
  end
   all_gossips
  end

  def self.find(id)
    self.all[id - 1]   
  end
  
  def self.update(author, content, id)  
    gossips = self.all
		gossips[id].author = author
		gossips[id].content = content
		CSV.open("db/gossip.csv", "w") { |csv| csv = "" }
		CSV.open("db/gossip.csv", "w") { |csv| gossips.each { |gossip| gossip.save }}
	end
 

end

