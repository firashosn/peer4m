class EvaluationDeadlineApproaching

	def perform
		all_students = User.where(:role => 'student')
		if all_students.count > 0
		#User.are_students.each do |a_user|
			all_students.each do |a_student|
			a_student.poll_evaluation_deadline_approaching()
			#in the poll check for evals ended and opened
			#create notification if one doesn't exist
			#boom done
			end
		end
	end

end