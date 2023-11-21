require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'User Validations' do
    it 'Is valid with complete values' do
      user = User.new(
        first_name: 'Luna',
        last_name: 'Moon',
        email: 'monkey@cat.com',
        password: 'password',
        password_confirmation: 'password'
      )
      expect(user).to be_valid
    end

    it 'Is not valid if password does not match password_confirmation' do
      user = User.new(
        first_name: 'Luna',
        last_name: 'Moon',
        email: 'test@test.com',
        password: 'password',
        password_confirmation: 'differentpassword'
      )
      expect(user).not_to be_valid
    end

    it 'Is not valid when password is empty' do
      user = User.new(
        first_name: 'Luna',
        last_name: 'Moon',
        email: 'monkey@cat.com'
      )
      expect(user).not_to be_valid
    end

    it 'Is not valid when email is empty' do
      user = User.new(
        first_name: 'Luna',
        last_name: 'Moon',
        password: 'password',
        password_confirmation: 'password'
      )
      expect(user).not_to be_valid
    end

    it 'Is not valid when first name is empty' do
      user = User.new(
        last_name: 'Moon',
        email: 'monkey@cat.com',
        password: 'password',
        password_confirmation: 'password'
      )
      expect(user).not_to be_valid
    end

    it 'Is not valid when last name is empty' do
      user = User.new(
        first_name: 'Luna',
        email: 'monkey@cat.com',
        password: 'password',
        password_confirmation: 'password'
      )
      expect(user).not_to be_valid
    end

    it 'Is not valid if the email is not unique' do
      User.create(
        first_name: 'Luna',
        last_name: 'Moon',
        email: 'monkey@cat.com',
        password: 'password',
        password_confirmation: 'password'
      )
      user = User.new(
        first_name: 'Monkey',
        last_name: 'Cat',
        email: 'MONKey@CAT.com',
        password: 'password123',
        password_confirmation: 'password123'
      )
      expect(user).not_to be_valid
    end

  end

  describe '.authenticate_with_credentials' do
    it 'authenticates with spaces around email' do
      user = User.create(
        first_name: 'John',
        last_name: 'Doe',
        email: 'test@test.com',
        password: 'password',
        password_confirmation: 'password'
      )

      authenticated_user = User.authenticate_with_credentials(' test@test.com ', 'password')
      expect(authenticated_user).to eq(user)
    end

    it 'authenticates with wrong case email' do
      user = User.create(
        first_name: 'John',
        last_name: 'Doe',
        email: 'eXample@domain.COM',
        password: 'password',
        password_confirmation: 'password'
      )

      authenticated_user = User.authenticate_with_credentials('EXAMPLe@DOMAIN.CoM', 'password')
      expect(authenticated_user).to eq(user)
    end
  end
end