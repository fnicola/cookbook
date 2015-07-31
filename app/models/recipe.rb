class Recipe < ActiveRecord::Base
  include PgSearch
  has_many :favorites

  # multisearchable :against => [:name, :ingredients, :time]
  pg_search_scope :whose_name_starts_with,
    :against => [:name, :ingredients, :time],
    :using => {
      :tsearch => {:prefix => true}
    }

  def favorited_by( user )
    favorites.where(user_id: user.id).present?
  end
end
