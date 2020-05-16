# frozen_string_literal: true

describe 'User Model' do
  it 'Compare passwords with is_password match' do
    user = User.new(name: 'Test User', email: 'test@email.za.net', password: 'super_pword')
    expect(user.password == 'super_pword').to be(true)
  end

  it 'Compare passwords with is_password no match' do
    user = User.new(name: 'Test User', email: 'test@email.za.net', password: 'super_pword')
    expect(user.password == 'wrong_pword').to be(false)
  end
end
