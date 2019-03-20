require 'rails_helper'

RSpec.describe Student, type: :model do
  # write your student model here
  describe 'attributes' do
    it 'has a name' do
      name = 'Tim'
      student = Student.create(name: name)
      expect(student.name).to eq(name)
    end

    it 'has a school' do
      school = 4
      student = Student.create(school_id: school)
      expect(student.school_id).to eq(school)
    end

    it 'has a student number' do
      number = 1234
      student = Student.create(student_number: number)
      expect(student.student_number).to eq(number)
    end

    it 'has a gpa' do
      gpa = 3.9
      student = Student.create(gpa: gpa)
      expect(student.gpa).to eq(gpa)
    end

  

   
  end

  describe "vaildations" do
    it { should validate_presence_of :name }
    it { should validate_presence_of :student_number}
    it { should validate_presence_of :gpa }
    it { should validate_uniqueness_of :name }
    
    it 'has a student number lower bound' do
      should validate_numericality_of(:student_number).
      is_greater_than_or_equal_to(0)
    end

    it 'as a student number higher bound' do
      should validate_numericality_of(:student_number).
      is_less_than_or_equal_to(10000)
    end
  end
  
  describe "association" do
    it { should belong_to(:school) }
  end

  describe "uniqueness" do
    School.create!(name: 'foo', address: '123', principal: 'mt')
    Student.create!(school_id: 1, name: 'foo', student_number: 1234, gpa: 3.9)
    subject { Student.new(name: 'foo', student_number: 1234, gpa: 3.9) }
    it { should validate_uniqueness_of(:name) }
  end

  describe "numericality" do
    before(:each) do
      @student = Student.create(name: 'foo', student_number: 1234, gpa: 3.9)
    end
    
     it { should validate_numericality_of(:student_number) }
  end 
end 