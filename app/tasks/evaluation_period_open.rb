class EvaluationPeriodOpen
	
  def eval_open_batch
		all_students = User.where(:role => 'student')
		#User.are_students.each do |a_user|
		if all_students.count > 0
			all_students.each do |a_student|
			batch_notifications = a_student.poll_batch_notifications()
			end
		end	
	end
end
