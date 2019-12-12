module Api
  class RolesController < ApplicationController
    def create_role
      data = params[:role]
      response = RoleApi.create_roles(data)

      render :status => response.code, :json => response.body
    end

    def roles_list
      response = RoleApi.get_roles_list()

      render :status => response.code, :json => response.body
    end

    def roles_by_uid
      uid = params[:uid]
      response = RoleApi.get_roles_by_uid(uid)

      render :status => response.code, :json => response.body
    end

    def assign_role_by_uid
      uid = params[:uid]
      data = params[:role]
      response = RoleApi.assign_roles_by_uid(data, uid)

      render :status => response.code, :json => response.body
    end

    def delete_role
      role_name = params[:role]
      response = RoleApi.delete_role(role_name)

      render :status => response.code, :json => response.body
    end
  end
end
