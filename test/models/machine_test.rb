require 'test_helper'

class MachineTest < ActiveSupport::TestCase

	# Attribute validation tests
	
	def test_name_presence_validations
		machine_no_name = machines(:machine_no_name)
		assert_not machine_no_name.save, "Saved machine without a name."
	end
end
