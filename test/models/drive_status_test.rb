require 'test_helper'

class DriveStatusTest < ActiveSupport::TestCase

	# Attribute validation tests

	def test_drive_presence_validation
		drive_status_no_drive = drive_statuses(:drive_status_no_drive)
		assert_not drive_status_no_drive.save, "Saved drive status without a drive."
	end


	# Tests for DriveStatus#evaluate_status

	def test_pending_alert_creation

		assert_difference 'Alert.count', 1, "Didn't alert about pending reallocations" do
			DriveStatus.create(
				drive: drives(:drive_canonical),
				pending: 1,
				reallocations: 0,
				uncorrectable: 0
			).destroy
		end
	end

	def test_reallocation_alert_creation

		assert_difference 'Alert.count', 1, "Didn't alert about an increase in reallocations" do
			DriveStatus.create(
				drive: drives(:drive_canonical),
				pending: 0,
				reallocations: 1,
				uncorrectable: 0
			).destroy
		end
	end

	def test_uncorrectable_alert_creation

		assert_difference 'Alert.count', 1, "Didn't alert about increase in uncorrectable sectors" do
			DriveStatus.create(
				drive: drives(:drive_canonical),
				pending: 0,
				reallocations: 0,
				uncorrectable: 1
			).destroy
		end
	end


	# Test for DriveStatus default values.

	def test_drive_status_attribute_setup
		drive_status = DriveStatus.create(drive: drives(:drive_canonical))

		assert_not drive_status.lifetime.nil?, "Saved drive status with nil lifetime."
		assert_not drive_status.pending.nil?, "Saved drive status with nil pending sectors."
		assert_not drive_status.reallocations.nil?, "Saved drive status with nil reallocated sectors."
		assert_not drive_status.ssd_wear.nil?, "Saved drive status with nil SSD wear."
		assert_not drive_status.uncorrectable.nil?, "Saved drive status with nil uncorrectable sectors."

	end
end