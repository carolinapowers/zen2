class ApplicationController < ActionController::Base
  # protect_from_forgery with: :exception
  
  set_current_tenant_by_subdomain(:organization, :slug)

  after_action :add_user_headers

  before_bugsnag_notify :add_user_info_to_bugsnag

  protected

  def add_user_info_to_bugsnag(notification)
    notification.user = {
      email: current_user.email,
      id: current_user.id,
    }

    notification.organization = {
      slug: current_tenant&.slug,
      name: current_tenant&.name,
      id: current_tenant&.id,
    }
  end

  def append_info_to_payload(payload)
    super
    payload[:user_id] = current_user.try(:id)
    payload[:host] = request.host
    payload[:source_ip] = request.remote_ip
  end

  def add_user_headers
    return unless current_user

    response.headers['X-User-ID'] = current_user.id
  end
end
