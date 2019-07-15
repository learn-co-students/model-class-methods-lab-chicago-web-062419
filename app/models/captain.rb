class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    includes(boats: :classifications).where(classifications: {name: "Catamaran"})
    #* return all captains of catamarans. 
  end

  def self.sailors
    includes(boats: :classifications).where(classifications: {name: "Sailboat"}).distinct
    #* return captains with sailboats.
  end

  def self.motorboat_operators
    includes(boats: :classifications).where(classifications: {name: "Motorboat"})
  end

  def self.talented_seafarers
    where("id IN (?)", self.sailors.pluck(:id) & self.motorboat_operators.pluck(:id))
    #* uses '&' to pick 2 different attributes that apply.
  end

  def self.non_sailors
    where.not("id IN (?)", self.sailors.pluck(:id))
  end

end
