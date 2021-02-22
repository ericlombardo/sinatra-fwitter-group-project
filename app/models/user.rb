class User < ActiveRecord::Base
  has_secure_password
  has_many :tweets

  def slug
    self.username.split(' ').join('-').downcase
  end

  def self.find_by_slug(slug) # compares Artist instances as slug with params slug
    User.all.find do |u|
      u.slug == slug
    end
  end
end
