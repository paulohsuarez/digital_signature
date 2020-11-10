class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  
  has_one :signature
  has_many :user_requests
  has_many :requests, through: :user_requests


  validates_presence_of :nome
  validates_uniqueness_of :email

	FUNCIONARIO = 'Funcionario'
	CLIENTE = 'Cliente'

    PERFIS = [
    FUNCIONARIO,
    CLIENTE
  	]

  def active_for_authentication?
    if ativo?
      super && ativo?
    end
  end

end
