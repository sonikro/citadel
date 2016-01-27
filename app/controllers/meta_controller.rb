class MetaController < ApplicationController
  before_action :require_meta

  def index
  end

  private

  def require_meta
    redirect_to root_path unless user_can_meta?
  end
end