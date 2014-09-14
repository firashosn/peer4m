class EvaluationDeadlineApproaching


  def eval_deadline_approaching_batch
    all_students = User.where(:role => 'student')
    if all_students.count > 0
      all_students.each do |a_student|
      a_student.poll_evaluation_deadline_appoaching
      end
    end
  end
end