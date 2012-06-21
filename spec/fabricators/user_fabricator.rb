Fabricator(:user) do
  email { Fabricate.sequence(:email) { |i| "user_#{i}@example.com" } }
  password "password"
  password_confirmation "password"
  confirmed_at Time.now
end	