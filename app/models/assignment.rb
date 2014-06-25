class Assignment < ActiveRecord::Base
  belongs_to :course
  has_many :teams

=begin
def assign_teams
        if @teams_text
          @team_line = @teams_text.split(/\n/).map do |line|
            @team_name = line.split(':').first
            @team_members = line.split(',').map do |team_mems|
            	@student_name = teams_text.split
            end

            Task.find_or_create_by_name(assignment)
            Task.people.find_or_create_by_name(assignee)
          end
        end
      end
=end


end

class Team < ActiveRecord::Base
      belongs_to :assignment
      #has_and_belongs_to_many :students
end