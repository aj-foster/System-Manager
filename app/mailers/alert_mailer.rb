class AlertMailer < ActionMailer::Base

	default from: "System Manager <services@planets.ucf.edu>"

	def alert_email(alert)
		@users = User.where(role: :approved, send_alerts: true)
		@alert = alert

		title = alert.name

		if alert.alertable.present?
			title = title + " (" + alert.alertable.name + ")"
		end

		mail(to: @users.map(&:email), subject: "[Alert] #{title}")
	end
end