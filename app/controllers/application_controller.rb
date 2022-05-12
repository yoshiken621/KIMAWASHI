class ApplicationController < ActionController::Base

  # 新規登録する際に受け取る情報の選別の前処理
  before_action :configure_permitted_parameters, if: :devise_controller?

  private

  # 新規登録の際にデータベースに送られる情報の内訳
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:nickname, :age_select_id, :sex_select_id, :email])
  end
end
