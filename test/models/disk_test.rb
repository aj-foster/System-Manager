require 'test_helper'

class DiskTest < ActiveSupport::TestCase

	# Attribute validation tests
	
	def test_name_presence_validation
		disk_no_name = disks(:disk_no_name)
		assert_not disk_no_name.save, "Saved disk without a name."
	end
	
	def test_serial_number_presence_validation
		disk_no_serial_number = disks(:disk_no_serial_number)
		assert_not disk_no_serial_number.save, "Saved disk without a serial number."
	end
	
	def test_capacity_presence_validation
		disk_no_capacity = disks(:disk_no_capacity)
		assert_not disk_no_capacity.save, "Saved disk without a capacity."
	end
	
	def test_format_presence_validation
		disk_no_format = disks(:disk_no_format)
		assert_not disk_no_format.save, "Saved disk without a format."
	end

	def test_name_uniqueness_validation
		disk_nonunique_name_1 = disks(:disk_nonunique_name_1)
		disk_nonunique_name_2 = disks(:disk_nonunique_name_2)
		disk_nonunique_name_1.save
		assert_not disk_nonunique_name_2.save, "Saved disk without a unique name."
	end
end