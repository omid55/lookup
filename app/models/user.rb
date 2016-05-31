class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  ratyrate_rater

  has_many :photos
  has_many :reviews
  has_many :posts
  has_many :photo_likes
  has_many :comments
  has_many :liked_photos, :through => :photo_likes
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable


end
