class Answer < ActiveRecord::Base
  belongs_to :question
  belongs_to :user
  has_many :avotes
  validates :name, :answer, presence: true

  def current_votecount
    @answer.qvotes.sum(:value)
  end
end



