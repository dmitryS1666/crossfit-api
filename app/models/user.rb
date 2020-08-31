# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0)
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string
#  last_sign_in_ip        :string
#  confirmation_token     :string
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  first_name             :string
#  last_name              :string
#  phone                  :string
#  account_id             :bigint
#  manager_id             :bigint
#  organization           :string
#  unp                    :string
#  failed_attempts        :integer          default(0), not null
#  unlock_token           :string
#  locked_at              :datetime
#  superadmin_role        :integer
#

class User < ApplicationRecord

  belongs_to :account, optional: true
  has_many :user_contacts
  devise :database_authenticatable,
         :registerable,
         :lockable,
         :recoverable,
         :rememberable,
         :validatable, password_length: 4..8
  has_many :access_tokens,
           class_name: 'Doorkeeper::AccessToken',
           foreign_key: :resource_owner_id,
           dependent: :delete_all # or :destroy if you need callbacks
  has_many :access_grants,
           class_name: 'Doorkeeper::AccessGrant',
           foreign_key: :resource_owner_id,
           dependent: :delete_all # or :destroy if you need callbacks

  def generate_password_token!
    self.reset_password_token = generate_token
    self.reset_password_sent_at = Time.now.utc
    save!
  end

  def password_token_valid?
    (self.reset_password_sent_at + 4.hours) > Time.now.utc
  end

  def unlock_token_valid?
    (self.locked_at + 6.month) > Time.now.utc
  end

  def reset_password!(password)
    self.reset_password_token = nil
    self.password = password
    save!
  end

  def lock_access!(opts = { })
    self.locked_at = Time.now.utc

    if unlock_strategy_enabled?(:email) && opts.fetch(:send_instructions, true)
      send_unlock_instructions
    else
      save(validate: false)
    end
  end

  # Send unlock instructions by email
  def send_unlock_instructions
    raw, enc = Devise.token_generator.generate(self.class, :unlock_token)
    self.unlock_token = enc
    save(validate: false)
    raw
  end

  def send_unlock_instructions_on_demand
    raw, enc = Devise.token_generator.generate(self.class, :unlock_token)
    self.unlock_token = enc
    save(validate: false)
    send_devise_notification(:unlock_instructions, raw, {})
    raw
  end

  private

  def generate_token
    SecureRandom.hex(10)
  end
end
