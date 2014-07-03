class Team < ActiveRecord::Base
  #require 'CSV'

  belongs_to :assignment
  has_many :team_enrollments
  has_many :users, :through => :team_enrollments

=begin
 def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|

      team_hash = row.to_hash # get the team name
      team = Team.where(id: team_hash["id"])

      if team.count == 1
        team.first.update_attributes(team_hash)
      else
        Team.create!(team_hash)
      end # end if !product.nil?
    end # end CSV.foreach
  end # end self.import(file)
=end

end
