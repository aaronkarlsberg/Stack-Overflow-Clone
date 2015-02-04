class Question < ActiveRecord::Base
  has_many :answers, dependent: :destroy
  validates :title, :content, presence: true,
                    length: {minimum: 5}


  def upvote
    self.points += 1
    save
  end

  def downvote
    self.points -= 1
    save
  end
end
