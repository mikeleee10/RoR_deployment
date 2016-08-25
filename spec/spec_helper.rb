def create_user name='kobe', email='kobe@lakers.com', password='password', password_confirmation='password'
  User.create(name: name, email: email, password: password, password_confirmation: password_confirmation)
end
def log_in user, password='password'
  visit '/sessions/new'
  fill_in 'email', with: user.email
  fill_in 'password', with: password
  click_button 'Log in'
end
RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end
  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end
  config.shared_context_metadata_behavior = :apply_to_host_groups
end
