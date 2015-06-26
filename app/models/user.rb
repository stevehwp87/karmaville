class User < ActiveRecord::Base
  has_many :karma_points

  attr_accessible :first_name, :last_name, :email, :username

  validates :first_name, :presence => true
  validates :last_name, :presence => true

  validates :username,
            :presence => true,
            :length => {:minimum => 2, :maximum => 32},
            :format => {:with => /^\w+$/},
            :uniqueness => {:case_sensitive => false}

  validates :email,
            :presence => true,
            :format => {:with => /^[\w+\-.]+@[a-z\d\-.]+\.[a-z]+$/i},
            :uniqueness => {:case_sensitive => false}

  def self.karma_method
    User.all.each_with_index do |user, index|
      p index if index%100 == 0
      user.karma = user.total_karma
      user.save
    end
  end

  def self.by_karma

    joins(:karma_points).group('users.id').order('SUM(karma_points.value) DESC')

  end

  def total_karma
    self.karma_points.sum(:value)
  end

  def full_name
    "#{first_name} #{last_name}"
  end
end

# counter = 0

# User.all.each do |user|
#   line = user.karma_points.map(&:value).inject{ |sum, value| sum + value}
#   User.connection.execute "UPDATE users SET karma=#{line} WHERE users.id=#{user.id}"
#   counter +=1
#   puts "running #{counter}" if counter%1000 == 0
# end