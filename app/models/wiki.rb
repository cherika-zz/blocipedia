class Wiki < ActiveRecord::Base
  belongs_to :user

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