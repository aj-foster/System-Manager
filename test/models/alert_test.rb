require 'test_helper'

class AlertTest < ActiveSupport::TestCase

	# Tests for Alert::touch
	#

	def test_nil_attribute_rejection
		assert_not Alert.touch, "Accepted Alert.touch without attributes."
	end

	def test_existing_alert_touch
		alert_id = alerts(:alert_canonical).id

		assert_difference 'Alert.find(alert_id).multiplicity', 1, "Didn't increment multiplicity of existing alert" do
			Alert.touch(
				name: "Canonical Name",
				message: "Alert Message",
				alertable: drives(:drive_canonical)
			)
		end
	end

	def test_new_alert_touch
		assert_difference 'Alert.count', 1, "Didn't create new Alert" do
			Alert.touch(
				name: "New Alert",
				message: "Foreign message",
				alertable: drives(:drive_canonical)
			)
		end
	end
end