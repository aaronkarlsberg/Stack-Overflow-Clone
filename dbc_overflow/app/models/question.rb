class Question < ActiveRecord::Base
  belongs_to :user
  has_many :answers, dependent: :destroy
  has_many :qvotes
  validates :title, :content, presence: true,
                    length: {minimum: 5}
  def current_votecount
    @question.qvotes.sum(:value)
  end
end
