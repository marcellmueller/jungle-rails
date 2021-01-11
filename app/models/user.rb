class User < ActiveRecord::Base
  has_secure_password
  validates :name, presence: true
  validates :password, :presence =>true, :confirmation =>true, length: { minimum: 6 }
  validates :email, presence: true, uniqueness: { case_sensitive: false }, :case_sensitive => false
  def email=(val)
    write_attribute :email, val.downcase
  end

  def strip_whitespace
    self.name = self.name.strip unless self.name.nil?
    self.email = self.email.strip unless self.email.nil?
    self.password = self.password.strip unless self.password.nil?
  end
  
  
  def self.authenticate_with_credentials(email, password)
    email = email.downcase
    email = email.strip
    user = User.find_by_email(email)
    if user.authenticate(password)
     return user
    else
      return nil
    end
  end
end

