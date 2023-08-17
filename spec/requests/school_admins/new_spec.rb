RSpec.feature 'New School Admin' do
  

  feature 'Validation errors' do
    context 'kind related errors' do
      scenario 'when a teacher wants to be set a student' do
        visit edit_user_path(teacher_1)
  
        select("Student", from: "user_kind")
        click_on 'Update User'
  
        expect(page).to have_text(
          "Kind can not be student because is teaching in at least one program"
        )
        expect(teacher_1.reload).to be_teacher
      end

      scenario 'when a student wants to be set as a teacher' do
        visit edit_user_path(user_1)
  
        select('Teacher', from: "user_kind")
        click_on 'Update User'
  
        expect(page).to have_text(
          "Kind can not be teacher because is studying in at least one program"
        )
        expect(user_1.reload).to be_student
      end
    end
  end

  feature 'Validation ok' do
    scenario 'when a teacher wants to be set a student' do
      visit edit_user_path(teacher_3)

      select('Student', from: "user_kind")
      click_on 'Update User'

      expect(page).not_to have_text(
        "Kind can not be student because is teaching in at least one program"
      )
      expect(teacher_3.reload).to be_student
    end

    scenario 'when a student wants to be set as a teacher' do
      visit edit_user_path(user_4)

      select('Teacher', from: "user_kind")
      click_on 'Update User'

      expect(page).not_to have_text(
        "Kind can not be teacher because is studying in at least one program"
      )
      expect(user_4.reload).to be_teacher
    end
  end
end