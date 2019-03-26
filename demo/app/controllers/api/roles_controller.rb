module Api
  class RolesController < ApplicationController
    def create_role
      data = params[:role]
      response = LoginRadiusRolesClient.roles_create(data)

      render :status => response.code, :json => response.body
    end

    def roles_list
      response = LoginRadiusRolesClient.roles_list()

      render :status => response.code, :json => response.body
    end

    def roles_by_uid
      uid = params[:uid]
      response = LoginRadiusRolesClient.roles_by_uid(uid)

      render :status => response.code, :json => response.body
    end

    def assign_role_by_uid
      uid = params[:uid]
      data = params[:role]
      response = LoginRadiusRolesClient.assign_roles_by_uid(uid, data)

      render :status => response.code, :json => response.body
    end
    
    def delete_role
      role_name = params[:role]
      response = LoginRadiusRolesClient.delete_role(role_name)

      render :status => response.code, :json => response.body
    end
  end
end
