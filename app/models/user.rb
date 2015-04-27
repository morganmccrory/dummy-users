class User < ActiveRecord::Base
  include BCrypt

  validates :password_hash, presence: true
  validates :email, presence: true
  validates :email, uniqueness: true, on: :create

# def self.authenticate(password)
#   if user.password == params[:user][:password]
#     return user
#   else
#     nil
#   end
# end

  def password
    @password ||= Password.new(password_hash)
  end

  def password=(new_password)
    @password = Password.create(new_password)
    self.password_hash = @password
  end


end
