require 'test_helper'

class DiskStatusTest < ActiveSupport::TestCase

	# Attribute validation tests

	def test_disk_presence_validation
		disk_status_no_disk = disk_statuses(:disk_status_no_disk)
		assert_not disk_status_no_disk.save, "Saved disk status without a disk."
	end


	# Tests for DiskStatus#evaluate_status

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


	# Test for DiskStatus#setup_disk_status

	def test_disk_status_attribute_setup
		disk_status = DiskStatus.create(disk: disks(:disk_canonical))

		assert_not disk_status.lifetime.nil?, "Saved disk status with nil lifetime."
		assert_not disk_status.pending.nil?, "Saved disk status with nil pending sectors."
		assert_not disk_status.reallocations.nil?, "Saved disk status with nil reallocated sectors."
		assert_not disk_status.ssd_wear.nil?, "Saved disk status with nil SSD wear."
		assert_not disk_status.uncorrectable.nil?, "Saved disk status with nil uncorrectable sectors."

	end
end