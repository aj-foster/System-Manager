require 'test_helper'

class UserTest < ActiveSupport::TestCase

	# Attribute validation tests
	
	def test_name_presence_validation
		user_no_name = users(:user_no_name)
		assert_not user_no_name.save, "Saved user without a name."
	end
end
