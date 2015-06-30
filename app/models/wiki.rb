class Wiki < ActiveRecord::Base
  extend FriendlyId
  friendly_id :title, use: :slugged


  belongs_to :user

# collaborator model that we created
  has_many :collaborators
# name we invented to create anoter method for going through collaborator's model to get users
  has_many :contributors, through: :collaborators, source: :user

  # scope :visible_to, -> (user) { user ? all : where(private: false) }
  scope :visible_to, -> (user) { 
    if user && ((user.role == 'premium') || (user.role == 'admin')) 
      all 
    else
      where(private: false)  
    end
  }

  def public?
    !private
  end
end