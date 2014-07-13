class Todo < ActiveRecord::Base
  belongs_to :user
  validates :content, presence: true
  acts_as_list scope: :todos

  def self.to_csv
    CSV.generate do |csv|
      csv << column_names
      all.each do |todos|
        csv << todos.attributes.values_at(*column_names)
      end
    end
  end
end
