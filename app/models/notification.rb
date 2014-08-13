class Notification < ActiveRecord::Base
  belongs_to :user

  enum type: [ :team_created, :ranking_update, :evaluation_deadline_approaching, :evaluated ]

end
