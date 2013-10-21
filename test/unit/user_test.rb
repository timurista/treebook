require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "a user should enter a first name" do
  	user = User.new
	  	assert !user.save #tell us user should not be saved in the db
	  	#assert errors on first name field are not empty, or only assert errors
	  	assert !user.errors[:first_name].empty?
	end
	test "a user should enter a last name" do
		user = User.new
		assert !user.save
		assert !user.errors[:last_name].empty?
	end

	test "a user should enter a profile name" do
		user = User.new
		assert !user.save
		assert !user.errors[:profile_name].empty?
	end

	test "a user have a unique profile name" do
		user = User.new
		user.profile_name = users(:tim).profile_name

		# user.profile_name = "timurista"
		# user.first_name = "Tim"
		# user.last_name = "Urista"
		# user.email = "timothy.urista@gmail.com"
		# user.password = "password"
		# user.password_confirmation = "password"
		## When active, the below shows errors
		# puts user.errors.inspect
		assert !user.save
		assert !user.errors[:profile_name].empty?
	end

	test "a user should have a profile name without spaces" do
		user = User.new
		user = User.new(first_name: 'Tim', last_name: 'Urissa', email: 'timothy.urista2@gmail.com')
		user.password = user.password_confirmation = 'asdfadfa'
		user.profile_name = "My Profile With Spaces"
		assert !user.save #make sure it cant be saved
		assert !user.errors[:profile_name].empty?
		assert user.errors[:profile_name].include?("must be formatted correctly.") #format errors
	end

	test " a user should have a correctly formatted profile name" do
		user = User.new(first_name: 'Tim', last_name: 'Urissa', email: 'timothy.urista2@gmail.com')
		user.password = user.password_confirmation = 'asdfadfa'
		profile_name 'timurista_1'
		assert user.valid?
	end
end
