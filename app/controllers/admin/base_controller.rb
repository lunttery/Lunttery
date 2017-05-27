class Admin::BaseController < ApplicationController
  skip_authorization_check
  before_action :authenticate_admin!

  private

  def authenticate_admin!
    not_found unless current_user && current_user.has_role?(:admin)
  end
end
