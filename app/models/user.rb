class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :favorites

  def favorite( recipe )
    favorites.where(recipe: recipe).first_or_create
  end

  def unfavorite( recipe )
    favorites.where(recipe: recipe).destroy_all
  end

  def admin?
    roles == 'admin'
  end
end
