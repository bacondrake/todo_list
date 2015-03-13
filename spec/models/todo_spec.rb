require 'rails_helper'

RSpec.describe Todo, :type => :model do
  it "belongs to user" do
    user = FactoryGirl.create(:user)
    expect(:todo).to belong_to(:user)
  end
end


# class Todo < ActiveRecord::Base
#   belongs_to :user
#   validates :content, presence: true

#   def self.to_csv
#     CSV.generate do |csv|
#       csv << column_names
#       all.each do |todos|
#         csv << todos.attributes.values_at(*column_names)
#       end
#     end
#   end
# end
