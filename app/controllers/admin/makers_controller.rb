module Admin
  class MakersController < Admin::ApplicationController
    before_action :default_params

    # To customize the behavior of this controller,
    # you can overwrite any of the RESTful actions. For example:
    #
    # def index
    #   super
    #   @resources = Maker.
    #     page(params[:page]).
    #     per(10)
    # end

    # Define a custom finder by overriding the `find_resource` method:
    def find_resource(param)
      Maker.find_by!(code: params[:code])
    end

    # See https://administrate-prototype.herokuapp.com/customizing_controller_actions
    # for more information

    private

    def default_params
      params[:order] ||= 'id'
      params[:direction] ||= 'asc'
    end
  end
end
