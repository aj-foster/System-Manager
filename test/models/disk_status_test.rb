require 'test_helper'

class DiskStatusTest < ActiveSupport::TestCase

	# Attribute validation tests

	def test_disk_presence_validation
		disk_status_no_disk = disk_statuses(:disk_status_no_disk)
		assert_not disk_status_no_disk.save, "Saved disk status without a disk."
	end


	# Alert creation tests

	def test_pending_alert_creation

		assert_difference 'Alert.count', 1, "Didn't alert about pending reallocations" do
			DiskStatus.create(
				disk: disks(:disk_canonical),
				pending: 1,
				reallocations: 0,
				uncorrectable: 0
			).destroy
		end
	end

	def test_reallocation_alert_creation

		assert_difference 'Alert.count', 1, "Didn't alert about an increase in reallocations" do
			DiskStatus.create(
				disk: disks(:disk_canonical),
				pending: 0,
				reallocations: 1,
				uncorrectable: 0
			).destroy
		end
	end

	def test_uncorrectable_alert_creation

		assert_difference 'Alert.count', 1, "Didn't alert about increase in uncorrectable sectors" do
			DiskStatus.create(
				disk: disks(:disk_canonical),
				pending: 0,
				reallocations: 0,
				uncorrectable: 1
			).destroy
		end
	end
end