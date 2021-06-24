class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  #validates_format_of :email, with: /\@finances.gouv.fr/, message: 'Vous devez avoir un mail finances.gouv.fr'
end
