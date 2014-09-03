class Tasks::EvaluationPeriodOpen

	def perform
		User.are_students.each do |a_user|
			batch_notifications = a_user.poll_batch_notifications()
			#in the poll check for evals ended and opened
			#create notification if one doesn't exist
			#boom done
			end

	end

end
