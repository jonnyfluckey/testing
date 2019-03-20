require 'rails_helper'

RSpec.describe StudentsController, type: :controller do
  # Write your test below
  # it will be easier to test this controller with factory bot
    # you would have to add the gem and configure it.

    # FactoryBot.define do
    #   factory :student do
    #     name { "John Doe" }
    #     student_number  { 1234 }
    #     gpa { 3.9 }
    #   end
    # end

    let(:valid_attributes) { 
      { 
        name: 'John Doe', 
        student_number: 1234, 
        gpa: 3.9
      }
    }

    let(:invalid_attributes) {
      { 
        name: '', 
        student_number: 1234, 
        gpa: 3.9
      }
    }

    

    describe "GET #index" do
      it "returns http success" do
        school = School.create!(name: 'East High', address: '123', principal: 'joe', capacity: 100, private_school: true)
        get(:index, params:  {school_id: school.id})
        expect(response).to be_successful
      end
    end
  
    describe "GET #show" do
      it "returns http success" do
        school = School.create!(name: 'East High', address: '123', principal: 'joe', capacity: 100, private_school: true)
        student = @school.students.create!(valid_attributes)
        get(:show, params: {school_id: school.id, id: student.id})
        expect(response).to be_successful
      end
    end
  
    describe "GET #new" do
      it "returns http success" do
        get :new, params: {id: school_id}
        expect(response).to be_successful
      end
    end
  
    describe "GET #edit" do
      it "returns http success" do
        student = @school.students.create! valid_attributes
        get :edit, params: { id: student.id }
        expect(response).to be_successful
      end
    end
  
    describe "POST #create" do
      context "with valid params" do
        it "creates a new student" do
          expect {
            post :create, params: { student: valid_attributes }
          }.to change(Student, :count).by(1)
        end
  
        it "redirects to the created student" do
          post :create, params: { student: valid_attributes }
          expect(response).to redirect_to(@school.students.last)
        end
      end
  
       context "with invalid params" do
        it "does not creates a new student" do
          expect {
            post :create, params: { student: invalid_attributes }
          }.to change(Student, :count).by(0)
        end
  
        it "redirects to new template" do
          post :create, params: { student: invalid_attributes }
          expect(response).to be_successful
        end
      end
    end
  
    describe "PUT #update" do
      context "with valid params" do
        let(:new_attributes) {
          { student_number: 250 }
        }
  
        it "update the student" do
          student = @school.students.create! valid_attributes
          put :update, params: {id: student.id, student: new_attributes }
          student.reload
          expect(@school.students.student_number).to eq(new_attributes[:student_number])
        end
  
        it "redirect to the student updated" do
          student = @school.students.create! valid_attributes
          put :update, params: {id: student.id, student: valid_attributes }
          expect(response).to redirect_to(student)
        end
      end
  
      context "with invalid params" do
        it "does not update the student" do
          student = @school.students.create! valid_attributes
          put :update, params: {id: student.id, student: invalid_attributes }
          student.reload
          expect(@school.students.name).to_not eq(invalid_attributes[:name])
        end
  
        it "redirect to the edit form" do
          student = @school.students.create! valid_attributes
          put :update, params: {id: student.id, student: invalid_attributes }
          expect(response).to be_successful
        end
      end
    end
  
     describe "DELETE #destroy" do
      it "destroys the requested student" do
        student = @school.students.create! valid_attributes
        expect {
          delete :destroy, params: {id: student.id}
        }.to change(Student, :count).by(-1)
      end
  
      it "redirects to the school list" do
        student = @school.students.create! valid_attributes
        delete :destroy, params: {id: student.id}
        expect(response).to redirect_to(school_students_path(@school))
      end
    end

end
