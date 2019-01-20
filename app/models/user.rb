class User < ActiveRecord::Base

# 制限
 has_secure_password
  validates :userid,  presence: true
  validates :name,  presence: true
  validates :email, presence: true
  validates :password, presence: true, length: { minimum: 6 }

# 与えられた文字列のハッシュ値を返す
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

# ランダムなトークンを返す
def User.new_token
  SecureRandom.urlsafe_base64
end

# ログイン情報を記録
def remember
  self.remember_token = User.new_token
  update_attribute(:remember_digest, User.digest(remember_token))
end

# 渡されたトークンがダイジェストと一致したらtrueを返す
def authenticated?(remember_token)
  return false if remember_digest.nil?
  BCrypt::Password.new(remember_digest).is_password?(remember_token)
end

# ログアウト
def forget
  update_attribute(:remember_digest, nil)
end
end
