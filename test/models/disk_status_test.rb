require 'test_helper'

class DiskStatusTest < ActiveSupport::TestCase

	# Attribute validation tests

	def test_disk_presence_validation
		disk_status_no_disk = disk_statuses(:disk_status_no_disk)
		assert_not disk_status_no_disk.save, "Saved disk status without a disk."
	end
end
