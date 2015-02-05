require 'test_helper'

class DriveTest < ActiveSupport::TestCase

	# Attribute validation tests
	
	def test_name_presence_validation
		drive_no_name = drives(:drive_no_name)
		assert_not drive_no_name.save, "Saved drive without a name."
	end
	
	def test_serial_number_presence_validation
		drive_no_serial_number = drives(:drive_no_serial_number)
		assert_not drive_no_serial_number.save, "Saved drive without a serial number."
	end
	
	def test_capacity_presence_validation
		drive_no_capacity = drives(:drive_no_capacity)
		assert_not drive_no_capacity.save, "Saved drive without a capacity."
	end
	
	def test_format_presence_validation
		drive_no_format = drives(:drive_no_format)
		assert_not drive_no_format.save, "Saved drive without a format."
	end

	def test_name_uniqueness_validation
		drive_nonunique_name_1 = drives(:drive_nonunique_name_1)
		drive_nonunique_name_2 = drives(:drive_nonunique_name_2)
		drive_nonunique_name_1.save
		assert_not drive_nonunique_name_2.save, "Saved drive without a unique name."
	end
end